# MNT-07 — validação física do ciano claro

**PENDENTE: operador ainda não confirmou esta alteração no hardware.**

1. Gravar UF2 candidato Pico 2 W via BOOTSEL, sem `flash_nuke`.
2. Na HOME CONNECTED, observar todos os textos que usam ciano: agora devem ter tonalidade clara esbranquiçada uniforme.
3. Em SAVED DEVICES, conferir que só o nome do mouse conectado está no novo ciano; dados do mouse permanecem amarelos, dicas cinzas, REMOVE DEVICE branco e título magenta.
4. Navegar por MOVEMENT OPTIONS, horizontal/vertical DPI, ROTATION, PROFILE, REMAPPING OPTIONS, COMBINATIONS 1–6 e SHORTCUTS, comparando as marcações de seleção e o texto ciano.
5. Visitar HELPS: título magenta, dicas e contraste anteriores preservados; B retorna; KEY Y bloqueia e desbloqueio volta HOME.
6. Examinar sob iluminação normal: novo ciano claro RGB565 `0xBFFF` deve permanecer distinguível do branco (`0xFFFF`) e do cinza (`0xC618`), sem reduzir legibilidade.
7. Regressão: mouse BLE, USB HID, ajustes e persistência não sofreram alteração.

**Aceite global:** PENDING. A escolha definitiva da cor depende do teste no dispositivo.
