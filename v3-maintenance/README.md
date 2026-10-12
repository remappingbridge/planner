# RemappingBridge v3.x — manutenção incremental pós-v3.0.0

**Estado atualizado em 12/10/2026:** MNT-01..MNT-11 **aceitos e publicados**, último release [**v3.2.1**](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1). **MNT-12 NOVO**: ciano condicional para `MODIFIER SHORTCUTS` e valores atribuídos de `COMBINATIONS` — **somente planejado, não iniciado**. **MNT-13**: investigação PAIR NEW, duas partes — **não iniciado**. **MNT-14**: Zoom/Obsidian, antes MNT-12, **suspenso**. Nenhum firmware foi modificado por essa reorganização.

## Baseline e fontes

- Produto: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge), Pico 2 W, LCD/HAT 9×21, USB Mouse/Keyboard/Consumer e BLE HOGP.
- Histórico: [v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0) — `d7c7950fe595bd0e14a970cf60a29d085f065db4`; última release aceita [v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1) — commit `3846e8f4ee5fba40421c0db1f51387de6c51e953`.
- Repositórios/planejamentos históricos [MOD](../modifier-shortcuts/README.md), [MOV](../movement-options/README.md) e [HOPE](../RP-2350/hope/) preservados.
- Qualquer implementação futura deve partir do SHA da **tag v3.x oficial mais recente** no momento de execução. Não reescrever tags ou abrir v4.0.0 neste programa.

## Documentos e numeração atual

1. [01 — Backlog](01-backlog-and-contract.md): **3 hotfixes, 12 melhorias**; MEL-08 Zoom continua MNT-14; MEL-09 nome BLE, MEL-10 exclusão de mouse, MEL-11 PAIR NEW e MEL-12 nova indicação visual.
2. [02 — Matriz dos 14 gates](02-gates-and-versioning.md): MNT-01..11 encerrados, MNT-12/13 planejados, MNT-14 suspenso.
3. [03 — Testes e aceites](03-tests-and-acceptance.md): matriz visual do MNT-12, estágios de investigação MNT-13 e legado Zoom MNT-14.
4. [04 — Decisões e riscos](04-decisions-and-risks.md): estado do firmware, fonte da regra visual e segurança do contrato Pair New.
5. [MNT-12 — Modifier Shortcuts + Combinations](gates/MNT-12.md): indicação ciano **se CUSTOM realmente aplicado E há botão Modifier**; só valores atribuídos de combinações mudam; UNAVAILABLE / NOT CUSTOMIZED preservados.
6. [MNT-13 — PAIR NEW](gates/MNT-13.md): Parte 1 causa raiz e Parte 2 GO/NO-GO/BLOCKED/NOT A BUG; nenhuma correção automaticamente autorizada.
7. [MNT-14 — Zoom no Obsidian](gates/MNT-14.md): antigo MNT-12, por sua vez antigo MNT-10, **escopo preservado e suspenso**.
8. [Investigação PAIR NEW prévia](investigations/pair-new-with-connected-mouse-2026-10-11.md) é insumo estático ao MNT-13, não aceite nem execução da Parte 1.
9. [gates/](gates/) contém todos MNT-01..MNT-14; [executions/](executions/) conserva evidências de gates aceitos e planos separados de MNT-13.

## Regras de execução e publicação

- **Este pedido autoriza planejamento apenas.** Não iniciar MNT-12/13/14, nem criar branch, PR, commit no firmware, CI, UF2 ou release. A criação do MNT-12 não reabre um gate aceito.
- MNT-12 é mudança de **paleta semântica da UI**, sem alteração de RGB, USB/HID, BLE, atalhos, persistência ou navegação; versão PATCH v3.x apenas após implementação autorizada e aceite físico.
- MNT-13 continua em duas partes, diagnóstico somente e decisão de viabilidade; diagnóstico não gera tag/UF2 release nem autoriza um patch automaticamente.
- MNT-14 permanece SUSPENSO até pedido explícito; sem release para Zoom apenas investigado.
- Qualquer gate com código exige branch da tag publicada vigente, PR draft, regressões host e Pico 2 W produção, UF2 de GitHub Actions e checksum, teste físico desde HOME CONNECTED e **aceite explícito** antes de mesclar/release. Se falhar, correção e novo UF2 na mesma branch; nenhuma versão fictícia.
