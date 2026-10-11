# 01 — Baseline v2.0.0, escopo e decisões arquiteturais

## Baseline verificada no código
- Produto v2.0.0: Pico 2 W + HAT Waveshare LCD 1.3 ST7789, grid **9×21**, navegação HAT no release, USB HID Mouse + Keyboard.
- `BLU2USB_SCREEN_COUNT = 38` na v2.0.0; `BLU2USB_SCREEN_MOUSE_OPTIONS` tem 4 opções (Passthrough, Standard, Escape, Custom). A HOME conectada oferece remapping, movement, saved devices e pair new.
- Perfil **global**, persistido em 14 bytes (`PROFILE_SCHEMA_VERSION=2`); `Custom` contém 5 entradas source→target e um draft. Movimento H/V/rotação é **por identidade de mouse BLE**, separado do perfil global.
- O alvo `ESCAPE` existe em `domain/profile.h` e o remapper emite HID `BLU2USB_KEY_ESCAPE`. O USB já oferece Keyboard 6KRO/modificadores; **não** oferece Consumer Control.
- Pontos de extensão: `src/ux_model/ux_model.c` / `src/renderer/renderer.c` (UX), `src/profiles/profiles.c` (config), `src/remap/remap.c` (roteamento), `src/hid_aggregator/hid_aggregator.c` (estado mantido), `src/app/main.c` (composição), `src/usb_hid/usb_descriptors.c` (transport), `src/storage/storage_pico.c` (flash).

## Pedidos explícitos do anexo
1. Excluir `STANDARD REMAP` e `ESCAPE REMAP` e sua exibição de PROFILE/status; preservar `PASSTHROUGH DEFAULT`, `CUSTOM REMAPPING` e introduzir `MODIFIER SHORTCUTS`.
2. Trocar alvo `ESCAPE` por `MODIFIER` nas cinco telas `WILL BECOME`; `ESCAPE` vira item entre as 30 opções de atalho.
3. Ter 6 páginas de `COMBINATIONS` (2 combinações/página), cada uma com rótulo + valor; 5 páginas de `SHORTCUTS` (6 ações/página).
4. Permitir cadastrar o atalho antes de escolher o botão modificador.
5. `MOD + <BOTÃO>` cujo botão coincide com o MODIFIER fica `UNAVAILABLE`. `KEY A: RESET SELECTED` restaura `NOT CUSTOMIZED`, menos nesse estado. `JOY PRESS` acessa seleção disponível; `KEY A: APPLY AND BACK` grava atalho e volta.
6. Renomear o slug de metadata `remapper-options` para `remapping-options`.

## Inferências recomendadas (não são texto literal do anexo)
- **Escopo global** dos 12 atalhos e do único botão `MODIFIER`, seguindo o perfil Custom global existente. Movement Options permanece por mouse; nunca reutilizar o índice de Saved Devices para atalhos.
- `MODIFIER` é **papel de um único source físico** entre LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD, e não a tecla Shift/Ctrl do computador. O firmware traduz `MODIFIER + gesto` numa ação do catálogo.
- A seleção `MODIFIER` em `WILL BECOME` modifica o **draft**; só o `APPLY CUSTOM` aceito torna o botão ativo no runtime. Alterar o source escolhido para MODIFIER deve desatribuir o antigo, de forma atômica; proposta: antigo volta à sua ação identidade, com prévia explícita na UI. Decisão de UX a congelar antes do gate.
- Uma atribuição a uma combinação atualmente `UNAVAILABLE` **não é apagada**: fica armazenada, mas mascarada enquanto houver colisão. Mudar/desativar o botão MODIFIER a torna visível novamente.
- `MODIFIER RELEASED IS` funciona como **tap**: emite a ação na liberação apenas se nenhuma combinação tiver sido consumida durante a pressão. Evitar disparo indesejado ao soltar depois de COPY, scroll ou movimento.
- As combinações de botões disparam na **borda de pressão**, nunca como clique repetido. Wheel detents representam eventos discretos. Os quatro gestos MOVE precisam de limiar, reset/antirruído e política de repetição formal.
- Sem modificador ativo, atalhos continuam cadastrados e visíveis, porém não executam. Com `PASSTHROUGH`, remap customizado/shortcuts não afetam o mouse.
- Os atalhos produzem comandos HID sintéticos liberados integralmente; jamais deixar Ctrl/GUI/teclas presas ao desconectar, trocar perfil ou bloquear.
- Não introduzir telas, confirmações ou sistema de perfis de SO adicionais não desenhados. Bloqueios reais permanecem como ADR pendente.

## Compatibilidade e limites
- Preservar reconnect/pair/remove, saved device identity, movimento pós-rotação, Logitech Lift, bloqueio do LCD, Help, interface e fontes/cor.
- Sem reimplementação de BLE/HID, sem framework/event bus extra, sem debug por USB CDC/UART, sem modificação de `movement-options` por conveniência.
- O inventário previsto é **38 − 4 telas de Standard/Escape + 11 telas de combinação/atalho = 45** telas, sujeito a verificação automática no gate de contrato. A antiga rota `MOUSE_OPTIONS` é atualizada, não duplicada.
- *Atenção*: quatro telas antigas de perfil ficam inacessíveis e devem ser retiradas dos IDs/metadados/testes. Renomear o slug não obriga renumerar valores persistidos; screen IDs não são esquema de flash.
- Nenhuma migração destrutiva antes de aceitar cenários de rollback, inclusive atualização UF2 sem apagar bonds.
