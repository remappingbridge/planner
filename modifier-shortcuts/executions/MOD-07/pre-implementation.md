# MOD-07 — Catálogo Keyboard HID 22/30 (Linux-first)

**Estado: IMPLEMENTADO EM BRANCH, CI / ACEITE FÍSICO PENDENTES — 2026-10-11.**

Dependência: MOD-06 aprovado pelo operador por mensagem explícita «gate aceito. prossiga» após entregar Pico 2 W UF2 SHA256 `6b9cbcd09a2aa3f66dba36498547e56e44e2cb07439150ade1bf584b6228837c`. A branch [feature/modifier-shortcuts-mod07](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod07) saiu do commit imutável do MOD-06 `751b24f6c2a22fe0f4130dc57b8073c774faceee`. [PR #27 draft](https://github.com/remappingbridge/remappingbridge/pull/27); main/tag v2.0.0 intocados.

Contrato validado em [catálogo](../../04-shortcuts-hid-catalog.md), [matriz de gates](../../06-gates-and-acceptance.md) e [MOD-00 aprovado](../MOD-00/operator-acceptance.md): IDs **1..18** e **25..28** recebem mapeamento **USB Keyboard/Keypad** real, em 8-byte boot-compatible HID (6KRO, oito bits de modificador). As ações Consumer Media/Volume/Brightness **19..24/29..30 permanecem não implementadas** até MOD-08. Nenhum terceiro interface, Report ID, alteração VID/PID ou CDC.

Implementação: `src/modifier_shortcuts/keyboard_catalog.c` mapeia 22 IDs em HID usage + máscara Ctrl/Shift, separando a semântica dos rótulos no firmware. `modifier_shortcuts.c` usa o mapa em todas as fontes do MOD-05/06 (botão, MODIFIER RELEASED, Wheel, MOVE), mantendo FIFO limitada, no auto-repeat, source HID sintético isolado, duas fases de confirmação USB Down/Up, cancelamentos por BLE/USB/Lock/perfil e prevenção de 6KRO overflow / down duplicado de uma tecla já ocupada por outra origem. Não modifica storage/schema, Movement e Bluetooth.

Política do host: Linux desktop primeiro, atalhos por convenção de aplicativo, sem detecção do SO nem promessa macOS/Windows. REDO = Ctrl+Shift+Z; RENAME = F2; FULL SCREEN = F11; SCREENSHOT FULL = Print Screen; SCREENSHOT AREA = Shift+Print Screen (compositor pode variar); REFRESH = Ctrl+R; HOME SCREEN/PAGE = **tecla Home**, não Mostrar Área de Trabalho; ZOOM IN/OUT = Ctrl+Keypad Plus/Minus, RESET = Ctrl+0. Teclado brasileiro e suporte do aplicativo aos atalhos numéricos precisam de teste físico. Backspace e Delete Forward são usos HID distintos.

A CI deve verificar 22 traduções, oito IDs explicitamente excluídos, USB busy/keyup, ownership, 6KRO, FIFO, regresso MOD-05/06 e build Pico 2 W, com SHA256 da UF2. MOD-08 bloqueado até aceite do operador no Linux real.
