# MOV-03 — Pré-implementação

**Início:** 2026-10-10. **Estado:** candidato de implementação; aceite físico pendente.

Gate anterior MOV-02: **ACCEPTED** pelo operador no chat, registrado em `executions/MOV-02/physical-acceptance.md`.

## Escopo
- Horizontal Fast DPI, acessível pela HOME conectada: `HOME > MOVEMENT OPTIONS > HORIZONTAL SLOW DPI > JOY RIGHT > HORIZONTAL FAST DPI`.
- Quatro ganhos `1.25x`, `1.5x`, `2x`, `3x`, nos limites 9×21 e começando na coluna 17 (contagem a partir de 1).
- JOY UP/DOWN envolvente, JOY LEFT/RIGHT com paginação Slow ↔ Fast, KEY X abre FAST DPI HELP e qualquer tecla retorna ao mesmo item sem bloquear; KEY B cancela; KEY A aplica e volta **somente após salvar**.
- O ganho horizontal muda exclusivamente H; preserva V e rotação. Valor confirmado ciano e seleção branca, preservando regras da v1.0.
- Adição pedida pelo operador: em Saved Devices, cada página usa apenas o nome do mouse conectado em ciano; todos os demais caracteres não vazios de todas as linhas/páginas devem ser amarelo padrão do sistema, inclusive title, hints, PROFILE, DPI, ROTATION e REMOVE DEVICE. Mouses salvos mas inativos aparecem inteiramente em amarelo. Desconectar retira ciano; reconectar outra identidade muda destaque apenas para ela.

## Testes de regressão automatizados
Novo `tests/test_mov03_horizontal_fast.c`: exatidão das 9 linhas e limites das colunas; tons branco e ciano; todos os quatro multiplicadores; cancelamento sem gravar; Help e KEY Y sem lock; paginação de ida/volta; persistência reconhecida somente após confirmação; inversão de paginação/seleção; Saved Devices com mouse conectado, inativo, desconectado, reconectado, páginas navegadas e joystick fisicamente pressionado. `tests/test_hope04_saved_devices.c` continua válido para apresentação textual e status de conexão.
O build físico deve partir do mesmo commit dos testes, com teste host e Pico CI bem-sucedidos.

## Regra de aceite
Não aceitar MOV-03 automaticamente com CI; solicitar avaliação física a partir da HOME conectada. Não modificar release/v1.0.0 nem mesclar o PR Draft #22.
