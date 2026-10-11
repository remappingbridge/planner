# MOV-05 — Vertical Fast DPI | Candidato para testes físicos

**Status:** host CI `52/52 PASS`, firmware Pico 2 W em compilação, aceite físico `PENDING`.

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
Aguardar conclusão do `pico2-w-production` desse SHA, registrar artefato e checksum do UF2.
Execução manual: `physical-acceptance.md`; operador ainda precisa declarar aceito/rejeitado.
