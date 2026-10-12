# MNT-13 — candidato de firmware para aceite físico

**STATUS: IMPLEMENTADO / CI COMPLETA PASS / UF2 PRODUÇÃO SHA VALIDADO / ACEITE FÍSICO PENDING.** Não houve merge, tag nova nem release. Versão interna ainda `v3.2.2`.

## Base, implementação e revisão
- Base: tag oficial [`v3.2.2`](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.2), commit `0d35397e6a1619f2a5dc314d0f2659206912d177` (igual a main antes do gate).
- Branch: `maintenance/v3x-mnt-13`; HEAD do candidato `e19030b7a721c43ecae172a78be1ab623c86a95c`.
- [PR #43 **DRAFT**](https://github.com/remappingbridge/remappingbridge/pull/43). Sem merge até aceite explícito.
- [GitHub Actions #38254486989](https://github.com/remappingbridge/remappingbridge/actions/runs/38254486989): **96/96 testes host PASS**, build **Pico 2 W Release PASS** e upload do artefato de produção PASS, para o commit de candidato acima.
- Artefato oficial Actions: ID **11749980494**, `blu2usb-picow-production-pico2w`. Contém `blu2usb_picow.uf2` (952.832 bytes).
- UF2 extraído para conversa como `remappingbridge-mnt13-selection-marker-pico2w.uf2`, **SHA-256 `f11285d82c3768bd48c8b91d0614f2d73a2c701f67aea1996a1eed1851c0a3ee`**. Aferido localmente e **idêntico à saída `sha256sum build-pico/blu2usb_picow.uf2` do job de produção oficial**; não confundir ZIP com UF2.

## Alterações
1. `src/renderer/renderer.c`: etapa única `blu2usb_ui_apply_selection_marker` sobre frame, com validação de opção, linha e margem; limpa seta anterior e herda o tom final da primeira letra da opção focada. Mapeamento por `selected_row` existente, sem alterações de UX/FSM.
2. `src/app/main.c`: `project` → `enforce_applied_visual_contract` → **`apply_selection_marker`** → `renderer_render`. Mantém intacta a projeção e as premissas de testes de gates anteriores.
3. `include/blu2usb/renderer/renderer.h`: exporta somente a função de acabamento visual.
4. `tests/test_mnt13_selection_marker.c`: percorre **27 telas navegáveis** (HOME, SEARCH/RETRY, REMAPPING, EDIT, cinco WILL BECOME, MOVEMENT, quatro DPI, ROTATION, seis COMBINATIONS, cinco SHORTCUTS), cada opção, seleção inválida, cinco tipos de exceção/sem-lista, Saved Devices com zero/um/dois bonds, recomposição, paginação, tonos e ausência de deslocamento de textos.
5. `tests/test_mnt13_source.py`: valida ordem efetiva na aplicação, `>` no glyph do display e guards do renderer. Registro em `tests/CMakeLists.txt`.
6. Nenhum arquivo de BLE, USB HID, flash/storage, mapeamentos, paleta, versões, textos da UX ou contratos de teclas foi alterado.

## Aceite/manual
Executar [cenários físicos](physical-acceptance.md) desde HOME CONNECTED, usando BOOTSEL e **sem `flash_nuke`**. Testar primeira coluna, 9×21, foco versus CURRENT, página e HELP, saved devices e todas as exceções, em LCD real.

**Somente após `gate aceito`**: planejar/publicar o próximo PATCH v3.x a partir do commit correto, com nova CI do bump de versão; integrar/tag/release/UF2 final de fonte correspondente. **MNT-14 PAIR NEW e MNT-15 Zoom fora do escopo.**
