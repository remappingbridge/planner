# MOV-05 — Vertical Fast DPI | Candidato para testes físicos

**Status:** host CI `52/52 PASS`, Pico 2 W UF2 `PASS`, aceite físico `PENDING`.

Produto: `remappingbridge/remappingbridge`
Branch: `feature/movement-options-v1.0`
Commit candidato: `59c01a2bcec78267fa2b0baa0ddfa4989353a4c7`
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38097711254
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Alterações deste gate
1. `tests/test_mov05_vertical_fast.c` cobre o gate Vertical Fast desde a HOME conectada, todos os multiplicadores, cópia completa 9×21 e valores na col 17, comportamento no release, wrap, paginação vertical sem cruzar para H, Help sem lock, cancelar, aplicar após gravação com preservação de H e Rotation.
2. Cobre ganho V quando rot=270° e frações em deslocamentos pequenos com resultados exatos; testa delta grande de 1200 contas transmitido por vários relatórios USB sem perda.
3. Registrado no CMake/CTest, fazendo a suíte aumentar de 51 para **52 testes host**, todos aprovados.
4. Nenhuma alteração de runtime é necessária: Vertical Fast já estava integrada na branch previamente. Portanto, o novo UF2 deverá ser binariamente idêntico ao do MOV-04 se o build for reprodutível — confirmar com SHA-256, não presumir. A aceitação física do MOV-05 continua necessária independentemente disso.

## Evidência e aceite
Testes host: `52/52 PASS` em 2026-10-10.
O `pico2-w-production` passou e publicou o artefato `11686186807`, com `blu2usb_picow.uf2` de **925.696 bytes**, **1.808 blocos**, família RP2350, SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`. A verificação foi feita em cima dos bytes extraídos do ZIP do próprio GitHub Actions. O UF2 é **binariamente idêntico ao MOV-04 aceito**, pois só os testes/documentação mudaram. Não é necessário reflashear quem permaneceu no firmware MOV-04; o MOV-05 ainda exige teste/aceite físico próprio.
Execução manual: `physical-acceptance.md`; operador ainda precisa declarar aceito/rejeitado.
