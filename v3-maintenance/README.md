# RemappingBridge v3.x — manutenção incremental pós-v3.0.0

**Estado atualizado em 2026-10-11:** MNT-01..MNT-11 aceitos e publicados, com última versão **[v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1)**. **MNT-10** entregou exclusão completa de mouse/configuração; MNT-11 publicou correção de nomes BLE; MNT-12 guarda o antigo diagnóstico Zoom (antes MNT-10). MNT-12 está suspenso até nova autorização; investigação separada de PAIR NEW em `investigations/pair-new-with-connected-mouse-2026-10-11.md`.

## Baseline congelada
- Produto: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge).
- Baseline imutável: [release/tag v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0), commit exato **`d7c7950fe595bd0e14a970cf60a29d085f065db4`** (verificado no GitHub).
- Planejamento anterior, encerrado: [modifier-shortcuts/MOD-00..MOD-10](../modifier-shortcuts/README.md); v3.0.0 publicada. Este projeto não reabre gates MOD, não usa como base uma antiga branch MOD e não reescreve versão publicada.
- Novo trabalho será realizado **somente depois de pedido explícito para iniciar**, em branches próprias `maintenance/v3x-mnt-XX` criadas da **última tag v3.x publicada**. Nada é modificado em `remappingbridge/remappingbridge` por este planejamento.
- Produto: Raspberry Pi Pico 2 W, LCD/HAT com grade 9 linhas × 21 caracteres, USB Mouse+Keyboard/Consumer, BLE e saved mouse; preservar v3.0 e todas as 30 ações/12 combinações.

## Organização
1. [01 — Backlog literal e critérios por item](01-backlog-and-contract.md): **3 hotfixes, 10 melhorias**; Zoom Obsidian definido como **Melhoria 8**; nome redundante do mouse renumerado **Melhoria 9** porque o rascunho tinha dois títulos `8`.
2. [02 — Gates, dependências e versões](02-gates-and-versioning.md): **12 gates**, os hotfixes 2/3 empacotados atomicamente, Help/Lock realizado **antes** da legenda LOCKS ANYWHERE, e **uma publicação condicionada a cada gate fisicamente aceito**.
3. [03 — Cenários físicos e regressão](03-tests-and-acceptance.md): cada candidato nasce testável desde HOME CONNECTED e requer CI + UF2 Pico 2 W, checksum e aceite.
4. [04 — Decisões, semântica visual e riscos](04-decisions-and-risks.md): diferencia cores, controles, nomes, compatibilidade de layout e semver.
5. [MNT-09 — candidato/aceite](executions/MNT-09/operator-acceptance.md) e publicação [v3.1.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.1.4); demais releases anteriores aceitos.
6. [MNT-10 — exclusão completa de mouse](gates/MNT-10.md) planejado; [MNT-11 — sufixo BLE](gates/MNT-11.md) preservado; [MNT-12 — Zoom genérico](gates/MNT-12.md) renumerado, sem implementação.
7. [gates/](gates/): contrato independente de cada MNT-01..MNT-12, pronto para implementação futura.

## Regras de entrega e publicação
- Hotfixes/correções cosméticas: **PATCH**; mudança intencional de comportamento dos Helps (somente KEY B volta; KEY Y bloqueia): **MINOR**; **MAJOR não está no escopo**. Tabela de versões é **previsão**, deve ser recalculada a partir da última tag realmente publicada se outro release intercalar.
- Em cada gate: criar branch da última tag publicada, implementar somente escopo aprovado, CI host PASS + build Pico 2 W, UF2 real e SHA-256, PR de revisão, roteiro físico desde HOME, **aceite explícito do operador**, então atualizar versão/código/release notes, publicar tag GitHub Release com UF2/SHA256SUMS, validar release e só então iniciar gate seguinte. O pedido atual registra o aceite e publicação do MNT-09, mas **não autoriza implementar o novo MNT-10 neste momento**. Os releases seguintes continuam condicionados aos aceites de seus próprios gates.
- Rejeição/bug: corrigir **na mesma branch e dentro do mesmo gate**, substituir UF2 candidato, retestar e manter número de versão futuro reservado; **não publicar** uma falha. Item apenas diagnosticado/documentado (ex.: Zoom) não gera release fictícia.
- Preservar sempre flash sem `flash_nuke`, bonds BLE, configuração v3, Movement por mouse, identidade USB VID/PID/interfaces, Lock, Modifier, Custom/Passthrough, telas e semântica atual fora do gate.
