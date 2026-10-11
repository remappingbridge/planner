# MNT-03 — roteiro de validação física de Movement Options

**Status: PENDING — NÃO TESTADO PELO OPERADOR.** O gate MEL-01 remove apenas o X dos fatores mostrados no resumo HORIZONTAL DPI e VERTICAL DPI em MOVEMENT OPTIONS. A versão futura v3.0.3 depende do aceite explícito.

## Preparação
1. Baixar o UF2 candidato cujo SHA será documentado em [candidate.md](candidate.md); regravar Pico 2 W por BOOTSEL, sem `flash_nuke` (preservar BLE bonds, Movement e atalhos).
2. Partir de **HOME CONNECTED** e selecionar `MOVEMENT OPTIONS`.

## Testes
- [ ] **01 — Tela inicial**: título `MOVEMENT OPTIONS` continua magenta; as duas linhas mostram exatamente `HORIZONTAL DPI 1` e `VERTICAL DPI 1`, sem `x` ou `X`, no mesmo alinhamento e padrão de cores original.
- [ ] **02 — Eixo horizontal**: escolher 0.75x na tela de seleção; a lista continua mostrando `0.75x` e depois de KEY A aplicar e voltar o resumo mostra `HORIZONTAL DPI 0.75` sem `x`.
- [ ] **03 — Eixo vertical**: escolher 1.5x e aplicar; o resumo mostra `VERTICAL DPI 1.5` sem `x`. Horizontal permanece 0.75 e vertical 1.5 — ganhos independentes, mouse move conforme valores escolhidos.
- [ ] **04 — Extremos**: selecionar 0.25x e 3x em ambos eixos (individualmente); os valores 0.25, 3 aparecem sem X no resumo e as listas mantêm x.
- [ ] **05 — Rotação**: ciclo 0/90/180/270 e ação KEY A preservam a rotação e não alteram os ganhos dos dois eixos.
- [ ] **06 — Cancelamento**: alterar valor na lista sem APPLY, pressionar KEY B; resumo preserva valor antigo e não aplica movimento.
- [ ] **07 — Reinício/persistência**: atualizar configurações e reiniciar Pico; os fatores continuam aplicados no mouse e aparecem com texto sem X no resumo.
- [ ] **08 — Saved Devices/MNT-01/MNT-02**: em Saved Devices título magenta, REMOVE DEVICE branco e dicas cinza; informações de DPI por mouse seguem iguais; em REMOVE THIS KEY X abre Help e KEY Y bloqueia. Sem exclusão real de mouse.
- [ ] **09 — Regression smoke**: cursor, USB, BLE, profile e Modifier Shortcuts continuam operando; 9 linhas × 21 colunas sem truncamento, cores originais mantidas.

**Não mudar mais nada neste gate**: a melhoria futura MNT-04 é sobre barras `/`; a MNT-05 sobre os Helps.

## Decisão
- Resultados individuais: PENDING, nenhum observado pelo assistente.
- **ACEITE GLOBAL: PENDING.**
- Somente depois de `gate aceito`: versionar e publicar v3.0.3, antes de iniciar MNT-04.
