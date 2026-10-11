# MOV-04 — Vertical Slow DPI | Contrato de implementação

Data: 2026-10-10. Produto: `remappingbridge/remappingbridge`. Branch: `feature/movement-options-v1.0`, base congelada `release/v1.0.0`.

Pré-requisito: MOV-01, MOV-02 e MOV-03 aceitos fisicamente pelo operador. **Apenas MOV-04 está aberto à validação física agora.**

## Fluxo de entrada obrigatório
`home-connected → MOVEMENT OPTIONS (2ª opção) → VERTICAL DPI (2ª opção) → VERTICAL SLOW DPI`.
Sem telas intermediárias temporárias. Cada ação é disparada no *release* do controle do HAT, não no *press*.

## Contrato de tela
```
VERTICAL SLOW DPI
 NORMAL        1x
 SLIGHTLY SLOW 0.75x
 SLOW          0.5x
 VERY SLOW     0.25x

JOY LEFT\RIGHT: PAGE
KEY A: APPLY AND BACK
KEY X: HELP SLOW DPI
```
Grade 9×21 caracteres. Os valores começam na coluna 16 (base 1). Tecla B é Back/Cancel implícito. Joystick Up/Down percorre quatro itens com wrap. Joystick esquerda/direita acessa *somente* Vertical Fast/Slow; nenhuma transição para Horizontal. `KEY X` abre Help Slow, qualquer tecla retorna sem aplicar nem bloquear. Valor aplicado em ciano, opção em foco em branco.

## Persistência e isolamento
Vertical Slow manipula somente `vertical_quarters` (1,2,3,4 = 0.25×,0.5×,0.75×,1×). Horizontal e rotação permanecem byte a byte. `KEY A` produz a solicitação de aplicação mas só muda estado/tela depois da confirmação de gravação TLV do mouse pareado atual. `KEY B` descarta seleção candidata. Persistência sobre reinicialização e mudança de mouse permanece exigência do fluxo agregado. A navegação back da v1.0 reinicia seleção do menu pai em HORIZONTAL DPI (índice 0): para reabrir VERTICAL DPI é necessário selecionar novamente a segunda opção.

## Testes
Arquivo dedicado `tests/test_mov04_vertical_slow.c` e registro no `tests/CMakeLists.txt`.
Cobre grade/posições/cor, seleção somente após release, wrap, cancelamento, Help não bloqueante, paginação vertical exclusiva, isolamento H e rotação com H=2× e rot=270°, confirmação de persistência e quatro ganhos verticais; acumulação exata de quartos de delta HID, incluindo 0.25× com micro-movimentos, sem perda de distância.

## Stop/aceite
Somente o operador aceita MOV-04 após testar o UF2 correspondente ao SHA validado. A publicação de CI ou a existência de telas dos gates posteriores não substituem aceite físico. PR #22 permanece Draft e release/main preservados.
