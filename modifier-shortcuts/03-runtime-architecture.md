# 03 — Arquitetura de runtime, domínio e máquinas de estado

## Integração mínima com a v2.0
`BLE HOGP parsed event → canonical Mouse event → [modifier detector + gesture classifier] → remap pass-through/Custom → HID aggregator (Mouse + synthetic Keyboard/Consumer) → USB service`.
A lógica reside num módulo de domínio pequeno, proposto `modifier_shortcuts` (sem loop/serviço independente). Recebe eventos canônicos, snapshot imutável de configuração global, estado de conexão e valores atuais de Movement; devolve (a) evento Mouse encaminhável, (b) comandos de atalho tipados e (c) indicação de consumo. `app/main.c` apenas compõe; `ux_model` não transforma relatórios de mouse; `remap` não conhece nomes de telas; USB não conhece `MOD + MOVE UP`.

**Ordem**: detectar o source MODIFIER **antes** do mapeamento Custom de botões, para distinguir botões físicos de destinos. Para gestos MOVE usar os eixos de saída **após rotação** v2.0, mas **antes do ganho H/V**, preservando a interpretação de MOVE UP do cursor e tornando o limiar independente de DPI. Não alimentar duas vezes o acumulador de `movement_pipeline`: compartilhar transformação pura de eixos ou calcular a classificação sem mutar o pipeline. Se modo Modifier consumir movimento, nunca enviar o mesmo delta ao agregador. Se não consumir, preservar o pipeline e a regra de ACK USB existente.

## Entidades
- `ModifierSource = NONE | LEFT | RIGHT | MIDDLE | FORWARD | BACKWARD`: **único source ativo**, derivado do Custom aplicado.
- `CombinationId` fixo/estável, de 0 a 11, na ordem de `02-ui-navigation-contract.md`.
- `ShortcutId = NONE (0) | 1..30` na ordem do catálogo. Valor **UNAVAILABLE é derivado**, nunca enum persistido.
- `ShortcutAssignments[12]` persistidas globalmente, inclusive valores mascarados.
- `ShortcutAction` define semântica (KeyboardChord / KeyboardKey / ConsumerUsage / HostSpecific / UnsupportedUntilResolved), não códigos USB codificados na UI.
- `ChordState`: modifierDown, pressedButtons, consumedCombo, consumedButtons, directionalAccumulator, directionLatch, queuedActions e generation/session. Não persistir nenhum estado transitório de botão.

> **MOD-00 — ressalva de precedência:** o contrato candidato em [executions/MOD-00/candidate.md](executions/MOD-00/candidate.md) propõe um tratamento mais conservador para o tap (qualquer gesto secundário suprime MODIFIER RELEASED, mesmo sem atribuição) e captura/supressão de movimento enquanto o Modifier estiver pressionado e houver MOVE configurado. Os detalhes desta seção são históricos/propostas; estas opções só serão normativas após aceite explícito do MOD-00.

## Máquina de estados do MODIFIER
| Estado | Evento | Transição/saída |
|---|---|---|
| INACTIVE | Mouse não conectado / perfil PASSTHROUGH / Custom sem source MODIFIER | Mouse v2 normal; assignments editáveis mas inertes |
| IDLE | pressionar o source MODIFIER | ARMED; **consumir** seu clique físico (down não chega ao host) |
| ARMED | pressionar botão diferente com assignment existente | CONSUMED; emitir 1 ação; consumir down/up físico desse botão |
| ARMED | wheel com assignment no sentido recebido | CONSUMED; emitir 1 ação por unidade/detent, com limite de fila |
| ARMED | movimento que cruza limiar classificado e tem assignment | CONSUMED; emitir ação; rearmar gesto só após neutralização/histerese |
| ARMED | soltar MODIFIER sem combinação consumida | emitir `MODIFIER RELEASED` se atribuído; voltar IDLE |
| CONSUMED | soltar MODIFIER | **não** disparar `MODIFIER RELEASED`; neutralizar estado, voltar IDLE |
| Qualquer | disconnect, remove, troca de perfil/modifier, BLE overflow, USB reset | CANCELLED: neutralizar Mouse/Keyboard/Consumer próprios, descartar pending gestures sem disparar release; transição a IDLE/INACTIVE |

Não reencaminhar eventos de release cujo down foi consumido pelo modo modifier. Para uma segunda tecla física pressionada enquanto MODIFIER está down e **não** há assignment, opção recomendada: encaminhar sua função Custom normal e **não** marcar a sessão consumida; documentar risco de tap ao soltar e validar no gate de eventos. Alternativa mais segura a decidir em MOD-00: considerar qualquer segundo gesto usado, mesmo sem assignment, como cancelamento do RELEASED. Recomenda-se **sim**, para evitar atalho acidental, sem suprimir o movimento não mapeado.

## Direcional MOVE / wheel: contrato a congelar
- Entrada MOVE: quatro gestos de um eixo dominante, no sistema de coordenadas **do cursor pós-rotação**. Não interpretar diagonal como duas ações. Dominância/histerese e tempo de espera por centro impedem multiplicação de ações por ruído. Sem pressão do MODIFIER, nenhuma supressão ou classificação.
- **Inferência recomendada:** enquanto MODIFIER está pressionado, suprimir movimento físico do ponteiro somente durante uma sessão de gesto MOVE intencional/reconhecida; para evitar deslocamento do cursor antes do reconhecimento, solução preferida é **buffer curto até classificar** e, caso não haja gesto atribuído, liberar com transformação/ack corretos. O efeito no arraste e perda de movimento precisa de validação física; se inviável, optar por modo gesto com supressão de movimento durante todo MODIFIER (decisão explícita).
- **Não fixar limiares sem teste físico.** Critérios a congelar: limiar baseado em contagens relativas acumuladas e independente de DPI, eixo dominante, reset por quietude/histerese, 1 ação por gesto (sem autorepeat não solicitado), ausência de trigger por jitter. Wheel: valores assinados, detents maiores que 1 geram eventos discretos; pan horizontal permanece pan (não aciona Wheel Up/Down).
- Botões: pressionar uma única vez não é múltiplo clique; segurar não repete; source físico, não botão já remapeado.

## Gerador de ações USB
- Gerar **keydown/modifier → USB report aceito → keyup/modifier release → USB report aceito** em duas ou mais fases. Eventos simultâneos respeitam ordem FIFO, tempos mínimos testados e ownership por source sintético.
- Não colapsar keydown+keyup antes de o endpoint aceitar cada relatório; a função USB existente evita enviar reports idênticos. Uma fila bounded + executor incremental impede perder eventos em `tud_hid_n_ready=false`. Overflow = política explícita de drop/coalesce sem teclas presas e sem bloqueio de HAT/BLE.
- Manter HID aggregator como autoridade dos held refs; usar source synthetic próprio, não liberar teclas de outra origem; reset em disconnect, profile APPLY, dispositivo removido e corrupção de fila.
- Touch do HAT/lock nunca ativa atalhos. Trocar Custom enquanto Mouse segura botão deve liberar ownership, inclusive Logitech Lift Forward held fix, como a v2.0 faz em `apply_profile`.
- Não confundir o MODIFIER do mouse com os bits USB Ctrl/Shift/Alt/GUI: estes são produzidos **somente pelo ShortcutAction**.

## Invariantes de segurança
1. Nenhum evento de atalho sem source ativo, combo disponível e assignment válido.
2. Nenhum clique vazado do source MODIFIER e nenhum release sem down correspondente.
3. Nenhum `MODIFIER RELEASED` depois de combo usada, desconexão ou alteração de perfil.
4. Nenhuma tecla/modificador do host permanece pressionado; teclado normal mantém ownership.
5. Nenhuma dupla transformação/duplicação de movimento, pan, wheel ou tecla com endpoint ocupado.
6. Gravação de configuração nunca bloqueia processamento BLE prolongadamente, e alterações só se tornam efetivas depois de commit persistente bem-sucedido.
