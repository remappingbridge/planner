# Investigação — Pair New só encontra novo mouse quando nenhum está conectado

**Data:** 11/10/2026 (horário local). **Natureza:** diagnóstico somente, sem correção nem novo gate. **Estado:** comportamento reportado pelo operador; análise estática concluída, causa exata em hardware **não identificada**. Não iniciar MNT-12 por solicitação expressa do operador.

## Sintoma reportado

> Pair New só pareia um novo mouse quando não há outro mouse conectado.

O cenário precisa ser reproduzido com um **mouse realmente não salvo**, anunciando em **modo de pareamento**, dentro da janela de 15 segundos. Um dispositivo já presente em Saved Devices é intencionalmente ignorado por Pair New.

## Contrato original canônico (não é comportamento previsto)

- [connected-home-pair-new 2026-09-20](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-connected-home-pair-new.md), seção 3: entrar em Pair New com mouse atual conectado deve mantê-lo ativo durante scan; não desconectar ao entrar.
- [pair-new-help-and-handoff 2026-09-20](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-pair-new-help-and-handoff.md): candidato BLE HOGP não salvo é temporariamente não autoritativo; após qualificação, liberar HID antigo, desconectar o atual e promover o novo; cancelamento/timeout preservam o anterior.
- [single-connected-mouse 2026-09-20](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-single-connected-mouse.md): somente um mouse autoritativo, mas uma sessão BLE candidata temporária pode coexistir durante o handoff.
- [HOPE-06 physical acceptance](../../RP-2350/hope/executions/HOPE-06/physical-acceptance.md): o primeiro candidato falhou por limites BTstack de 1 cliente/conexão; corrigido para 2 e **fisicamente aceito** em 23/09/2026.

**Conclusão contratual:** o sintoma, se reproduzido com dispositivo realmente novo, é **bug/regressão**, não nova interpretação de UI.

## Código verificado, base oficial v3.2.0

- `include/btstack_config.h`: `MAX_NR_GATT_CLIENTS 2`, `MAX_NR_HCI_CONNECTIONS 2`, `MAX_NR_HIDS_CLIENTS 2`; causa histórica de HOPE-06 NÃO reapareceu.
- `src/ux_model/ux_model.c`: HOME CONNECTED oferece entrada `BLU2USB_SCREEN_PAIR_MOUSE`; nenhum gate UX condiciona a entrada à ausência de mouse conectado.
- `src/app/main.c`: entrar em `BLU2USB_SCREEN_PAIR_MOUSE` dispara `blu2usb_ble_hogp_pico_request_pair_new()` também a partir da HOME conectada; sair cancela; evento `PAIR_NEW_PROMOTED` atualiza sessão.
- `src/ble_hogp/ble_hogp_pico.c`: `start_pair_new()` permite `g_state == BLE_HOGP_STATE_READY`; inicia `gap_start_scan()`, 15 s. `GAP_EVENT_ADVERTISING_REPORT` abre candidato separado `g_pair_new_connection_handle`; conexões já salvas são ignoradas. Após security e HIDS/descriptor, `pair_new_begin_handoff()` desconecta a sessão antiga **somente nesse momento**. Os blocos centrais de `start_pair_new`, `pair_new_begin_handoff` e `service_pair_new_requests` foram comparados ao commit de HOPE-06 aceito `90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`: sem bloqueio novo de Pair New quando READY (houve evolução de contagem de bonds, não um veto de estado).
- O teste histórico `tests/test_hope06_pair_new_source.py` verifica configurações de pool e presença de chamadas, mas **não simula a concorrência real do controlador BLE/radio/BTstack**. CI e compilação não bastam para determinar onde o candidato para.

## Hipóteses técnicas a instrumentar (não comprovadas)

1. O pedido `PAIR_NEW` chegou à pilha com `g_state READY`, mas `gap_start_scan` não produziu relatórios durante conexão BLE ativa.
2. Scan recebe propaganda de mouse novo, mas `gap_connect` falha enquanto HCI atual permanece conectada.
3. Conexão candidata inicia, mas eventos de pairing/security, HIDS ou descriptor falham/expiram em coexistência.
4. O dispositivo apresentado não anuncia em modo de pareamento ou é classificado como bond salvo/mesma IRK (corretamente ignorado). Reproduzir com mouse verdadeiramente não salvo elimina essa ambiguidade.
5. Janela única de 15 s é consumida antes de completar a descoberta/autenticação/HIDS.

**Não afirmar causa raiz física sem rastreamento dos estágios.**

## Roteiro comparativo mínimo (sem alterar firmware)

1. Identificar mouse A atualmente conectado e mouse B **não salvo**, emparelhável, com bateria/advertising habilitados.
2. Com A conectado, ir HOME CONNECTED → PAIR NEW MOUSE, **só então colocar B em modo de pareamento**, observar por até 15 s. Verificar se A continua movendo o ponteiro durante a busca e se B termina associado.
3. Registrar tela/resultado: sucesso/handoff, `NEW MOUSE NOT FOUND`, retorno imediato, travamento ou perda de A; verificar se B aparece em Saved Devices.
4. Cancelar com KEY B; A deve continuar conectado. Repetir com A desligado/desconectado, usando o **mesmo B ainda não salvo**, para ter comparação controlada.
5. Se falhar apenas com A conectado, marcar bug reproduzido do **caminho concorrente**, preservar estado e não remover/zerar dados à força.

**Diagnóstico seguinte apenas se autorizado:** incluir logs serial/trace delimitados por condição em `request_pair_new`, `start_pair_new`, `gap_start_scan`/advertising, `gap_connect`/status, `sm_request_pairing`, HIDS/descriptor, timeout e handoff; testar no Pico 2 W. Evitar mudança de comportamento ou versão antes de evidência.

## Versionamento

O aceite do MNT-11 é independente desta investigação: publicar **v3.2.1** para normalização de nomes conforme PR #41. MNT-12 **não inicia**. PAIR NEW não foi alterado como parte do MNT-11.
