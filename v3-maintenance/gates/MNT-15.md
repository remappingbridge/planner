# MNT-15 — Zoom genérico: diagnosticar Obsidian antes de corrigir HID

**Status vigente em 12/10/2026: PLANEJADO / SUSPENSO — NÃO INICIADO, NÃO IMPLEMENTAR.** Cancelamento do MNT-14 não autoriza nem desbloqueia este gate; somente novo pedido explícito do operador poderá iniciar investigação, branch ou implementação. O gate Zoom/Obsidian foi movido de MNT-12 para MNT-14 e depois para MNT-15, sem mudança de requisitos. Nenhuma alteração de firmware, CI, UF2 ou release foi executada.

- Backlog: **MEL-08 (solicitação explícita)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-12 aceito e publicado como v3.2.2** (MNT-10 e MNT-11 concluídos); a branch futura `maintenance/v3x-mnt-15` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Histórico de renumeração: **MNT-10 → MNT-12 → MNT-14 → MNT-15**; o conteúdo de MEL-08 Zoom/Obsidian foi preservado. Nova renumeração autorizada em 12/10/2026 para reservar MNT-13 à indicação visual de seleção. MNT-14 é o diagnóstico PAIR NEW em duas partes.
- Versão prevista somente após aceite físico: **próxima versão v3.x disponível ao executar MNT-15 (PATCH apenas se correção real; sem release se só diagnóstico)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Investigar ZOOM IN/OUT: teclado físico funciona no Obsidian KDE Debian13; RemappingBridge falha no Obsidian e funciona no navegador; RESET funciona. Não modificar firmware até obter origem/semântica dos eventos. Se solução genérica HID for confirmada e passar regressões, implantar alteração mínima, sem condição por aplicativo.

## Preparação técnica — para execução futura
Correlacionar device nodes BLU2USB vs AT integrado com evtest e udevadm; capturar Ctrl/Shift/Equal/Minus/0, layout XKB ABNT2, keydown/up, temporização. Validar equivalente comum em vários aplicativos, não supor que event0 registra BLU2USB.

## Teste físico individual desde HOME CONNECTED
Demonstração A/B: teclado notebook + BLU2USB acionando Zoom In/Out/Reset em Obsidian e navegador; logs do dispositivo correto, 30 ações restantes intactas; sem alteração de identity USB. Gate documental sem código recebe decisão DEFERRED/NO RELEASE, não versão falsa.

## Riscos/limites
Não criar mapeamento exclusivo do Obsidian, novo menu de layout ou versão que quebra zoom Firefox.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-15/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-15/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-15 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Este gate permanece suspenso até instrução explícita de início. MNT-13 indicador de seleção e MNT-14 PAIR NEW são planos independentes, não pré-requisitos de diagnóstico Zoom.** Renumeração é apenas documental; não iniciar qualquer etapa de execução.
