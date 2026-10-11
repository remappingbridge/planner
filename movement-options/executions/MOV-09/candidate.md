# MOV-09 — Remove This Mouse | Candidato de CI

**Status: host CI 58/58 PASS; Pico 2 W produção PASS; aceite físico PENDING.**

Código: `remappingbridge/remappingbridge`, branch `feature/movement-options-v1.0`.
Commit candidato: `6a75b6212a152e34fec457b481e9bb513e5898ae`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38099188203
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Delta em relação ao MOV-08 aceito
- `src/ble_hogp/ble_hogp_pico.c`: o worker assíncrono de remoção agora emite `BLU2USB_BLE_HOGP_MESSAGE_SAVED_MOUSE_REMOVE_FAILED` quando o índice lógico selecionado não puder ser resolvido para uma identidade BLE (bond removido externamente). Antes retornava silenciosamente e deixava o estado `remove_pending` preso na UI. A operação continua sem apagar nenhum outro bond.
- `tests/test_mov09_remove_this.c`: contrato de tela 9×21, nome da identidade lógica e cores, cancelar sem exclusão, Help sem Lock, chave KEY A gera comando somente após release, proteção pending contra duplo comando, reação a falha e nova tentativa; mouse conectado versus inativo, saída do último bond.
- `tests/test_mov09_remove_runtime_source.py`: verifica invariantes do firmware Pico não cobertos pela UX host: captura e fixação da identidade, ordenação transacional do armazenamento de preferências e remoção dos bonds, rollback de preferências caso o flash falhe, notificação FAILED/REMOVED, neutralização HID do mouse conectado e o novo FAILED para bond já ausente.
- Registrados os dois testes no CMake/CTest. **58 testes host aprovados de 58** (56 anteriores + 2 MOV-09).

Build Pico 2 W de produção concluído com sucesso e artefato baixado do CI: `11687290125` (`blu2usb-picow-production-pico2w`). UF2 RP2350 multi-family validado (925.696 bytes; 1.808 blocos), SHA-256 `dbbeb26fd013facccacb226d8b9e3bdba487871a146560f18c8ed28130721bdc`. Comparado com MOV-08 aceito (SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`), **o arquivo difere** devido à correção de runtime. **É obrigatório gravar o novo UF2 para testar o MOV-09**, não usar o firmware antigo.

## Validação pendente
O teste host não simula flash/BTstack fisicamente, tampouco afirma que o hardware removeu um bond. O roteiro físico envolve **exclusão real** de um pareamento; avisar o operador claramente e não executar remoção por conta própria. Não há aceite físico MOV-09 nem MOV-10. Build de produção verificado, SHA-256 do UF2 e artefato do mesmo commit registrados acima. Aceite físico ainda pendente.
