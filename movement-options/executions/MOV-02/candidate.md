# MOV-02 — Candidato para teste físico

Status: HOST CI PASS / PICO 2 W CI PASS / ACEITAÇÃO FÍSICA PENDENTE.

Branch do produto: `feature/movement-options-v1.0`.
Commit candidato: `f13425c2c1ec8642803fa2398cd3f67606d440e6`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38095384245
PR: https://github.com/remappingbridge/remappingbridge/pull/22

Mudanças deste candidato:
- Ajuste literal de ROTATION: `KEY A: APPLY` -> `KEY A: APPLY AND BACK`, limite 21 caracteres, linha 7.
- Novo teste `tests/test_mov02_horizontal_slow.c` que navega desde HOME conectada até HORIZONTAL SLOW DPI, cobrindo células e tons 9×21, current/selecionado, navegação no release, wrap, cancelamento, Help Y não bloqueante, Apply que não anuncia sucesso antes de TLV, preservação de V/Rotation e copy de ROTATION.
- Registro do teste no CMake e CI. 49/49 testes host PASS (run 38095384245).

Compatibilidade: manter a v1.0 estável, demais gates não aceitos; todas as telas de implementação prévia permanecem na branch isolada.

Artefato da execução `38095384245`: `blu2usb-picow-production-pico2w`, artifact ID `11685218547`.
UF2 final: `blu2usb_picow.uf2`, 925.184 bytes; SHA-256 `ef6b259dc2f75a8b71f441a94873aa2d23ed49b06ada23ad2c1fd70256d9e91d`.
CI final: **49/49 testes host aprovados, firmware Pico 2 W compilado, validado e artefato publicado**. O arquivo possui cabeçalhos de UF2 válidos, incluindo os blocos family-specific de Pico 2 W.
