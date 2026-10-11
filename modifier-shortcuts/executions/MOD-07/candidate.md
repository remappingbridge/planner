# MOD-07 — Candidato Keyboard HID 22/30 pronto para teste físico

**Status: CI 72/72 PASS + PICO 2 W UF2 VERIFIED / ACEITO FISICAMENTE PELO OPERADOR — 2026-10-11.**

## Base, source e artefato auditados
- Dependência: [MOD-06 aceito fisicamente](../MOD-06/physical-acceptance.md) pelo operador através de «gate aceito. prossiga» em 2026-10-11. Commit base **`751b24f6c2a22fe0f4130dc57b8073c774faceee`**, UF2 aprovado SHA256 `6b9cbcd09a2aa3f66dba36498547e56e44e2cb07439150ade1bf584b6228837c`.
- Branch [`feature/modifier-shortcuts-mod07`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod07), criada exatamente daquele commit, [PR #27 draft](https://github.com/remappingbridge/remappingbridge/pull/27). Sem merge ou tag; main e v2.0.0 intactos.
- Commit exato candidato **[`0b62137494ce34a86bbecb8d8ee42a7cdfa42385`](https://github.com/remappingbridge/remappingbridge/commit/0b62137494ce34a86bbecb8d8ee42a7cdfa42385)**.
- [GitHub Actions CI #366](https://github.com/remappingbridge/remappingbridge/actions/runs/38149731598): `host-architecture` **SUCCESS 72/72 CTests**, inclui duas novas verificações MOD-07 e regressões MOD-01..06; `pico2-w-production` **SUCCESS**.
- [Artefato oficial ZIP 11705632305](https://github.com/remappingbridge/remappingbridge/actions/runs/38149731598/artifacts/11705632305), digest do ZIP `f96f87b51c988d071dc18ef74032e1eb7fe4ec7cc5b017aa02d94e6a17272346`. Não confundir com SHA do firmware.
- Firmware extraído `blu2usb_picow.uf2`: **942592 bytes**, SHA256 **`2f934c507e8502029114ffc4075363b108e23185c51cf28abb022884fc35a576`**. Extração e `sha256sum` independentes em container confirmaram o valor do CI Pico. Arquivo entregue `remappingbridge-mod07-pico2w.uf2`, cópia binariamente idêntica.

## Exatamente 22 teclas/atalhos implementados
`src/modifier_shortcuts/keyboard_catalog.c` retorna HID Keyboard/Keypad usage + máscara Ctrl/Shift para semântica IDs **1..18 e 25..28** no catalogo já aceito:

| IDs | Ações | HID teclado enviado |
|---|---|---|
| 1..6 | COPY, CUT, SELECT ALL, PASTE, UNDO, REDO | Ctrl+C, Ctrl+X, Ctrl+A, Ctrl+V, Ctrl+Z, Ctrl+Shift+Z |
| 7..11 | ESCAPE, SPACE, ENTER, BACKSPACE, DELETE | Escape 0x29, Space 0x2c, Enter 0x28, Backspace 0x2a, Delete Forward 0x4c |
| 12..18 | RENAME, FULL SCREEN, SCREENSHOT FULL, SCREENSHOT AREA, REFRESH, FIND, SAVE | F2, F11, Print Screen, Shift+Print Screen, Ctrl+R, Ctrl+F, Ctrl+S |
| 25..28 | HOME SCREEN/PAGE, ZOOM IN, ZOOM OUT, RESET ZOOM | HID Home 0x4a, Ctrl+Keypad Plus 0x57, Ctrl+Keypad Minus 0x56, Ctrl+0 (0x27) |

**Host policy:** Linux desktop first; actions named RENAME, SCREENSHOT, REFRESH, FULL SCREEN, zoom depend on compositor/application and layout. O nome HOME é tecla Home, **não** Mostrar Área de Trabalho. Ctrl+Keypad Plus/Minus usados para contornar posição física variável de +/− em teclados US/ABNT2; aplicativo pode aceitar ou não. Nem host OS detection nem interface de platform config nova. Redo é Ctrl+Shift+Z, não Ctrl+Y.

## Runtime/compatibilidade
- Todas as fontes MOD-05/06 (solo Modifier Released, botões físicos, Wheel e MOVE) continuam usando a FIFO de oito eventos e fase separada **USB keydown aceito → keyup aceito**. Modifier físico não vira Ctrl de modo permanente; Ctrl/Shift são sintéticos para cada ação.
- Antes de emitir, o executor verifica se a mesma tecla já está fisicamente pressionada por outra fonte (evita relatar down que host não recebeu) e se seis posições Keyboard 6KRO já estão ocupadas (espera sem descartar USB state). Ao cancelar, libera **somente seu próprio source sintético**, não teclas de outro teclado.
- IDs **19..24** (mídia/volume) e **29..30** (brilho) retornam UNSUPPORTED, mantêm atribuições salvas mas nunca emitem falsos comandos Keyboard; Consumer HID e enumeração continuam responsabilidade de MOD-08.
- No change to 45-screen UX, v3 flash schema, 12 saved combo assignments, BLE bonds, Mouse Movement H/V gains and rotation, Logitech HID++, USB VID/PID, existing two interfaces and Boot Keyboard 8-byte report.
- CTest `mod07_keyboard_catalog_22_actions` valida todos os 22 pares id→keycode/modifiers, 8 IDs futuros excluídos, ack em endpoint ocupado e keyup, FIFO, 6KRO e ownership alheio; `mod07_keyboard_runtime_source_contract` inspeciona ligação com backend, descriptor e exclusões. Testes compilados com asserts habilitados até sob Release.

## Aceite pendente
[12 cenários físicos desde HOME](physical-acceptance.md) exigem editor, browser e gerenciador de arquivos Linux. Byte HID correto **não** comprova que compositor/aplicativo executará o efeito sem teste de hardware. **MOD-07 ACEITO pelo operador por «gate aceito prossiga»; MOD-08 autorizado.** Nada publicado ou mergeado.
