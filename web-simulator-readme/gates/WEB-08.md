# WEB-08 — HAT/LCD visual, responsive e brilho 0–100%

**Status:** ACCEPTED by operator on 2026-10-12; WEB-09 authorized, including removal of optional WEB-08 display controls. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-07 aceito.

## Candidate evidence

- [Firmware/source baseline](../executions/WEB-08/preflight.md)
- [Implemented candidate and 226 isolated browser checks](../executions/WEB-08/candidate.md)
- [14 numbered production browser acceptance tests](../executions/WEB-08/manual-tests.md)

WEB-08 acceptance is **pending**; WEB-09 **not started**.

## Escopo fechado

Converter a página mínima em uma aplicação web moderna e visualmente cuidada: moldura do LCD, joystick e quatro botões HAT estilizados e arredondados, blocos de controles com sombras discretas, densidade ajustável, estados hover/active/focus, adaptação mobile e HiDPI.

## Entrega observável

Sem cabeçalho editorial/navbar/footer/links de menu global; controles e painel HAT são elementos da aplicação. Brilho web clamp 0..100% somente, sem 750/1000%, e magenta escuro mais suave aprovado no WEB-02; Lock efetivo 0% com valor lembrado; escala CSS separada de brightness.

## Aceite e cenários manuais

Conferir acessibilidade (44px touch targets, foco visível, legendas, contraste, labels, zoom/reduced-motion), Firefox/Chromium desktop, mobile touch, 320px/768px/2K; atenuação magenta sem desvio em tons da fonte C.

## Limites

Não transformar a página em site institucional com Hero/menu/footer; não aplicar filtro de brilho >1; cores do firmware não devem ser substituídas pelas do shell.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes aplicáveis e roteiro manual; registrar evidências e rollback em `../executions/WEB-08/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
