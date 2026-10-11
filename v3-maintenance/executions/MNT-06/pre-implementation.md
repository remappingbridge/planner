# MNT-06 — preflight

- Dependência obrigatória: tag oficial v3.1.0 após MNT-05 aceito.
- Item MEL-03: exclusivamente substituir legenda ` KEY Y: LOCK` por `KEY Y: LOCKS ANYWHERE` na tela `BLU2USB_SCREEN_MOUSE_SAVED` (`FIRST MOUSE CONNECTED`).
- Preservar 9 linhas × 21 colunas, todas as interações existentes, bloqueio universal e desbloqueio global para HOME, sem alterar outras telas.
- Branch a partir de tag v3.1.0; PR draft, CI host completa + Pico 2 W produção, UF2 com SHA, teste físico desde FIRST MOUSE CONNECTED; somente após aceite versionar v3.1.1.
- A partir do estado observado na main, rótulo atual é ` KEY Y: LOCK`. Não iniciar branch de fonte enquanto tag v3.1.0 estiver pendente.
