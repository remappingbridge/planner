# MOV-10 — Help unificado | Teste físico final

**Status: PENDING — aguardando aceite específico do operador.**

Usar o firmware MOV-10 validado neste gate; **começar todos os percursos a partir da `home-connected`** com pelo menos um mouse salvo.

1. **Horizontal Slow:** HOME → MOVEMENT OPTIONS → HORIZONTAL DPI; se estiver em Fast, usar JOY LEFT. Selecionar uma opção Slow diferente da atualmente aplicada e pressionar KEY X. Conferir **SLOW DPI HELP** e o texto “SLOWER DPI POINTER / ARE RECOMMENDED / FOR MOVEMENTS THAT / REQUIRE GREATER / SENSITIVITY AND / PRECISION”, terminando em `ANY KEY: BACK`. Voltar com KEY Y; confirmar ausência de lock e restauração da seleção/candidato; o valor aplicado não muda.
2. **Vertical Slow:** HOME → MOVEMENT OPTIONS → VERTICAL DPI → Vertical Slow; abrir KEY X e verificar **a mesma página Slow**. Voltar com KEY A ou JOY PRESS e confirmar que o retorno não aplica alteração. Somente um KEY A posterior, já fora do Help, pode aplicar.
3. **Horizontal Fast:** abrir Horizontal Slow e JOY RIGHT → Horizontal Fast. Escolher Fast 3X sem aplicar, abrir KEY X; conferir **FAST DPI HELP**, a instrução com “HIGH-RESOLUTION / DESKTOP AND / WIDESCREEN / ENVIRONMENTS” e `ANY KEY: BACK`. Voltar com KEY Y, conferir seleção exata e que H anterior não mudou.
4. **Vertical Fast:** repetir o caminho para Vertical Fast; voltar do Help usando KEY B, confirmar que a primeira tecla apenas fecha o Help, sem cancelar a página. Uma segunda KEY B, já na página de escolha, pode cancelar normalmente.
5. **Rotation:** HOME → MOVEMENT OPTIONS → ROTATION. Selecionar 270° sem aplicar e pressionar KEY X; confirmar **ROTATION HELP** e `EVERY 90 DEGREES / FROM THE PREVIOUS / DIRECTION / ANTICLOCKWISE`. Voltar com KEY A; confirmar que não aplica rotação e continua na opção 270°. Repetir Help e voltar com KEY Y: não deve bloquear.
6. **Remove Mouse Help (sem excluir):** HOME → SAVED DEVICES → página de mouse inativo → JOY PRESS → REMOVE THIS MOUSE → KEY Y. Conferir **REMOVE MOUSE HELP**, `BUTTON REMAPPING AND`, `CUSTOM MOVEMENTS` e `ANY KEY: BACK`. Voltar com KEY A: apenas retorna à confirmação, **não exclui** o mouse. Conferir nome do mesmo mouse e voltar com KEY B para cancelar.
7. **Segurança/regressão:** nas telas Help, tecla Y não bloqueia o visor; retorno B/X/A/JOY não altera H/V/Rotation, perfis ou bonds; Mouse, wheel, pan, clique e drag continuam funcionando. Após retornar do Help, confirmar que as teclas retomam suas funções normais. Testar desligar/religar o Pico com preferências mantidas; não apagar bonds.
8. **Opcional:** reabrir a confirmação Remove This e iniciar exclusão somente se desejar efetivamente remover um pareamento; enquanto a remoção estiver pendente, KEY Y não deve abrir Help nem bloquear. Este teste destrutivo já foi aceito no MOV-09 e não é requisito repeti-lo.

Registrar PASS/FAIL, dispositivo, SHA exato do firmware/UF2, observações e eventual falha. **O aceite físico MOV-10 será a última validação, mas não concede automaticamente autorização de merge/release.**
