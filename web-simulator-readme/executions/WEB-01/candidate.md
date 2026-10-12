# WEB-01 — Candidato de página estática

**Situação:** CANDIDATO IMPLEMENTADO / VERIFICAÇÃO ESTRUTURAL E SMOKE MOCK-DOM PASS / **TESTE VISUAL MANUAL E ACEITE PENDENTES**.

- [PR #1 — código WEB-01](https://github.com/remappingbridge/remappingbridge.github.io/pull/1), branch `web/web-01-static-app-foundation`, derivada de `84eaf2c144a081f935d70e78c2b9870a06c64467`.
- Dependência WEB-00 [encerrada e autorizada](../WEB-00/operator-acceptance.md).
- [Preflight](preflight.md) e [cenários manuais](manual-tests.md).

## Código entregue

| Arquivo | Função |
|---|---|
| `index.html` | único documento público; prévia textual FIRST SEARCHING e HAT de 9 botões com `aria-label` |
| `assets/css/app.css` | shell dark e controles arredondados, estados de pressão, layout responsivo, foco visível e preferência de movimento reduzido |
| `assets/js/app.js` | bootstrap `DOMContentLoaded`, validação dos 9 IDs, registro de click/tap nativo, feedback/contador e botão Limpar |
| `tests/index.html` | testes acessíveis no próprio browser, em `file://` ou HTTP local |
| `tests/runner.js` | 14 casos automáticos independentes de Node/npm, inclusive criação de DOM de teste |
| `.nojekyll` | arquivos do site servidos sem Jekyll |
| `README.md` | instruções de abertura, escopo/limitações, HTML estático e Pages (não afirmado publicado) |

`LICENSE` AGPLv3 e `.gitignore` preservados. **Nenhum código de firmware nem README do repo `remappingbridge` foi alterado.**

## Verificação realizada no código fonte conectado (PASS)

1. Inspeção dos assets na branch: **6 arquivos principais** verificados (HTML, CSS, JS, dois tests e README), todos usando caminhos locais relativos; nenhuma `nav`, `footer`, `iframe` ou CDN.
2. Há **9 identificadores HAT** no HTML, únicos: `JOY_UP`, `JOY_DOWN`, `JOY_LEFT`, `JOY_RIGHT`, `JOY_PRESS`, `KEY_A`, `KEY_B`, `KEY_X`, `KEY_Y`.
3. O JavaScript principal e o runner de testes passaram por análise sintática no mecanismo V8 isolado (execução de funções JavaScript sem navegador).
4. Execução do JS principal em **DOM simulado**: bootstrap `ready`, estados pointerdown/up, dois clicks `JOY_UP` e `KEY_Y` atualizam contador de `00` para `02`, feedback identifica o último controle; reset volta para `00`.
5. A constante de prévia apresenta **exatamente 9 linhas**, de comprimentos `[21,19,21,13,19,20,14,20,20]`, sem ultrapassar 21 colunas; corresponde ao `SEARCHING_FIRST` v3.2.3.
6. `maxWebBrightnessPercent: 100` é metadata do contrato — **não existe controle de brilho neste gate**.
7. CSS inclui teclado focus-visible, estados hover/pressed, responsive e redução de movimentos. Ajuste adicional abaixo de 400px empilha D-pad e teclas para melhor alcance.

**Não testado/pendente:** abertura real no Firefox/Chromium desktop/Android, viewport/screenshot real, execução humana de `tests/index.html` e publicação GitHub Pages. O teste em DOM simulado **não** equivale a teste no navegador; não marcar evidência visual como PASS.

## Teste de aceite esperado

Abrir `index.html` via arquivo ou HTTP, verificar visual, clicar os nove controles, feedback, contagem, Limpar, resize, scroll em smartphone, e executar `tests/index.html` no browser. Não navegar por 45 telas ou aplicar ações reais: elas são entregas de gates posteriores.

## Estado e continuidade

PR de código do site está **draft**, sem merge. Após aceite explícito do operador, registrar `operator-acceptance.md` do WEB-01, integrar a PR, e liberar WEB-02 (renderer exato). Não criar UF2, firmware, tag nem versão do produto neste programa.
