# MNT-05 — preflight e implementação

- Base imutável: tag publicada `v3.0.4`, após aceite MNT-04.
- Branch: [`maintenance/v3x-mnt-05`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-05).
- PR candidato: [#35](https://github.com/remappingbridge/remappingbridge/pull/35), draft até aceite.
- Escopo MEL-04: em todas as dez telas Help, `KEY B: BACK` substitui `ANY KEY: BACK`; somente KEY B sai, KEY Y bloqueia e desbloqueia mantendo a tela Help, os demais botões são inertes.
- Implementação centralizada em `src/ux_model/ux_model.c`: caminho `is_help()` antes das outras ações; unlock preserva tela Help; retorno B conserva foco e contexto (Searching Help retorna Retry conforme contrato anterior, Remapping Help retorna Options).
- Proteção Remove This: Help não emite comando de exclusão; KEY A é inerte dentro da ajuda.
- Teste `test_mnt05_help_lock.c` itera sobre as dez telas Help, todos os controles, lock/unlock e B.
- Não alterar HID/USB, BLE, persistência, matemática Movement ou Modifier.
- Versionamento futuro: `v3.1.0` MINOR **somente após aceite físico**.
