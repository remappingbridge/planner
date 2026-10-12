# WEB-01 — Página única e bootstrap estático

**Status:** CANDIDATO IMPLEMENTADO EM BRANCH DO SITE / SMOKE ESTRUTURAL PASS / TESTE VISUAL E ACEITE PENDENTES. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-00 aceito.

## Evidência da implementação

- [PR #1 — remappingbridge.github.io](https://github.com/remappingbridge/remappingbridge.github.io/pull/1) — código estático em branch draft.
- [Preflight](../executions/WEB-01/preflight.md)
- [Candidate e resultados técnicos](../executions/WEB-01/candidate.md)
- [Cenários de teste manual PENDENTES](../executions/WEB-01/manual-tests.md)

**WEB-02 permanece bloqueado até o aceite explícito do WEB-01.**

## Escopo fechado

Criar root index.html, .nojekyll, assets CSS/JS relativos, carregamento sem imports Node/npm, documentação de execução local e preparo da configuração Pages por main/root; não criar landing ou menu global.

## Entrega observável

Tela de laboratório mínima com LCD dummy identificável, área HAT de controles e indicação explícita de simulação; inicialização sem console error e documentação dos caminhos.

## Aceite e cenários manuais

Abrir index.html via file:// no Firefox e via HTTP simples; resize e reload; nenhuma página de navegação extra; publicação real depende Settings Pages e não é declarada ativa sem teste.

## Limites

Ainda sem navegação/45 telas, device mock ou README principal.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-01/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
