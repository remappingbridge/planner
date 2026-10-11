# MNT-01 — Saved Devices: dicas, REMOVE DEVICE e seleção branca

**Status: CANDIDATO DE FIRMWARE PRONTO — CI 81/81 + UF2 DE PRODUÇÃO VERIFICADO — AGUARDANDO ACEITE FÍSICO.** Build e artefato: [executions/MNT-01/candidate.md](../executions/MNT-01/candidate.md); [teste físico](../executions/MNT-01/physical-acceptance.md). Nada foi mesclado, publicado ou versionado como v3.0.1.

- Backlog: **HF-01** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **v3.0.0**; a branch futura `maintenance/v3x-mnt-01` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.0.1 (PATCH)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Corrigir exclusivamente a apresentação da tela `BLU2USB_SCREEN_SAVED_DEVICES`: dicas no cinza padrão, `REMOVE DEVICE` não selecionado cinza, e a única ação disponível apresentada como selecionada branca. Nome ativo mantém o tom CURRENT vigente. Não alterar bond, itens PROFILE/DPI/ROTATION, contagem de saved mice nem fluxo de remoção.

## Preparação técnica — para execução futura
Inspecionar renderer/tones/spans, seleção do UX model, templates e snapshots SAVED DEVICES no tag v3.0.0; privilegiar regra de seleção sem inventar novas opções.

## Teste físico individual desde HOME CONNECTED
HOME CONNECTED → SAVED DEVICES com 1/2+ bonds → confirmar dicas cinza, REMOVE DEVICE branco em destaque, navegação JOY e acesso Remove This; retroceder sem delete; repetir mouse ativo/não ativo e ausência de nome. Fixtures 9×21 e zero alteração de dados.

## Riscos/limites
O nome do mouse conectado não pode ser recolorido pela seleção de REMOVE DEVICE.

## Contrato de entrega (etapas já executadas registradas em executions/MNT-01)
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-01/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-01/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
