# MOV-06 — Rotation | Cenários físicos

**Status: PENDING — aguardando confirmação do operador.**

1. Com mouse salvo conectado e firmware MOV-06 ou último firmware de mesmo SHA-256, abrir HOME CONNECTED → MOVEMENT OPTIONS → ROTATION.
2. Conferir valores `0-DEGREE`, `90-DEGREE`, `180-DEGREE`, `270-DEGREE` e hints `KEY A: APPLY AND BACK`, `KEY B: CANCEL`, `KEY X: HELP` sem truncar (grade 9×21).
3. Selecionar `90-DEGREE` e pressionar KEY B. Reabrir ROTATION e conferir que valor anterior persistiu. Joystick Up/Down deve envolver 0 ↔ 270.
4. Aplicar `90-DEGREE`, `180-DEGREE` e `270-DEGREE` com KEY A. Em cada caso confirmar retorno a MOVEMENT OPTIONS, ângulo mostrado em ciano e preservação de H/V. Reabrir ROTATION: atual selecionado branco; movendo foco, aplicado fica ciano. Reiniciar Pico sem apagar bonds e confirmar valor.
5. Ao pressionar KEY X em ROTATION, confirmar ROTATION HELP, texto `ANTICLOCKWISE` e `ANY KEY: BACK`. Pressionar KEY Y dentro de Help retorna à seleção exata e **não** bloqueia.
6. Configurar `HORIZONTAL DPI = 2X`, `VERTICAL DPI = 1X`, `ROTATION = 270-DEGREE`. Mover mouse fisicamente para frente/trás: ponteiro deve ir horizontalmente nas direções opostas, com ganho 2×. Mover mouse para esquerda/direita: ponteiro deve ir verticalmente, 1×. Desenhar um círculo lento: trajetória do ponteiro deve ser uma elipse deitada.
7. Configurar H=1X V=1X e percorrer 0/90/180/270: confirmar orientação em cada quadrante, sem que cliques, scroll, pan, drag ou mapeamento de botões sejam transformados. Testar movimentos rápidos/grandes e diagonais sem perdas evidentes.
8. Voltar a MOVEMENT OPTIONS e pressionar KEY A (`RESET ALL`). Confirme H=1X, V=1X e ROTATION=0-DEGREE após gravação; desconectar/reconectar e reiniciar para conferir persistência. Verificar se Saved Devices mantém somente o nome do mouse conectado em ciano.

Registrar PASS/FAIL, mouse, commit/UF2 SHA-256 e anomalias. A aprovação do CI não equivale a aceite físico. MOV-07 não recebe aceite automático.
