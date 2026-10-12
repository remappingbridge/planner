# MNT-11 — validação física: nome BLE sem MOUSE duplicado

**STATUS: PENDING.** Não aceite automaticamente. PR #41 draft, candidato a disponibilizar após CI host completa e build Pico 2 W; firmware ainda contém versão interna v3.2.0. Futuro release v3.2.1 somente após aceite explícito.

1. Gravar o novo UF2 via BOOTSEL **sem `flash_nuke`**, preservando os bonds, perfis, atalhos e ajustes personalizados MNT-10.
2. Em HOME CONNECTED e Saved Devices, confirmar que `BTS. 0MOUSE2` aparece como **`BTS. 0MOUSE2`** (sem ` MOUSE` duplicado). A grafia é convertida para maiúsculas somente na tela, tal como na versão anterior.
3. Verificar nomes que já contêm substring (case-insensitive): `mOuSe2` → `MOUSE2`, `MOUSE-123` → `MOUSE-123`, `MOUSEPAD` → `MOUSEPAD`, `SuperMousePad` → `SUPERMOUSEPAD`.
4. Verificar nome sem substring: `LIFT` → `LIFT MOUSE`; `LOGITECH LIFT` → `LOGITECH LIFT MOUSE` quando cabe. Sem nome, só espaços ou nome composto por caracteres sem suporte → `UNKNOWN MOUSE`.
5. Com nome maior que 15 caracteres, verificar limite do LCD 9×21 e que a detecção de `MOUSE` foi feita no nome inteiro **antes** do truncamento. Caso com a subsequência após o 15º caractere não deve acrescentar ` MOUSE` no display.
6. Desligar/religar mouse, reconectar, visitar vários Saved Devices e retornar a HOME: a normalização deve permanecer idêntica; o nome BLE bruto, bonds, perfis individuais, DPI, Rotation, Modifier e atalhos não podem ser alterados.
7. Testar Help/Lock e retorno HOME sem regressões. Se o nome capturado de seu mouse real não contiver a substring `MOUSE`, ainda deve receber um único sufixo ` MOUSE` na UI.

**Observação:** os casos artificiais de nome exigem dispositivo que anuncie aqueles nomes; a CI host exercita todos os casos. No teste físico, use o(s) nomes BLE dos mouses disponíveis, sem exigir renomeá-los pelo firmware.

**Aceite físico MNT-11: PENDING.**
