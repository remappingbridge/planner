# WEB-09 — Laboratório web: Inspector, cenários e evidências

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-08 aceito.

## Escopo fechado

Adaptar recursos úteis do mouse-ui-legacy-v1, mas não suas telas obsoletas: Inspector de elemento, ID semântico/bounds 240×240, timeline de eventos, copiar referência, cenários reproduzíveis da UX atual, simular timeout/erro e exportar captura/JSON/TXT local.

## Entrega observável

Painel de diagnóstico dentro da mesma página, acessível e ocultável, sem alterar framebuffer. Cenários First Use, connected/multi, remove, stale/fail, movement/custom/shortcuts; porta inspiração dos 15 cenários v1 revisando e descartando estados aposentados.

## Aceite e cenários manuais

Repetir cenários determinísticos e conferir state hash, event log e export; garantir localStorage não contaminado por cenário isolado. Testar COPY REF e evidência após falhas.

## Limites

Não enviar dados ao servidor nem anunciar Inspector como recurso de firmware físico.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-09/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
