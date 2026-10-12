# WEB-04 — 45 telas e navegação canônica v3

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-03 aceito.

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
