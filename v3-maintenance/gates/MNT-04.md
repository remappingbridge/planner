# MNT-04 — Padronizar barra / em textos LCD

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-02** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-03 publicado**; a branch futura `maintenance/v3x-mnt-04` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.0.4 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Substituir separadores visuais exibidos como backslash por slash em TODAS as telas/helps, sobretudo legendas JOY LEFT/RIGHT, JOY UP/DOWN e HOME SCREEN/PAGE. Não editar escapes de linguagem C nem caminhos, dados BLE, storage, ou USB.

## Preparação técnica — para execução futura
Mapear strings literais e geradas em src/ux_model e renderer, fixture full 9×21, impedir truncamento, separar display-only de código de controle.

## Teste físico individual desde HOME CONNECTED
Percorrer HOME/Remapping/Movement/Saved/Combination/Shortcuts/Help; auditoria dos 9×21 sem barra invertida exibida; nenhum caractere extra ou mudança de navegação.

## Riscos/limites
Substituição textual global em fonte C é expressamente proibida.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-04/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-04/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
