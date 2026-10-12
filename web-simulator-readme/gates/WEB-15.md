# WEB-15 — Auditoria integrada e fechamento WEB

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `planner (registros) + inspeção dos dois destinos`. **Dependência:** WEB-14 aceito.

## Escopo fechado

Auditar consistência final entre firmware/release, versão web, README, link Pages, assets, UF2/checksums, ilustrações, limitações e matriz de testes. Registrar manutenção futura firmware→mouse-ui→web→README e evidências por gate.

## Entrega observável

Registro conclusivo dos 16 gates com SHAs/PRs reais, testes navegador, disponibilidade Pages, aprovação expressa e riscos conhecidos; plano para reagir a novas releases sem quebrar link ou tela.

## Aceite e cenários manuais

Navegar do README até site, executar primeiro uso/home/movement/modifier/remove, testar touch e teclado, conferir download UF2/sha256, nenhuma referência a UX aposentada ou brilho >100.

## Limites

Sem patch de firmware, sem merge de código não aceito, não declarar aceite de gate pendente e não transformar resultado de simulação em prova de hardware real.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-15/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
