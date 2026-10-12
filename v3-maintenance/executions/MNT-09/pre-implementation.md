# MNT-09 — preparação de HOME CONNECTED

- MNT-08 recebeu aceite físico do operador em 11/10/2026; v3.1.3 foi versionada e integrada pelo PR #38, squash commit `93077730ef447351b354b8994b620fcfc0a1963a`. Confirmar a tag oficial antes de encerrar o gate.
- Escopo MEL-07: **a primeira opção** da HOME CONNECTED deve ser sempre ` REMAPPING OPTIONS`, independentemente de perfil Custom ou Passthrough, incluindo depois de reinicialização.
- Estado atual identificado: `screens[BLU2USB_SCREEN_HOME]` linha 1 é template ` NO REMAP PASSTHROUGH` marcado DYN(1); `src/renderer/renderer.c` chama `home_profile_summary(ux->active_profile)` e substitui a linha 1 por texto dependente do perfil. A seleção `selection=0` já abre `BLU2USB_SCREEN_MOUSE_OPTIONS`. Não alterar isso.
- Alteração mínima proposta: trocar template de linha 1 para ` REMAPPING OPTIONS` fixo, remover dependência `DYN(1)` e retirar helper dinâmico não utilizado. Manter DYN(0) do nome do mouse. Contratos 9×21, foco, títulos, BLE/HID e perfis/persistência intocados.
- Testar ambos os perfis, seleção/JOY PRESS, outras três opções, retorno Home, Help e nome atual; executar CI host completa e Pico 2 W; distribuir UF2 candidato com hash para aceite físico. Publicação prevista após aceite: v3.1.4 PATCH.
