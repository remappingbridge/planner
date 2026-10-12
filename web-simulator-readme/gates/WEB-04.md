# WEB-04 — 45 telas e navegação canônica v3

**Status:** CANDIDATE IMPLEMENTED, 90/90 ISOLATED JS/DOM/CANVAS CHECKS PASS; PRODUCTION-BROWSER ACCEPTANCE PENDING. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-03 aceito.

## Implementation evidence

- [WEB-04 website implementation branch](https://github.com/remappingbridge/remappingbridge.github.io/tree/web/web-04-canonical-screens-hat-layout)
- [Preflight and exact firmware source hashes](../executions/WEB-04/preflight.md)
- [Candidate/limitations and 90 checks](../executions/WEB-04/candidate.md)
- [Production browser manual checklist](../executions/WEB-04/manual-tests.md)

The operator additionally required **no LCD BACKGROUND selector**, permanently vivid **Gentle #300c39**, a **smaller centered LCD**, joystick on the left, and A/B/X/Y in one vertical column on the right. The implementation addresses those requirements. **WEB-05 NOT STARTED.**

## Escopo fechado

Portar a máquina de estados da fonte C para JavaScript puro, todas as 45 telas v3 atuais, templates e opções, transições de página, foco, HELP, HOME, RETRY, remoção/pareamento visual. Fonte v3 é normativa.

## Entrega observável

Da HOME CONNECTED ou SEARCHING FIRST se alcançam telas canônicas no estado simulado; IDs e strings 9×21, títulos magenta, nenhuma tela v1 obsoleta.

## Aceite e cenários manuais

Executar fixtures de cada tela, contagem de rotas HOME 4 e HOME offline 2, navegação B/Help/Y; screenshot navegador; 45 telas sem overflow.

## Limites

Comandos APPLY/REMOVE serão simulados plenamente em gates posteriores; não mascarar isso como paridade end-to-end já pronta.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-04/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
