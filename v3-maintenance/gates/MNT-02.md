# MNT-02 — Remove This: KEY X abre Help e KEY Y conserva Lock

**Status: CANDIDATO IMPLEMENTADO — CI #445 82/82 PASS + UF2 Pico 2 W SHA256 verificado; aceite físico PENDING.** [PR #32 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/32), [candidato](../executions/MNT-02/candidate.md), [roteiro físico](../executions/MNT-02/physical-acceptance.md); nenhuma v3.0.2 publicada.

- Backlog: **HF-02 + HF-03 (atômicos)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-01 publicado**; branch `maintenance/v3x-mnt-02` criada exatamente da tag oficial `v3.0.1`, SHA `b776fec2cf2c89788d1bdfed7aa257aa766f2dc6`.
- Versão prevista somente após aceite físico: **v3.0.2 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Na tela `BLU2USB_SCREEN_REMOVE_THIS` trocar dica `KEY Y: HELP` por `KEY X: HELP` e implementar entrada real ao `BLU2USB_SCREEN_HELP_REMOVE_THIS` com KEY X no mesmo candidato. KEY Y continua LOCK; nenhum Help pode efetuar exclusão. Não modificar a semântica global das telas Help antes do MNT-05, salvo correção indispensável ao retorno.

## Preparação técnica — executada no candidato isolado
Inspecionar ux_model.c (input handlers, help dispatch, return_screen, selected bond) e renderer; testar bordas press/release KEY X/Y, pending removal e retorno intacto.

## Teste físico individual desde HOME CONNECTED
HOME CONNECTED → SAVED DEVICES → REMOVE DEVICE → REMOVE THIS; validar rótulo KEY X: HELP e entrada por X, sair do Help pela regra da v3 atual, KEY B cancela em Remove This, KEY Y trava, desbloqueia sem remover bond. Não publicar label sem handler.

## Riscos/limites
Perda do bond de destino ao abrir ajuda ou remoção acidental seria blocker.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-02/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-02/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
