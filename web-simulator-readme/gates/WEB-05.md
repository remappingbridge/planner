# WEB-05 — Mouse virtual, eventos, persistência e busca

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-04 aceito.

## Escopo fechado

Criar identidades de 0..8 mouses salvos, cenários Pair New, primeiro uso, reconexão, timeout/retry, remoção, front bond, relógio determinístico, histórico de eventos, save/load localStorage com schema/validação; resultados commit-first.

## Entrega observável

Persistência local por Mouse sem transmissão de dados; reload/reboot não duplica, delete limpa todo bond, nomes persistem; botões de conexão/desconexão/sucesso/falha visíveis.

## Aceite e cenários manuais

Testes Search First, Saved Search, Pair, Timeout, 8/8 overflow, switch per Mouse, rem. current/offline, cancel + stale result, reset em storage desativado.

## Limites

Sem pretensão de BLE HOGP físico; não usar WebBluetooth como requisito.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-05/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
