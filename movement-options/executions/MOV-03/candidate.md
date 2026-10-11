# MOV-03 — Candidato CI e testes físicos

Status: **50/50 testes host PASS / Pico 2 W production build PASS / aceite físico PENDING**.

Produto: `remappingbridge/remappingbridge`
Branch: `feature/movement-options-v1.0`
Commit candidato: `326c5f11164932aad5415783197d01cbc180de2e`
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38096841875
PR Draft #22: https://github.com/remappingbridge/remappingbridge/pull/22

Alterações em relação ao MOV-02 aceito:
1. `src/renderer/renderer.c`: em Saved Devices o único texto ciano é a linha do nome do mouse efetivamente conectado naquela página. Todos os outros caracteres não vazios em todas as linhas, páginas e hints são `BLU2USB_UI_TONE_STATIC` (amarelo padrão). A regra é aplicada por último, após seleção e destaque da tecla pressionada, e não afeta outras telas.
2. `tests/test_mov03_horizontal_fast.c`: cenários que percorrem da HOME conectada até Fast DPI, conferem 1.25/1.5/2/3×, exatidão da grade, current/selection, paginação Slow↔Fast, Help, Cancel/Apply e isolamento dos eixos. Simulam páginas de Saved Devices, mouse ativo, mouse salvo mas inativo, desconexão, reconexão de outro mouse e tecla pressionada.
3. CMake: acrescentado teste 50; todos os testes host aprovados no commit candidato.

Ainda não há aceite físico do MOV-03. Não mesclar a branch ao release/main.

Pico 2 W production build e verificação de UF2: PASS no mesmo run do commit acima.
Artefato GitHub Actions: `11686925370` (nome `blu2usb-picow-production-pico2w`).
Firmware extraído: `remappingbridge-mov03-326c5f11.uf2`, 925.696 bytes, 1808 blocos UF2, family codes RP2350 metadata + firmware. SHA-256 do UF2: `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`.
Todos os 50 testes do host e build/verificação Pico passaram. Gate MOV-03 **aguarda aceite físico do operador**.
