# MNT-08 — preflight / contrato de renderização

**Fonte imutável:** commit da publicação formal MNT-07 `9ccc3f38b1bb697546d756f2fca3475d33204f2a`, correspondente ao conteúdo v3.1.2; branch `maintenance/v3x-mnt-08` criada exatamente desse SHA. Verificação de tag GitHub deve ocorrer antes da conclusão do gate.

**Escopo:** somente semântica de seleção/foco do LCD, sem mudança de textos, controles, BLE/HID, persistência ou cálculo Movement.

**Design:** normal `BLU2USB_UI_TONE_CURRENT` usa ciano pastel `0xD7FF` (MNT-07); nova cor selecionada `BLU2USB_UI_TONE_SELECTED_CURRENT` usa ciano normal `0x07FF`. `blu2usb_ui_tone_on_focus(normal)` converte `CURRENT -> SELECTED_CURRENT` e demais opções para `EMPHASIZED` branco. O fluxo de foco atua só nas linhas/span selecionáveis, nunca no ciano informativo. A UI de Profile/Remap, que reconstrói as cores em `profile_feedback.c`, utiliza a mesma função semântica.

**Regressões essenciais:** Movement (valor ciano por span, texto cinza branco no foco), DPI e Rotation (atual focado versus sem foco), Profile, Custom Remap, WILL BECOME, Shortcuts, Combinations, Saved Devices (nome conectado ciano pastel e ação REMOVE DEVICE branca), Help sem seleção. Grid 9×21 inalterado.

**Critérios:** CI completa host + Pico 2 W, UF2/checksum, PR draft e cenários físicos. **MNT-08 só terá aceite após o operador validar o contraste do par de cores junto ao MNT-07**, conforme aceite formal antecipado deste.
