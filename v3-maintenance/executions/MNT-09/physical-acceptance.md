# MNT-09 — validação física HOME CONNECTED

**Estado: PENDING.** PR #39 draft. Firmware candidato na versão interna v3.1.3; v3.1.4 **somente após aceite físico explícito**.

1. Instalar UF2 candidato Pico 2 W por BOOTSEL, sem `flash_nuke`.
2. Com mouse conectado e perfil PASSTHROUGH, confirmar HOME CONNECTED com primeira opção **`REMAPPING OPTIONS`** (texto fixo), mantendo o título com nome real do mouse e as demais opções MOVEMENT OPTIONS, SAVED DEVICES, PAIR NEW MOUSE intactas.
3. Usar JOY PRESS na primeira opção; a tela REMAPPING OPTIONS deve abrir normalmente, mantendo perfil e opções internos. KEY B retorna à HOME; seu primeiro item continua REMAPPING OPTIONS.
4. Ativar perfil CUSTOM e retornar à HOME. Confirmar primeira opção exatamente igual; não mostrar `REMAPPED TO CUSTOM`.
5. Reiniciar com CUSTOM persistido. Verificar primeira opção REMAPPING OPTIONS, e que o perfil CUSTOM continua ativo dentro de REMAPPING OPTIONS.
6. Reativar PASSTHROUGH, reiniciar e confirmar mesma legenda fixa. Verificar também as outras três opções, ordem, seleção e Ajuda; nome do mouse e cores de foco da v3.1.3 não mudaram.
7. Bluetooth, USB/HID, dados persistidos e lock/unlock continuam normais.

**Aceite MNT-09:** PENDING; nenhuma verificação física individual é presumida PASS.
