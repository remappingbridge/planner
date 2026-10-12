# WEB-00 — Fixtures canônicas da UX v3.2.3

Arquivos lidos/extraídos do firmware no commit **`f38c5fd15c68ea9a36d3b05912727788d7b98e81`** e armazenados no **planner**, não no site:

- [screen-templates.json](v3.2.3/screen-templates.json): 45 telas, ordinais 0..44, nove linhas literais extraídas da tabela `screens[]` em `src/ux_model/ux_model.c`, `dynamicRows` do `DYN` original, opções de `blu2usb_ux_option_count`, linhas de foco de `renderer.c` e linha de hints por `first_hint_row`.
- [interaction-contract.json](v3.2.3/interaction-contract.json): ordem dos enums de HAT/perfil/targets/combo, lista literal de 31 labels do lookup `blu2usb_ux_shortcut_name` (0 = NOT CUSTOMIZED + 1..30 ações), cores `renderer.h`, medidas LCD, Movement em quartos, 3 rotas HOME e matriz de testes futuros MNT-12/MNT-13.

## Como essas fixtures foram produzidas e conferidas

Foi feita extração automatizada, usando JavaScript isolado e acesso de leitura ao GitHub:
1. Ler `include/blu2usb/ux_model/ux_model.h` do SHA fixado; extrair a ordem literal `BLU2USB_SCREEN_*` terminada em `BLU2USB_SCREEN_COUNT`.
2. Ler `src/ux_model/ux_model.c`; percorrer as 45 entradas `[BLU2USB_SCREEN_*] = {{ ... }, DYN(...) }` da tabela; extrair exatamente nove strings (`EMPTY` vira `""`) e máscaras `DYN`. **Nunca fazer `trim()` das strings originais.**
3. Conferir cada ID, ordem e `optionCount` com o `switch` original do modelo. Para focos, usar `selected_row()` e a sobreposição `blu2usb_ui_apply_selection_marker()` do renderer, incluindo o caso Saved Devices.
4. Ler `test_mnt13_selection_marker.c`, extrair todos os `menus[]` e confirmar cada um dos **27** menus/contagens de opções; validar que Saved Devices **não entra nesse array** porque `optionCount == 0` apesar de ter um botão implícito.
5. Extrair `BLU2USB_MOD_COMBO_*`, `names[31]`, `BLU2USB_CONTROL_*`, fontes/targets/paleta e ganho Motion do C. O processo detectou **12 combos, 30 atalhos, 9 controles**. Verificar o predicado MNT-12 em `blu2usb_ux_modifier_shortcuts_active` e testes do firmware.
6. Comparar campos e detectar overflow: duas strings do template `HELP_REMAPPER_OPTIONS` possuem comprimento 22 e o `blu2usb_ui_frame_set_text` do firmware corta até a coluna 20 (**21 células**). Preservá-las *sem edição* no JSON.

### Limites das fixtures

Estes arquivos **não** são dump do framebuffer renderizado. `templateRows` são strings da fonte, inclusive placeholders e strings maiores que 21; `dynamicRows` vem do bitmask do template, **não é inventário completo de todas as alterações dinâmicas do renderer** (ex.: nomes/conteúdo salvos, Movement, tintas/cores). Cada caso de execução exigirá primeiro `project`, depois `enforce_applied_visual_contract`, depois `apply_selection_marker`, e por último renderização Canvas.

Regras MNT-12/MNT-13 em JSON são **contratos para testes futuros**, não testes browser já executados. Os asserts realizados no WEB-00 foram somente estáticos e estão no [candidate.md](../executions/WEB-00/candidate.md). Para novos firmwares, criar **novo diretório de versão** e registrar diff/commit; não sobrescrever a fonte histórica de v3.2.3. No WEB-01 disponibilizar estas fixtures ao código web em formato compatível com JS puro e, em WEB-10, gerar goldens renderizados comparando Canvas com software C compilado.

## Checagens que bloqueiam próxima versão

- A versão nova tem a mesma contagem de telas? Se não, refazer matriz e gates afetados.
- Mudaram `renderer.c`, `profile_feedback.c`, `interaction.c` ou `ux_model.c`? Se sim, revalidar seleção, menus, cores e comando por comando — mesmo que IDs mantenham-se iguais.
- `mouse-ui` acompanha versão nova? Se não, classificar fonte firmware como prioridade, não importar regressões ou fixtures desatualizadas.
- Nenhum resultado de parser substitui aceite humano da aparência, foco/contrast e tempos de interação.

**Estado:** WEB-00 candidato, aguardando revisão. WEB-01 ainda não iniciado.
