# 06 — Gates MOD-00..MOD-10: dependências, testes e aceite físico

**MOD-00 and MOD-01: ACCEPTED BY OPERATOR. MOD-02: CORRECTED AND ACCEPTED. MOD-03: CI+UF2 AND PHYSICALLY ACCEPTED. MOD-04: CORRECTED AND PHYSICALLY ACCEPTED (66/66 tests). MOD-05: CI 68/68 PASS + verified UF2, physical acceptance pending. MOD-06..MOD-10: PLANNED.** Futuro trabalho em branch nova de `remappingbridge/remappingbridge` partindo da tag imutável `v2.0.0`; documentos/registro de evidência apenas neste planner. Cada gate com alterações executáveis (MOD-01..10) exige CI host PASS, build de produção Pico 2 W, arquivo **.uf2**, SHA-256, roteiro específico de teste físico iniciando em `home-connected`, **aceite explícito do operador**, evidência e SHA. Não avançar em caso de regressão. MOD-00 é contratual/documental, sem firmware e sem UF2.

| Gate | Tema | Dependência | Resultado observável/limite de escopo |
|---|---|---|---|
| MOD-00 | Contrato arquitetural, fontes e fixtures | v2.0.0 | [Candidato documental](executions/MOD-00/candidate.md), [ACCEPTED](executions/MOD-00/operator-acceptance.md); nenhum código ou UF2 |
| MOD-01 | Remapping Options v3 + limpeza legado | MOD-00 | [Candidato CI PASS + UF2](executions/MOD-01/candidate.md); 3 opções, Standard/Escape fora de telas/status/Help; 34 telas runtime; [aceito fisicamente](executions/MOD-01/physical-acceptance.md) |
| MOD-02 | 6 páginas Combinations | MOD-01 | [Candidato corrigido e aceito](executions/MOD-02/visual-bugfix.md); HOME → combinations 1..6; 40 telas, seleção por par, paginação/wrap, RESET idempotente, 9×21, valores ainda NONE; [aceito fisicamente](executions/MOD-02/physical-acceptance.md) |
| MOD-03 | 5 páginas Shortcuts + persistência | MOD-02 | [Candidato 63/63 PASS + UF2](executions/MOD-03/candidate.md); HOME → combo → shortcuts → APPLY AND BACK; 30 itens, cancel, restaurar foco, reboot/reread, migração v2; [aceito fisicamente](executions/MOD-03/physical-acceptance.md) |
| MOD-04 | Custom MODIFIER + máscaras | MOD-03 | [Correção CI 66/66 PASS + UF2](executions/MOD-04/visual-correction.md), [aceito fisicamente](executions/MOD-04/physical-acceptance.md); 5 WILL BECOME usam MODIFIER, source único, UNAVAILABLE derivado, dados mascarados preservados, Custom Apply |
| MOD-05 | Runtime buttons + modifier released | MOD-04 | [candidato CI 68/68 PASS e UF2](executions/MOD-05/candidate.md), [teste físico pendente](executions/MOD-05/physical-acceptance.md): HOME configura, Keyboard Escape/COPY real, sem clique do MODIFIER, suppress do released após combinação |
| MOD-06 | Wheel e movimento 4 sentidos | MOD-05 | HOME configura wheel/move; rotação 0/90/180/270, ganho H/V, gesto único/histerese, sem spill de Mouse |
| MOD-07 | Keyboard catalog (ações sem Consumer) | MOD-06 | Keyboard usages/chords 1..18,25..28 com política de SO aprovada; press/release/USB backpressure |
| MOD-08 | Consumer/Media/Brightness | MOD-07 + ADR-HID | 19..24,29..30 testados em host real, contrato USB/boot/enumeração aceito, sem promessas falsas |
| MOD-09 | Recovery, BLE, UI/Help/lock e Saved Devices | MOD-08 | Disconnect, overflow, boot, migração, removal, color, legendas, compatibilidade Movement/Logitech |
| MOD-10 | Paridade, segurança e release candidate | MOD-09 | Toda matriz, UF2 produção, rollback/upgrades, 30 ações verificadas e operador aprova candidato; **não publicar sem pedido separado** |

## MOD-00 — sem testes físicos
O gate é exclusivamente documental. A revisão ocorre em [operator-acceptance.md](executions/MOD-00/operator-acceptance.md); **nenhum UF2 é produzido**, e não se executam testes no Pico. Documentos não constituem aceite do operador.

## Testes físicos mínimos por gate
**MOD-01**: conectar Mouse salvo, navegar desde HOME → Remapping Options, verificar 3 opções, `KEY B`, `KEY X` Help atualizado, `KEY Y` lock e retorno. Confirmar que Standard/Escape não aparecem mais em HOME nem Saved Devices. Mouse e movimento v2 intactos.

**MOD-02**: HOME → remapping → Modifier Shortcuts → `combinations-1`; navegar páginas 1→6→1 e 1→6; up/down selecionar a dupla inteira (rótulo+valor); `KEY A RESET SELECTED` em NONE é no-op; `KEY B` retorna, sem disparar um shortcut.

**MOD-03**: selecionar combo, abrir 5 páginas/30 itens; fazer COPY e depois ESCAPE em combos distintas, `KEY A APPLY AND BACK`, `KEY B` cancela edição, reabrir e observar o valor/foco; reiniciar dispositivo e verificar persistência. **Comportamento HID ainda não é requisito neste gate.**

**MOD-04**: ativar Custom com Modifier no LEFT, observar `MOD + LEFT CLICK IS / UNAVAILABLE`; não permitir acesso/reset do slot mascarado; atribuir Modifier ao MIDDLE e confirmar recuperação do valor latente LEFT; trocar Passthrough/Custom, aplicar/reiniciar e confirmar que o modifier ativo é único.

**MOD-05**: configurar `MODIFIER RELEASED = ESCAPE` e `MOD + RIGHT = COPY`. Soltar Modifier sem combo → um Escape; segurar Modifier e RIGHT → um Copy, soltar Modifier → zero Escape extra; segurar não repete; sem modifier configurado não há atalho; clicar normal e arrastar com botões não remapeados continua utilizável.

**MOD-06**: com Modifier pressionado fazer scroll up/down (unidade e múltiplas), move left/right/up/down, gesto diagonal, tremor pequeno, inversão rápida, espera, movimento sem Modifier. Repetir com rotação 90/270, H=2x V=1x e reconexão. Um gesto intencional por ativação; sem movimento/scroll espúrio e sem dupla transformação.

**MOD-07**: em Linux alvo selecionado, validar ações de edição e teclas com editor e aplicativo próprios; RENAME/FULL SCREEN/SCREENSHOT/FIND/SAVE/ZOOM/SHOW HOME com interpretação definida em ADR. Para cada ação, confirmar tecla liberada mesmo com USB ocupado.

**MOD-08**: host detectar **HID Consumer Control** quando exigido; Play/Pause/Track/Volume/Mute executam de fato; brilho ↑/↓ só é aprovado se controlar backlight real do host declarado. Regressão de teclado 6KRO, mouse, USB enumeration e hot-plug com duas interfaces ou mudança autorizada.

**MOD-09**: em meio a atalho, desconectar Mouse, desparear/remover, bloquear LCD, trocar perfil, saturar fila/USB e reiniciar. Nunca deixar teclas presas; apenas o nome do mouse conectado fica ciano em Saved Devices; Mouse novo conserva Movement default e shortcuts globais.

**MOD-10**: repetição end-to-end HOME→combo→shortcut→APPLY, RESET, UNAVAILABLE, ausência Modifier, reboot, remove/reconnect e todas as 30 ações em plataforma(s) aprovada(s), com .uf2 hash+testes. Testar atualização sem apagar bond e downgrade ensaiado. Não atribuir ACCEPTED sem mensagem explícita.

## Testes automatizados previstos
- Semântica: 12 combos estáveis + 30 IDs estáveis + exclusividade Modifier + máscara UNAVAILABLE sem perda de dado + KEY A reset/no-op + evento release.
- UI: fixtures textuais **9×21** de todas 11 telas, selecionado branco/atual ciano com exceção de Saved Devices, foco e wrap, lock/help, regressões de 38 telas v2.
- Persistência: schema v2→v3, CRC/falhas de flash, reboot, snapshot commit-before-UI, 12 slots e removidos sem aliases.
- Runtime: borda de botão, quadrantes, wheel, diagonais, jitter, tecla solta, modifier released/consumed, BLE overflow, HID busy, fila limitada e fontes distintas.
- USB: report descriptors, VID/PID e contagem interfaces conforme ADR, teclado preexistente, Consumer, boot/hotplug, sem CDC/UART/debug, .uf2 reprodutível.
- Snapshot integrado: HOME conectado e desconectado, Pair New/Save/Remove, Movement H/V/rot por Mouse, Logitech HID++, Help e overlay de cores.

## Governança
Cada `executions/MOD-XX/` futuro contém `pre-implementation.md`, `candidate.md`, `physical-acceptance.md`, SHA da branch, commit do planner, logs/CI, hash do .uf2, cenários feitos pelo operador e decisão. Uma branch/gate por vez partindo do SHA do último gate aceito; sem avanço automático, merge ou release não autorizados. Este plano não registra execução, aprovação, build ou testes que ainda não ocorreram.
