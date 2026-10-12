# WEB-03 — HAT virtual, Lock e Help

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-02 aceito.

## Escopo fechado

Conectar teclado setas/Enter-Espaço/A-B-X-Y a joystick e keys do HAT, touch/pointer rounded controls, press/release, repetição/debounce, lock/unlock, help/return; não roubar teclas durante input em painéis.

## Entrega observável

Pressionado visual no HAT/LCD, botão Y LOCK conforme UX, KEY B retorna em HELP, primeiro evento de unlock consumido; controls com aria-label.

## Aceite e cenários manuais

Teste press→release e long press, keyup perdido/foco window blur, click/tap/touch, HELP B/Y e lock/visibility; teclado-only e mouse-only.

## Limites

Não há BLE real nem device data persistido neste gate.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-03/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
