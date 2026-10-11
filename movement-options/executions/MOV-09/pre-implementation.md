# MOV-09 — Remove This Mouse | Contrato de gate

Data: 2026-10-10 (America/Sao_Paulo). Repositório: `remappingbridge/remappingbridge`; branch: `feature/movement-options-v1.0` isolada da release v1.0.0.

## Precondições
MOV-01 até MOV-08: **ACCEPTED** individualmente pelo operador. MOV-09: candidato, aceite físico PENDING. MOV-10 não aceito.

## UI e fluxo
`home-connected → SAVED DEVICES (terceira opção) → JOY RIGHT/LEFT seleciona página do mouse → JOY PRESS → REMOVE THIS MOUSE`.

Tela de confirmação 9×21:
```text
REMOVE THIS MOUSE
<nome do mouse>
SAVED PAIRING AND
PREFERENCES WILL
BE DELETED.

KEY A: REMOVE
KEY B: CANCEL
KEY Y: HELP
```
O nome é sempre derivado do **bond lógico** capturado quando se entrou em Remove This, e nunca do ordinal da página (porque o mouse ativo pode ser ordenado primeiro). O nome do mouse conectado pode manter ciano nesta tela; o requisito de apenas o nome ciano e *todo o resto amarelo* se refere especificamente à tela **SAVED DEVICES**, não é aplicado de modo indevido à confirmação.

KEY B cancela sem persistir nenhuma alteração e volta à mesma página; KEY Y abre Remove Mouse Help, e outra tecla no Help retorna à confirmação sem acionar Lock. KEY A, apenas no release, solicita remoção uma única vez e seta `remove_pending`. Repetições de KEY A, B ou Y durante pending não podem emitir segunda exclusão ou trocar alvo.

## Transação BLE e dados
`src/app/main.c` pede ao serviço BLE que remova **somente a identidade selecionada**. Se for mouse conectado, primeiro neutraliza relatórios HID pendentes, e o serviço BLE desconecta esse mouse antes de remover seu bond.

`src/ble_hogp/ble_hogp_pico.c` resolve o índice lógico para o par endereço/IRK, exclui primeiro a preferência de movimentos daquele par, depois seus nomes salvos e seu bond, por identidade. Se gravar a nova tabela de preferências falhar, restaura a entrada em memória e publica `REMOVE_FAILED`, mantendo os bonds. Re-parear a identidade removida deve restaurar defaults H=1x/V=1x/Rot=0°, não antigas preferências.

Correção defensiva específica do MOV-09: se o bond lógico deixar de existir **antes** de o trabalho assíncrono capturar sua identidade, publicar `REMOVE_FAILED` ao invés de retornar silenciosamente, para que a UI saia de pending e permita tentar novamente.

A UI somente atualiza listagem e destinos após `REMOVE_FAILED` (mantém dados, mostra Saved Devices) ou `SAVED_MOUSE_REMOVED` (resincroniza bonds, remove alvo, primeira busca se zero bonds); não deve anunciar exclusão antes de confirmação BLE.

## Testes
- `tests/test_mov09_remove_this.c`: fluxo desde Home Connected com três mouses e mouse ativo em índice lógico 1, alvo inativo selecionado em outra página; layout; ajuda e cancelamento sem alterar valores; KEY A gera exatamente um comando direcionado ao bond lógico; proteção enquanto pending; erro permite nova tentativa; exclusão do ativo e transição final sem bonds, simulação de UI.
- `tests/test_mov09_remove_runtime_source.py`: garante o caminho real Pico de captura de identidade, remoção de preferências com rollback, publicação de sucesso/falha, os handlers do app e a correção para bond ausente.
- CMake/CTest, CI host e artefato Pico 2 W a validar por SHA do mesmo commit. **O teste host não remove bonds físicos**: o usuário deve verificar com pelo menos dois mouses físicos, preferencialmente removendo um inativo antes de testar exclusão do conectado.

Não alterar release/main nem mesclar PR #22. Aceite só após operador validar fisicamente.
