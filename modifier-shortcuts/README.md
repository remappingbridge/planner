# Modifier Shortcuts — planejamento arquitetural (RemappingBridge v2.0.0)

**Status: MOD-00 and MOD-01 ACCEPTED; MOD-02 ACCEPTED; MOD-03 ACCEPTED; MOD-04 CORRECTED AND ACCEPTED; MOD-05 ACCEPTED; MOD-06 PHYSICALLY ACCEPTED; MOD-07 PHYSICALLY ACCEPTED; MOD-08 PHYSICALLY ACCEPTED by operator; MOD-09 PHYSICALLY ACCEPTED by operator; MOD-10 qualification candidate, CI/UF2 and physical validation pending.** Data: 2026-10-11. Documento de entrada: `TELAS MODIFIER.md` fornecido pelo operador. Repositório de produto: [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge). Fonte imutável: [tag v2.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v2.0.0). Este diretório NÃO contém alterações de firmware.

## Resultado esperado
Continuar em `home-connected > remapping-options > combinations-N > shortcuts-X-Y > KEY A: APPLY AND BACK`, permitindo associar uma das **30 ações de teclado** a cada uma de **12 combinações** envolvendo um botão físico `MODIFIER`. Configurar atalhos independe de selecionar o botão modificador. `STANDARD REMAP` e `ESCAPE REMAP` deixam de existir como perfis/opções; `ESCAPE` passa a ser um atalho configurável.

## Fontes em ordem de precedência
1. Regras explícitas e telas do anexo `TELAS MODIFIER.md` (neste planejamento, separadas de inferências).
2. Estado efetivo da tag `v2.0.0`: `README.md`, `docs/releases/v2.0.0.md`, `src/ux_model/ux_model.c`, `src/renderer/renderer.c`, `src/app/main.c`, `src/profiles/profiles.c`, `src/remap/remap.c`, `src/usb_hid/usb_descriptors.c`, `include/blu2usb/{domain,profiles,storage,ux_model,usb_hid}`.
3. [movement-options](../movement-options/README.md) (gates MOV-01–10 aceitos) e `RP-2350/hope`: regras preservadas de navegação, visual, UI/estado e aceite físico.
4. Inferências deste planejamento, claramente identificadas; nenhum conflito com texto literal pode ser resolvido silenciosamente na implementação.

## Leia na ordem
- [01 — Escopo, inventário e decisões](01-baseline-decisions.md)
- [02 — Telas, paginação e navegação](02-ui-navigation-contract.md)
- [03 — Modelo, pipeline de eventos e máquina de estados](03-runtime-architecture.md)
- [04 — Catálogo das 30 ações e contrato HID/host](04-shortcuts-hid-catalog.md)
- [05 — Persistência, migração e rollback](05-persistence-migration.md)
- [06 — Gates e testes físicos](06-gates-and-acceptance.md)
- [07 — Matriz de rastreabilidade e riscos](07-traceability-decisions.md)

## Regras inegociáveis
- Nunca aplicar uma combinação cujo estado efetivo é `UNAVAILABLE`; `KEY A` em `combinations` reseta **somente a combinação selecionada** a `NOT CUSTOMIZED`, salvo indisponíveis.
- Seleção e navegação pelo HAT são disparadas na **liberação**; `KEY B` cancela/volta sem persistir; `KEY Y` preserva lock/unlock e a primeira interação de unlock é consumida.
- A camada de domínio de atalhos não deve duplicar a pilha BLE, o remapper, o agregador HID, o armazenamento ou o compositor existentes.
- Contrato visual 9 linhas × 21 caracteres, com só o nome do mouse conectado em ciano em `Saved Devices`; sem debug embarcado.
- Antes de qualquer mudança de descritor USB, decidir compatibilidade das 30 ações, sobretudo multimídia/brilho. Nenhuma alegação genérica de suporte multiplataforma sem testes.
- A implementação futura usa uma branch separada **criada a partir da tag `v2.0.0`**, nunca altera essa tag. Um gate de cada vez, cada gate implementado testável desde `home-connected`, CI + UF2 e cenários físicos; aceite humano antes do próximo gate.

## MOD-00 — candidato documental para aceite (2026-10-11)
- [Preflight e baseline](executions/MOD-00/pre-implementation.md)
- [Contrato candidato + decisões propostas](executions/MOD-00/candidate.md)
- [Revisão e aceite do operador — ACCEPTED](executions/MOD-00/operator-acceptance.md)
- [Fixture literal do anexo: 17 telas em 9×21](fixtures/mod-00-source-layouts.json)
- MOD-00 foi **aprovado explicitamente** em 2026-10-11. Não criou UF2 nem alterou firmware.

## MOD-01 — branch de firmware e validação
- [Baseline e escopo](executions/MOD-01/pre-implementation.md)
- [Build candidato CI PASS + hash UF2](executions/MOD-01/candidate.md)
- [Cenários físicos, aceite ACCEPTED](executions/MOD-01/physical-acceptance.md)
- [Branch do firmware](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01) — derivada de v2.0.0.
- [PR de revisão em draft #23](https://github.com/remappingbridge/remappingbridge/pull/23) — não mesclado.
- Executa a remoção real das quatro telas antigas de confirmação Standard/Escape e atualiza Remapping Options, Help e status. O botão MODIFIER SHORTCUTS acessa COMBINATIONS no MOD-02; o seletor de 30 atalhos fica reservado para MOD-03.
- **MOD-01 fisicamente aceito pelo operador em 2026-10-11.**

## MOD-02 — seis páginas de combinações
- [Escopo e pré-implementação](executions/MOD-02/pre-implementation.md)
- [Firmware corrigido, CI 61/61 PASS + SHA](executions/MOD-02/visual-bugfix.md)
- [Candidato MOD-02 anterior, substituído pela correção visual](executions/MOD-02/candidate.md)
- [Cenários físicos, aceite ACCEPTED](executions/MOD-02/physical-acceptance.md)
- [Contrato técnico e roteiro no firmware](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod02-combinations.md)
- 6 novas telas, 12 slots estáveis, 40 telas runtime; RESET em NONE não grava flash; o catálogo de atalhos só surge em MOD-03.
- MOD-02 foi aceito pelo operador; MOD-03 foi executado após esse aceite.

## MOD-03 — cinco telas de atalhos e persistência
- [Candidato validado, 63/63 PASS + UF2 e SHA](executions/MOD-03/candidate.md)
- [Escopo e migração v3](executions/MOD-03/pre-implementation.md)
- [Cenários físicos e aceite ACCEPTED](executions/MOD-03/physical-acceptance.md)
- [Contrato e fluxo no firmware](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod03-shortcuts.md)
- 45 telas, 30 ações configuráveis, 12 combinações globais; sem execução HID até gates posteriores.

## MOD-04 — Modifier físico exclusivo e máscaras reversíveis
- [Correção de 4 bugs de UI, CI 66/66 PASS + SHA UF2](executions/MOD-04/visual-correction.md)
- [Candidato original MOD-04, substituído](executions/MOD-04/candidate.md)
- [Escopo e dependência física aceita](executions/MOD-04/pre-implementation.md)
- [Cenários de testes físicos, aceite ACCEPTED](executions/MOD-04/physical-acceptance.md)
- [Branch exclusiva](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod04) e [PR #24 em draft](https://github.com/remappingbridge/remappingbridge/pull/24)
- Novo MODIFIER como destino do Custom, 1 source exclusivo, combinações de mesmo botão UNAVAILABLE (sem apagar shortcut), retorno do valor salvo ao mudar source; nenhuma execução HID até MOD-05.

## MOD-05 — buttons + Escape e Copy
- [Candidato CI 68/68 PASS e UF2 verificado](executions/MOD-05/candidate.md)
- [Escopo de runtime](executions/MOD-05/pre-implementation.md)
- [Testes físicos, aceite ACCEPTED](executions/MOD-05/physical-acceptance.md)
- [Fluxo no firmware](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod05/docs/modifier-shortcuts/mod05-buttons-and-keyboard.md)
- [Branch MOD-05](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod05), [PR draft #25](https://github.com/remappingbridge/remappingbridge/pull/25).
- Somente HID Keyboard Escape e Ctrl+C neste gate; MOD-06 depende de aceite físico.

## MOD-06 — Wheel e MOVE direcional
- [Candidato MOD-06, CI 70/70 PASS + SHA/UF2](executions/MOD-06/candidate.md)
- [Escopo da classificação, sem alterar Movement](executions/MOD-06/pre-implementation.md)
- [Cenários físicos desde HOME, aceite ACCEPTED](executions/MOD-06/physical-acceptance.md)
- [Branch do firmware](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod06), [PR #26 draft](https://github.com/remappingbridge/remappingbridge/pull/26)
- Suporte a detents verticais, pan preservado, captura MOVE com rotação pré-DPI, direção dominante, quietude/histerese. A execução USB permanece limitada aos dois atalhos validados no MOD-05 (ESCAPE e COPY).

## MOD-07 — Keyboard HID catálogo 22/30
- [Candidato CI 72/72 e SHA/UF2 de produção](executions/MOD-07/candidate.md)
- [Escopo e política Linux-first](executions/MOD-07/pre-implementation.md)
- [12 cenários físicos, aceite ACCEPTED](executions/MOD-07/physical-acceptance.md)
- [Branch](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod07), [PR #27 draft](https://github.com/remappingbridge/remappingbridge/pull/27)
- IDs 1..18/25..28 em Keyboard; IDs 19..24/29..30 aguardam Consumer no MOD-08.

## MOD-08 — Consumer Media / Volume / Brightness
- [Candidato corretivo CI 75/75 PASS, novo UF2 e SHA256](executions/MOD-08/candidate.md)
- [Bugs relatados e retestes KDE/Android/Obsidian](executions/MOD-08/operator-bugfix-20261011.md)
- [Contrato de implementação e ADR-HID A](executions/MOD-08/pre-implementation.md)
- [Testes físicos USB e Linux desde HOME](executions/MOD-08/physical-acceptance.md), [aceite explícito do operador](executions/MOD-08/operator-acceptance.md)
- [Branch dedicada](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod08), [PR #28 draft](https://github.com/remappingbridge/remappingbridge/pull/28)
- HID Consumer na interface Keyboard existente, Report IDs 1/2, Boot Keyboard preservado, 8 IDs 19..24/29..30. Brilho real é dependente do hardware Linux.

## MOD-09 — Recovery, lock, BLE/USB, Saved Devices
- [Base, riscos e escopo](executions/MOD-09/pre-implementation.md)
- [Candidato CI 77/77 PASS, UF2 verificado e SHA-256](executions/MOD-09/candidate.md)
- [Roteiro físico desde HOME CONNECTED](executions/MOD-09/physical-acceptance.md)
- [Branch de firmware MOD-09](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod09)
- Base exata: MOD-08 aceito `5bfde2c4dc21aef3505ea9884a4878ae8ee8ec6f`. Não avançar MOD-10 antes de aprovação.

## MOD-10 — release qualification, not publication
- [Contract/dependencies](executions/MOD-10/pre-implementation.md)
- [Candidate, CI and UF2](executions/MOD-10/candidate.md)
- [Full physical regression / downgrade plan](executions/MOD-10/physical-acceptance.md)
- [Firmware branch](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod10), descending from MOD-09 SHA `dcc85dfc86ef140bf8acb2be54488f0ce07b3000`.
- No merge, tag or release before an explicit separate request.
