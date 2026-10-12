# MNT-15 / MEL-08 — Observações de Zoom no Mabox (12/10/2026)

**Estado:** relato físico coletado, hipótese de incompatibilidade de shortcut/layout em investigação; **sem causa demonstrada, firmware não alterado, nenhuma versão gerada**. MNT-14 já está cancelado por validação positiva de pareamento. Esta nota não autoriza automaticamente um patch ou publicação.

## Ambiente informado pelo operador

- **Host:** Mabox Linux; operador acredita que a sessão utiliza **X11**, mas `$XDG_SESSION_TYPE` ainda não foi consultado.
- **Firmware usado:** esperado RemappingBridge estável v3.2.3, mas o UF2 exato/hashes do dispositivo não foram apresentados nesta execução.
- **Aplicações testadas:** Obsidian, navegador e terminal.
- **Método de teste:** ações Zoom In / Zoom Out / Reset Zoom do RemappingBridge; não há eventos `evtest` ou teclado físico comparativo registrados neste relato.

## Evidência de funcionamento reportada

| Aplicação | ZOOM IN | ZOOM OUT | RESET ZOOM |
|---|---|---|---|
| Obsidian | **FAIL** (não amplia) | **PASS** (diminui) | **PASS** (reseta) |
| Navegador | **PASS** | **PASS** | **PASS** |
| Terminal | **PASS** | **PASS** | **PASS** |

Esses são resultados **observados/referidos pelo operador**, não rastros de input USB. Corrigem o histórico do Debian KDE onde haviam sido reportadas falhas Zoom In *e* Zoom Out no Obsidian: **no Mabox apenas Zoom In falha**. Não transportar resultado entre hosts sem registrar a distinção.

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
2. **Dentro do Obsidian com foco**, testar no teclado físico **Ctrl + = SEM Shift** e anotar se amplia.
3. Testar no mesmo teclado **Ctrl + Shift + =**, anotar se amplia. Não confundir tecla `+` impressa em layout ABNT2/alternativo com usage Equal.
4. Com uma nota de Obsidian e navegador/terminal abertos, comparar ação ZOOM IN do RemappingBridge, ZOOM OUT e RESET; não instalar plugin de Zoom nem reatribuir hotkey antes desse A/B.
5. Se teclado Ctrl+= funciona onde Ctrl+Shift+= falha: **hipótese prioritária** é uso desnecessário de Shift na ação de Zoom In para Obsidian. Avaliar **mudança genérica** de `Ctrl+Shift+Equal` para `Ctrl+Equal`, sempre testando navegador e terminal. Não aplicar sem demonstração/regressões.
6. Se ambas as teclas físicas funcionam mas o RemappingBridge não: coletar via `evtest` ou `libinput debug-events` do **device BLU2USB correto** o KEY_LEFTCTRL, KEY_LEFTSHIFT, KEY_EQUAL, keydown/keyup e comparar emissão e ordem de eventos ao teclado físico. Não presumir que `event0` corresponda ao RemappingBridge.
7. Se apenas `Ctrl+Shift+=` funciona fisicamente: não mudar mapeamento para `Ctrl+=` sem investigar layout/temporização do HID.

## Critérios de autorização futura

- Separar compatibilidade de atalho, discrepância layout XKB/keysym e temporização/modificadores HID por evidências reproduzíveis.
- Não criar condição `if (Obsidian)`, não modificar as 29 outras ações, perfil/USB descriptors, BLE ou navegação.
- Solução genérica, se necessária, deve ter teste host para as ações 26/27/28 e regressão física em Obsidian, navegador e terminal, depois CI Pico 2 W e UF2 de candidato em branch, com aceite antes de PATCH.
- **Sem patch ou nova release neste relato.** A última estável segue **v3.2.3**.

**Situação MNT-15:** diagnóstico enriquecido pelos resultados do Mabox, **investigação de compatibilidade pendente**; nenhuma causa raiz comprovada, implementação não iniciada.
