# MNT-03 — Movement Options: retirar x apenas do resumo H/V

**Status: CANDIDATO ENTREGUE — CI #453 83/83 PASS + UF2 Pico 2 W SHA256 verificado; ACEITE FÍSICO PENDING.** [PR #33 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/33), [candidato](../executions/MNT-03/candidate.md) e [roteiro físico](../executions/MNT-03/physical-acceptance.md). Sem merge, tag ou v3.0.3 publicada.

- Backlog: **MEL-01** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-02 publicado**; branch `maintenance/v3x-mnt-03` criada da tag oficial `v3.0.2`, commit `4ac38c50b8ad96c4d8b7fc7d80033c7a97807300`.
- Versão prevista somente após aceite físico: **v3.0.3 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Em MOVEMENT OPTIONS remover sufixo x dos valores dinâmicos de HORIZONTAL DPI e VERTICAL DPI, mantendo fatores de ganho, arredondamento, escala, o restante da tela, lista Slow/Fast e persistência intactos.

## Preparação técnica — executada no candidato
Examinar project_movement_options e movement_gain_name em renderer; preferir formatador dedicado ao resumo sem mutilar representação compartilhada; conferir índices de tone spans após alterar comprimento.

## Teste físico individual desde HOME CONNECTED
HOME → MOVEMENT OPTIONS: H e V configurados independentemente para 0.25, 0.75, 1, 1.25, 1.5, 2, 3; valores sem x no resumo e valores das listas preservados; mover Mouse, reboot e confirmar ganhos reais.

## Riscos/limites
Não mudar contagem interna de quarters; número sem x é apenas representação de UI.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-03/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-03/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. Etapas 1 e 2 concluídas; entrega de candidato/roteiro na etapa 3; **aguarda aceite físico explícito**. Etapa 4 bloqueada.
