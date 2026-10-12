# MNT-13 — Pré-implementação (12/10/2026)

**Autorizado para implementar pelo operador; PENDING aceite físico.**

## Baseline e isolamento
- Versão base oficial: `v3.2.2`, SHA `0d35397e6a1619f2a5dc314d0f2659206912d177`, igual à `main` na abertura.
- Branch de implementação: `maintenance/v3x-mnt-13`. Sem alterar tags/release/versão interna até aceite.
- MNT-14 (PAIR NEW) e MNT-15 (Zoom) fora do escopo.

## Inventário de código e templates
- `src/ux_model/ux_model.c`: `blu2usb_ux_option_count` expõe 4 HOME, 2 SEARCH/RETRY, 3 REMAPPING, 5 EDIT, 6 WILL BECOME, 3 MOVEMENT, 4 em cada DPI/ROTATION, 2 COMBINATIONS, 6 SHORTCUTS; retorna zero para SAVED DEVICES.
- `src/renderer/renderer.c`: `selected_row` já mapeia opção para linha física (COMBINATIONS: 1/3; MOVEMENT: 1/2/4); `blu2usb_ui_project` limpa todas as 9x21 células a cada projeção e aplica cores de foco/CURRENT.
- `src/renderer/profile_feedback.c`: `blu2usb_ui_enforce_applied_visual_contract` é a etapa posterior à projeção, recompõe tons de REMAPPING, EDIT, WILL BECOME.
- `src/app/main.c`: executa projeto → contrato visual → render físico; a seta será etapa final separada, depois do contrato, sem mudar snapshots da API de projeção/contrato usados pelos testes de gates anteriores.
- Todos os **itens navegáveis** nas telas enumeradas reservam espaço ASCII inicial em coluna 0. Exceção informativa da tela SAVED DEVICES tem rótulo ` REMOVE DEVICE` na linha 5; projetar seta apenas se `blu2usb_ux_saved_bond_for_page` resolver bond real.
- Telas de HELP, confirmação, pareamento, primeiro mouse, carregamento e dicas não possuem seleção navegável; sem seta.
- A seta herda a tonalidade da célula 1 já focada (branco ou ciano claro); nunca a de um valor diferente.

## Execução e validação
1. Implementar finalização idempotente do frame (célula 0) usando seleção válida, screen e bond; sem mutação do modelo UX e sem dependência de flash.
2. Testar exaustivamente todas as telas, páginas, seleções, estados sem menu, seleção inválida, bordas, cores, leitura do texto após primeira coluna e reaproveitamento do mesmo frame em transições.
3. CI host completa + firmware Pico 2 W, extrair UF2 oficial, conferir SHA com log, disponibilizar candidato e roteiro de teste físico desde HOME CONNECTED.
4. Somente aceite físico explícito autoriza bump PATCH, merge e release.
