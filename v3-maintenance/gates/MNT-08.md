# MNT-08 — Seleção de ciano claro passa a ciano normal

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-06** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-07 publicado**; a branch futura `maintenance/v3x-mnt-08` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.2 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Ao selecionar item cuja cor normal é ciano claro esbranquiçado, renderizar estado selecionado em ciano normal, mais destacado. Ao perder seleção voltar ao ciano claro. Para itens padrão, continuar cinza→branco. Respeitar os spans/linhas em UI v3.

## Preparação técnica — para execução futura
Implementar precedência explícita entre roles CURRENT e SELECTED, não aplicar a texto CURRENT informativo não selecionável. Validar saved devices que só destaca nome conectado.

## Teste físico individual desde HOME CONNECTED
Alternar foco nos itens elegíveis em Movement, Saved Devices se houver opção, Combinations/Shortcuts, retornar e comparar foto; cinza→branco inalterado; nome desconectado nunca ciano.

## Riscos/limites
Paleta global sem semântica de seleção cria recoloração indevida; testar foco real.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-08/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-08/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
