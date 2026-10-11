# 03 — Matriz de teste físico, host e regressão de v3.x

**Estado:** checklists PROPOSTOS / nenhum executado. Cada gate abaixo será validado na mesma base de hardware Pico 2 W + LCD ST7789 + HAT + mouse BLE, e desde HOME CONNECTED. O operador escolhe ambiente real de hosts; CI nunca simula cor/contraste real do LCD.

## Preparação comum
1. Identificar tag estável instalada e a versão candidata, guardar 12 combos de shortcuts e parâmetros Movement; fazer backup quando pertinente sem flash_nuke.
2. Carregar UF2 de produção via BOOTSEL; conferir SHA256 antes de gravar, reinicialização e reconexão BLE sem perder bonds. O downgrade de firmware v3→v2 não faz parte deste plano.
3. HOME CONNECTED: testar movimento, click normal, perfil ativo, Remapping Options, Modifier Shortcuts e Saved Devices antes da tela alvo; sem telas novas a menos que expressamente aprovadas.
4. A cada gate validar função alterada + smoke de UI/Help/Lock + ausência de teclas Mouse/Keyboard/Consumer presas e persistência após reinício.

## Testes específicos por gate

| Gate | Roteiro verificável | Passa se |
|---|---|---|
| MNT-01 | HOME → SAVED DEVICES, navegar bonds, observar dicas e REMOVE DEVICE; JOY PRESS entra no Remove This; cancelar | Dicas cinza padrão, REMOVE DEVICE branco quando a única opção selecionada, paginação correta; somente nome ativo com tom atual de destaque |
| MNT-02 | HOME → SAVED DEVICES → REMOVE DEVICE → REMOVE THIS; KEY X Help, KEY B retorna/cancela, KEY Y Lock | `KEY X: HELP` visível e funcional; KEY Y nunca abre Help; sem apagar mouse por entrar/sair da ajuda |
| MNT-03 | HOME → MOVEMENT OPTIONS, configurar H/V 0.25, 1, 1.5, 3 | Linhas HORIZONTAL/ VERTICAL DPI não exibem `x`; valores continuam corretos, rotação/movimento inalterados |
| MNT-04 | Abrir todas as telas que usam `\` nas dicas, incluindo JOY LEFT/RIGHT e HOME SCREEN/PAGE | Todo separador visual do LCD é `/` e cabe em 21 colunas; armazenamento/código/USB não mudam |
| MNT-05 | Fluxo FIRST MOUSE CONNECTED e KEY Y | Dica exata `KEY Y: LOCKS ANYWHERE` legível, sem truncar; KEY Y efetivamente bloqueia |
| MNT-06 | Abrir todos os HELP de todas as telas, testar KEY A/B/X/Y, JOY/joy press, lock e unlock | Apenas B volta e restaura contexto; Y bloqueia; todos demais comandos não executam ação; Help persiste após unlock |
| MNT-07 | Percorrer HOME, Saved Devices, Movement, Custom, Combinations, Shortcuts, Helps, comparar fotografias do LCD | Todos textos antes em ciano normal tornam-se ciano claro esbranquiçado; outros tons preservados; legível e consistente |
| MNT-08 | Em páginas com valores de estado ciano, alternar item selecionado/desselecionado; Saved Devices | Texto ciano claro selecionado vira ciano normal e volta ao ciano claro ao perder foco; cinza→branco comum preservado |
| MNT-09 | HOME CONNECTED em PASSTHROUGH e CUSTOM; JOY PRESS primeira opção | Rótulo fixo `REMAPPING OPTIONS` independentemente do perfil; destino e dados do perfil intactos |
| MNT-10 | Em Debian 13 KDE Obsidian e navegador, testar Zoom In/Out/Reset do teclado físico e BLU2USB; comparar eventos por device com evtest/udevadm; reiniciar | Somente após correção HID genérica: ambas apps executam Zoom In/Out/Reset, sem side effects em layout; se não demonstrado, registrar decisão SEM RELEASE |
| MNT-11 | Nome BLE `BTS. 0MOUSE2`, `mouse`, `MOUSE123`, `LIFT`, vazio/UNKNOWN, truncado; HOME e SAVED DEVICES, desligar/religar | Qualquer subsequência `MOUSE` dispensa sufixo; LIFT recebe ` MOUSE`; sem duplo sufixo nem truncamento perigoso; bonds intactos |

## Testes automatizados e cross-gate

- **UI textual**: fixtures exatas para cada estado numa grade 9×21, incluindo dicas, backslash/substrings em texto visível, todas as telas de Help, selecionados, fallback de mouse e número de caracteres; não testar apenas fragmentos textuais sem navegar.
- **Renderização visual**: snapshots/cor por `BLU2USB_UI_TONE_*`, spans e precedência quando texto atual também está selecionado; validação manual de contraste no LCD, com foco no texto ciano claro esbranquiçado.
- **Input/Help**: bordas release de KEY B/KEY Y, lock/unlock em Help, supressão de KEY A/X/JOY, retorno de foco, cancelamento e remove sem side effects.
- **Nomes**: teste `strstr` case-insensitive/normalização, fragmentos dentro de letras/dígitos, capacidade do buffer, truncamento, pontuação, nome presente/ausente, sem mutação do payload BLE ou persistência.
- **HID/Zoom**: evento BLU2USB deve ser medido **no eventN próprio**, não inferido de `AT Translated Set 2 keyboard` em event0; testar keydown e keyup de Ctrl/Shift/Equal/Minus e 0, tempo e layout, navegador+Obsidian; manter 30 ações, Consumer/Media, screenshots e mouse.
- **Regressão**: todo CI host anterior, Pico 2 W produção, sem novo USB interface/CDC, preserve versão/persistência de v3, USB VID/PID, Bluetooth, perfil Custom/Passthrough, Modifier, Movement H/V+rotação, Saved Devices/Remove flow, 30 atalhos.
- **Entrega**: `.uf2` e SHA-256 em cada gate **com alteração real**, novos SHA/CI se houver correção, release notes e tag apenas **após aprovação física**. Se artefato binariamente idêntico e a mudança for apenas testes, registrar prova e justificar publicação; gate apenas documental não gera versão falsa.

## Classificação de evidências
- **PASS**: observado fisicamente no cenário, com hardware/host indicado.
- **FAIL**: observado comportamento divergente, atualizar branch do mesmo gate.
- **N/A**: host ou hardware sem suporte e limitação aprovada explicitamente; não confundir N/A com PASS.
- **PENDING**: não testado. Aceite global não autoriza inventar resultados individuais.
