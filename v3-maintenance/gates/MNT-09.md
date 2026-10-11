# MNT-09 — HOME CONNECTED: primeira opção fixa REMAPPING OPTIONS

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-07** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-08 publicado**; a branch futura `maintenance/v3x-mnt-09` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.4 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
A primeira opção da HOME CONNECTED deve sempre ler REMAPPING OPTIONS em vez de status do perfil. Manter destino selecionável, ordenação/ajudas e modelo interno de Custom/Passthrough.

## Preparação técnica — para execução futura
Localizar projeção dinâmica do primeiro item da HOME e retirar dependência de home_profile_summary dessa linha sem apagar estado ou refletir em outras telas.

## Teste físico individual desde HOME CONNECTED
Com perfil CUSTOM e depois PASSTHROUGH (incluindo reboot), primeira opção sempre REMAPPING OPTIONS, JOY PRESS abre fluxo correto; outras opções e mouse name intactos.

## Riscos/limites
Não confundir índice de seleção com título da tela, nem remover estado de profile usado no remapper.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-09/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-09/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
