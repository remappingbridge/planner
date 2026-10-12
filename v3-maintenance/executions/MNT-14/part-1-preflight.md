# MNT-14 / Parte 1 — preflight e auditoria estática executada

**STATUS: AUDITORIA ESTÁTICA EXECUTADA / REPRODUÇÃO FÍSICA PENDING / CAUSA RAIZ NÃO COMPROVADA.** Iniciada em **12/10/2026** após autorização expressa: *"gate aceito. implemente o proximo"*. O aceite refere-se a MNT-13, não a correção de PAIR NEW. O MNT-14 tem duas partes e só a primeira foi iniciada.

## Base auditada e integridade

- Última fonte integrada: `remappingbridge/remappingbridge` **main** no commit **`f38c5fd15c68ea9a36d3b05912727788d7b98e81`**, PR #43 MNT-13 mesclado; `CMakeLists.txt` e teste bootstrap declaram **3.2.3**. O workflow de release [v3.2.3](https://github.com/remappingbridge/remappingbridge/actions/runs/38280962230) foi iniciado a partir desse commit; validar tag, Release e SHA256SUMS após conclusão.
- Candidato MNT-13 fisicamente aceito: SHA `c1d20493c208651ddac1a433de96d5fc44eedfae`, [CI 96/96 + Pico 2 W](https://github.com/remappingbridge/remappingbridge/actions/runs/38257166557). A publicação versionada não altera a lógica de BLE/HOGP.
- Fonte do comportamento aprovado originalmente: [HOPE-06 aceite 23/09/2026](../../RP-2350/hope/executions/HOPE-06/physical-acceptance.md), commit integrado `90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`. Havia falha com limites HCI/GATT/HIDS 1/1/1; o rework fisicamente aceito passou a 2/2/2.
- Contratos: [Connected HOME Pair New](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-connected-home-pair-new.md), [Handoff](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-pair-new-help-and-handoff.md), [One authoritative mouse](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-single-connected-mouse.md).

## Verificações realizadas sobre a fonte versionada

| Etapa | Evidência estática observada | Limitação |
|---|---|---|
| Recursos da stack | `include/btstack_config.h` conserva `MAX_NR_HCI_CONNECTIONS=2`, `MAX_NR_GATT_CLIENTS=2`, `MAX_NR_HIDS_CLIENTS=2` | Não mede agendamento rádio/coexistência na placa |
| HOME Connected → Pair New | `src/app/main.c` (fluxo `screen_before`/entrada `PAIR_MOUSE`) solicita `blu2usb_ble_hogp_pico_request_pair_new()`; saída/lock cancela | Não prova consumo efetivo da flag na stack |
| Requisições assíncronas | `service_pair_new_requests()` consome flag atômica e a recoloca quando `start_pair_new()` falha | Pode haver espera/condições transitórias não observadas |
| Estado READY com A conectado | `start_pair_new()` permite `BLE_HOGP_STATE_READY`, salvo busca/reconnect/handoff pendentes | A API `gap_start_scan()` não tem retorno de status checado neste ponto |
| Janela de descoberta | Timer de 15.000 ms, parâmetros de scan `(0, 48, 48)` e `gap_start_scan()` | Sem prova de `GAP_EVENT_ADVERTISING_REPORT` com sessão A ativa |
| Anúncio de B | Eventos GAP passam por filtro de serviço HID, appearance, lista de rejeitados e identidade salva; tentam `gap_connect()` | Falha pode ser antes do filtro, após filtro ou por identidade legítima |
| Conexão B | `GAP_SUBEVENT_LE_CONNECTION_COMPLETE` trata conexão candidata e encaminha a `sm_request_pairing()` | Sem códigos/status em hardware |
| Segurança e HID | SM + GATT/HIDS validam serviço, descriptor, `parser_has_mouse` e novo bond lógico | Sem trace de pairing/descriptor/RPA e sem comprovação temporal |
| Handoff | `pair_new_begin_handoff()` mantém A até B qualificado e só então pede desconexão; `pair_new_finalize_promotion()` promove B | Não demonstra B atingir o estágio READY |
| Regressões comparativas | A comparação GitHub HOPE-06 → v3.2.3 inclui alterações substanciais em registro de bonds/perfis, eventos HCI/SM e caminhos de sessão; `service_pair_new_requests` e `pair_new_begin_handoff` continuam com o corpo essencial preservado | Diff extenso não identifica por si causa causal; precisa primeira divergência física |

**Resultado da auditoria:** as duas hipóteses simplistas (pools regrediram para 1; ou UI/estado READY proíbe Pair New) **não são sustentadas pelo código**. A causa raiz do relato permanece **INCONCLUSIVE** sem observação física controlada.

## Execução física necessária — sem mudar firmware nem apagar flash

O primeiro ensaio deve usar a versão 3.2.3 publicada, iniciando na **HOME CONNECTED**. Identificar um mouse A conectado e um mouse B **BLE HOGP de fato novo, ausente de SAVED DEVICES** e colocado em pairing. Confirmar que B funciona quando A está ausente; não confundir mouse salvo, falta de advertising e janela de 15 s com defeito. Preferir reservar ao menos duas identidades novas para evitar que B fique salvo ao obter sucesso no primeiro ensaio.

A execução, observáveis, critérios de classificação e protocolo de logs não invasivos estão em [part-1-physical-execution.md](part-1-physical-execution.md). Até a prova, **não corrigir firmware**, **não criar release MNT-14**, **não iniciar Parte 2**; diagnóstico estático não é aceite de causa raiz.
