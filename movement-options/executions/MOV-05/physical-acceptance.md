# MOV-05 — Aceite físico

**Status: PENDING — aguardando teste do operador.**

## Roteiro físico partindo da home-connected
1. Confirmar conexão Bluetooth e abrir `MOVEMENT OPTIONS` (segunda opção da HOME).
2. Selecionar `VERTICAL DPI` (segunda opção) e pressionar JOY PRESS; em `VERTICAL SLOW DPI`, pressionar JOY RIGHT para entrar em `VERTICAL FAST DPI`.
3. Conferir as quatro linhas e multiplicadores `1.25x`, `1.5x`, `2x`, `3x`; valores a partir da coluna 17 e KEY A: APPLY AND BACK / KEY X: HELP FAST DPI.
4. Escolher `1.5x`, pressionar KEY B: retornar sem modificar valor aplicado.
5. Reabrir `VERTICAL DPI`, entrar em Fast e aplicar `1.5x` com KEY A. Verificar retorno a `MOVEMENT OPTIONS`, V=1.5X em ciano e H e rotação preservados. Repetir com 1.25x, 2x e 3x se possível.
6. Pressionar JOY PRESS em `VERTICAL DPI` novamente: se V for >1x, a página Fast deve abrir diretamente com o valor confirmado selecionado (branco). Mover seleção para outra opção: o valor confirmado deve ficar ciano e o foco branco. KEY B não altera V.
7. Abrir Fast Help via KEY X, voltar com KEY Y e garantir preservação da seleção e ausência de lock. JOY LEFT e RIGHT devem navegar só entre Vertical Slow e Fast e lembrar a escolha de cada página; Up/Down envolve itens.
8. Com V=3x, movimentar mouse verticalmente e em diagonal; comparar distância com V=1x (idealmente com aceleração do host desativada). Confirmar que a rotação existente compõe sem alterar o eixo horizontal; movimentos grandes não devem ser truncados. Clique, arraste, scroll, pan e remap de botões permanecem normais.
9. Reiniciar Pico sem limpar bonds e verificar persistência; em `SAVED DEVICES`, só o nome do mouse conectado deve ficar em ciano. Em outras páginas, todos os textos são amarelos.

Registrar PASS/FAIL, SHA fonte/UF2, mouse e observações. **Aprovação do CI não equivale ao aceite do MOV-05.**
