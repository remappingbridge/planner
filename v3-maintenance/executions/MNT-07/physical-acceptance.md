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

## Ajuste do teste físico — segunda revisão
Apenas avaliar o **novo ciano pastel `0xD7FF`**. O anterior `0xB65A` foi rejeitado por escuro, e `0xBFFF` foi considerado razoável, porém forte. Esperado: ciano semelhante ao `0xBFFF`, mais suave e claro, **não** aproximado do cinza padrão. Em SAVED DEVICES, comparar o nome do mouse ativo com outros textos e confirmar contraste em iluminação real. Registrar aceite somente depois de instalar o novo UF2.
