# MNT-03 — Movement Options: retirar x apenas do resumo H/V

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-01** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-02 publicado**; a branch futura `maintenance/v3x-mnt-03` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.0.3 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Em MOVEMENT OPTIONS remover sufixo x dos valores dinâmicos de HORIZONTAL DPI e VERTICAL DPI, mantendo fatores de ganho, arredondamento, escala, o restante da tela, lista Slow/Fast e persistência intactos.

## Preparação técnica — para execução futura
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
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
