# RemappingBridge v3.x — manutenção incremental pós-v3.0.0

**Estado atualizado em 11/10/2026:** gates **MNT-01 a MNT-11 aceitos e publicados**, última release oficial [**v3.2.1**](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1). **MNT-12** (Zoom Obsidian) segue **suspenso** a pedido do operador. **MNT-13** (PAIR NEW com mouse conectado) foi **somente planejado**, com **Parte 1 — comprovação da causa raiz** e **Parte 2 — decisão sobre corrigir ou não segundo viabilidade**. Não houve execução do MNT-13, branch de firmware nem UF2 novo.

## Baseline e fontes

- Firmware: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge), Pico 2 W e HAT LCD 9×21, Bluetooth Mouse → USB Mouse/Keyboard/Consumer.
- Baseline histórica imutável [v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0), commit `d7c7950fe595bd0e14a970cf60a29d085f065db4`.
- Última versão publicada antes do novo planejamento: [v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1), commit de release `3846e8f4ee5fba40421c0db1f51387de6c51e953`.
- Históricos [modifier-shortcuts](../modifier-shortcuts/README.md), [movement-options](../movement-options/README.md) e [HOPE](../RP-2350/hope/) preservados.
- Regra: qualquer mudança futura no firmware parte do SHA da **última tag realmente publicada**, não de branches antigas ou do arquivo deste planejamento. Não criar v4.0.0.

## Organização e gates

1. [01 — Backlog e requisitos](01-backlog-and-contract.md): **3 hotfixes e 11 melhorias**; MEL-08 Zoom, MEL-09 sufixo BLE, MEL-10 remoção de mouse, **MEL-11 PAIR NEW**.
2. [02 — Matriz dos 13 gates, dependências e versionamento](02-gates-and-versioning.md): MNT-01..MNT-11 encerrados; MNT-12 suspenso; MNT-13 novo, em duas partes.
3. [03 — Testes, evidências e aceites](03-tests-and-acceptance.md): cenários físicos e regressões, incluindo os dois marcos do MNT-13.
4. [04 — Decisões e riscos](04-decisions-and-risks.md): SemVer, riscos de BLE/HID e critérios GO/NO-GO.
5. [MNT-12 — Zoom genérico](gates/MNT-12.md): **PENDING / SUSPENSO**; conservar todo o planejamento antigo.
6. [MNT-13 — PAIR NEW com mouse conectado](gates/MNT-13.md): **PENDING**. Parte 1 causa raiz reproduzida e comprovada; Parte 2 decisão sobre viabilidade. Nenhuma correção está autorizada automaticamente.
7. [Investigação estática já concluída](investigations/pair-new-with-connected-mouse-2026-10-11.md): origem do requisito, HOPE-06, verificação da v3.2.0, hipóteses abertas. É **insumo**, não aceite/execução da Parte 1.
8. [gates/](gates/): contratos individuais de MNT-01..MNT-13; [executions/](executions/): evidências e aceites históricos dos gates executados.

## Regra de condução e publicação

- **Este pedido atualiza somente o planejamento.** Não iniciar o MNT-12, a Parte 1 ou a Parte 2 do MNT-13 sem comando explícito do operador. Não criar branch, PR, alteração em `remappingbridge/remappingbridge` ou firmware por escrever um gate no planner.
- MNT-13 **Parte 1:** reproduzir com mouse conectado e B genuinamente não salvo; medir scan/conexão/security/HIDS/handoff; provar ou descartar hipótese; relatório técnico, **NO RELEASE**.
- MNT-13 **Parte 2:** avaliar causa real, capacidade Bluetooth e custo/risco. Registrar decisão **GO / NO-GO / BLOCKED / NOT A BUG**, com aceite do operador. Um **GO exige nova autorização explícita para implementar**, e implementação não equivale a aceite físico.
- Se autorizado corrigir: PR draft de branch da última tag v3.x, testes host/CI, Pico 2 W produção, UF2 oficial conferido por SHA-256, cenários físicos desde HOME CONNECTED, aceite expresso, bump SemVer 3.x e release. Bug não resolvido ou diagnóstico documental **não geram versão fictícia**.
- Nunca introduzir a exigência de desligar o mouse atual como “arquitetura” para PAIR NEW; esse procedimento é somente contorno/teste de comparação. Preservar um único mouse autoritativo, possível candidato temporário não autoritativo, perfis/bonds por mouse e 9×21.
