# MNT-15 — Zoom genérico: diagnosticar Obsidian antes de corrigir HID

**Status atualizado em 12/10/2026: IMPLEMENTADO NA BRANCH [maintenance/v3x-mnt-15](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-15) / [PR #45 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/45) / CI 98/98 HOST + PICO 2 W PASS / UF2 VERIFIED / ACEITE FÍSICO PENDING.** O operador autorizou expressamente o gate após testes Mabox/Obsidian/navegador. Novo ZOOM IN genérico = HID Equal `0x2E` + Left Ctrl `0x01` **sem Shift**. ZOOM OUT/RESET inalterados. Terminais divergem entre Ctrl+= e Ctrl+Shift+=: **não prometer compatibilidade universal**. [Candidato CI/UF2/hash](../executions/MNT-15/candidate.md) concluído: commit `7177672d109f8f13aea77ba707c614e53d6065f1`, [CI #38298979787](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787), 98/98 PASS + Pico 2 W PASS, SHA-256 do UF2 `4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`. Sem release/tag nova até aceite físico.

- Backlog: **MEL-08 (solicitação explícita)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-13 aceito e publicado como v3.2.3** (MNT-14 cancelado sem patch); a branch futura `maintenance/v3x-mnt-15` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Histórico de renumeração: **MNT-10 → MNT-12 → MNT-14 → MNT-15**; o conteúdo de MEL-08 Zoom/Obsidian foi preservado. Nova renumeração autorizada em 12/10/2026 para reservar MNT-13 à indicação visual de seleção. MNT-14 é o diagnóstico PAIR NEW em duas partes.
- Versão prevista somente após aceite físico: **próxima versão v3.x disponível ao executar MNT-15 (PATCH apenas se correção real; sem release se só diagnóstico)**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
**Distinguir hosts e testes:** histórico Debian 13 KDE: Zoom In e Out via RemappingBridge falhavam no Obsidian e funcionavam no navegador, Reset funcionava no Obsidian, teclado físico funcionava. Novo Mabox: apenas Zoom In falha no Obsidian; Zoom Out e Reset funcionam, navegador e terminal aceitam os três. Firmware v3.2.3 emite Zoom In como **Ctrl+Shift+HID Equal**, Zoom Out **Ctrl+Minus**, Reset **Ctrl+0**. **Teste Ctrl+= versus Ctrl+Shift+= no Obsidian realizado:** sem Shift amplia, com Shift não amplia. **Novo resultado do operador:** Ctrl+= sem Shift funciona também no navegador; **terminais variam**, uns exigem Shift e outros não. Após pedido expresso de implementação, a ação 26 foi alterada de máscara `0x03` para `0x01` mantendo HID Equal `0x2E`, de maneira genérica. ZOOM OUT/RESET, UX, BLE e descritores não mudaram. O trade-off foi informado: terminais que dependem exclusivamente de Ctrl+Shift+= podem deixar de ampliar via esta ação RemappingBridge. Nenhuma emissão dupla nem detecção de aplicativo. Layout XKB e event node USB continuam úteis se houver divergências.

## Código implementado e validação complementar
Correlacionar device nodes BLU2USB vs AT integrado com evtest e udevadm; capturar Ctrl/Shift/Equal/Minus/0, layout XKB ABNT2, keydown/up, temporização. Validar equivalente comum em vários aplicativos, não supor que event0 registra BLU2USB.

## Teste físico individual desde HOME CONNECTED
[Checklist físico candidato](../executions/MNT-15/physical-acceptance.md): testar BLU2USB acionando Zoom In/Out/Reset em Obsidian, navegador, terminal sem Shift e terminal que exige Shift. Documentar explicitamente a possível perda de Zoom In no último; confirmar Redo/Screenshot Area com Shift, 30 ações intactas, ausência de stuck-key/USB e todos os perfis BLE inalterados. Somente operador marca aceite; nenhum release antes do aceite.

## Riscos/limites
Não criar mapeamento exclusivo do Obsidian, novo menu de layout ou versão que quebra zoom Firefox.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-15/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-15/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-15 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Autorização explícita de implementação recebida em 12/10/2026; alteração restrita à ação 26, com trade-off explícito em terminais.** MNT-13 está publicado v3.2.3 e MNT-14 cancelado. Candidato [PR #45 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/45) com 98/98 testes host e Pico 2 W produção PASS; [UF2 validado](../executions/MNT-15/candidate.md), ainda sem release; aguardar aceite físico.
