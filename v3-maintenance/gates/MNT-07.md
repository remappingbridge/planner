# MNT-07 — Ciano normal passa a ciano claro esbranquiçado

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-05** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-06 publicado**; a branch futura `maintenance/v3x-mnt-07` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.2 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Alterar todas as ocorrências de texto no tom ciano normal atual para tom ciano claro esbranquiçado, em todo LCD. Manter papéis e contraste dos demais tons.

## Preparação técnica — para execução futura
Examinar BLU2USB_UI_TONE_CURRENT, palette e mapeamento ST7789. Aplicar preferência por design token, não edição dispersa. Registrar cor RGB escolhida após teste hardware real, sem inventar código antecipadamente.

## Teste físico individual desde HOME CONNECTED
Capturas/fotos comparáveis de HOME, Movement, Saved Devices nome conectado, Profile, DPI, Rotation, Combinations, Shortcuts, Helps. Ciano claro consistente e legível; branco e cinza imutáveis.

## Riscos/limites
Não piorar contraste para baixa visão; não pintar texto amarelo ou nome desconectado.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-07/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-07/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
