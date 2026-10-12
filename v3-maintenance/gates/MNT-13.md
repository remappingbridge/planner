# MNT-13 — Marcador pipe `|` na primeira coluna da opção focada

**STATUS: IMPLEMENTADO EM CANDIDATO / CI 96/96 + PICO 2 W PASS / UF2 VERIFICADO / ACEITE FÍSICO PENDING.** O gate foi inicialmente planejado em 12/10/2026; nova ordem expressa para implementar resultou na [branch e PR #43 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/43). Ainda **sem merge/tag/release**. [Candidato e SHA](../executions/MNT-13/candidate.md) · [Cenários físicos](../executions/MNT-13/physical-acceptance.md).

- Identificador de backlog: MEL-13 NOVO; numeração MEL independente dos gates históricos.
- A última base aceita antes deste plano é v3.2.2 (MNT-12); futura implementação deve derivar da tag oficial v3.x mais recente que existir na ocasião.
- Gate anterior MNT-13 (PAIR NEW) preservado como **[MNT-14](MNT-14.md)**, com duas partes independentes de causa raiz e decisão GO/NO-GO; anterior MNT-14 (Zoom) preservado como **[MNT-15](MNT-15.md)** e continua suspenso.
- Escopo: **somente o indicador visual de foco em menus/listas**, sem alterar comandos, perfil efetivo, mapeamentos, HID, BLE, armazenamento, nomes, campos, texts, tons RGB nem navegação.

## 1. Regra visual universal

Em **toda tela que apresenta opções entre as quais o operador pode navegar e escolher**, exibir o caractere ASCII pipe **`|`** na **primeira coluna física do LCD** (coluna 1 para o usuário; índice 0 do frame) **somente na linha da opção atualmente selecionada**.

Invariantes verificáveis por frame:

1. Em uma lista com pelo menos uma opção elegível, **exatamente um marcador `|`**, na primeira coluna da opção que recebe o foco de navegação. Todas as demais opções dessa tela mantêm a primeira coluna vazia, sem marcador. O marcador precisa seguir a seleção ao mover JOY e não ficar na opção anterior.
2. O símbolo representa **o item com foco para escolher/acionar**, e não o item atualmente aplicado, salvo, conectado, ou que está ciano por representar valor CURRENT. A marcador pode estar em opção branca e outra opção continuar ciano normal por já estar aplicada.
3. A primeira coluna é **célula 0**, não a segunda. Os templates existentes geralmente começam com espaço à esquerda; usar essa margem para substituir o espaço pelo pipe. **Nunca sobrescrever letras ou cortar/empurrar textos** fora do limite 9 linhas por 21 colunas. Caso um template não reserve essa margem, documentar ajuste mínimo no preflight antes de implementar.
4. O símbolo conserva o **tom do foco** já calculado para a opção: branco quando opção comum selecionada, ciano clarinho quando CURRENT selecionado conforme MNT-08/MNT-12. Não introduzir nova cor ou recolorir toda a linha.
5. Recalcular a cada projeção da tela e retirar qualquer marcador anterior ao trocar seleção, página, Help, tela, lock/unlock, conexão ou mouse. **Não persistir** o marcador, nem inseri-la na string de rótulos, eventos ou estruturas de flash.
6. **Nenhum marcador** em títulos, status, conteúdo descritivo, nomes de mouse, parâmetros somente informativos, dicas KEY/JOY, telas de resultado, telas de espera, instruções e Help. A marcador não pode fazer parecer acionável algo que não existe.
7. Se o foco lógico não for válido, não inventar opção, nem deixar marcador residual. Um estado UNAVAILABLE pode pertencer a combinação focada sem alterar seu status/tonalidade, pois o pipe pertence à **segunda linha da opção focada (valor/status)**. Se o valor for UNAVAILABLE, ele conserva a cor STATIC e o pipe usa o tom branco do rótulo focado.

## 2. Inventário técnico das telas da v3.2.1 (preflight obrigatório contra tag vigente)

Mapeamento inicial conferido em src/ux_model/ux_model.c, include/blu2usb/ux_model/ux_model.h e src/renderer/renderer.c. O inventário de implementação deve ser atualizado contra a tag efetiva, contemplando qualquer tela de lista adicionada posteriormente.

| Telas com lista | Contagem/seleção atual | Linha física que recebe | |
|---|---|---|
| HOME CONNECTED | 4 opções | linha 1, 2, 3 ou 4 (1 + selection) |
| HOME_SEARCHING e HOME_RETRY | 2 opções por tela | linha 1 ou 2 |
| REMAPPING OPTIONS | 3 opções | linha 1, 2 ou 3; o estado CURRENT e o ciano de MODIFIER SHORTCUTS MNT-12 continuam independentes |
| EDIT CUSTOM REMAP | 5 opções de botão | linhas 1..5; cursor do botão atualmente focado, não target persistido |
| LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD WILL BECOME | 6 destinos por tela | linhas 1..6; apenas target em foco, não target configurado |
| MOVEMENT OPTIONS | 3 itens | HORIZONTAL linha 1; VERTICAL linha 2; ROTATION linha **4**, nunca linha 3 COUNTERCLOCKWISE (descritiva) |
| HORIZONTAL/VERTICAL SLOW DPI e FAST DPI | 4 por tela | linhas 1..4, segundo foco atual mesmo que opção aplicada seja outra |
| ROTATION | 4 opções | linhas 1..4, sem misturar valor aplicado e foco |
| COMBINATIONS 1 OF 6 até 6 OF 6 | 2 pares por página | pipe na **segunda linha (valor/status) 2 ou 4**; **não** nos rótulos 1 e 3. Conservar NOT CUSTOMIZED/UNAVAILABLE, ciano de valores MNT-12 e seleção de par |
| SHORTCUTS 1..5 | 6 por página | linhas 1..6; marcador no atalho em foco, não no atalho atribuído/ciano |
| SAVED DEVICES | uma opção operacional implícita quando há bond | somente linha **5** (REMOVE DEVICE), mesmo com contador de opções igual a zero; se não há mouses salvos, opção indisponível e **sem marcador** |
| PAIR NEW, RETRY PAIR NEW, REMOVE THIS, APPLY PASSTHROUGH, PASSTHROUGH APPLIED, FIRST MOUSE/SEARCHING FIRST, HELP e demais telas sem lista navegável | zero opções em lista | **sem marcador**; ações KEY A/B/X/Y nas dicas não são entradas de menu |

A regra não depende exclusivamente de blu2usb_ux_option_count(): SAVED DEVICES retorna **0** por causa da paginação, apesar de possuir única opção operacional REMOVE DEVICE quando há bond. Tampouco depende cegamente de selected_row(): COMBINATIONS seleciona um par rótulo+valor, mas o pipe fica na segunda linha (valor/status); MOVEMENT remapeia sua terceira escolha para linha 4. Não desenhar pipe em linhas somente informativas. Valor UNAVAILABLE mantém tom STATIC; seu pipe usa tom branco de foco.

## 3. Exemplos de aparência — apenas indicador

HOME CONNECTED, terceira opção focada:

    LOGITECH LIFT MOUSE
     REMAPPING OPTIONS
     MOVEMENT OPTIONS
    |SAVED DEVICES
     PAIR NEW MOUSE

REMAPPING OPTIONS, terceira opção focada:

    REMAPPING OPTIONS
     PASSTHROUGH DEFAULT
     CUSTOM REMAPPING
    |MODIFIER SHORTCUTS

A opção MODIFIER SHORTCUTS mantém a tonalidade do MNT-12 (ciano claro com CUSTOM+Modifier aplicado; branco quando não).

COMBINATIONS 2 OF 6, segundo par focado:

    COMBINATIONS 2 OF 6
     MOD + LEFT CLICK IS
     UNAVAILABLE
     MOD + RIGHT CLICK IS
    |PASTE

O pipe fica na linha PASTE (segunda linha), **não na linha MOD + RIGHT CLICK IS**; as cores de UNAVAILABLE e PASTE não mudam com a adição do marcador.

SAVED DEVICES, com pelo menos um mouse salvo:

    1 OF 2
    LOGITECH LIFT MOUSE
    PROFILE: CUSTOM
    DPI: H 1 - V 1
    ROTATION: 0 DEGREE
    |REMOVE DEVICE

Nome de mouse, PROFILE, DPI e ROTATION são informativos e jamais ganham marcador.

## 4. Abordagem arquitetural — adotada pelo candidato

- Buscar um **único mecanismo de acabamento do frame** que recebe o modelo UX e calcula a linha do cursor com base no ID da tela e ux->selection, com retorno explícito **sem marcador** quando não há opção válida. Reaproveitar o mapeamento de selected_row() onde correto, tratando COMBINATIONS, MOVEMENT e SAVED DEVICES explicitamente.
- Aplicar o marcador **após** composição dinâmica, foco, sobreposição de profile_feedback e regras de Saved Devices, para a marcador não sumir nem sobrescrever estados CURRENT/UNAVAILABLE. Verificar coordenadas das células e tons efetivos, não redesenhar os textos de menu.
- O pipe deve ser desenhado na célula frame->cells[row][0], à esquerda do primeiro caractere da opção. Herda o tom do valor focado, exceto UNAVAILABLE (texto permanece STATIC; pipe branco da linha de rótulo). Zero limpeza de caracteres informativos em coluna 0. Evitar estado/cache global que cause ghosting entre frames.
- Adicionar suporte ao glifo ASCII **`|`** em glyph_row() no renderer; não introduzir fonte externa, novo pixel format, novas cores ou coluna adicional.
- Não modificar FSM/teclas, persistência, BLE, USB HID, profile/custom drafts, modifier, shortcuts, movement, número ou ordem de opções, Hint/Help, títulos e status.

## 5. Testes exigidos para futuro aceite

1. **Cada tela da lista acima**, em cada opção: exatamente um | na primeira coluna (índice 0) da linha certa e nenhum | em outras linhas. Validar também caracteres do resto da linha intactos, cores e 9×21.
2. **Transições**: JOY UP/DOWN e LEFT/RIGHT onde aplicável; página anterior/seguinte, entrada/saída, BACK/Help, Lock/unlock, reset, Apply, reboot, trocar mouse. Nenhum fantasma do marcador anterior.
3. **COMBINATIONS**: 6 páginas e os dois pares; `|` somente nas linhas de valor/status 2 ou 4 (segunda linha de cada escolha), nunca nos rótulos 1/3. O valor mantém ciano normal/claro conforme MNT-12; UNAVAILABLE/NOT CUSTOMIZED e rótulos preservam tons antigos. Em UNAVAILABLE, o pipe permanece branco.
4. **SHORTCUTS**: 5 páginas, todas as 30 entradas; seleção pode divergir da ação previamente atribuída/ciano. A marcador acompanha a entrada em foco e não a atribuída.
5. **MOVEMENT**: terceira escolha marcador ROTATION na linha 4 e não na linha descritiva 3. DPI Slow/Fast e Rotation: marcador acompanha foco independentemente de Current.
6. **SAVED DEVICES**: com zero, um e vários bonds. | em REMOVE DEVICE somente quando ação disponível; jamais em nome do mouse, perfil, movimento ou dicas.
7. **Telas sem lista**: Help, pareamento/resultado, Remove This, confirmações KEY A etc. têm zero |, mesmo com o último menu previamente focado.
8. **Regressões**: preservar cores de todos gates anteriores (em especial MNT-08 e MNT-12), rotas, perfil/bonds por mouse, 12 combinações/30 atalhos, USB/HID, BLE, help/lock e firmware produção Pico 2 W.
9. Implementação autorizada: branch da tag v3.2.2, PR #43 draft, testes host (96/96 PASS), build Pico 2 W oficial PASS, UF2 com SHA verificado e roteiro físico desde HOME CONNECTED disponíveis. **Aceite físico ainda não observado**. Somente então bump PATCH, merge e release; não prosseguir automaticamente para MNT-14 ou MNT-15.

## 6. Estado final

**MNT-13 — CANDIDATO PRONTO PARA TESTE FÍSICO.** Código, regressões, CI e UF2 verificáveis registrados em [candidate.md](../executions/MNT-13/candidate.md). **Aceite físico PENDING; sem tag/release.** MNT-14 continua diagnóstico PAIR NEW em duas partes, não iniciado; MNT-15 Zoom/Obsidian suspenso.
