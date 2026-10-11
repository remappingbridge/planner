# MNT-04 — testes físicos LCD e aceite

**STATUS: PENDING — sem relato de validação física do operador.**

## Preparação
Instalar o UF2 de produção Pico 2 W via BOOTSEL sem `flash_nuke`, preservando bonds BLE, perfis, Movement e Modifier Shortcuts. Iniciar na tela **HOME CONNECTED** com mouse pareado e conectado.

## Cenários
- [ ] **01 — Remapping Options**: entrar no menu e confirmar `JOY UP/DOWN: SELECT`; navegação vertical, destaque e cores permanecem corretos.
- [ ] **02 — Saved Devices**: abrir Saved Devices e confirmar `JOY RIGHT/LEFT: PAGE`, cinza padrão; título magenta, só nome ativo ciano e `REMOVE DEVICE` branco. Paginar e entrar em Remove This, cancelar sem apagar.
- [ ] **03 — Movement**: percorrer HORIZONTAL SLOW/FAST e VERTICAL SLOW/FAST. As quatro telas mostram `JOY LEFT/RIGHT: PAGE`; foco, ganho, rotação e retorno APPLY AND BACK não regrediram.
- [ ] **04 — Combinations 1..6**: todas exibem `JOY LEFT/RIGHT: PAGE`; paginação, seleção, reset e acesso à lista de atalhos permanecem funcionais.
- [ ] **05 — Shortcuts 7..12**: rótulo `ENTER/RETURN`, sem barra invertida e sem mudança da ação HID.
- [ ] **06 — Shortcuts 19..24**: rótulo `PLAY/PAUSE`, sem barra invertida, acionamento e persistência intactos.
- [ ] **07 — Shortcuts 25..30**: rótulo `HOME SCREEN/PAGE`; texto inteiro em uma linha do LCD, sem truncar ou mudar ação selecionada.
- [ ] **08 — Helps**: entrar em Help a partir de menus e retornar como na versão anterior; o comportamento global de KEY B e KEY Y reservado ao futuro MNT-05 não muda.
- [ ] **09 — Smoke regressão**: nenhum backslash apresentado nas legendas LCD, máximo de 9 linhas x 21 colunas, títulos magenta, cores corretas, mouse BLE e USB HID funcionais, bond preservado após reinício.

## Aceite
- Resultados individuais: não informados.
- Aceite físico global: **PENDING**.
- Não atribuir PASS nem data fictícios sem mensagem do operador.
