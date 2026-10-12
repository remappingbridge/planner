# MNT-15 — Zoom genérico: diagnosticar Obsidian antes de corrigir HID

**Status atualizado em 12/10/2026: TESTES MABOX REGISTRADOS / DIAGNÓSTICO DE ZOOM SEM PATCH.** MNT-14 foi cancelado por relato de pareamentos bem-sucedidos. No Mabox (X11 ainda não confirmado), ZOOM IN falha somente no Obsidian; ZOOM OUT e RESET funcionam no Obsidian, e todas as três ações funcionam no navegador e terminal. **Novo teste com teclado físico no Obsidian: Ctrl+= sem Shift amplia, Ctrl+- sem Shift diminui e com Shift o zoom não ocorre.** [Registro físico e investigação](../executions/MNT-15/mabox-zoom-investigation-2026-10-12.md). **Nenhuma implementação, branch, UF2 ou release MNT-15 autorizados.**

- Backlog: **MEL-08 (solicitação explícita)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-13 aceito e publicado como v3.2.3** (MNT-14 cancelado sem patch); a branch futura `maintenance/v3x-mnt-15` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Histórico de renumeração: **MNT-10 → MNT-12 → MNT-14 → MNT-15**; o conteúdo de MEL-08 Zoom/Obsidian foi preservado. Nova renumeração autorizada em 12/10/2026 para reservar MNT-13 à indicação visual de seleção. MNT-14 é o diagnóstico PAIR NEW em duas partes.
- Versão prevista somente após aceite físico: **próxima versão v3.x disponível ao executar MNT-15 (PATCH apenas se correção real; sem release se só diagnóstico)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
**Distinguir hosts e testes:** histórico Debian 13 KDE: Zoom In e Out via RemappingBridge falhavam no Obsidian e funcionavam no navegador, Reset funcionava no Obsidian, teclado físico funcionava. Novo Mabox: apenas Zoom In falha no Obsidian; Zoom Out e Reset funcionam, navegador e terminal aceitam os três. Firmware v3.2.3 emite Zoom In como **Ctrl+Shift+HID Equal**, Zoom Out **Ctrl+Minus**, Reset **Ctrl+0**. **Teste Ctrl+= versus Ctrl+Shift+= no Obsidian realizado:** sem Shift amplia, com Shift não amplia. Priorizar agora **Ctrl+= sem Shift no navegador e no terminal**, com teclado físico, para assegurar que a eventual remoção genérica de Shift não gere regressão. A proposta, somente após esse controle e autorização expressa, é ação 26 mudar de máscara `0x03` para `0x01`, mantendo HID Equal `0x2E`; não alterar ZOOM OUT/RESET nem criar lógica por aplicativo. Layout XKB e event node USB continuam úteis se houver divergências.

## Preparação de diagnóstico e testes complementares
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
5. **Resultados do Mabox foram incorporados ao diagnóstico, sem autorização de implementação.** MNT-13 está publicado v3.2.3 e MNT-14 cancelado; nenhum dos dois é pré-requisito para eventual correção Zoom. Antes de alterar firmware, **validar Ctrl+= sem Shift em navegador e terminal**; a diferença com/sem Shift já foi observada no Obsidian. Preservar navegador/terminal.
