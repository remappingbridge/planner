# MOV-07 — HOME Connected | Contrato de validação

Data: 2026-10-10, horário de São Paulo. Produto: `remappingbridge/remappingbridge`. Branch: `feature/movement-options-v1.0`. Base: `release/v1.0.0`.

Pré-requisitos: MOV-01 até MOV-06 aceitos individualmente pelo operador. MOV-07 ainda NÃO aceito fisicamente.

## Entrada e navegação
Tela principal ao estabelecer conexão BLE com mouse salvo:
```text
MOUSE GENERIC NAME
 NO REMAP PASSTHROUGH
 MOVEMENT OPTIONS
 SAVED DEVICES
 PAIR NEW MOUSE

JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP TO REMOVE
```
Título e resumo de profile são dinâmicos e refletem mouse ativo e remap. A primeira linha de opção é o remap atual (acessa REMAPPING OPTIONS), a segunda MOVEMENT OPTIONS, a terceira SAVED DEVICES e a quarta PAIR NEW MOUSE. O retorno via KEY B deve preservar contrato de v1.0 de cada submenu e voltar para a HOME conectada. Joystick Up/Down percorre as quatro linhas com wrap e age no release, não no press.

KEY X abre HELP HOME CONNECTED (orientações de remoção), retorna à mesma HOME preservando seleção em faixa 0–3 inclusive quarto item, mesmo se a tecla de retorno for Y, sem bloquear. KEY B na HOME não tem ação. KEY Y numa tela normal bloqueia LCD; a primeira sequência de pressionar/soltar uma tecla apenas desbloqueia e restaura HOME, não entra em menus nem altera settings. O loop de envio de HID mouse/teclado permanece ativo com LCD bloqueado.

## Reconexão, sem regressões
Quando uma conexão BLE cai com bonds presentes, HOME conectada ou tela Movement Options/filhas muda para HOME SEARCHING; expirando a busca chega HOME RETRY. Essas telas têm apenas SAVED DEVICES e PAIR NEW MOUSE (duas opções); NÃO expor MOVEMENT OPTIONS sem mouse conectado. Uma reconexão de dispositivo salvo sincroniza identidade, nome, profile e TLV de H/V/rotação e volta a HOME conectada com quatro opções. Se mouse nunca foi salvo, preservar fluxo SEARCHING FIRST MOUSE e tutorial HOPE-01/02. Não mudar regras existentes de Saved Devices: somente o nome do mouse conectado fica ciano, todo o resto amarelo padrão.

## Evidência de teste
`tests/test_mov07_home_connected.c` exercita apresentação e opções HOME, as quatro rotas, cores da seleção, wrap, retorno B, Help X e retorno Y ao quarto item, Lock/Unlock e conservação de Movement/Remap, simulação explícita de desconexão/timeout/reconexão e restauração de configurações por mouse.

`tests/test_mov07_home_runtime_source.py` assegura as transições reais da implementação Pico (`src/app/main.c`) que não são executáveis em testes host: conectou/desconectou, timeout, sincronização da identidade e preferência TLV, emissão de relatórios USB de mouse e teclado independentemente do backlight/lock. Esse teste estático não substitui o teste de desconexão física.

CMake/CTest executam ambos junto aos 53 testes anteriores. A versão binária pode ser idêntica ao MOV-06 já aceito porque HOME foi implementada antecipadamente como pré-requisito MOV-01. Comprovar hash do artefato Pico no mesmo SHA.

## Aceite
Não marcar MOV-07 accepted antes da verificação física do operador. Manter PR #22 Draft, sem merge nem alterações em main/release.
