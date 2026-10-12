# MNT-15 / MEL-08 — Observações de Zoom no Mabox (12/10/2026)

**Estado atualizado após novo teste:** o operador confirmou no teclado físico do Obsidian que **Ctrl + = sem Shift amplia** e que **com Shift o zoom não responde**; relatou também diminuir normalmente sem Shift. Isso fortalece a incompatibilidade entre o atalho ZOOM IN atual do firmware (Ctrl+Shift+Equal) e a interpretação do Obsidian neste host, mas **não demonstra ainda que Ctrl+Equal funcionará em todos os aplicativos**. Firmware não alterado; nenhuma nova versão gerada. MNT-14 já está cancelado por validação positiva de pareamento. Esta nota não autoriza automaticamente um patch ou publicação.

## Ambiente informado pelo operador

- **Host:** Mabox Linux; operador acredita que a sessão utiliza **X11**, mas `$XDG_SESSION_TYPE` ainda não foi consultado.
- **Firmware usado:** esperado RemappingBridge estável v3.2.3, mas o UF2 exato/hashes do dispositivo não foram apresentados nesta execução.
- **Aplicações testadas:** Obsidian, navegador e terminal.
- **Método de teste:** ações Zoom In / Zoom Out / Reset Zoom do RemappingBridge em três aplicativos; **comparação adicional no teclado físico do Obsidian**: Ctrl+= sem Shift amplia e Ctrl+- sem Shift diminui, mas com Shift o Zoom não ocorre. Não há eventos `evtest` documentados.

## Evidência de funcionamento reportada

| Aplicação | ZOOM IN | ZOOM OUT | RESET ZOOM |
|---|---|---|---|
| Obsidian | **FAIL** (não amplia) | **PASS** (diminui) | **PASS** (reseta) |
| Navegador | **PASS** | **PASS** | **PASS** |
| Terminal | **PASS** | **PASS** | **PASS** |

Esses são resultados **observados/referidos pelo operador**, não rastros de input USB. Corrigem o histórico do Debian KDE onde haviam sido reportadas falhas Zoom In *e* Zoom Out no Obsidian: **no Mabox apenas Zoom In falha**. Não transportar resultado entre hosts sem registrar a distinção.

## Teste discriminante concluído pelo operador

Em resposta ao teste solicitado, o operador informou: **"sem o shift aumenta e diminui o zoom, mas com shift não acontece"**. No contexto do teste do teclado físico dentro do Obsidian, isso significa:

- **Ctrl + = (sem Shift):** aumenta o zoom.
- **Ctrl + - (sem Shift):** diminui o zoom.
- **Com Shift nas combinações de zoom testadas:** a ação não ocorre.

**Interpretação limitada à evidência:** o resultado favorece a hipótese de **atalho não aceito pelo Obsidian com Shift neste host**, pois o próprio teclado físico reproduz essa diferença. Não é correto atribuir o comportamento apenas à temporização USB ou a um defeito de HCI/BLE. O teste não confirma ainda se mudar o atalho global para Ctrl+= preserva navegador e terminal.

**Próximo controle antes de patch:** testar o **teclado físico Ctrl+= SEM Shift** no **navegador e no terminal**; registrar se ele também amplia nesses programas (a ação atual do RemappingBridge já funciona ali, mas usa Shift). Se ambos funcionarem, a proposta mínima é retirar **MOD_SHIFT somente da ação 26, ZOOM IN**, preservando `HID Equal 0x2E + MOD_CTRL 0x01`, em vez da máscara `0x03`. Deixar ação 27 (Ctrl+-) e 28 (Ctrl+0) **intocadas**, pois passam no Mabox.

**Decisão de implementação:** proposta técnica pronta para validação cruzada; sem autorização expressa para mudar firmware, não criar branch, UF2, tag ou release.

## Inspeção do mapeamento de firmware v3.2.3

Fonte versionada [keyboard_catalog.c](https://github.com/remappingbridge/remappingbridge/blob/v3.2.3/src/modifier_shortcuts/keyboard_catalog.c), com regressão [test_mod07_keyboard_catalog.c](https://github.com/remappingbridge/remappingbridge/blob/v3.2.3/tests/test_mod07_keyboard_catalog.c):

- Ação 26 `ZOOM IN`: HID Usage **0x2E (Equal)** + modificadores Left Ctrl **0x01** + Left Shift **0x02**, máscara **0x03**: **Ctrl+Shift+=**.
- Ação 27 `ZOOM OUT`: HID Usage **0x2D (Minus)** + Left Ctrl **0x01**: **Ctrl+-**.
- Ação 28 `RESET ZOOM`: HID Usage **0x27 (0)** + Left Ctrl **0x01**: **Ctrl+0**.

Por ser a mesma ação HID que funciona no navegador e terminal, **USB HID não está globalmente indisponível**. Isso não elimina uma diferença de tratamento de Shift/layout XKB pelo Obsidian/Electron; tampouco prova que Ctrl+= funcionaria em todos os hosts.

## Pistas externas, não confirmação do caso atual

- [Obsidian Forum — Accidental small fonts](https://forum.obsidian.md/t/accidentally-made-fonts-in-side-panels-top-bar-and-gutters-very-small/43658) descreve **Ctrl+=** como combinação de Zoom In no Obsidian, e adverte sobre uso de Shift para `+`.
- [Obsidian Forum — Zoom does not work with all keyboard layouts](https://forum.obsidian.md/t/zoom-does-not-work-with-all-keyboard-layouts/26853) registra caso de **zoom out funcionar e zoom in falhar** no Linux dependendo de layout, com mudança ao alternar para US.
- Esses registros antigos **não comprovam bug na versão de Obsidian do operador**. São hipóteses úteis para discriminar Ctrl+= de Ctrl+Shift+= e diferenciar keycode/keysym por XKB.

## Próximo experimento não destrutivo prioritário (sem firmware novo)

1. No terminal do Mabox, executar `printf 'session=%s layout=%s\\n' "${XDG_SESSION_TYPE:-unknown}" "$(setxkbmap -query 2>/dev/null | sed -n 's/^layout:[[:space:]]*//p')"` para documentar sessão e layout (se `setxkbmap` existir).
2. **CONCLUÍDO no Obsidian:** teclado físico **Ctrl + = SEM Shift amplia**; **com Shift não amplia**.
3. **PENDENTE:** testar teclado físico **Ctrl + = SEM Shift** tanto no navegador como no terminal, para verificar compatibilidade antes de mudar o atalho global. Não confundir tecla `+` impressa em layout ABNT2/alternativo com usage Equal.
4. Com uma nota de Obsidian e navegador/terminal abertos, comparar ação ZOOM IN do RemappingBridge, ZOOM OUT e RESET; não instalar plugin de Zoom nem reatribuir hotkey antes desse A/B.
5. **Condição observada no Obsidian:** Ctrl+= funciona e Ctrl+Shift+= falha. Hipótese prioritária é o Shift desnecessário na ação Zoom In para este aplicativo/host. A mudança genérica `Ctrl+Shift+Equal` → `Ctrl+Equal` continua **condicionada** a teste de teclado físico em navegador e terminal, testes do firmware e autorização explícita.
6. Se ambas as teclas físicas funcionam mas o RemappingBridge não: coletar via `evtest` ou `libinput debug-events` do **device BLU2USB correto** o KEY_LEFTCTRL, KEY_LEFTSHIFT, KEY_EQUAL, keydown/keyup e comparar emissão e ordem de eventos ao teclado físico. Não presumir que `event0` corresponda ao RemappingBridge.
7. Se apenas `Ctrl+Shift+=` funciona fisicamente: não mudar mapeamento para `Ctrl+=` sem investigar layout/temporização do HID.

## Critérios de autorização futura

- Separar compatibilidade de atalho, discrepância layout XKB/keysym e temporização/modificadores HID por evidências reproduzíveis.
- Não criar condição `if (Obsidian)`, não modificar as 29 outras ações, perfil/USB descriptors, BLE ou navegação.
- Solução genérica, se necessária, deve ter teste host para as ações 26/27/28 e regressão física em Obsidian, navegador e terminal, depois CI Pico 2 W e UF2 de candidato em branch, com aceite antes de PATCH.
- **Sem patch ou nova release neste relato.** A última estável segue **v3.2.3**.

**Situação MNT-15:** falha específica de atalho com Shift reproduzida também no teclado físico do Obsidian; **validação cruzada pendente em navegador e terminal**. Nenhum patch/CI/UF2/release MNT-15; implementação não iniciada.
