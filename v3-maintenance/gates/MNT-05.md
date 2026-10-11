# MNT-05 — First Mouse Connected: KEY Y LOCKS ANYWHERE

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-03** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-04 publicado**; a branch futura `maintenance/v3x-mnt-05` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.0.5 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Na tela first-mouse-connected (= BLU2USB_SCREEN_MOUSE_SAVED na v3) substituir a dica final por KEY Y: LOCKS ANYWHERE; demais dicas e controles intocados.

## Preparação técnica — para execução futura
Atualizar fixture da tela e confirmar limite 21 caracteres; manter lógica de KEY Y existente. Referência de lock em Help torna-se verdade após MNT-06.

## Teste físico individual desde HOME CONNECTED
Reproduzir FIRST MOUSE CONNECTED com hardware e ler literalmente KEY Y: LOCKS ANYWHERE; pressionar KEY Y, confirmar lock/unlock; 9×21 sem corte/overflow.

## Riscos/limites
Legendas devem caber em 21 caracteres e não prometer comportamento inexistente em tela específica.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-05/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-05/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
