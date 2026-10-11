# MNT-02 — roteiro de aceite físico (HF-02 + HF-03)

**STATUS: PENDING — NÃO TESTADO FISICAMENTE PELO OPERADOR / NÃO ACEITO.**

Firmware fonte: branch [`maintenance/v3x-mnt-02`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-02), [PR #32 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/32). Base oficial [v3.0.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.1). Versão futura após aprovação: **v3.0.2** (ainda NÃO publicada).

## Preparação
1. Baixar o **UF2 candidato MNT-02** de [candidate.md](candidate.md), conferir o SHA256 informado. Instalar com Pico 2 W em modo BOOTSEL **sem flash_nuke**.
2. Iniciar pela **HOME CONNECTED** com pelo menos um mouse salvo e conectado. O fluxo MNT-01 deve estar preservado: Saved Devices magenta no título, nome conectado ciano, REMOVER branco e dicas cinza.

## Cenários específicos de MNT-02
- [ ] **01 — Entrada**: HOME CONNECTED → terceira opção SAVED DEVICES → JOY PRESS na linha branca `REMOVE DEVICE`. Abre `REMOVE THIS MOUSE` do bond visualizado (sem remover), título magenta e texto completo.
- [ ] **02 — Legenda**: na linha final de REMOVE THIS aparece exatamente `KEY X: HELP`, não `KEY Y: HELP`.
- [ ] **03 — KEY X real**: KEY X abre `REMOVE MOUSE HELP` ao soltar o botão. A tela Help apresenta seu conteúdo intacto, inclusive `ANY KEY: BACK` (MNT-05 alterará esta regra).
- [ ] **04 — Retorno Help**: dentro do Help, pressionar KEY B (ou outra tecla, como na v3.0.1) retorna a REMOVE THIS **sem excluir**, exibindo o mesmo mouse. Um segundo KEY X pode abrir o Help novamente sem perder bond ou entrar num loop.
- [ ] **05 — KEY Y global**: diretamente em REMOVE THIS, KEY Y bloqueia o dispositivo, **não** abre Help. Desbloqueie normalmente; a primeira tecla de unlock não deve disparar `KEY A: REMOVE`.
- [ ] **06 — Cancelamento**: voltar a REMOVE THIS e pressionar KEY B para cancelar; retorna à mesma página Saved Devices, com o mesmo mouse salvo. **Não pressione KEY A: REMOVE** para testar este gate.
- [ ] **07 — Vários mouses**: navegar entre 2+ bonds; abrir Remove This numa página de mouse não ativo, abrir e fechar Help, cancelar. Não trocar silenciosamente o bond alvo nem confundir página visual com bond lógico.
- [ ] **08 — Regressão MNT-01 e v3.0.1**: Saved Devices título magenta, Remove Device branco, dicas cinzas; HOME/Movement H/V + Rotation, perfil Custom/Passthrough, Modifier Shortcuts, USB cursor/teclas continuam funcionando; reboot mantém preferências.
- [ ] **09 — Processamento pendente**: comportamento de bloqueio de Help/Lock durante exclusão BLE será validado por testes automatizados; **não é necessário excluir fisicamente o mouse** para simular pending neste gate. Marcar N/A se não houver cenário seguro.

## Resultado
- CI host/build Pico 2 W: ver [candidate.md](candidate.md) quando disponível.
- Evidência física individual: ainda não fornecida.
- **Gate aprovado:** PENDING.
- v3.0.2: NÃO publicada. Não executar merge, tag, release ou próximo gate sem `gate aceito` explícito.

Este gate altera apenas a legenda e comando de Help REMOVE THIS; o novo contrato global dos Helps não faz parte do MNT-02.
