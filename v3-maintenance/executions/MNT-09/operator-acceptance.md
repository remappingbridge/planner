# MNT-09 — aceite explícito do operador

Em 11/10/2026 o operador informou **"gate aceito"** depois de testar o firmware candidato MNT-09, cuja HOME CONNECTED exibe sempre `REMAPPING OPTIONS` na primeira opção, independente do perfil. O aceite é global; os resultados de cada cenário físico não foram informados individualmente.

- Candidato validado: branch `maintenance/v3x-mnt-09`, commit `98b773c992b8c1d2e83a41c33f8c59d1b9461410`.
- CI #505: 90/90 testes host e build de produção Pico 2 W aprovados.
- UF2 candidato SHA256 `7c5c4b5b52e7f7c74b23f4468ac5a21df686ccef8cc6fc07d306b0ad9bc658ba`.
- **Autorizado publicar v3.1.4 (PATCH)** e atualizar o planejamento de gates: o novo MNT-10 é a limpeza completa de dispositivo/bond ao remover de Saved Devices, o MNT-11 continua melhoria do nome BLE, antigo MNT-10 Zoom será MNT-12.
