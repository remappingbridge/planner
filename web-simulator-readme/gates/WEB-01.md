# WEB-01 — Página única e bootstrap estático

**Status:** ACEITO PELO OPERADOR EM 12/10/2026. **Testes manuais futuros: somente navegador em produção; execução local no Debian não exigida.** **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-00 aceito.

## Evidência da implementação

- [PR #1 — remappingbridge.github.io](https://github.com/remappingbridge/remappingbridge.github.io/pull/1) — código estático em branch draft.
- [Preflight](../executions/WEB-01/preflight.md)
- [Candidate e resultados técnicos](../executions/WEB-01/candidate.md)
- [Cenários de teste manual PENDENTES](../executions/WEB-01/manual-tests.md)

**WEB-01 está aceito**, com [registro do operador](../executions/WEB-01/operator-acceptance.md). **WEB-02 permanece NÃO INICIADO**, aguardando nova ordem. É obrigatório concluir a auditoria English-only antes do próximo gate.

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
