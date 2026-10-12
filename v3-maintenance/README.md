# RemappingBridge v3.x — manutenção incremental pós-v3.0.0

**Estado atualizado em 12/10/2026:** gates **MNT-01..MNT-13 aceitos/publicados**, última tag oficial **[v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4)**. **MNT-14 CANCELADO a pedido do operador**, após testes físicos relatados como bem-sucedidos em cenários variados/adversos; auditoria estática histórica preservada, sem diagnóstico causal ou patch. **MNT-15 Zoom: ACEITO E PUBLICADO v3.2.4**. O operador aprovou o UF2 da [PR #45](https://github.com/remappingbridge/remappingbridge/pull/45); [release oficial](executions/MNT-15/release.md), CI 98/98 + Pico 2 W PASS e checksum comprovado. Ação 26 = Ctrl+Equal sem Shift, com limitação de terminais que exigem Shift documentada. MNT-14 cancelado, sem nova implementação.

## Baseline e fontes

- Produto: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge), firmware para Pico 2 W, LCD/HAT 9×21, Mouse/Keyboard/Consumer USB HID e BLE HOGP.
- Fonte v3.0.0 imutável: commit `d7c7950fe595bd0e14a970cf60a29d085f065db4`.
- Última release verificada: **[v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4)**, commit squash/tag `69a640d9767ec7198572eb9b5073ed71f8f3d202`, PR #45, CI de release #38300896801 (98/98 host + Pico 2 W PASS), checksum do UF2 oficial `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`.
- Históricos [modifier-shortcuts](../modifier-shortcuts/README.md), [movement-options](../movement-options/README.md) e [HOPE](../RP-2350/hope/) preservados. A futura branch de qualquer gate com firmware parte exclusivamente da **última tag oficial publicada**, nunca de uma branch candidata.

## Índice atualizado — 15 gates

1. [01 — Backlog e contrato](01-backlog-and-contract.md): **3 hotfixes e 13 melhorias**. MEL-12 corresponde ao MNT-12 aceito, MEL-13 ao novo indicador visual do MNT-13, MEL-11 ao MNT-14 (PAIR NEW) e MEL-08 ao MNT-15 (Zoom).
2. [02 — Matriz dos gates, dependências e SemVer 3.x](02-gates-and-versioning.md): MNT-01..13 publicados; MNT-14 cancelado sem correção/release após validação física positiva relatada pelo operador; MNT-15 fisicamente aceito e publicado v3.2.4.
3. [03 — Testes e aceites](03-tests-and-acceptance.md): cenários do marcador `|` em todas as listas, exceções de COMBINATIONS/SAVED DEVICES, diagnóstico PAIR NEW e Zoom.
4. [04 — Decisões e riscos](04-decisions-and-risks.md): cor e foco, integridade das telas 9×21, composição final do renderer, riscos BLE/HID.
5. [MNT-12 — cores de Modifier/Combinations](gates/MNT-12.md): **ACEITO v3.2.2**. [Aceite](executions/MNT-12/operator-acceptance.md) e [release](executions/MNT-12/release.md).
6. [MNT-13 — novo indicador de opção selecionada](gates/MNT-13.md): **ACEITO/PUBLICADO v3.2.3**. Só a opção focada recebe o caractere `|` na primeira coluna; em opções de duas linhas, na segunda linha; nenhuma outra opção/tela informativa.
7. [MNT-14 — PAIR NEW com A conectado](gates/MNT-14.md): **CANCELADO POR DECISÃO DO OPERADOR** após testes físicos positivos; relatórios de investigação estática anteriores preservados como histórico em [executions/MNT-14](executions/MNT-14/part-1-root-cause.md). Não executar Parte 2 nem correção.
8. [MNT-15 — Zoom genérico Obsidian/Mabox](gates/MNT-15.md): **ACEITO E PUBLICADO v3.2.4** — [matriz Mabox e investigação](executions/MNT-15/mabox-zoom-investigation-2026-10-12.md). Antigo MNT-14; correção genérica Zoom In publicada; [aceite](executions/MNT-15/operator-acceptance.md) e [release](executions/MNT-15/release.md).
9. [gates/](gates/) contém MNT-01..15; [executions/](executions/) conserva histórico de aceites e apenas roteiros planejados dos gates não iniciados.

## Regras de condução

- **Aceite MNT-13 encerrado/publicado v3.2.3.** [Aceite](executions/MNT-13/operator-acceptance.md), [release oficial](executions/MNT-13/release.md) e [candidato histórico](executions/MNT-13/candidate.md). **MNT-14 cancelado após validação física relatada; MNT-15 foi aceito, integrado na PR #45 e publicado como v3.2.4, sem iniciar novo gate.**
- MNT-13 é mudança de exibição, sem alteração de estado/aplicação de perfis, nomes, armazenamento, ações HID ou comandos. Reaproveitar seleção UX, coluna física 1 (índice 0), cores existentes e linha apropriada de cada item.
- MNT-14: Parte 1 teve preflight/auditoria estática; testes físicos positivos informados pelo operador motivaram cancelamento, sem prova de causa raiz e sem Parte 2. Planos originais são conservados como histórico.
- MNT-15: teste Mabox demonstra Zoom In falhando apenas no Obsidian; Zoom Out e Reset funcionam e os três comandos operam no navegador e terminal. Ctrl+= sem Shift foi validado em Obsidian e navegador; terminais apresentam diferenças de atalho. Gate fisicamente aceito pelo operador e versão v3.2.4 publicada com UF2 e SHA256SUMS.
- Qualquer nova implementação autorizada exige branch da tag oficial v3.x mais recente, PR draft, CI host e Pico 2 W produção, UF2 de CI com SHA-256 conferido e validação física. **Somente após aceite explícito** fazer bump PATCH, merge e release. Nunca usar `flash_nuke` durante atualização normal.

