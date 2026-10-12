# WEB-03 — HAT virtual, Lock e Help

**Status:** CANDIDATE IMPLEMENTED / 80/80 ISOLATED REGRESSIONS PASS / PRODUCTION-BROWSER ACCEPTANCE PENDING. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-02 aceito.

## Implementation and tests

- [WEB-03 site PR #4](https://github.com/remappingbridge/remappingbridge.github.io/pull/4)
- [Preflight and provenance](../executions/WEB-03/preflight.md)
- [Candidate and 80-check report](../executions/WEB-03/candidate.md)
- [Production-browser acceptance checklist](../executions/WEB-03/manual-tests.md)
- Operator's carried-over improvement: default **Gentle** backdrop `#300c39`, more vivid and less gray than WEB-02. No semantic foreground changes.

WEB-04 is **NOT STARTED**; require explicit WEB-03 acceptance.

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
