# MOV-08 — Saved Devices | Candidato de CI e testes físicos

**Estado: HOST CI 56/56 PASS; PICO 2 W EM COMPILAÇÃO; ACEITAÇÃO FÍSICA PENDING.**

- Repositório: `remappingbridge/remappingbridge`
- Branch: `feature/movement-options-v1.0` (não mesclada)
- Commit candidato: `7a18ee16a486a17d676f5ba10be58432a0965bc3`
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098664052
- PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Diferenças deste gate
As telas SAVED DEVICES e o estilo ciano exclusivo no nome do mouse conectado estavam implementados na branch desde MOV-03, e tiveram seus acessos validados em MOV-07. MOV-08 não modifica código de produção: adiciona o teste dedicado `tests/test_mov08_saved_devices.c` e o registro no CMake/CTest.

Novo teste cobre, a partir da HOME conectada, três dispositivos com valores separados de movimento: Logitech Lift H2/V0.75/Rot270, Mouse Alpha H0.5/V3/Rot90 e Mouse Gamma H1.25/V1.5/Rot180. Examina cada linha renderizada em 9×21, contador, paginação e wrap, ciano somente no nome da identidade ativa e amarelo em todos os demais caracteres, inclusive quando joystick está pressionado; mouse conectado primeiro (qualquer índice de bond), reconexão em outra identidade sem sobrepor preferências, perfil global corrente (sem inferência de perfil por mouse), navegação para confirmação Remove This pelo **bond correto** e cancelamento, título longo, lista vazia e impedimento de remoção sem bond. No ambiente host, simula a hidratação de preferências do armazenamento; validação BLE/TLV real pertence ao roteiro físico.

Host 56/56 PASS. Aguardar CI Pico do mesmo SHA para anexar artefato e comparar UF2 bit a bit com MOV-07 já aceito. **NÃO** aceitar MOV-08 automaticamente com CI.

Cenários físicos: `physical-acceptance.md`.
