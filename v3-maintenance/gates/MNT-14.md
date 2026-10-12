# MNT-14 — PAIR NEW com mouse conectado: causa raiz e decisão de viabilidade

**Status: PARTE 1 INICIADA — AUDITORIA ESTÁTICA CONCLUÍDA, PROVA FÍSICA PENDING / CAUSA INCONCLUSIVE.** Originalmente MNT-13, renumerado em 12/10/2026 para **MNT-14**. Ambas as partes permanecem sem execução e sem correção autorizada; não iniciar MNT-13 (nova seta de seleção) nem MNT-15 (Zoom).

- Backlog: **MEL-11 (novo)** — investigar possível regressão no PAIR NEW concorrente.
- Contrato: `PAIR NEW MOUSE` deve conseguir descobrir e qualificar um novo mouse BLE HOGP enquanto um mouse anterior permanece conectado e operacional. Somente o **handoff bem-sucedido** pode desconectar o antigo; cancelamento/timeout preservam o antigo.
- Base de referência: última tag oficial verificada ao **iniciar a execução** (a versão `v3.2.1` era a base histórica quando o gate original foi escrito; a execução deverá verificar a última tag estável, atualmente **v3.2.3** (tag `f38c5fd15c68ea9a36d3b05912727788d7b98e81`)); manter a **v3.2.0** como baseline da investigação estática já realizada. Não reabrir os releases v3.2.0/v3.2.1.
- **Nova ordem:** MNT-12 (cores) aceito; **MNT-13** (marcador `|`) está aceito e publicado v3.2.3; **MNT-14** preserva o diagnóstico PAIR NEW em duas partes; **MNT-15** preserva Zoom/Obsidian suspenso. MNT-14 Parte 1 foi iniciada posteriormente mediante autorização do operador; Parte 2 e MNT-15 ainda não.
- **Estrutura obrigatória:** duas partes sequenciais e separadas: **Parte 1 = descobrir/comprovar causa raiz; Parte 2 = decidir GO / NO-GO / BLOCKED para uma correção segundo causa raiz, viabilidade, riscos e evidências**. A Parte 2 não transforma automaticamente a investigação em autorização para modificar o firmware.

## 1. Sintoma e distinção fundamental

**Relato do operador:** “Pair New só pareia novo dispositivo quando não há dispositivo conectado”.

É preciso distinguir:

1. **Novo mouse ainda não salvo + A conectado:** deve parear, com A funcionando durante a descoberta e B inicialmente não autoritativo.
2. **Novo mouse ainda não salvo + nenhum mouse conectado:** também deve parear. O fato de funcionar apenas aqui, se reproduzido em condições controladas, constitui bug/regressão.
3. **Mouse B já salvo em Saved Devices:** deve ser ignorado como vencedor de PAIR NEW em qualquer estado; sua reconexão ocorre no fluxo de busca por **mouses salvos**, não no de novo pareamento. Isso é comportamento **intencional**, não o bug.
4. **Mouse B sem advertising/mode pairing, fora da janela de 15 s ou incompatível com BLE HOGP:** falta de conexão sozinha não prova defeito.

Não substituir o requisito por “desligar A primeiro”. Isso é, no máximo, uma **medida de contorno temporária para teste**, jamais a solução de arquitetura pretendida.

## 2. Fonte de verdade — decisão original (20/09/2026)

Os requisitos históricos estão preservados no próprio repositório `planner`:

- [2026-09-20-connected-home-pair-new.md](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-connected-home-pair-new.md): a HOME conectada expõe Pair New; o mouse atual deve permanecer utilizável na busca; somente um candidato novo, qualificado, pode vencer; handoff apenas após qualificação.
- [2026-09-20-pair-new-help-and-handoff.md](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-pair-new-help-and-handoff.md): revisão com **prioridade superior** a interpretações anteriores; PAIR NEW NÃO desconecta A ao começar; timeout/cancelamento deixam A conectado; BLE não autoritativo B pode coexistir temporariamente; depois desconectar A e promover B; nunca dois mouses autoritativos.
- [2026-09-20-single-connected-mouse.md](../../RP-2350/mouse-bridge-remapper/requirements/2026-09-20-single-connected-mouse.md): o limite de um mouse **autoritativo** não implica limite de uma conexão BLE durante Pair New. A exceção temporária de candidato BLE é explicitamente prevista.
- [HOPE-06 — validação física](../../RP-2350/hope/executions/HOPE-06/physical-acceptance.md) e [candidato](../../RP-2350/hope/executions/HOPE-06/candidate.md): em **23/09/2026**, primeira versão não pareou com A conectado por `MAX_NR_HCI_CONNECTIONS=1`, `MAX_NR_GATT_CLIENTS=1`, `MAX_NR_HIDS_CLIENTS=1`. Rework alterou os três para **2**, CI aprovada e operador deu **PASS / ACEITE FÍSICO** no commit `ac685b6d05de20706aa40c3c04591aab0639c98e`, integrado depois como `90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`. O problema atual se parece com aquele, mas **não assumir a mesma causa sem prova**.

**Conclusão já fundamentada:** desconectar A como condição obrigatória de Pair New **não foi o desenho aprovado**.

## 3. Investigação já realizada — evidências estáticas, NÃO causa raiz

A análise anterior foi registrada em [investigations/pair-new-with-connected-mouse-2026-10-11.md](../investigations/pair-new-with-connected-mouse-2026-10-11.md). Verificações em código oficial `v3.2.0`:

| Elemento | Evidência confirmada | O que NÃO comprova |
|---|---|---|
| `include/btstack_config.h` | `MAX_NR_HCI_CONNECTIONS 2`, `MAX_NR_GATT_CLIENTS 2`, `MAX_NR_HIDS_CLIENTS 2` | Que o controlador e a stack realmente consigam realizar scan/connect simultâneos em hardware nessa condição |
| `src/ux_model/ux_model.c` | HOME CONNECTED oferece destino `BLU2USB_SCREEN_PAIR_MOUSE`; não exige A desconectado | Que uma solicitação chegue efetivamente à stack em todo estado |
| `src/app/main.c` | Entrada no Pair New solicita `blu2usb_ble_hogp_pico_request_pair_new()`; saída/Lock pode cancelar; promoção trata troca de sessão/HID | Que pedidos e respostas assíncronos tenham ordenação correta no hardware |
| `src/ble_hogp/ble_hogp_pico.c` — `start_pair_new()` | `g_state == BLE_HOGP_STATE_READY` **é permitido**; cria janela de 15.000 ms e chama `gap_start_scan()` | Que o scanner produza eventos de advertising enquanto A está conectado |
| `GAP_EVENT_ADVERTISING_REPORT` / `gap_connect` | Candidato não salvo é selecionado, com conexão própria `g_pair_new_connection_handle`; salvo é filtrado | Que B chegue a receber eventos, conexão ou autenticação |
| `SM_EVENT_*` e GATT HIDS | Qualificação usa security, HID service, descriptor e `parser_has_mouse`; relatórios candidatos não controlam USB | Que não haja falha por timeout, rádio, interleaving ou handle/CID |
| `pair_new_begin_handoff()` | A é desconectado **depois** da qualificação de B; B só então vira autoritativo | Que a qualificação de B chegue a acontecer |
| `service_pair_new_requests()` | Solicitação via flag atômica, tenta `start_pair_new` e recoloca flag se a tentativa falhar | Que não haja starvation/condição transitória em concorrência |
| Teste `tests/test_hope06_pair_new_source.py` | Confirma estaticamente os três limites `2`, estados/rotas e lógica de handoff | Não emula BLE real nem prova scan simultâneo |
| Comparação com HOPE-06 aceito | Blocos centrais de `start_pair_new`, `pair_new_begin_handoff` e `service_pair_new_requests` ainda permitem A conectado; diferença evolutiva na contagem de bonds | Não exclui regressão em callbacks, conectividade, filtros, SDK ou comportamento de rádio |

**Estado atual do diagnóstico:** os pools estáticos **não voltaram ao valor 1** e não há veto explícito a PAIR NEW no estado READY. **Não foi isolada a causa raiz real.** Não afirmar antecipadamente “limitação do microcontrolador”, “bug do BTstack” nem “bug da UI”.

## 4. PARTE 1 — Diagnóstico e comprovação da causa raiz (SOMENTE INVESTIGAÇÃO)

### 4.1 Critérios prévios e baseline

1. **Preflight estático executado:** confirmar `v3.x` oficial em `remappingbridge/remappingbridge`, SHA da tag, notas, CI e hash do UF2 executado no hardware. Registrar em `executions/MNT-14/part-1-preflight.md`. MNT-13 e MNT-15 não são desbloqueados pelo início desta investigação.
2. Confirmar mouse **A** conectado, nome/identidade, e mouse **B** realmente **não salvo**, compatível com BLE HOGP e colocado em modo de pareamento. Registrar diferenças de modelo/advertising; usar B na mesma condição nos controles.
3. Estabelecer um baseline **sem mexer em flash**, bonds, perfis ou atalhos. Não usar `flash_nuke`, excluir bonds ou alterar a UX para “resolver” o teste.
4. Registrar o histórico HOPE-06 e quais diferenças de código entre o commit fisicamente aceito e o release atual podem afetar init da stack, scan/connection, security, HID ou janela de tempo. A inspeção deve abranger callbacks, não apenas as três rotinas já comparadas.

### 4.2 Matriz de reprodução controlada

| Cenário | Sequência | Esperado | Evidência necessária |
|---|---|---|---|
| A conectado, B inédito | HOME CONNECTED → PAIR NEW; iniciar advertising de B dentro dos 15 s | A segue controlando USB; B qualifica; handoff somente ao fim | Mensagens UI, tempo, evento B conectado/erro, estado final A/B |
| A conectado, nenhum B | Entrar e deixar expirar 15 s | Timeout; A permanece íntegro | Estado de scan, timer, retorno de UI, ausência de perda de A |
| A conectado, cancelar | Entrar, usar KEY B ou Help/Lock conforme contrato corrente | Busca cancela; A permanece conectado | Traço do cancelamento e ausência de input travado |
| A conectado, B já salvo | Colocar B salvo em advertising | B ignorado; nenhum handoff para salvo | Bond/IRK e razão da rejeição |
| A desconectado, B inédito | Mesmo B, mesma distância e modo de pareamento | Pair New deve funcionar sem sessão A | Traço de sucesso como controle negativo |
| B reconhecido por RPA/IRK | B anuncia com endereço privado resolvível ou DB tem identidade correspondente | Classificar salvo corretamente; não trocar por “novo” | Evento de resolving e matching de identidade sem expor dados privados |
| Repetição e reinício | Repetir em execuções e após reboot, sem destruir registros | Mesma regra funcional, sem vazamentos/duplos bonds | Reprodutibilidade, versão, condições ambientais |

Se o primeiro teste chegar a **sucesso com A conectado**, registrar esse resultado e a possível intermitência; não inventar bug reproduzido.

### 4.3 Instrumentação por estágios (se reprodução exigir)

Adicionar **somente instrumentação diagnóstica mínima e reversível**, preferindo logs já disponíveis, sem mudar a lógica do produto ou criar novas interfaces USB. Qualquer build de observabilidade para o Pico 2 W deve ser identificado como **não release**, com fonte, SHA, CI/UF2, sem apagar flash; instalar apenas quando houver necessidade e autorização de execução da Parte 1.

Capturar timestamps, estado atual, resultado/status e correlação de sessão para:

1. `UX PAIR_NEW` → `request_pair_new` → consumo do pedido em `service_pair_new_requests` → `start_pair_new` / motivo exato de recusa, incluindo `g_saved_search_active`, `g_reconnect_cancel_pending`, `g_state` e handoff pendente.
2. Retorno de `gap_start_scan` e callbacks de `GAP_EVENT_ADVERTISING_REPORT`; diferenciar ausência de advertising de rejeição por bond conhecido, aparência HID ou lista de rejeitados.
3. `gap_connect` e `GAP_SUBEVENT_LE_CONNECTION_COMPLETE`: endereço/tipo anonimizado, status da tentativa, handle da conexão atual versus handle candidato.
4. `SM_EVENT_PAIRING_COMPLETE`, `SM_EVENT_REENCRYPTION_COMPLETE`, identity resolving/IRK: qualificação e classificações salvo/novo.
5. Conexão HIDS, leitura de nome, descriptor, `parser_has_mouse`, CID e erro real.
6. `pair_new_begin_handoff`, desconexão de A, liberação de estados USB segurados, `pair_new_finalize_promotion` e mensagem `PAIR_NEW_PROMOTED`.
7. Timeout de 15 s, cancelamento, retentativas, mudança de tela, concorrência com `saved_search`, e recuperação de estado.

**Privacidade/segurança:** não salvar IRK nem identidade BLE completa em artefatos públicos; ofuscar endereços e logs com identificadores correlacionáveis efêmeros. Não alterar estado observável do protocolo durante a medição.

### 4.4 Como uma causa raiz fica COMPROVADA

Somente marcar **ROOT CAUSE CONFIRMED** se existirem, no mínimo:

- Reprodução física controlada de A conectado versus A ausente, com B novo e condição equivalente; **ou** evidência que descarte o relato por classificação válida de B salvo/mode pairing;
- Linha do tempo que mostre **a primeira divergência concreta** (pedido rejeitado, scan sem advertising, conexão recusada, security/HIDS falho, timeout, classificação incorreta, handoff quebrado etc.), indicando o estágio responsável;
- Evidência adicional que **confirme causalidade**, idealmente teste reversível/comparação código/SDK/controlador; não chamar hipótese de causa provada apenas por correlação;
- Relatório com evidências, versão exata, estados, logs anonimizados, conclusão, hipóteses descartadas e limitações.

Artefato de saída: `executions/MNT-14/part-1-root-cause.md`, contendo estado **CONFIRMED / NOT REPRODUCED / INCONCLUSIVE / ENVIRONMENTAL** e resumo de provas. **Esta parte termina sem correção funcional, merge ou release.** Somente após análise/aceite dos resultados pelo operador seguir à Parte 2.

## 5. PARTE 2 — Decisão fundamentada de corrigir ou não

Receber o relatório concluído da Parte 1 e avaliar em `executions/MNT-14/part-2-feasibility-decision.md`. **Nenhuma correção automática.** Registrar as quatro dimensões:

1. **Viabilidade técnica real:** ajuste localizado em estados/radio/BTstack/SDK? O controlador suporta coexistência sob as condições reais? Necessita nova arquitetura/driver? Existem APIs e testes reprodutíveis? Fix quebra a premissa de um mouse autoritativo?
2. **Custos e riscos:** RAM limitada do RP2350, pools HCI/GATT/HIDS, event loop e timers, duração de pareamento, BLE HID++/Logitech, distribuição de HID, watchdog, USB mouse+keyboard/consumer, consumo, flash, segurança de bonds/perfis individualizados MNT-10, retransmissões, regressões.
3. **Benefício funcional:** mantém A operacional durante descoberta e preserva A após falha/cancelamento? É genérico para BLE HOGP e mouses distintos, sem hard-code por marca? Compatível com telas atuais? Não reintroduz segundo mouse autoritativo?
4. **Comprovação possível:** existe solução mínima com teste automatizável + prova física A/B/handoff? Se o problema for limitação intrínseca e a solução exigir sacrificar requisitos, uma “correção” pode ser inviável/inadequada.

### Decisões possíveis

| Decisão | Condição | Próximo passo |
|---|---|---|
| **GO — corrigir bug** | Causa comprovada, solução compatível com contrato e custo/risco aceitáveis; plano de teste robusto | Apresentar proposta de diff/arquitetura e aguardar **autorização explícita de implementação**. Só então abrir branch firmware do último release estável v3.x, PR draft e executar correção com testes/UF2/aceite físico; versionar PATCH 3.x somente após aceite |
| **NO-GO / DEFERRED — não corrigir** | Causa comprovada, mas controlador/stack/segurança torna a correção inviável ou desproporcional | Documentar limites e alternativas operacionais como **contorno claramente rotulado**, sem mudar contrato original e sem release |
| **BLOCKED / INCONCLUSIVE** | Causa não reproduzida, logs insuficientes ou testes inconclusivos | Registrar dúvidas, evidências faltantes e próximos experimentos; **não** criar patch especulativo nem declarar gate resolvido |
| **NOT A BUG** | Foi comprovado que B já estava salvo, incompatível, fora de pareamento ou que não há divergência nas condições corretas | Registrar evidências de comportamento contratual, sem alteração de firmware |

A decisão **GO** não autoriza, por si só, lançar produto; código só é escrito mediante pedido expresso. O operador pode aceitar o **relatório da Parte 1** separadamente e também aprovar/rejeitar a **decisão da Parte 2**. **Aceite de diagnóstico ≠ aceite de firmware.**

### Condições caso uma correção venha a ser autorizada

- Escopo mínimo com explicação de causa e teste de regressão que **falhava antes** e passa depois, incluindo cenário físico A conectado → B novo, handoff, cancelamento, timeout e B já salvo ignorado.
- Preservar contrato de **um mouse autoritativo**, candidato temporário não autoritativo, 15 s salvo decisão expressamente revisada, USB HID, esquema/identidade/perfis/bonds dos outros mouses, UI 9×21 e todos os 93+ testes host então vigentes.
- Compilação production Pico 2 W, UF2 de CI oficial com SHA conferido e teste físico desde HOME CONNECTED; sem `flash_nuke` e sem interface/debug persistente adicionada.
- Versão futura dentro da série 3.x, calculada da **tag oficial mais recente no momento da implementação**. Se só houver diagnóstico ou NO-GO, **NO RELEASE**. Nenhuma tag reservada para MNT-14 neste momento.
- Documentar possível necessidade de separar investigação e patch em branches próprias para que diagnóstico não entre no firmware final.

**Roteiros operacionais separados (ambos apenas planejados):** [Parte 1 — protocolo de investigação](../executions/MNT-14/part-1-investigation-plan.md) e [Parte 2 — protocolo de decisão/viabilidade](../executions/MNT-14/part-2-feasibility-plan.md). Nenhum desses arquivos representa resultados coletados ou autorização de firmware.

## 6. Gatilhos de aceite e estado

- **Parte 1 — EM ANDAMENTO:** auditoria estática executada, reprodução e conclusão física pendentes. Encerra ao apresentar prova/resultado fundamentado e obter ciência/aceite do operador sobre o diagnóstico.
- **Parte 2 — PENDING:** não iniciada. Encerra com decisão GO / NO-GO / BLOCKED / NOT A BUG **aceita pelo operador**; GO fica aguardando **autorização posterior para implementação** e depois aceite físico de eventual candidato.
- **MNT-14 global:** **PARTE 1 EM ANDAMENTO — INCONCLUSIVE / NO RELEASE**, sem patch e sem conclusão física. [Preflight](../executions/MNT-14/part-1-preflight.md) · [Experimentos](../executions/MNT-14/part-1-physical-execution.md) · [Relatório aberto](../executions/MNT-14/part-1-root-cause.md). **MNT-15 (Zoom) SUSPENSO; MNT-13 v3.2.3 ACEITO/PUBLICADO.**

**Este gate valoriza a arquitetura originalmente aceita; nunca transformar “desconectar A para parear B” em comportamento intencional sem decisão formal de mudança de requisito.**
