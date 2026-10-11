# MOD-10 — matriz observável de todas as 30 ações

**Status: todas PENDING TESTE FÍSICO.** Este checklist é complementar aos [24 cenários integrados](physical-acceptance.md); não substitui identificação exata de firmware, host e aplicativos. Cada ação necessita duas evidências distintas: (1) evento USB/HID ou Linux input reconhecido quando observável; (2) efeito real no aplicativo/sistema declarado. Quando uma plataforma não suportar o comando, registrar **N/A limitado** ou **FAIL**, nunca PASS por conta apenas do código HID.

| ID | Ação exibida | Relatório | Efeito a observar | USB/HID | Funcional | Host/aplicativo |
|---:|---|---|---|---|---|---|
| 01 | COPY | Keyboard | Copiar seleção | PENDING | PENDING | — |
| 02 | CUT | Keyboard | Recortar seleção | PENDING | PENDING | — |
| 03 | SELECT ALL | Keyboard | Selecionar tudo | PENDING | PENDING | — |
| 04 | PASTE | Keyboard | Colar | PENDING | PENDING | — |
| 05 | UNDO | Keyboard | Desfazer | PENDING | PENDING | — |
| 06 | REDO | Keyboard | Refazer | PENDING | PENDING | — |
| 07 | ESCAPE | Keyboard | Cancelar/voltar conforme app | PENDING | PENDING | — |
| 08 | SPACE | Keyboard | Espaço | PENDING | PENDING | — |
| 09 | ENTER/RETURN | Keyboard | Confirmar/Enter | PENDING | PENDING | — |
| 10 | BACKSPACE | Keyboard | Apagar anterior | PENDING | PENDING | — |
| 11 | DELETE | Keyboard | Apagar seguinte | PENDING | PENDING | — |
| 12 | RENAME | Keyboard | Renomear item selecionado | PENDING | PENDING | — |
| 13 | FULL SCREEN | Keyboard | Alternar tela cheia | PENDING | PENDING | — |
| 14 | SCREENSHOT FULL | Keyboard | Captura de tela completa | PENDING | PENDING | — |
| 15 | SCREENSHOT AREA | Keyboard | Seleção retangular e drag sintético | PENDING | PENDING | — |
| 16 | REFRESH | Keyboard | Atualizar | PENDING | PENDING | — |
| 17 | FIND | Keyboard | Pesquisar | PENDING | PENDING | — |
| 18 | SAVE | Keyboard | Salvar | PENDING | PENDING | — |
| 19 | PLAY/PAUSE | Consumer | Reproduzir/Pausar | PENDING | PENDING | — |
| 20 | NEXT TRACK | Consumer | Próxima faixa | PENDING | PENDING | — |
| 21 | PREVIOUS TRACK | Consumer | Faixa anterior | PENDING | PENDING | — |
| 22 | VOLUME UP | Consumer | Aumentar volume | PENDING | PENDING | — |
| 23 | VOLUME DOWN | Consumer | Diminuir volume | PENDING | PENDING | — |
| 24 | MUTE | Consumer | Silenciar | PENDING | PENDING | — |
| 25 | HOME SCREEN/PAGE | Consumer | Home do sistema Android (não início de documento) | PENDING | PENDING | — |
| 26 | ZOOM IN | Keyboard | Ampliar; registrar Firefox e Obsidian separados | PENDING | PENDING | — |
| 27 | ZOOM OUT | Keyboard | Reduzir; registrar Firefox e Obsidian separados | PENDING | PENDING | — |
| 28 | RESET ZOOM | Keyboard | Restaurar escala 100% | PENDING | PENDING | — |
| 29 | BRIGHTNESS UP | Consumer | Brilho real da tela (não só evento recebido) | PENDING | PENDING | — |
| 30 | BRIGHTNESS DOWN | Consumer | Brilho real da tela (não só evento recebido) | PENDING | PENDING | — |

## Condições de execução
1. Iniciar em HOME CONNECTED. Associar uma ação à combinação `MOD + RIGHT CLICK`, executá-la, observar o relatório/efeito, registrar resultado e continuar para a próxima; manter Modifier realmente aplicado no perfil Custom e desabilitar repetição acidental.
2. Para as ações envolvendo aplicativos, especificar app e SO. Screenshot Area usa o segundo pressionamento do botão secundário para gerar drag LEFT sintético durante overlay, conforme MOD-08. Para volume/brilho utilizar dispositivo host com funcionalidades testáveis.
3. Após cada ação verificar release (nenhuma tecla fica pressionada), ausência de clique do Modifier e que `MODIFIER RELEASED` não dispara junto a uma combinação consumida.
4. Conferir todos os 12 tipos de combos separadamente no cenário Q06–Q08 da matriz integradora; passar 30 ações por um único botão não cobre a classificação Wheel/MOVE.
5. **Exceções previamente conhecidas:** Obsidian KDE zoom in/out pelo RemappingBridge não tinham confirmação de funcionamento; o zoom de navegador e Reset Zoom funcionaram anteriormente. Brilho real do host Linux não pode ser inferido de Consumer HID. Ações de mídia/volume e Android Home dependem do host. Anotar resultado, sem ajuste oculto no RC.

## Resultado e assinatura de aceite
- SHA de código MOD-10: PENDING
- SHA-256 do UF2 usado: PENDING
- Sistema operacional, sessão gráfica e apps: PENDING
- Quantidade ações com efeito comprovado: PENDING
- Exceções deliberadamente aceitas: PENDING
- Decisão humana: **PENDING**
