# MNT-10 — Zoom genérico: diagnosticar Obsidian antes de corrigir HID

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-08 (solicitação explícita)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-09 publicado**; a branch futura `maintenance/v3x-mnt-10` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.4 (PATCH se correção real; sem release se só diagnóstico)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Investigar ZOOM IN/OUT: teclado físico funciona no Obsidian KDE Debian13; RemappingBridge falha no Obsidian e funciona no navegador; RESET funciona. Não modificar firmware até obter origem/semântica dos eventos. Se solução genérica HID for confirmada e passar regressões, implantar alteração mínima, sem condição por aplicativo.

## Preparação técnica — para execução futura
Correlacionar device nodes BLU2USB vs AT integrado com evtest e udevadm; capturar Ctrl/Shift/Equal/Minus/0, layout XKB ABNT2, keydown/up, temporização. Validar equivalente comum em vários aplicativos, não supor que event0 registra BLU2USB.

## Teste físico individual desde HOME CONNECTED
Demonstração A/B: teclado notebook + BLU2USB acionando Zoom In/Out/Reset em Obsidian e navegador; logs do dispositivo correto, 30 ações restantes intactas; sem alteração de identity USB. Gate documental sem código recebe decisão DEFERRED/NO RELEASE, não versão falsa.

## Riscos/limites
Não criar mapeamento exclusivo do Obsidian, novo menu de layout ou versão que quebra zoom Firefox.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-10/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-10/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
