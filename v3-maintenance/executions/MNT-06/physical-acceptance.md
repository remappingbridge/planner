# MNT-06 — FIRST MOUSE CONNECTED (teste físico)

**Status: PENDING.** Candidato na branch `maintenance/v3x-mnt-06`, PR #36. Não publicar v3.1.1 antes de aceite explícito.

1. Instalar UF2 candidato por BOOTSEL, **sem flash_nuke**.
2. No fluxo de **primeiro mouse conectado**, confirmar título FIRST MOUSE CONNECTED e última linha exata `KEY Y: LOCKS ANYWHERE` (21 colunas, sem truncamento, cor e alinhamento padrões).
3. Pressionar KEY Y e confirmar bloqueio; desbloquear com um controle e verificar retorno global para HOME sem executar a ação desse controle.
4. Abrir qualquer Help e confirmar que KEY Y bloqueia, desbloqueio retorna HOME, B retorna à tela de origem quando desbloqueado, e A/X/JOY são inertes em Help.
5. Conferir que Saved Devices, Movement, Remapping, Modifier Shortcuts, HID e pareamento BLE continuam iguais à v3.1.0; reinicialização não apaga configurações.

**Aceite físico global:** PENDING; resultados individuais não comunicados.
