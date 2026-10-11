# MOV-07 — HOME Connected | Testes físicos

**Status: PENDING — aguardando confirmação do operador.**

1. Com mouse salvo conectado ao Pico 2 W, conferir que a HOME exibe nome do mouse, resumo de remap atual e as quatro opções na ordem: remap, MOVEMENT OPTIONS, SAVED DEVICES e PAIR NEW MOUSE; sem linhas cortadas.
2. Navegar com JOY UP/DOWN e confirmar wrap da primeira para quarta opção e vice-versa. Seleção branca, demais itens conforme a paleta v1.0; o menu não deve mudar antes de soltar o controle.
3. Entrar em REMAPPING OPTIONS, voltar com KEY B. Repetir com MOVEMENT OPTIONS e SAVED DEVICES; verificar que o menu não abre outras telas ao retornar à HOME.
4. Selecionar a quarta opção PAIR NEW MOUSE e retornar com KEY B sem parear um mouse novo; não alterar os bonds existentes.
5. Na quarta opção, abrir HELP com KEY X; confirmar o texto REMOVE CONNECTED HELP e passos para remover. Pressionar KEY Y dentro de Help: voltar à HOME, ainda na quarta opção, SEM bloquear o visor. JOY PRESS deve abrir PAIR NEW MOUSE.
6. Na HOME, pressionar KEY Y para bloquear. Confirmar que o display apaga. Movimentar o mouse: ponteiro e remap continuam ativos com os últimos ganhos H/V/rotação. Pressionar e soltar JOY PRESS uma vez: desbloqueia e volta à HOME, **sem entrar em nenhum menu** e sem resetar os ganhos.
7. Ajustar H=2×, V=0.75×, ROT=270° e sair para HOME. Desligar o mouse. Verificar HOME SEARCHING; aguardar timeout para HOME RETRY. Em ambas as telas devem existir APENAS SAVED DEVICES e PAIR NEW MOUSE, nunca MOVEMENT OPTIONS. KEY A em RETRY reinicia busca. KEY B de HOME SEARCHING cancela para RETRY (contrato v1.0).
8. Religar o mouse salvo. Confirmar HOME Connected, quatro opções e que MOVEMENT OPTIONS conserva H=2×, V=0.75×, ROT=270°. Reiniciar Pico sem apagar bonds e confirmar novamente. Conferir que Saved Devices preserva a regra: apenas nome do mouse efetivamente conectado em ciano.
9. Testar que nenhuma tela de erro, pareamento e remapeamento da v1.0 foi indevidamente alterada pelo fluxo de HOME.

Preencher após executar: resultado PASS/FAIL, SHA-256 do UF2 utilizado, mouse, anomalias e observações. Aceite de MOV-07 não implica aceite de MOV-08 a MOV-10.
