# WEB-00 — Autoridade, snapshot e fixtures

**Status:** AUTORIZADO/ACEITO PARA PROSSEGUIR PELO OPERADOR EM 12/10/2026 (“prossiga”); verificação estática PASS. **Destino em futura execução:** `planner (execução apenas documental)`. **Dependência:** Nenhum. Primeiro gate da série.

## Candidato e evidências

- [Preflight de fontes/licenças](../executions/WEB-00/preflight.md)
- [Candidate — validações estáticas](../executions/WEB-00/candidate.md)
- [45 telas e mapa de interações](../executions/WEB-00/screen-matrix.md)
- [Fixtures versionadas](../fixtures/README.md)
- [Checklist manual PENDENTE](../executions/WEB-00/manual-tests.md)

**Nenhum código de site ou README do firmware alterado neste gate. WEB-01 autorizado; ver [decisão do operador](../executions/WEB-00/operator-acceptance.md).**

## Escopo fechado

Registrar tags/SHAs upstream, inventário exato dos 45 screens e fluxo C do firmware, diferenciais do mouse-ui v3 e exclusões v1; preparar corpus normativo imutável por commit e convenção de versão WEB.

## Entrega observável

Mapa screen ID→texto 9×21→opções→eventos→tons; corpus de casos MNT-12/MNT-13 com casos de borda; caminho de licenças (firmware CC0 e site AGPLv3); matriz de regressão/aceite; nenhum código de app nem mudança firmware.

## Aceite e cenários manuais

Auditar README da v3 e simulação desktop; provar que nenhum STANDARD/ESCAPE REMAP reaparece na UX v3 e que a fonte é a última release; congelar fontes no registro de preflight.

## Limites

Apenas especificação; não publicar site e não escrever produto.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-00/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
