# MNT-01 — pré-implementação

**Gate iniciado em 2026-10-11 após pedido explícito "execute o primeiro gate".** Status: IN PROGRESS / NÃO ACEITO.

## Rastreabilidade
- Última release v3.x verificada via GitHub Releases: **v3.0.0**, tag SHA **`d7c7950fe595bd0e14a970cf60a29d085f065db4`**.
- Branch de trabalho criada deste SHA exato: [`maintenance/v3x-mnt-01`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-01).
- Escopo: **somente HF-01** da [matriz v3.x](../../01-backlog-and-contract.md), tela `BLU2USB_SCREEN_SAVED_DEVICES`.
- Versão **v3.0.1** é alvo condicionado a aceite físico, **não liberada**.

## Diagnóstico do baseline
- Em `src/renderer/renderer.c`, `project_saved_devices` escreve `REMOVE DEVICE` como `BLU2USB_UI_TONE_EMPHASIZED`, e duas linhas de dicas são projetadas genericamente.
- Posteriormente, `blu2usb_ui_project` aplica destaque genérico por tecla pressionada.
- `blu2usb_ui_enforce_applied_visual_contract` contém política v3.0 específica de Saved Devices que força **todos os textos não vazios em STATIC**, exceto o nome do mouse conectado, que fica em CURRENT. Portanto tanto REMOVE DEVICE quanto dicas aparecem com o amarelo padrão.
- Em `src/ux_model/ux_model.c`, `blu2usb_ux_option_count` devolve **0** para Saved Devices porque a navegação nesta tela usa JOY LEFT/RIGHT para paginação e JOY PRESS para entrar em REMOVE THIS sem lista interna com foco. Isso deve **permanecer**, sem acrescentar opção real ou mudar comandos.
- Teste legado `tests/test_mov08_saved_devices.c` (MOV-08) codifica o contrato visual antigo de todo texto STATIC; precisa ser atualizado para a nova especificação, sem reduzir cobertura de identidade, paginação, dados e destino Remove This.

## Contrato de mudança mínima
- `Saved Devices` com **bond válido**: título/PROFILE/DPI/ROTATION permanecem STATIC; só nome do Mouse conectado CURRENT; dica row7/8 ACTIONABLE (**LIGHT GRAY**); única opção real `REMOVE DEVICE` row5 **EMPHASIZED** (**WHITE**, foco implícito constante).
- `Saved Devices` sem bond (0 OF 0): `REMOVE DEVICE` aparece **ACTIONABLE** cinza como desabilitada, pois não é uma ação que o usuário possa executar; JOY PRESS continua inócuo. A página vazia não é removida e evita falsa seleção de exclusão. Se for exigido branco também em 0 OF 0, validar com operador, não inventar ação.
- Pressionar e segurar KEY/JOY não recolore dicas; em Saved Devices prevalece o contrato explícito, fora dela nada muda.
- Não alterar UX model, BLE/storage/pairing, identidade USB, MIDI/Consumer, Movement, grade 9×21, rótulos, paleta ou fluxos futuros.
- Testar 1 e 3 bonds, ativo e desconectado, outras páginas, 0 bonds e JOY PRESS/KEY B, posições/tonalidades célula por célula.

## Entrega e gate
- CI host integral + Pico 2 W Release, UF2 SHA-256 verificado, PR draft, docs de candidato e roteiro físico desde HOME CONNECTED.
- **PENDING** até operador reportar testes físicos e disser `gate aceito`; somente nesse momento ocorrerão merge, version bump e publicação v3.0.1.
