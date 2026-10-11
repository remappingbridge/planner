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
