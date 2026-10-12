# 04 — Decisões de planejamento, evidências e riscos

**Somente planejamento, não execução.** Autoridade 1: pedido textual do operador; 2: [tag v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0) e fontes nela; 3: histórico aceito [modifier-shortcuts](../modifier-shortcuts/README.md) e [movement-options](../movement-options/README.md); 4: inferências aqui rotuladas.

## Decisões que evitam ambiguidades
1. **Numeração 8 duplicada:** pedido explícito "inclua como melhoria numero 8" corresponde à pendência atual **Zoom no Obsidian**. Por isso MEL-08=Zoom; o nome BLE antes rotulado `## 8` vira **MEL-09**. Ambos preservados.
2. **Hotfixes 2 e 3 indivisíveis:** indicação visual de KEY X e ação de KEY X devem sair num único UF2/release; manter ambos como itens separados no backlog para rastreabilidade, mas agrupados no MNT-02.
3. **Hotfix 1 cor/seleção:** só há uma opção operacional em SAVED DEVICES; ela deve vir destacada branco sem alterar o status do nome do mouse. Não confundir linhas PROFILE, DPI, ROTATION e dicas com opções ativas.
4. **Fidelidade textual:** `HORIZINTAL` no pedido é grafia informal; a tela v3 diz `HORIZONTAL DPI`, preservá-la. Exigir retirar `x` apenas das linhas de resumo de Movement Options, sem mudar o cálculo de escala nem necessariamente as telas Slow/Fast.
5. **Slash:** `/` é delimitador VISÍVEL na UI, não substituição global de sequências C `\n`, `\0` ou caminhos e dados; verificar `HOME SCREEN/PAGE` e captions.
6. **Ordem dos gates MEL-04/MEL-03:** implementar Help/Lock global (MNT-05, v3.1.0) antes da dica `KEY Y: LOCKS ANYWHERE` (MNT-06, v3.1.1), apesar de a lista original apresentar MEL-03 primeiro. Evitar versão intermediária que promete lock global antes de estar válido. **KEY Y durante Help:** lock tem precedência sobre outras teclas quando Help aberto, desbloqueio não executa BACK. `KEY B` volta somente fora de lock. Abrir Help a partir de Remove This não permite remoção acidental.
7. **Cores:** nomes são papéis relativos (cinza padrão, branco selecionado, ciano normal, ciano claro esbranquiçado), não valores RGB inventados. Conferir palette atual da v3 e medições de legibilidade no LCD antes de escolher código. Antes de MEL-06, MEL-05 só muda a base do destaque; depois, apenas texto **selecionável** de destaque muda para o ciano normal selecionado. Não converter todo texto amarelo nem nomes de mouse desconectado em ciano.
8. **HOME Connected:** substituir texto dinâmico **apenas na primeira opção** por `REMAPPING OPTIONS`, preservar destino e estado real do perfil; não perder estado de Custom/Passthrough persistente.
9. **MOUSE dentro de outros caracteres:** a v3.0.0 atualmente busca a palavra `MOUSE` com fronteiras de palavra; o usuário quer **subsequência independente de fronteiras**. Alterar a decisão de sufixo, não as strings reais informadas via BLE. Normalizar nomes para HOME e Saved Devices sem duplicar lógica.
10. **Zoom:** evidência de teclado físico OK e RemappingBridge apenas navegador OK **é defeito de equivalência de entrada potencial**, não autorização para hard-code `Obsidian`. O log de `evtest event0` mede teclado AT integrado. Antes de trocar HID map, obter node próprio do BLU2USB e comparar. `RESET ZOOM` já funciona, regressão proibida.
11. **SemVer v3.x:** TAG `v3.0.0` é baseline estável, e v4 não se aplica. Cosmetic/bug fix PATCH; Help behavior deliberate MINOR. O cronograma de tags pode mudar por release intermediário; não saltar números, nunca tag sem código/aceite.
12. **Guarda operacional:** usuário pediu **não implementar agora**. Alterar só `remappingbridge/planner`; não criar branches de firmware, CI, releases, tags ou arquivos UF2 nesta etapa.

## Evidências verificadas no baseline v3.0.0
- Tag **`v3.0.0` = `d7c7950fe595bd0e14a970cf60a29d085f065db4`**, publicada 2026-10-11.
- `src/ux_model/ux_model.c`: `BLU2USB_SCREEN_SAVED_DEVICES` tem `REMOVE DEVICE`; `BLU2USB_SCREEN_REMOVE_THIS` mostra `KEY Y: HELP`; diversas ajudas mostram `ANY KEY: BACK`; `BLU2USB_SCREEN_MOUSE_SAVED` contém `KEY Y: LOCK`.
- `src/renderer/renderer.c`: formata `HORIZONTAL DPI ...x` e `VERTICAL DPI ...x` em MOVEMENT OPTIONS; a rotina de nome acrescenta ` MOUSE` quando `MOUSE` não ocorre como palavra inteira; o texto inicial da HOME é preenchido dinamicamente com perfil.
- `README.md` da v3.0.0 confirma hardware e identidade USB, 30 atalhos, 12 combos e compatibilidade de flash. Nenhum bug registrado aqui foi "corrigido" no firmware por este planejamento.

## Principais riscos e contramedidas
- **Quebra de navegação** com Help only-B: testar TODAS as páginas Help/return screen e interação KeyY lock, inclusive fluxo de exclusão, após alteração.
- **Cores com baixo contraste**: não assumir que "ciano mais claro" é visível; inspeção no LCD, cores no selecionado e no não selecionado.
- **Legendas >21 colunas**: validar `KEY Y: LOCKS ANYWHERE` e todas as variantes traduzidas para LCD; sem truncar.
- **Nome BLE truncado**: teste nomes contendo `MOUSE` após o 21º caractere; critério decidido pelo conteúdo original completo antes da formatação/truncamento, sem corromper UTF-8.
- **Zoom dependente de layout/host**: comparar evdev/XKB para ABNT2 antes de escolher usage, não quebrar navegador/Android.
- **Perda de bonds/perfis**: update UF2 normal, nunca flash_nuke; verificar storage v3 após cada gate e respeitar downgrade v2 não totalmente compatível.
- **Lançamento prematuro ou tag errada**: exigir CI do commit final versionado, SHA UF2 e GitHub Release, recuperação de falha de publish sem tag duplicada.

## Revisão de escopo após aceite MNT-09 (11/10/2026)

- **Novo MNT-10 / MEL-10:** priorizar exclusão completa do dispositivo e de **todas as configurações associadas apenas à identidade do mouse**. A exclusão atual remove bonds/nomes/Movement TLV, porém `blu2usb_profiles_t` é restaurado do storage global no boot: investigar e corrigir a separação de profiles/shortcuts por identidade BLE antes de considerar o defeito solucionado. **Apagar o perfil global inteiro é proibido** se prejudicar outros mouses.
- **MNT-11 existente / MEL-09:** detecção de substring MOUSE em nome BLE foi preservada na sequência, após a publicação do novo MNT-10.
- **MNT-15 / MEL-08:** Zoom foi movido **MNT-10 → MNT-12 → MNT-14 → MNT-15**; requisitos e suspensão preservados, sem autorização de hard-code por aplicativo.
- **Persistência e integridade:** definir formato/escopo/retrocompatibilidade de dados por bond, controle de falha parcial, limpeza idempotente e defaults de pareamento; slots reciclados/IRK/RPA não podem permitir ressurreição de settings. Atualizar SemVer em 3.x conforme impacto real da mudança.
- **Cores aceitas:** CURRENT sem foco `0x07FF`, CURRENT selecionado `0xD7FF`, cinza/branco inalterados (MNT-07/08 aceitos).

## MNT-14 (antigo MNT-13) — decisão sobre PAIR NEW, sem workaround travestido de arquitetura

**Status: PLANEJADO, não iniciado; MNT-15 Zoom suspenso; MNT-12 (cores) aceito e publicado como v3.2.2; MNT-13 (seta de seleção) não iniciado.** [Contrato MNT-14](gates/MNT-14.md) incorpora [investigação estática já registrada](investigations/pair-new-with-connected-mouse-2026-10-11.md).

**Autoridade funcional:** documentação canônica de 20/09/2026 no programa `RP-2350/mouse-bridge-remapper/requirements` (connected HOME, ajuda/handoff e um mouse autoritativo) tem prioridade. Com o mouse A conectado, Pair New pode pesquisar B verdadeiramente novo sem desconectar A; qualificação B → handoff seguro; timeout/cancelamento preservam A; salvo B não é aceito como novo. “Desligar A para B funcionar” é **workaround/controle negativo**, não requisito de produto.

**Histórico físico relevante:** HOPE-06 (23/09/2026) inicialmente falhou porque `MAX_NR_HCI_CONNECTIONS`, `MAX_NR_GATT_CLIENTS` e `MAX_NR_HIDS_CLIENTS` estavam em `1`; rework colocou cada um em `2`, e houve **aceite físico**. A `v3.2.0` ainda contém os três valores em `2`, e a máquina de estados ainda permite Pair New em `READY`; **não se conclui que esse é o problema atual**. Teste unitário de símbolos não prova coexistência real do scan/connection/SM/HIDS no Pico 2 W.

**Duas partes com decisões distintas:**

1. **Parte 1 — DIAGNOSTICAR:** reproduzir A conectado versus desconectado com B realmente inédito dentro de 15 s, medir primeira falha da cadeia UI → request → scan → report → connect → security → HIDS → handoff, com evidência versionada/anônima. Nenhum patch de comportamento; resultado técnico pode ser causa confirmada ou inconclusivo.
2. **Parte 2 — DECIDIR:** avaliar suporte real do controlador/BTstack, risco, custo, compatibilidade com a arquitetura (um autoritativo, candidato temporário), teste/rollback. Documentar GO / NO-GO / BLOCKED / NOT A BUG. GO aprovado **não é autorização implícita para implementar**: requer nova instrução do operador, CI, UF2 candidato, teste físico e aceite. Sem código real aceito → **NO RELEASE**.

**Riscos a não ocultar:** starvation ou retorno falso de scan coexistente; timing intermitente; dispositivo B já salvo ou advertising de pairing ausente; race da troca de handles/CID e eventos USB mantidos; divergência SDK/firmware controlador; memória/pools; alteração acidental da limpeza de bonds MNT-10; efeitos indesejáveis de logs na temporização. Diagnóstico real, não solução de desconexão precoce.


## Alteração do programa em 12/10/2026 — MNT-12 concluído, MNT-13 seta e Zoom renumerado MNT-15

- **MNT-12 / MEL-12 NOVO:** aparência de `MODIFIER SHORTCUTS` e dos **valores atribuídos** nas seis telas `COMBINATIONS`. Predicado único: **CUSTOM REMAPPING aplicado** + **existe um botão Modifier efetivo**. Os dois requisitos são necessários, em conjunto, e não bastam presença de Modifier em perfil Custom inativo nem Custom aplicado sem Modifier. O predicado não depende de ter atalhos configurados.
- **Exibição REMAPPING OPTIONS:** somente linha `MODIFIER SHORTCUTS` ganha CURRENT (`0x07FF`) se o predicado é verdadeiro e SELECTED_CURRENT (`0xD7FF`) se focada. Em todos demais casos, cinza normal / branco focado. Continuar acessível sempre, sem flag de disabled.
- **Exibição COMBINATIONS:** somente **linhas de valor 2 e 4** de atalho efetivamente configurado, não indisponível, podem receber CURRENT/SELECTED_CURRENT; rótulos das combinações mantêm cinza/branco. `NOT CUSTOMIZED` e `UNAVAILABLE` permanecem com suas tonalidades, inclusive ao selecionar; NÃO mudar semântica de atalhos.
- **Fonte de dados:** `ux->active_profile` + `ux->modifier_source` derivado de `profiles->custom_targets` efetivamente aplicado; a UX também mantém `custom_targets` de draft. **Nunca basear ciano somente em draft**, nem em armazenamento de outro bond/mouse salvo. Só representação visual, sem novo campo persistente.
- **Risco de precedência:** `renderer.c` reaplica `ACTIONABLE` às linhas COMBINATIONS antes de foco e restaura `UNAVAILABLE` a `STATIC`; `profile_feedback.c` reconstrói todas as opções de REMAPPING OPTIONS depois. Aplicar indicador **na etapa exata** sem contaminar rótulos ou sobrescrever exceções. Reusar `BLU2USB_UI_TONE_CURRENT`, `BLU2USB_UI_TONE_SELECTED_CURRENT` e `blu2usb_ui_tone_on_focus`, sem novo RGB.
- **Histórico preservado:** Zoom/Obsidian, `MEL-08`, agora **[MNT-15](gates/MNT-15.md)**, permanece suspenso; **[MNT-14](gates/MNT-14.md)** continua investigação de PAIR NEW em duas partes; **[MNT-13](gates/MNT-13.md)** é o indicador de foco `>`, apenas planejado.
- **Atualização:** MNT-12 foi implementado, testado fisicamente e publicado como **v3.2.2** após seu aceite. Nesta solicitação **nenhum código novo** é autorizado para MNT-13/14/15; somente o planner foi renumerado e atualizado.

## Novo MNT-13 — seta de foco > na primeira coluna

- **Contrato:** somente o item de menu **atualmente focado** recebe `>` na coluna física 1 (array índice 0). **Exatamente uma seta por tela de lista válida**, nenhuma em opção não selecionada, status/título/Help/hints, e zero nas telas sem escolha real. Não confundir **foco** com valor CURRENT já aplicado (ciano).
- **Inventário e exceções essenciais:** `blu2usb_ux_option_count()` cobre a maior parte dos menus, mas **SAVED DEVICES** retorna 0 apesar de ter uma única ação implícita REMOVE DEVICE quando há bond; se vazio, zero seta. `selected_row()` cobre muitas telas, mas **MOVEMENT OPTIONS** terceira escolha corresponde à linha 4 ROTATION (linha 3 informativa) e **COMBINATIONS** seleciona duas linhas — seta somente no **rótulo linha 1 ou 3**, nunca nos valores 2/4.
- **Sem mudança de estrutura dos menus:** usar margem de índice 0 nos templates; não sobrescrever o primeiro caractere, truncar labels, alterar textos, 9×21, rotas, comandos/controles, BLE, profiles/bonds, atalhos ou estados. A seta deve usar a cor efetiva de seleção já calculada, branco ou ciano claro conforme o item focado, sem novo RGB.
- **Risco de composição:** o renderer projeta templates/dinâmicas, foco, estado CURRENT e overlays de Saved Devices; `profile_feedback.c` reconstrói tons após projeção. Uma seta colocada antes pode ser sobrescrita; inserir via **uma etapa final de apresentação do frame** e garantir remoção do marcador antigo a cada redraw, sem apagar caracteres estáticos em coluna 0.
- **Regressões:** verificar todas as telas e opções, 6 COMBINATIONS × 2 pares, 5 SHORTCUTS × 6 opções, HOME/SEARCHING/RETRY, 5 WILL BECOME, Movement, 4 DPI, Rotation e Saved Devices com 0/1/N bonds; ausência de marcador em PAIR NEW/Remove This/Help/estados sem lista.
- **Status:** novo MNT-13 **somente planejado** em [gate detalhado](gates/MNT-13.md). Nenhum firmware/teste/CI/UF2 do novo marcador foi criado. MNT-14 e MNT-15 continuam intocados funcionalmente.
