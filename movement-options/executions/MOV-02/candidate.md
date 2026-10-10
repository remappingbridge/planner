# MOV-02 — Candidato para teste físico

Status: HOST CI PASS / PICO 2 W CI EM EXECUÇÃO / ACEITAÇÃO FÍSICA PENDENTE.

Branch do produto: `feature/movement-options-v1.0`.
Commit candidato: `f13425c2c1ec8642803fa2398cd3f67606d440e6`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38095384245
PR: https://github.com/remappingbridge/remappingbridge/pull/22

Mudanças deste candidato:
- Ajuste literal de ROTATION: `KEY A: APPLY` -> `KEY A: APPLY AND BACK`, limite 21 caracteres, linha 7.
- Novo teste `tests/test_mov02_horizontal_slow.c` que navega desde HOME conectada até HORIZONTAL SLOW DPI, cobrindo células e tons 9×21, current/selecionado, navegação no release, wrap, cancelamento, Help Y não bloqueante, Apply que não anuncia sucesso antes de TLV, preservação de V/Rotation e copy de ROTATION.
- Registro do teste no CMake e CI. 49/49 testes host PASS (run 38095384245).

Compatibilidade: manter a v1.0 estável, demais gates não aceitos; todas as telas de implementação prévia permanecem na branch isolada.

Artefato/UF2 final: registrar somente após sucesso do job Pico deste mesmo commit.
