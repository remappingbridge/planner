# WEB-00 — Checklist de revisão humana (PENDENTE)

Estes cenários inspecionam os **documentos de baseline**, pois ainda **não existe aplicação web nem joystick virtual**. A UX interativa só poderá ser testada a partir de WEB-01 e seus gates subsequentes.

- [ ] Conferir que a versão pública do firmware é a última release: [latest](https://github.com/remappingbridge/remappingbridge/releases/latest); tag/commit e assets no [preflight](preflight.md) ainda são válidos no aceite.
- [ ] Abrir [screen-matrix.md](screen-matrix.md), conferir os 45 IDs e a ordem HOME conectado, busca/retry, REMAPPING, Movement, Saved Devices, Combinations e Shortcuts; verificar que o índice não inclui os menus aposentados da v1.
- [ ] Conferir [screen-templates.json](../../fixtures/v3.2.3/screen-templates.json): HOME com quatro opções e linhas 1..4, MOVEMENT_OPTIONS foco 1/2/4, COMBINATIONS pipe 2/4, SAVED_DEVICES pipe 5 somente com bond.
- [ ] Conferir [interaction-contract.json](../../fixtures/v3.2.3/interaction-contract.json): 12 combinações, 30 atalhos, brilho web máximo 100, cores MNT-12 sob Custom+Modifier **aplicados**, fonte RGB565 v3.2.3.
- [ ] Ler a exceção das duas strings template de 22 caracteres em HELP_REMAPPER_OPTIONS; concordar que a futura aplicação web deve manter a truncagem física do LCD (21 colunas) e não inventar correção de copy.
- [ ] Conferir licenças, hardware Pico 2 W + Waveshare Pico-LCD-1.3 e README: app interativo em Pages; README do GitHub apenas prévia clicável (sem iframe JS funcional).
- [ ] Concordar com as exclusões: sem Node/npm, sem workflow Actions próprio, sem alterar firmware, sem implementar ainda `remappingbridge.github.io`, e sem UF2 novo.
- [ ] Autorizar explicitamente o aceite de WEB-00 após conferência; do contrário relatar correções dentro deste gate.

**Resultado do operador:** PENDENTE. Não criar `operator-acceptance.md` dizendo que foi aprovado sem manifestação explícita. O próximo gate WEB-01 fica bloqueado até esse aceite.
