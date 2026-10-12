# Planner

Planejamento, evidências e documentação operacional do ecossistema Remapping Bridge.

## Estrutura

- `RP-2350/mouse-bridge-remapper/` — programa histórico MBR para RP-2350.
- `RP-2350/mouse/` — UI/Core/integração modular para RP-2350.
- `RP-2350/hope/` — série HOPE do RemappingBridge; série concluída e RemappingBridge 1.0 publicado.
- `movement-options/` — planejamento, execução e aceite da funcionalidade Movement Options publicada como RemappingBridge 2.0.0.
- `modifier-shortcuts/` — histórico concluído dos gates MOD-00..MOD-10, que resultaram no RemappingBridge v3.0.0 publicado.
- `web-simulator-readme/` — **WEB-00 CONCLUÍDO, WEB-01 ACEITO/INTEGRADO, WEB-02 CANDIDATE; WEB-03..15 NOT STARTED; ENGLISH-ONLY e testes web em produção**: simulador HTML/CSS/JavaScript puro de página única em `remappingbridge.github.io`, controles HAT/LCD e fluxo v3.x, mais README raiz didático/de negócios no `remappingbridge`, hardware Pico 2 W/Waveshare Pico-LCD-1.3, prévia clicável da demonstração e download da release UF2 mais recente. Sem Node/npm, sem workflow Actions do projeto, sem alterar firmware nesta fase. [Programa e gates](web-simulator-readme/README.md).
- `v3-maintenance/` — manutenção RemappingBridge v3.x: **MNT-01..MNT-13 aceitos e publicados até [v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3)**; **MNT-14 PAIR NEW cancelado por decisão do operador após testes físicos bem-sucedidos** (sem alteração de firmware); **MNT-15 Zoom/Obsidian suspenso e não autorizado para implementação**. Histórico e evidências no [planejamento v3.x](v3-maintenance/README.md).
- `batocera/monitor5x4/` — configuração documentada do Batocera v43 para o monitor Dell P1917S 5:4.
- `aurora-xbox/` — registro rastreável do Xbox 360 E 1538: ABadAvatar/XeUnshackle, backup validado da NAND, Aurora 0.7b.2 e próximos passos de NetISO/macOS.
- `office-drive/` — planejamento independente existente.

A reorganização em `RP-2350/` agrupa os planners associados ao firmware/microcontrolador sem alterar seu conteúdo.
