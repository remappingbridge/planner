# MNT-02 — preflight técnico (HF-02 + HF-03, atômicos)

**Status: PREPARATION / AGUARDANDO TAG v3.0.1 OFICIAL ANTES DE CRIAR BRANCH DE FIRMWARE.** Planejamento MNT-02 autorizado pelo operador após aceite físico do MNT-01 em 2026-10-11.

## Dependência e versionamento
- Gate MNT-01 aceito, fonte do release em `main`: `b776fec2cf2c89788d1bdfed7aa257aa766f2dc6`.
- Workflow [release v3.0.1](https://github.com/remappingbridge/remappingbridge/actions/runs/38180559115) disparado após merge; verificar TAG/release/assets e SHA antes de iniciar implementação MNT-02.
- Só então criar `maintenance/v3x-mnt-02` da TAG oficial `v3.0.1`; versão futura **v3.0.2** SOMENTE após aceite físico MNT-02.

## Inventário na v3.0.1
- `src/ux_model/ux_model.c`: `BLU2USB_SCREEN_REMOVE_THIS` exibe `KEY Y: HELP` em sua linha 8. `blu2usb_ux_input` captura KEY Y nessa tela para abrir `BLU2USB_SCREEN_HELP_REMOVE_THIS`, em vez de respeitar o lock global.
- `lock_allowed` já inclui REMOVE THIS mas exclui Help. `ux->remove_pending` impede abertura de help/retorno durante exclusão; preservar essa trava. `return_screen` e `return_selection` preservam origem da ajuda; `remove_target_bond` aponta bond lógico selecionado e não pode mudar com a ajuda.
- Help REMOVE THIS permanece com `ANY KEY: BACK` neste gate, como todas as outras telas Help da v3.0.1. A mudança global para KEY B: BACK / KEY Y: LOCK dos Helps pertence exclusivamente à melhoria MEL-04 / MNT-05.
- `tests/test_mov09_remove_this.c`, `tests/test_hope30_help_remove_this.c` e `tests/test_hope30_help_remove_this_source.py` têm expectativas legadas de KEY Y = Help na tela Remove This; atualizar essas expectativas preservando demais cenários e manter a ação real de exclusão somente no KEY A.
- Não alterar renderer, paleta, Saved Devices aceita em MNT-01, schema flash, identidade USB, BLE ou Device removal.

## Contrato MNT-02
1. Texto exato linha 8 de REMOVE THIS: `KEY X: HELP`.
2. KEY X abre `HELP REMOVE THIS` **somente sem `remove_pending`**, ao SOLTAR a tecla, exatamente uma vez; KEY Y não abre Help.
3. KEY Y (sem pending) passa ao handler normal de lock da v3.0.1. Durante pending KEY Y não pode mudar estado ou gerar exclusão; nenhuma mudança em pending state machine.
4. Pressionar ANY KEY no Help fecha a ajuda e volta ao mesmo `REMOVE THIS` (inclusive KEY Y, **sem lock enquanto Help aberto**, regra mantida até MNT-05), preservando o mesmo bond lógico mesmo após mudança de ordem de Saved Devices.
5. KEY B em `REMOVE THIS` cancela e retorna à mesma página, sem apagar qualquer bond. KEY A só remove mediante confirmação explícita fora do Help.
6. Testar 9×21 e leitura literal da legenda, todas as bordas de tecla/HAT, comportamento locked/unlocked e ausência de remoção. Reinício BLE não muda outros dados.

## Gate de entrega
Source e testes host, build Pico 2 W CI, download UF2 e SHA256 verificado, PR draft e checklist físico desde HOME CONNECTED; **PENDING até aprovação física**. Sem publicar v3.0.2 ou avançar MNT-03 sem aceite.
