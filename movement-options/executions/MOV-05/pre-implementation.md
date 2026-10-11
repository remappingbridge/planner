# MOV-05 — Vertical Fast DPI | Contrato de implementação

Data: 2026-10-10 (São Paulo). Produto `remappingbridge/remappingbridge`; branch `feature/movement-options-v1.0`, base `release/v1.0.0`.

Pré-requisito físico: MOV-01, MOV-02, MOV-03 e MOV-04 **ACCEPTED** por confirmação do operador. MOV-05 ainda **PENDING**.

## Entrada pelo fluxo existente
`home-connected → MOVEMENT OPTIONS (segunda opção) → VERTICAL DPI (segunda opção) → VERTICAL SLOW DPI → JOY RIGHT → VERTICAL FAST DPI`. Se V já for maior que 1x, o botão JOY PRESS pode abrir diretamente VERTICAL FAST DPI. Sem páginas de debug.

## Contrato de layout 9×21
```text
VERTICAL FAST DPI
 SLIGHTLY FAST  1.25x
 FAST           1.5x
 VERY FAST      2x
 EXTREMELY FAST 3x

JOY LEFT\RIGHT: PAGE
KEY A: APPLY AND BACK
KEY X: HELP FAST DPI
```
Valores a partir da coluna **17**, base 1. Joystick Up/Down navega as quatro opções com wrap; Left/Right pagina somente dentro de Vertical Slow/Fast; Key X abre Help Fast e ANY KEY retorna preservando opção/candidato; Key B descarta e retorna à Movement Options; Key A confirma apenas V e retorna **após a gravação em TLV bem-sucedida**.

## Eixos, persistência e movimento
V tem ganhos 1.25x, 1.5x, 2x e 3x. A alteração mantém H e Rotation sem mudanças. Valor confirmado em ciano, item destacado em branco — sobrepõe ciano; ao deslocar seleção, valor efetivo reaparece em ciano. O acumulador USB preserva frações e transmite deslocamentos maiores em relatórios sucessivos, sem overflow. Valores se referem a **eixos de saída USB depois de aplicar rotação**, como documentado no pipeline; botão, roda, pan e teclas não recebem escala.

## Validação
Novo `tests/test_mov05_vertical_fast.c` registra cenário completo desde HOME e verifica layout, col 17, hints, cores, UP/DOWN no release e wrap, troca de página vertical, Help sem lock, cancelamento, confirmação e independência H/rotação, quatro multiplicadores 1.25–3x, soma fracionária exata, rotação de 270° e drenagem USB para deltas grandes. Registrar no CMake e verificar toda suíte host + Pico produção do SHA da branch. Não alterar release/main, perfil, pareamento nem a regra de ciano exclusivo ao nome do mouse conectado em Saved Devices.

MOV-05 só recebe ACCEPTED após teste físico e declaração do operador; UF2 binariamente idêntico ao gate anterior é admissível se os testes novos confirmarem que o runtime já integra a tela.
