# MOV-06 — Rotation | Especificação e pré-implementação

Data: 2026-10-10 (São Paulo). Código: `remappingbridge/remappingbridge`, branch `feature/movement-options-v1.0`, base `release/v1.0.0`.

MOV-01 até MOV-05: **ACCEPTED** (confirmações individuais do operador). MOV-06: **PENDING** até validação física.

## Entrada obrigatória a partir da home-connected
Conectar mouse salvo → HOME CONNECTED → MOVEMENT OPTIONS (segunda opção) → ROTATION (terceira opção).

## Layout 9×21
```text
ROTATION
 0-DEGREE
 90-DEGREE
 180-DEGREE
 270-DEGREE

KEY A: APPLY AND BACK
KEY B: CANCEL
KEY X: HELP
```
O texto `KEY A: APPLY AND BACK` (21 caracteres) é o refinamento aceito no MOV-02. Joystick Up/Down seleciona e faz wrap, no **release**, nunca no press. Escolha em branco; opção já aplicada em ciano quando outra está em foco. KEY B descarta sem alterar configuração; KEY A solicita aplicação e só retorna ao menu quando a gravação na identidade BLE foi confirmada; KEY X exibe ROTATION HELP, KEY Y ou qualquer tecla em Help volta à opção e não trava tela.

## Convenção de matemática e evidência física
Coordenadas USB com X+ direita, Y+ baixo. Rotação física anticlockwise deduzida do experimento G06 aceito: 270-DEGREE → `out.X=-in.Y; out.Y=in.X`. Para os demais ângulos `0:(x,y)`, `90:(y,-x)`, `180:(-x,-y)`, `270:(-y,x)`. O ganho horizontal multiplica o USB X **após** girar; vertical multiplica USB Y **após** girar. Assim, H=2x V=1x ROT=270-DEGREE → USB X=-2*rawY, USB Y=rawX e um círculo manual vira uma elipse deitada. Preservar carry fracionário, não descartar distância em relatórios USB acima de int8. Botões, wheel, pan, Escape e remap mantêm canais independentes.

## Código e testes
A tela, a entrada, a aplicação por identidade BLE e o pipeline já estavam na branch integrada e foram fisicamente exercitados nas etapas anteriores; MOV-06 acrescenta teste dedicado `tests/test_mov06_rotation.c` registrado no CMake. Teste passa pela HOME real (não tela fake), valida toda a grade, seleção/release, HELP e cancelamento, quatro ângulos e confirmação de escrita TLV simulada, RESET ALL, preservação H/V, vetor em cada ângulo, ganho horizontal 2x, 270° e distâncias grandes/fracionárias. Não alterar o código em release/main; no CI comparar checksum do novo UF2 com os anteriores e documentar identidade binária quando confirmada.

## Regra de aceite
Não marcar MOV-06 ACEITO até o operador executar os cenários físicos e confirmar. MOV-07–10 permanecem não aceitos.
