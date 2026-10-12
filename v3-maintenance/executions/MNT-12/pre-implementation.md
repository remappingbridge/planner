# MNT-12 — Preflight / baseline imutável

**INICIADO por comando expresso do operador em 12/10/2026.** Gate único: indicador de ciano condicional em REMAPPING OPTIONS e valores de COMBINATIONS. MNT-13 e MNT-14 não começam.

- Base: tag oficial [v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1), SHA verificado **`3846e8f4ee5fba40421c0db1f51387de6c51e953`**.
- Branch de implementação: `maintenance/v3x-mnt-12` derivada da tag, não da main solta; versão embutida permanece **3.2.1** até futuro aceite físico.
- O predicado é exclusivamente derivado de `ux->active_profile == BLU2USB_MOUSE_PROFILE_CUSTOM_REMAP` E `ux->modifier_source >= 0 && < BLU2USB_MOUSE_SOURCE_COUNT`. `synchronize_ux_profiles()` atribui `modifier_source` dos `profiles->custom_targets` salvos; não usar `ux->custom_targets` (pode ser draft).
- `src/renderer/profile_feedback.c`: o contrato visual recompõe os 3 itens de REMAPPING OPTIONS após a projeção; o novo CURRENT da linha 3 deve ser incorporado **nessa etapa**, com foco via `blu2usb_ui_tone_on_focus`.
- `src/renderer/renderer.c`: COMBINATIONS começa com 4 linhas ACTIONABLE, depois aplica foco aos pares e por último força UNAVAILABLE como STATIC. Inserir CURRENT somente nas linhas 2/4 **entre reset e foco**, com shortcut atribuído e disponível, preservando selected-current e indisponibilidade.
- Cores já publicadas: `BLU2USB_UI_TONE_CURRENT = 0x07FF`, `BLU2USB_UI_TONE_SELECTED_CURRENT = 0xD7FF`; gray/white fora da condição. Não alterar paleta, layout 9×21, perfis por mouse, persistência BLE, HID, 12 combos, 30 shortcuts ou navegação.
- Testes host por célula/linha: 4 estados lógicos × foco, seis páginas, 2 slots em cada, NOT CUSTOMIZED/UNAVAILABLE, draft, transições CUSTOM/PASSTHROUGH/mouse, overlays em outros menus e regressões anteriores. Exigir CI oficial e UF2 Pico 2 W com SHA verificado.
- Documentação do gate: [MNT-12](../../gates/MNT-12.md). Até aceite do firmware: **PENDING**, sem tag/merge/release nova.
