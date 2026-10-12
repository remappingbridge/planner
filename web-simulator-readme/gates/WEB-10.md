# WEB-10 — Paridade integral e publicação estática da aplicação

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-09 aceito.

## Escopo fechado

Auditar todos os fluxos v3 com fixtures do firmware e mouse-ui, rodar testes HTML em navegadores, corrigir regressões no mesmo gate, validar assets e publicação GitHub Pages main/(root).

## Entrega observável

App pronto para uso público e URL real verificada, controles completos, screen/framebuffer goldens, dashboard responsivo e documentação de teste local; licença e imagens auditadas.

## Aceite e cenários manuais

45 telas, MNT-12/13, 12/30 shortcuts, H/V/rotation, lock/help, saved 8, persist/reload, 0–100; Firefox, Chromium e mobile, teclado e touch; sem 404/console errors.

## Limites

Se Pages Settings exigir ação do usuário, status BLOCKED até confirmação. Não adicionar páginas de site nem workflow autoral.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-10/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
