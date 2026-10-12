# RemappingBridge v3.x — manutenção incremental pós-v3.0.0

**Estado atualizado em 12/10/2026:** gates **MNT-01..MNT-13 aceitos/publicados**, última tag oficial **[v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3)**. **MNT-14 CANCELADO a pedido do operador**, após testes físicos relatados como bem-sucedidos em cenários variados/adversos; auditoria estática histórica preservada, sem diagnóstico causal ou patch. **MNT-15 Zoom: implementação autorizada após teste Mabox; ação 26 passou de Ctrl+Shift+Equal para Ctrl+Equal na [PR #45 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/45), CI host 98/98 PASS, Pico 2 W e físico PENDING. Terminais apresentam atalhos com Shift distintos; limitação documentada, ainda sem release.**

## Baseline e fontes

- Produto: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge), firmware para Pico 2 W, LCD/HAT 9×21, Mouse/Keyboard/Consumer USB HID e BLE HOGP.
- Fonte v3.0.0 imutável: commit `d7c7950fe595bd0e14a970cf60a29d085f065db4`.
- Última release verificada: **[v3.2.2](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.2)**, commit squash `0d35397e6a1619f2a5dc314d0f2659206912d177`, PR #42, CI 94/94 host e build Pico 2 W concluídos com sucesso.
- Históricos [modifier-shortcuts](../modifier-shortcuts/README.md), [movement-options](../movement-options/README.md) e [HOPE](../RP-2350/hope/) preservados. A futura branch de qualquer gate com firmware parte exclusivamente da **última tag oficial publicada**, nunca de uma branch candidata.

## Índice atualizado — 15 gates

1. [01 — Backlog e contrato](01-backlog-and-contract.md): **3 hotfixes e 13 melhorias**. MEL-12 corresponde ao MNT-12 aceito, MEL-13 ao novo indicador visual do MNT-13, MEL-11 ao MNT-14 (PAIR NEW) e MEL-08 ao MNT-15 (Zoom).
2. [02 — Matriz dos gates, dependências e SemVer 3.x](02-gates-and-versioning.md): MNT-01..13 publicados; MNT-14 cancelado sem correção/release após validação física positiva relatada pelo operador; MNT-15 implemented as a candidate, physical acceptance pending.
3. [03 — Testes e aceites](03-tests-and-acceptance.md): cenários do marcador `|` em todas as listas, exceções de COMBINATIONS/SAVED DEVICES, diagnóstico PAIR NEW e Zoom.
4. [04 — Decisões e riscos](04-decisions-and-risks.md): cor e foco, integridade das telas 9×21, composição final do renderer, riscos BLE/HID.
5. [MNT-12 — cores de Modifier/Combinations](gates/MNT-12.md): **ACEITO v3.2.2**. [Aceite](executions/MNT-12/operator-acceptance.md) e [release](executions/MNT-12/release.md).
6. [MNT-13 — novo indicador de opção selecionada](gates/MNT-13.md): **ACEITO/PUBLICADO v3.2.3**. Só a opção focada recebe o caractere `|` na primeira coluna; em opções de duas linhas, na segunda linha; nenhuma outra opção/tela informativa.
7. [MNT-14 — PAIR NEW com A conectado](gates/MNT-14.md): **CANCELADO POR DECISÃO DO OPERADOR** após testes físicos positivos; relatórios de investigação estática anteriores preservados como histórico em [executions/MNT-14](executions/MNT-14/part-1-root-cause.md). Não executar Parte 2 nem correção.
8. [MNT-15 — Zoom genérico Obsidian/Mabox](gates/MNT-15.md): **CANDIDATO PR #45 / CI HOST 98/98 / ACEITE FÍSICO PENDING** — [matriz Mabox e investigação](executions/MNT-15/mabox-zoom-investigation-2026-10-12.md). Antigo MNT-14; firmware change restricted to Zoom In, no release yet.
9. [gates/](gates/) contém MNT-01..15; [executions/](executions/) conserva histórico de aceites e apenas roteiros planejados dos gates não iniciados.

## Regras de condução

- **Aceite MNT-13 encerrado/publicado v3.2.3.** [Aceite](executions/MNT-13/operator-acceptance.md), [release oficial](executions/MNT-13/release.md) e [candidato histórico](executions/MNT-13/candidate.md). **MNT-14 cancelado após validação física relatada; MNT-15 recebeu autorização expressa para alteração da ação 26 e tem PR #45 DRAFT, sem release.**
- MNT-13 é mudança de exibição, sem alteração de estado/aplicação de perfis, nomes, armazenamento, ações HID ou comandos. Reaproveitar seleção UX, coluna física 1 (índice 0), cores existentes e linha apropriada de cada item.
- MNT-14: Parte 1 teve preflight/auditoria estática; testes físicos positivos informados pelo operador motivaram cancelamento, sem prova de causa raiz e sem Parte 2. Planos originais são conservados como histórico.
- MNT-15: teste Mabox demonstra Zoom In falhando apenas no Obsidian; Zoom Out e Reset funcionam e os três comandos operam no navegador e terminal. Ctrl+= sem Shift foi validado em Obsidian e navegador; terminais apresentam diferenças de atalho. Candidato gerado para teste físico, ainda sem release.
- Qualquer nova implementação autorizada exige branch da tag oficial v3.x mais recente, PR draft, CI host e Pico 2 W produção, UF2 de CI com SHA-256 conferido e validação física. **Somente após aceite explícito** fazer bump PATCH, merge e release. Nunca usar `flash_nuke` durante atualização normal.

