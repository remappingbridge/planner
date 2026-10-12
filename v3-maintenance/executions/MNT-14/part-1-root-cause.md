# MNT-14 — Parte 1 / relatório de causa raiz (aberto)

**ESTADO ATUAL: INCONCLUSIVE — AUDITORIA ESTÁTICA CONCLUÍDA; REPRODUÇÃO/TRACE FÍSICOS NÃO OBTIDOS.** Documento iniciado em **12/10/2026** como parte do gate autorizado, mas **NÃO constitui causa raiz comprovada**, nem conclusão aceita pelo operador. Não há código corretivo e não se iniciou a Parte 2.

## Dados verificáveis

- Versão oficial de referência: **v3.2.3**, fonte/main/tag **`f38c5fd15c68ea9a36d3b05912727788d7b98e81`**, [Release](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), [CI de release](https://github.com/remappingbridge/remappingbridge/actions/runs/38280962230): **96/96 host PASS, Pico 2 W PASS**, UF2 SHA-256 `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`.
- Histórico: HOPE-06 tinha um bug por limites 1/1/1 de conexões/clientes, corrigido para **2/2/2** com aceite físico em **23/09/2026**. O firmware atual conserva 2/2/2.
- UI: fluxo `HOME CONNECTED → PAIR NEW MOUSE` invoca pedido de pareamento sem impor desconexão de A.
- Stack: `start_pair_new()` permite estado READY; scan 15 s; candidate handle independente; advertising filtra HID/appearance/rejected/saved; candidato passa por GAP/SM/GATT HIDS/descriptor; A é desconectado somente no handoff depois de B qualificado.
- Comparativo HOPE-06 → v3.2.3: rotinas principais `service_pair_new_requests()` e `pair_new_begin_handoff()` mantêm o contrato, mas eventos HCI/SM, registro de bonds/identidades e tratamento de sessão tiveram evolução; **diferenças de código não provam regressão**.
- **Não disponíveis:** modelo de A/B usado no relato, estado de SAVED DEVICES de B, resultados de scan/advertising em hardware, status de GAP/HCI/SM/GATT, confirmação do firmware instalado no Pico, tempos reais/trace, comparação A conectado vs A ausente com mesmo B inédito.

## Quadro de hipóteses testáveis, não conclusões

| ID | Hipótese | Evidência que diferencia | Situação |
|---|---|---|---|
| H1 | UI/request fica retido por flag de busca/reconnect | Tela e consumo de pedido + retorno real de start_pair_new | Não observado |
| H2 | Scan não recebe advertising quando A continua conectado | GAP adv count A-on vs A-off com mesmo B emitindo | Não observado |
| H3 | GAP vê B, mas filtro de saved/appearance o descarta | Motivo/identity resolving/advertising HID; B genuinamente novo | Não observado |
| H4 | GAP encontra B, mas conexão concorrente falha | gap_connect retorno + subevento LE connection status | Não observado |
| H5 | B conecta, mas SM/security, GATT/HIDS ou descriptor falha | evento de falha/timeout com handle candidato | Não observado |
| H6 | Timeout de 15 s antes da qualificação B | timestamps de stages desde início e timer | Não observado |
| H7 | Handoff com B qualificado não finaliza | início de handoff, desconexão A, evento promoção B | Não observado |
| H8 | B já salvo/sem pairing/incompatível, logo comportamento correto | B não listado, advertising/identidade e controle com A ausente | Não observado |

## Critérios de decisão da Parte 1

- **CONFIRMED**: primeiro estágio divergente A-on vs A-off identificado, causalidade testada e reproduzida, logs/versão preservados.
- **NOT REPRODUCED**: comportamento aprovado se observa repetidamente com A-on e B novo, registradas condições e intermitência eventual.
- **ENVIRONMENTAL / NOT A BUG potencial**: B sem advertising, salvo/IRK ou não BLE HOGP, com evidências claras.
- **INCONCLUSIVE (atual)**: análise estática não oferece os dados de evento necessários para separar H1..H8.

## Próximos experimentos de evidência física (pendentes)

Executar a [matriz não destrutiva](part-1-physical-execution.md) (principalmente cenários 1 e 4) no **UF2 oficial v3.2.3**. Se a diferença for reproduzida, traçar os eventos citados na mesma base, preferencialmente sem criar nova interface de debug e **sem mudar lógica de pareamento**. Atualizar este arquivo com timestamps/status/logs ofuscados, avaliação de causalidade, resultados e limitações. Só depois submeter o relatório de Parte 1 a aceite, e **somente após aceite** iniciar a Parte 2 de decisão GO/NO-GO/BLOCKED/NOT A BUG.

**Não foi criado patch funcional, PR de firmware, tag ou release do MNT-14.**
