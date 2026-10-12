# WEB-00 — Índice canônico das 45 telas do firmware v3.2.3

**Fonte:** [ux_model.h](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/include/blu2usb/ux_model/ux_model.h), [ux_model.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/ux_model/ux_model.c) e [renderer.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/renderer/renderer.c). IDs e ordinais **não devem ser renumerados**; a matriz a seguir foi montada e validada a partir de `fixtures/v3.2.3/screen-templates.json`.

Os valores de `templateRows` representam o **template antes** de qualquer projeção dinâmica do firmware, não uma captura renderizada. Campos alterados em runtime estão em `dynamicRows`. Os estilos finais e o pipe dependem das condições C e devem ser testados com cenários reais em WEB-02..10.

| # | ID | Título do template | Opções UX | Linha de foco MNT-13 | Linhas dinâmicas |
|---:|---|---|---:|---|---|
| 0 | `HOME` | `UNKNOWN MOUSE` | 4 | 1/2/3/4 | 0 |
| 1 | `HELP_HOME_CONNECTED` | `REMOVE CONNECTED HELP` | 0 | — | — |
| 2 | `HOME_SEARCHING` | `SEARCHING SAVED MOUSE` | 2 | 1/2 | — |
| 3 | `HOME_SEARCHING_HELP` | `HOME SEARCHING HELP` | 0 | — | — |
| 4 | `HOME_RETRY` | `DEVICE NOT FOUND` | 2 | 1/2 | — |
| 5 | `HOME_RETRY_HELP` | `HOME RETRY HELP` | 0 | — | — |
| 6 | `MOUSE_OPTIONS` | `REMAPPING OPTIONS` | 3 | 1/2/3 | — |
| 7 | `HELP_REMAPPER_OPTIONS` | `REMAPPING OPTIONS HELP` | 0 | — | — |
| 8 | `PAIR_MOUSE` | `PAIR NEW MOUSE` | 0 | — | — |
| 9 | `HELP_PAIR_NEW` | `PAIR NEW DEVICE HELP` | 0 | — | — |
| 10 | `RETRY_PAIR_NEW` | `NEW MOUSE NOT FOUND` | 0 | — | — |
| 11 | `HELP_RETRY_PAIR_NEW` | `MOUSE NOT FOUND HELP` | 0 | — | — |
| 12 | `MOUSE_SAVED` | `FIRST MOUSE CONNECTED` | 0 | — | — |
| 13 | `APPLY_PASSTHROUGH` | `APPLY PASSTHROUGH` | 0 | — | — |
| 14 | `PASSTHROUGH_APPLIED` | `PASSTHROUGH ACTIVE` | 0 | — | — |
| 15 | `EDIT_CUSTOM` | `EDIT CUSTOM REMAP` | 5 | 1/2/3/4/5 | 1,2,3,4,5 |
| 16 | `LEFT_WILL_BECOME` | `LEFT WILL BECOME` | 6 | 1/2/3/4/5/6 | — |
| 17 | `RIGHT_WILL_BECOME` | `RIGHT WILL BECOME` | 6 | 1/2/3/4/5/6 | — |
| 18 | `MIDDLE_WILL_BECOME` | `MIDDLE WILL BECOME` | 6 | 1/2/3/4/5/6 | — |
| 19 | `FORWARD_WILL_BECOME` | `FORWARD WILL BECOME` | 6 | 1/2/3/4/5/6 | — |
| 20 | `BACKWARD_WILL_BECOME` | `BACKWARD WILL BECOME` | 6 | 1/2/3/4/5/6 | — |
| 21 | `SAVED_DEVICES` | `0 OF 0` | 0 | 5 (somente bond) | 0,1,2,3,4 |
| 22 | `REMOVE_THIS` | `REMOVE THIS MOUSE` | 0 | — | 1 |
| 23 | `HELP_REMOVE_THIS` | `REMOVE MOUSE HELP` | 0 | — | — |
| 24 | `SEARCHING_FIRST` | `SEARCHING FIRST MOUSE` | 0 | — | — |
| 25 | `MOVEMENT_OPTIONS` | `MOVEMENT OPTIONS` | 3 | 1/2/4 | — |
| 26 | `HORIZONTAL_SLOW_DPI` | `HORIZONTAL SLOW DPI` | 4 | 1/2/3/4 | — |
| 27 | `HORIZONTAL_FAST_DPI` | `HORIZONTAL FAST DPI` | 4 | 1/2/3/4 | — |
| 28 | `VERTICAL_SLOW_DPI` | `VERTICAL SLOW DPI` | 4 | 1/2/3/4 | — |
| 29 | `VERTICAL_FAST_DPI` | `VERTICAL FAST DPI` | 4 | 1/2/3/4 | — |
| 30 | `ROTATION` | `ROTATION` | 4 | 1/2/3/4 | — |
| 31 | `HELP_SLOW_DPI` | `SLOW DPI HELP` | 0 | — | — |
| 32 | `HELP_FAST_DPI` | `FAST DPI HELP` | 0 | — | — |
| 33 | `HELP_ROTATION` | `ROTATION HELP` | 0 | — | — |
| 34 | `COMBINATIONS_1` | `COMBINATIONS 1 OF 6` | 2 | 2/4 | 2,4 |
| 35 | `COMBINATIONS_2` | `COMBINATIONS 2 OF 6` | 2 | 2/4 | 2,4 |
| 36 | `COMBINATIONS_3` | `COMBINATIONS 3 OF 6` | 2 | 2/4 | 2,4 |
| 37 | `COMBINATIONS_4` | `COMBINATIONS 4 OF 6` | 2 | 2/4 | 2,4 |
| 38 | `COMBINATIONS_5` | `COMBINATIONS 5 OF 6` | 2 | 2/4 | 2,4 |
| 39 | `COMBINATIONS_6` | `COMBINATIONS 6 OF 6` | 2 | 2/4 | 2,4 |
| 40 | `SHORTCUTS_1` | `SHORTCUTS 1-6 OF 30` | 6 | 1/2/3/4/5/6 | — |
| 41 | `SHORTCUTS_2` | `SHORTCUTS 7-12 OF 30` | 6 | 1/2/3/4/5/6 | — |
| 42 | `SHORTCUTS_3` | `SHORTCUTS 13-18 OF 30` | 6 | 1/2/3/4/5/6 | — |
| 43 | `SHORTCUTS_4` | `SHORTCUTS 19-24 OF 30` | 6 | 1/2/3/4/5/6 | — |
| 44 | `SHORTCUTS_5` | `SHORTCUTS 25-30 OF 30` | 6 | 1/2/3/4/5/6 | — |

## Controles e transições normativas (exemplos de roteamento)

| Origem/estado | Controle ou evento validado | Efeito esperado no modelo |
|---|---|---|
| `SEARCHING_FIRST`, nenhum bond | HAT | Didático; não navega. Evento virtual **CONNECT** é do laboratório, não tecla física do HAT |
| `HOME` conectado | JOY UP/DOWN | Seleção circular em 4 opções |
| `HOME` conectado | JOY PRESS | Selecionados: `MOUSE_OPTIONS`, `MOVEMENT_OPTIONS`, `SAVED_DEVICES`, `PAIR_MOUSE` |
| `HOME_SEARCHING` e `HOME_RETRY` | JOY PRESS | Selecionados: `SAVED_DEVICES`, `PAIR_MOUSE` |
| `MOUSE_OPTIONS` | JOY PRESS | Passthrough ativo/confirmar; Custom edit; Combinations 1 |
| `EDIT_CUSTOM` | JOY PRESS / KEY A | Abrir `*_WILL_BECOME` / emitir APPLY_CUSTOM sem aplicar antes do sucesso |
| `*_WILL_BECOME` | KEY A | Emitir CUSTOM_SET_TARGET; retornar ao editor **após confirmação** |
| `MOVEMENT_OPTIONS` | JOY PRESS | Horizontal, vertical ou rotation de acordo com seleção |
| `MOVEMENT_OPTIONS` | KEY A | Emitir APPLY_MOVEMENT defaults (Reset All) |
| `HORIZONTAL_*_DPI` ou `VERTICAL_*_DPI` | LEFT/RIGHT | Alterna paginação SLOW/FAST do mesmo eixo |
| `*_DPI` ou `ROTATION` | KEY A | Emitir APPLY_MOVEMENT; só confirmar após resultado |
| `COMBINATIONS_1..6` | LEFT/RIGHT | Páginas com wrap; seleção preservada |
| `COMBINATIONS_1..6` | JOY PRESS | Abrir SHORTCUTS correto, salvo se combinação UNAVAILABLE |
| `COMBINATIONS_1..6` | KEY A | RESET da combinação atribuída selecionada, nunca mexer nas demais |
| `SHORTCUTS_1..5` | LEFT/RIGHT | Páginas 1..5 com wrap; mantém/restaura foco adequado |
| `SHORTCUTS_1..5` | KEY A | Emitir SET_SHORTCUT, commit antes do retorno a COMBINATIONS |
| `SAVED_DEVICES` | LEFT/RIGHT / JOY PRESS | Paginar bond / abrir REMOVE_THIS, se houver bond válido |
| `REMOVE_THIS` | KEY A / KEY B / KEY X | Emitir REMOVE_MOUSE com confirmação / voltar / Help; durante pending não permitir transações conflitantes |
| Telas Help | KEY B / KEY Y | Retornar ao dono / bloquear; demais eventos consumidos |
| LOCKED | primeira sequência press-release válida | Desbloquear e resolver HOME; não acionar opção no mesmo evento |
| `PAIR_MOUSE` e buscas | eventos virtuais sucesso/timeout/cancelamento | Atualizar UX por adaptador mock; não representar conexão BLE real |

**Atenção:** evento de HAT tem transição PRESS seguida de RELEASE e só a segunda dispara a ação (fonte [interaction.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/interaction/interaction.c)). Eventos mock de conexão, timeout, persistência e falhas não são ações do firmware HAT. A matriz acima é índice de contrato, **não execução automática nem transição exaustiva**. A máquina C é a autoridade para condições secundárias, `return_selection`, Help e cancelamentos.

## Cores, layout e seleção

- Renderer em 240×240, 9 linhas×21 colunas, origem textual 7,8, glyph 5×7 ampliado 2× e char advance 11; os valores definitivos estão em `interaction-contract.json`.
- Títulos: magenta `0XF81F`; amarelo estático `0XFFB8`; cinza `0XC618`; branco `0XFFFF`; ciano `0X07FF` e ciano focado `0XD7FF`.
- MNT-13: COMBINATIONS `2/4` (valor/status); MOVEMENT `1/2/4`; SAVED_DEVICES linha `5` **apenas** se houver bond; todos os outros menus têm `1+selection`. Em tela sem menu ou seleção inválida, pipe não aparece.
- MNT-12: perfil Custom **aplicado** E Modifier aplicado, ambos, ativa ciano na linha 3 de `MOUSE_OPTIONS`; em combos, apenas o **valor** atribuído/disponível, se essa condição persistir.
- Renderer físico trunca strings-fonte de mais de 21 caracteres por `blu2usb_ui_frame_set_text`: `HELP_REMAPPER_OPTIONS` linhas `0` e `2` têm 22 caracteres. O port **não pode corrigir o conteúdo original**; reproduz corte no framebuffer.
- A única divergência visual web prevista é clarear de modo documentado o fundo dark-magenta `0X0801`, após aceite visual, sem modificar os tons de texto.
- UI web: brilho no navegador exclusivamente **0–100%**, brilho físico da LCD **não** é alterado. Controlar tamanho pelo zoom CSS, não por intensidade >100%.

## Linhagem e exclusões

- C antigo mantém `BLU2USB_MOUSE_PROFILE_DEFAULT_REMAP` e `BLU2USB_MOUSE_PROFILE_ESCAPE_REMAP` para compatibilidade de enum; **não** os incluir como opções de remapping v3.
- `LEARN THE KEYS` como item de menu foi retirado. `SEARCHING_FIRST` é didático e permanece.
- O antigo `mouse-ui-legacy-v1` é material de inspiração para ferramentas de laboratório, não fonte para textos, opções e lógica de v3.
- Este documento e JSONs são artefatos **de baseline**, não projeto web implementado nem fixture de framebuffer capturado em tempo de execução.
