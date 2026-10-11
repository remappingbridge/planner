# MNT-06 — Todos os Helps: KEY B volta, KEY Y bloqueia

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-04** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-05 publicado**; a branch futura `maintenance/v3x-mnt-06` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.0 (MINOR)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Modificar TODOS os tipos Help: dica ANY KEY: BACK vira KEY B: BACK, KEY B é o único comando de retorno; KEY Y executa lock/unlock com consumo de evento, e KEY A/X/direcionais/JOY PRESS não executam ação. Preservar a tela de origem e foco ao sair. Aborda também Help Remove This.

## Preparação técnica — para execução futura
Centralizar no is_help/handler UX e stack de lock, preferir contrato comum único em vez de if por tela; reconciliação com release-edge input; cobrir HELP de Bluetooth, Movement, Combinations/Shortcuts e outras telas.

## Teste físico individual desde HOME CONNECTED
Para cada Help, tentar todos os HAT inputs; somente B fecha e Y bloqueia, sem alterações de perfil, atalho, remoção ou paginação; após unlock permanece no Help, B volta ao ponto exato.

## Riscos/limites
Mudança funcional deliberada exige versão MINOR 3.1.0, regressão de Help será bloqueante.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-06/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-06/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
