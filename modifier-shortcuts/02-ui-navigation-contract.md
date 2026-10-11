# 02 — Contrato de telas, seleção, paginação e copy

## Fluxo canônico
`home-connected → remapping-options → combinations-1..6 → shortcuts-1-6 / shortcuts-7-12 / shortcuts-13-18 / shortcuts-19-24 / shortcuts-25-30 → KEY A: APPLY AND BACK → combinations (mesma página/linha)`.

A terceira opção da nova `remapping-options` é `MODIFIER SHORTCUTS`. As opções são **PASSTHROUGH DEFAULT**, **CUSTOM REMAPPING** e **MODIFIER SHORTCUTS**, nessa ordem. Não há perfil chamado "Modifier Shortcuts": é editor global separado do seletor de perfil. Metadata/canonical slug `remapping-options` substitui `remapper-options`; não deixar alias visível antigo. Atualizar Help da tela para não anunciar Standard/Escape removidos.

## Páginas de combinações (ordem normativa)
| Página | Combo da linha lógica 0 | Combo da linha lógica 1 |
|---|---|---|
| combinations-1 | MODIFIER RELEASED IS | MOD + MIDDLE IS |
| combinations-2 | MOD + LEFT CLICK IS | MOD + RIGHT CLICK IS |
| combinations-3 | MOD + FORWARD IS | MOD + BACKWARD IS |
| combinations-4 | MOD + WHEEL UP IS | MOD + WHEEL DOWN IS |
| combinations-5 | MOD + MOVE LEFT IS | MOD + MOVE RIGHT IS |
| combinations-6 | MOD + MOVE UP IS | MOD + MOVE DOWN IS |

Renderizar *duas linhas físicas por combo*: (r1 r2) primeira legenda/valor, (r3 r4) segunda legenda/valor. Linha 0 = título `COMBINATIONS N OF 6`; linha 5 vazia; 6 = `JOY LEFT\RIGHT: PAGE`; 7 = `JOY PRESS: ACCESS`; 8 = `KEY A: RESET SELECTED`. Mostrar valor **NOT CUSTOMIZED**, **UNAVAILABLE** ou nome da ação atribuída. **Não** incluir comentários entre parênteses no display. A dupla selecionada é uma única opção (seleção 0/1); destaque branco deve abranger a unidade lógica sem transformar `UNAVAILABLE` em ação acessível. Páginas dão wrap 1↔6; up/down dão wrap 0↔1.

### Regras de estado
- `UNAVAILABLE` só para a combo que usa o mesmo source físico atualmente escolhido como MODIFIER (MIDDLE/LEFT/RIGHT/FORWARD/BACKWARD); não para RELEASED, WHEEL ou MOVE.
- `JOY PRESS` em disponível abre o seletor de 30 atalhos com indicação da seleção previamente atribuída. Se não havia atribuição, default de foco é primeira ação (COPY), **sem persistência antes de aplicar**. Em UNAVAILABLE é no-op.
- `KEY A` reseta **apenas a combo selecionada** para NOT CUSTOMIZED (e confirma gravação antes de refletir a UI). Em UNAVAILABLE é no-op mesmo se existir valor previamente guardado.
- `KEY B` sai para remapping-options, sem alteração. `KEY Y` conserva Lock (sem executar atalhos).
- Não inventar novo Help porque o anexo não fornece layouts; `KEY X` segue política preexistente apenas se houver conteúdo aprovado. Isso é uma lacuna de copy a validar em MOD-00.

## Páginas de atalhos
| Tela/intervalo | Itens na ordem |
|---|---|
| shortcuts-1-6 | COPY, CUT, SELECT ALL, PASTE, UNDO, REDO |
| shortcuts-7-12 | ESCAPE, SPACE, ENTER\RETURN, BACKSPACE, DELETE, RENAME |
| shortcuts-13-18 | FULL SCREEN, SCREENSHOT FULL, SCREENSHOT AREA, REFRESH, FIND, SAVE |
| shortcuts-19-24 | PLAY\PAUSE, NEXT TRACK, PREVIOUS TRACK, VOLUME UP, VOLUME DOWN, MUTE |
| shortcuts-25-30 | HOME SCREEN\PAGE, ZOOM IN, ZOOM OUT, RESET ZOOM, BRIGHTNESS UP, BRIGHTNESS DOWN |

Tela de 9 linhas: título `SHORTCUTS X-Y OF 30`, linhas 1..6 com opções, linha 7 em branco, linha 8 `KEY A: APPLY AND BACK`. Joy Up/Down move foco em seis itens; Joy Left/Right muda página com wrap 1↔5; ao paginar a seleção deve restaurar a ação prévia quando estiver nessa página, senão preservar índice da linha (inferencia). `KEY A` salva e retorna à combinação de origem (mesma página e linha), com label atualizado; `KEY B` cancela draft e volta; `JOY PRESS` **não aplica** (é apenas uma inferência conservadora: único comando de aplicar indicado é KEY A). Sucesso depende da persistência; falha mantém editor aberto e mapping anterior.

## Outras telas alteradas
- As 5 `{LEFT,RIGHT,MIDDLE,FORWARD,BACKWARD} WILL BECOME` trocam o item **ESCAPE** por **MODIFIER** na mesma posição; as demais entradas mantêm ordenação. `KEY A: APPLY AND BACK` preservado.
- Remover rotas/feedback e status legados Standard/Escape de `home-connected`, `Saved Devices/PROFILE` e Help. Somente `PASSTHROUGH` ou `CUSTOM` constam como perfil; atalhos são configuração complementar e não "perfil".
- Cores v2: título magenta, texto estático amarelo, opção selecionada branco, valor atual ciano **exceto** Saved Devices (somente nome do Mouse ativo é ciano, todos os demais textos amarelos). `UNAVAILABLE` é visualmente estático/desabilitado, nunca ciano por estar selecionado.

## Copy literal a congelar em MOD-00
O anexo possui `PASSTHROUGT` (vs `PASSTHROUGH`), `WHELL` (vs `WHEEL`), `0F` (zero vs O) e `NOT CUSTMIZED` (vs regra textual `NOT CUSTOMIZED`). Estes documentos usam o **vocabulário semântico corrigido** para explicar a arquitetura, mas a implementação **NÃO deve corrigir silenciosamente** os textos desenhados: criar fixture 9×21 baseada no literal e obter decisão explícita do operador no gate MOD-00. O mesmo vale para `MOD + LEFT CLICK` versus `MOD + RIGHT CLICK`, nomenclatura de barra `\` e cabeçalhos.
