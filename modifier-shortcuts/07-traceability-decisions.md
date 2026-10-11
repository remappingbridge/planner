# 07 — Rastreabilidade, ambiguidades e decisões anteriores ao código

## Origem das regras
| ID | Origem no anexo | Decisão/arquivo | Aceite previsto |
|---|---|---|---|
| R01 | Regra 1: herdar RemappingBridge | 01/03/06: preservar v2 Bluetooth, lock, Movement e UI | MOD-09/10 |
| R02 | Regra 4: excluir STANDARD/ESCAPE e status | 01/02/05: apenas PASSTHROUGH/CUSTOM; migração de ativos antigos | MOD-01/03 |
| R03 | Regra 5 + páginas `WILL BECOME`: ESCAPE→MODIFIER | 01/02/03/05: target único e confirmação Custom | MOD-04 |
| R04 | Regra 6: UNAVAILABLE por colisão | 02/03/05: máscara derivada, slot persistido intocado | MOD-04 |
| R05 | Regra 7: 2 linhas por combinação | 02: seleção de par, título e 9×21 | MOD-02 |
| R06 | Regra 8: KEY A reset salvo UNAVAILABLE | 02/05: somente selecionada, commit atômico | MOD-02/03/04 |
| R07 | Regra 9: acessar combinação abre shortcuts | 02: Joy Press e 5 páginas; indisponível bloqueado | MOD-03/04 |
| R08 | Regra 10: metadata remapper→remapping | 01/02: slug/copy/Help novos | MOD-01 |
| R09 | Regra 11: modifier dispara shortcut | 03/04: FSM e ações HID | MOD-05..08 |
| R10 | Regra 12: editar sem Modifier; colisão futura | 01/02/05: store global independente; masking reversível | MOD-03/04 |
| R11 | Regra 13: fluxo HOME até KEY A | 02/06: teste físico completo por gate | MOD-03/10 |
| R12 | Telas combinations-1..6 | 02: 12 slots na ordem exata | MOD-02 |
| R13 | Telas shortcuts-1..30 | 02/04: 30 IDs e copy em ordem exata | MOD-03/07/08 |
| R14 | Comentário: valores parentéticos não renderizam | 02: dinâmico só o valor; sem comentários | MOD-02/03 |

**Candidato do MOD-00:** [executions/MOD-00/candidate.md](executions/MOD-00/candidate.md) registra propostas explícitas de resolução; [aceite do operador](executions/MOD-00/operator-acceptance.md) continua **PENDING**. A existência das propostas não significa que os bloqueios foram aceitos.

## ADRs / decisões que não constam expressamente no anexo
- **D1 [BLOCKER, MOD-00]** Literalidade/typos do desenho: `PASSTHROUGT`, `WHELL`, `0F`, `NOT CUSTMIZED`; decidir texto de exibição exato e congelar golden 9×21 antes do código.
- **D2 [BLOCKER, MOD-00]** Compatibilidade HID: Consumer Control na segunda interface com Report IDs (preferência condicional), terceira interface ou cobertura incompleta. O contrato v2 garante exatamente 2 interfaces; alteração precisa de aprovação e ensaio.
- **D3 [BLOCKER, MOD-00]** Plataformas/ações não universais: mapa Linux/Windows/macOS, HOME SCREEN\PAGE, SCREENSHOT e BRIGHTNESS; sem mecanismo de detecção de OS nem nova tela no anexo. Definir alvo declarado de aceitação e política de comportamento.
- **D4 [RECOMMENDED, MOD-00]** Single-Modifier e redistribuição de source: ao escolher novo MODIFIER, retornar antigo para identity, sem apagar shortcut correspondente. Confirmar que é a intenção.
- **D5 [RECOMMENDED, MOD-00]** `MODIFIER RELEASED` deve disparar só se nenhum gesto (inclusive sem assignment, decisão conservadora) tiver ocorrido durante a pressão; nenhum disparo em disconnect/cancel.
- **D6 [BLOCKER, MOD-00]** MOVE: eixo após rotação/antes de ganho; classificador diagonal e limiar; supressão vs buffering do ponteiro, uma ação por gesto, reset por neutralização. Critérios físicos antes de código.
- **D7 [RECOMMENDED, MOD-00]** Wheel: evento por detent; sem auto-repeat de mouse button; KEY A único APPLY na lista, Joy Press não aplica; seleção/paginação wrap.
- **D8 [RECOMMENDED, MOD-00]** Voltar/Lock/Help: B cancel/back, Y Lock, X apenas conteúdo Help existente aprovado; nenhuma tela extra criada por inferência.
- **D9 [BLOCKER, MOD-00]** Migração v2: Standard/Escape ativos viram Passthrough; targets antigos ESCAPE viram identity (não MODIFIER); schema v3; política de downgrade explicitada.
- **D10 [RECOMMENDED, MOD-00]** Shortcuts globais como Custom, não per-bond; Saved Devices continua mostrando profile global e Movement per-bond.
- **D11 [RECOMMENDED, MOD-00]** Colisão não apaga assignment: status derivado = UNAVAILABLE; reset impossível até conflito desaparecer. Teste guarda/recuperação.
- **D12 [RECOMMENDED, MOD-00]** Gravação flash antes de confirmar tela; falha de flash mantém seleção/editor e valor anterior.

## Perguntas técnicas que as telas sozinhas não respondem
1. `HOME SCREEN\PAGE` significa Home do cursor de texto/página, área de trabalho, ou tela inicial do sistema operacional? São ações diferentes.
2. "Zoom" é zoom do navegador/aplicação ou ampliação do desktop? Algum host que não possui função receberá no-op declarado.
3. Precisão do gesto MOVE: precisa detectar deslocamento físico absoluto, direção do ponteiro pós-rotação, ou direção da mão pré-rotação? Proposta pós-rotação (compatível com tela MOVE do cursor).
4. Se a pessoa segurar MODIFIER e outro botão **sem shortcut**, o botão mantém sua função física normalmente? Proposta encaminhar e inibir `MODIFIER RELEASED` por segurança.
5. O que ocorre ao mapear um segundo botão para MODIFIER? Proposta single source, reassignment atômico.
6. Que SO e aplicativos definem a interpretação de screenshots, F11, RENAME, REDO, mídia e brilho? Exigir ensaio de host.
7. A passagem instantânea pelo limiar da movimentação deve movimentar o cursor? Proposta buffering/supressão a validar.

Estas questões são **inferências/ADRs**, não requisitos afirmados pelo anexo. É permitido documentar proposta; **não está autorizada implementação com valores arbitrários**. Depois da aprovação deste planejamento, congelar decisões no MOD-00.

**Correção da rastreabilidade:** a ordem normativa das opções WILL BECOME é LEFT, RIGHT, MIDDLE, FORWARD, BACKWARD, MODIFIER (MODIFIER por último), conforme o anexo. A redação anterior 'substituir ESCAPE na mesma posição' foi corrigida em `02-ui-navigation-contract.md`.

## Verificação documental antes de abrir branch de firmware
- Todos os 12 slots e 30 labels comparados ao anexo, sem omissões;
- Inventário de telas reconfirmado (38 v2 → 45 alvo por adição líquida), Help/metadata e perfil antigo removidos;
- Tabelas binárias, falhas, relatório Consumer e plataforma alvo decididos;
- Cada gate com teste end-to-end iniciando na HOME e entrega UF2, exceto gate documental;
- Nenhuma modificação no repositório `remappingbridge/remappingbridge` enquanto o trabalho for apenas planejamento.
