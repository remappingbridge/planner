# HOPE gate plan

Status geral: **HOPE SERIES COMPLETE / REMAPPINGBRIDGE 1.0 PUBLISHED — HOPE-31 accepted and promoted; stable release `v1.0.0` published from main `99a59287342bc2daa519629e5572513dce7cc7f4` on 2026-09-26. No further HOPE gate exists.**.

## Ordem oficial de execução

A numeração identifica o gate; a **ordem de execução oficial** é a ordem do fluxo fornecido para o programa:

~~~text
HOPE-00
HOPE-01
HOPE-02
HOPE-08
HOPE-24
HOPE-09
HOPE-25
HOPE-06
HOPE-26
HOPE-07
HOPE-27
HOPE-03
HOPE-28
HOPE-10
HOPE-29
HOPE-11
HOPE-14
HOPE-12
HOPE-13
HOPE-15
HOPE-16
HOPE-17
HOPE-18
HOPE-19
HOPE-20
HOPE-21
HOPE-22
HOPE-04
HOPE-05
HOPE-30
~~~

A sequência desta feature está **concluída**. Nenhum novo gate deve ser iniciado automaticamente.

**ORDEM DO OPERADOR (2026-09-26): executar somente o HOPE-23 com o novo escopo abaixo. Após sua conclusão, voltar ao HOLD e não iniciar nenhum outro gate sem nova ordem explícita.**

`HOPE-23` e `HOPE-31` permanecem removidos desta sequência por decisão do operador. O trabalho correspondente poderá ser reprojetado futuramente como uma **nova feature, com uma nova série de gates**, mas somente após nova ordem explícita do operador.

## Regra universal de todos os gates

Em todo gate, inclusive gates de Help e HOPE-00:

- **adaptar/reaproveitar = substituir in-place**: pode reutilizar lógica G06, mas o layout antigo correspondente não pode continuar como fallback, alternativa ou tela paralela;
- toda rota equivalente ao ponto de fluxo substituído deve mostrar exclusivamente o layout Mouse UI v1 do gate atual;
- layout da tela introduzida deve corresponder à referência Mouse UI v1;
- região de dicas deve usar a cor correta;
- pixels/backgrounds devem estar nas posições corretas;
- pareamento de Mouse deve continuar funcionando;
- movimento do Mouse deve continuar funcionando;
- cliques devem continuar funcionando;
- regressões de gates HOPE já aceitos devem continuar consistentes;
- aceitação física pelo operador é obrigatória.

---

## HOPE-00 — exact G06 baseline

**Status:** ACCEPTED / PROMOTED TO MAIN `16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`.

**Objetivo:** copiar exatamente BLU2USB G06 aceito para `remappingbridge/remappingbridge` sem quebrar nada.

**Fonte:** `remappingbridge/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`.

**Não fazer neste gate:** nenhuma tela Mouse UI v1; nenhuma melhoria; nenhum refactor; nenhuma mudança de arquitetura.

**Aceitação:** árvore funcional equivalente à baseline G06, build/UF2 reproduzível e teste físico regressivo do comportamento G06.

---

## HOPE-01 — searching-first

**Status:** ACCEPTED / PROMOTED TO MAIN `4b0ebe933721895488a38f84c03f009c0d30cb32`.

**Objetivo:** substituir a apresentação inicial herdada pela tela `searching-first` Mouse UI v1.

**Adaptar antigo para novo:** transformar in-place o ponto de fluxo/tela antiga `LEARN THE KEYS` usada no primeiro boot. Reutilizar pareamento automático e infraestrutura existente por baixo, mas **não manter o layout antigo em nenhuma condição desse ponto de fluxo**.

**Remover antigo:** remover a apresentação visual antiga desse ponto do fluxo. Não criar `searching-first` em paralelo deixando `LEARN THE KEYS` como fallback.

---

## HOPE-02 — first-mouse-connected

**Status:** ACCEPTED / PROMOTED TO MAIN `d13f905fc2a817f464f3683edd4bf689247c30ed`.

**Objetivo:** implementar `first-mouse-connected` como feedback de sucesso de `searching-first`.

---

## HOPE-08 — home-searching

**Status:** ACCEPTED / PROMOTED TO MAIN `c88ebacdeb8265c9b8bd82882f97d9b8c960493a`.

**Objetivo:** implementar `home-searching` como estado da HOME e integrá-la ao fluxo já aceito.

---

## HOPE-24 — home-searching-help

**Status:** ACCEPTED / PROMOTED TO MAIN `aa6abb2294248aa8eabc4918eae1bdcfef26a959`.

**Objetivo:** implementar `home-searching-help` conforme Mouse UI v1.

---

## HOPE-09 — home-retry

**Status:** ACCEPTED / PROMOTED TO MAIN `b883353bb654826d4c960513e72182d2b35b4c6a`.

**Objetivo:** implementar `home-retry` como estado da HOME e integrá-la ao fluxo já aceito.

---

## HOPE-25 — home-retry-help

**Status:** ACCEPTED / PROMOTED TO MAIN `def2743022c3b522190eac06b97af0d4148348bd`.

**Objetivo:** implementar `home-retry-help` conforme Mouse UI v1.

---

## HOPE-06 — pair-new

**Status:** ACCEPTED / PROMOTED TO MAIN `90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`.

**Objetivo:** implementar `pair-new` conforme Mouse UI v1.

**Adaptar antigo para novo:** substituir in-place o fluxo antigo `HOME > MOUSE OPTIONS > PAIR DEVICE`, reaproveitando apenas sua lógica funcional; as telas/layouts antigos correspondentes não permanecem como fallback.

**Remover antigo completamente:** remover as telas antigas subsequentes desse fluxo antigo.

---

## HOPE-26 — help-pair-new

**Status:** ACCEPTED / PROMOTED TO MAIN `4a1451e5ce25573734fc6179c45867588b76bbb0`.

**Objetivo:** implementar `help-pair-new` conforme Mouse UI v1.

---

## HOPE-07 — retry-pair-new

**Status:** ACCEPTED / PROMOTED TO MAIN `a4ce8cc7d3be425152bfb825c9b282d8ee510bd8`.

**Objetivo:** implementar `retry-pair-new` conforme Mouse UI v1.

---

## HOPE-27 — help-retry-pair-new

**Status:** ACCEPTED / PROMOTED TO MAIN `1ffffebc0e9fabc55d981b7dcfbf7bba80bde78a`.

**Objetivo:** implementar `help-retry-pair-new` conforme Mouse UI v1.

---

## HOPE-03 — home-connected

**Status:** ACCEPTED / PROMOTED TO MAIN `95b8e6fab1710f562b7ce1ead629a9cca2734c17`.

**Objetivo:** implementar `home-connected` como estado da HOME.

**Adaptar antigo para novo:** substituir in-place a HOME antiga por `home-connected`, reaproveitando somente lógica/estado necessários; a HOME antiga não permanece como alternativa.

---

## HOPE-28 — help-home-connected

**Status:** ACCEPTED / PROMOTED TO MAIN `46e501f13784d3ef94e3d4213596b25afa731347`.

**Objetivo:** implementar `help-home-connected` conforme Mouse UI v1.

---

## HOPE-10 — remapper-options

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** substituir in-place o antigo `HOME > MOUSE OPTIONS` por `remapper-options`, mantendo suas funções úteis por baixo e exibindo somente o layout/texto Mouse UI v1.

---

## HOPE-29 — help-remapper-options

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** implementar `help-remapper-options` conforme Mouse UI v1.

---

## HOPE-11 — passthrough-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > PASSTHROUGH` e aplicar layout/texto Mouse UI v1.

---

## HOPE-14 — passthrough-not-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > PASSTHROUGH` e aplicar layout/texto Mouse UI v1.

---

## HOPE-12 — standard-not-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > DEFAULT REMAP` e aplicar layout/texto Mouse UI v1.

---

## HOPE-13 — standard-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > DEFAULT REMAP` e aplicar layout/texto Mouse UI v1.

---

## HOPE-15 — escape-not-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > ESCAPE REMAP` e aplicar layout/texto Mouse UI v1.

---

## HOPE-16 — escape-active

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > ESCAPE REMAP` e aplicar layout/texto Mouse UI v1.

---

## HOPE-17 — custom-edit

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função do antigo `HOME > MOUSE OPTIONS > CUSTOM REMAP (EDIT CUSTOM REMAP)` e aplicar layout/texto Mouse UI v1.

---

## HOPE-18 — left

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função antiga de edição `LEFT IS... / LEFT WILL BECOME` e aplicar a tela `left` Mouse UI v1.

---

## HOPE-19 — right

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função antiga de edição `RIGHT IS... / RIGHT WILL BECOME` e aplicar a tela `right` Mouse UI v1.

---

## HOPE-20 — middle

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função antiga de edição `MIDDLE IS... / MIDDLE WILL BECOME` e aplicar a tela `middle` Mouse UI v1.

---

## HOPE-21 — forward

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função antiga de edição `FORWARD IS... / FORWARD WILL BECOME` e aplicar a tela `forward` Mouse UI v1.

---

## HOPE-22 — backward

**Status:** ACCEPTED / PROMOTED TO MAIN `5c62a98a4495570237d7b4b223a090bea1020990`.

**Objetivo:** preservar a função antiga de edição `BACKWARD IS... / BACKWARD WILL BECOME` e aplicar a tela `backward` Mouse UI v1.

---

## HOPE-04 — saved-devices

**Status:** ACCEPTED / PROMOTED TO MAIN `a459316fd2c9eefb9fc85e6656cd96134f22d0a0`.

**Objetivo:** implementar `saved-devices`.

**Adaptar antigo para novo:** substituir in-place `HOME > OTHER OPTIONS > SAVED DEVICES` pela nova `saved-devices`, reutilizando apenas a funcionalidade interna necessária.

**Remover antigo completamente:** remover `PAIR KEYBOARD`, `PAIR COMPOSITE` e telas subsequentes desses fluxos, se existirem.

---

## HOPE-05 — remove-this

**Status:** ACCEPTED / PROMOTED TO MAIN `07abebc67d202ad67c52f325d6153b9ed0d90ab6`.

**Objetivo:** implementar `remove-this` conforme Mouse UI v1.

---

## HOPE-30 — help-remove-this

**Status:** ACCEPTED / PROMOTED TO MAIN `25670c9692aaaf709912e2d6bb87c27c10b25b4e` — exact physically accepted candidate `956906c2320c99937875bbbb95e6372945898424`.

**Objetivo:** implementar `help-remove-this` conforme Mouse UI v1.

---

## HOPE-23 — remove learn-the-keys

**Status:** ACCEPTED / PROMOTED TO MAIN `8aa50611bcaf1a0091de6b111de0c6b7e4a67646`.

**Objetivo:** cancelar definitivamente a tela/feature `learn-the-keys` e remover sua opção/rota de navegação da aplicação.

**Procedimento atualizado:**
- não implementar a tela `learn-the-keys`;
- remover `LEARN THE KEYS` das opções de `home-connected`, `home-searching` e `home-retry`;
- ajustar seleção, quantidade de opções, layout e navegação dessas HOME para que não exista posição vazia/rota residual;
- remover qualquer navegação manual que leve da HOME para `learn-the-keys`;
- preservar o fluxo automático `searching-first` usado quando ainda não existe Mouse salvo; ele não é a feature `learn-the-keys` e continua necessário para o primeiro pareamento;
- limpar nomes/aliases legados no código quando isso puder ser feito sem alterar o comportamento aceito de `searching-first`;
- manter todos os gates já aceitos sem regressão;
- ao concluir, voltar ao HOLD: nenhum gate seguinte deve ser iniciado automaticamente.

---

## HOPE-31 — final inventory and documentation

**Status:** ACCEPTED / PROMOTED TO MAIN `5a8f3d39e37e9b5a17ccdee0af5531c6d3423087` — exact physically accepted candidate `15a3ec9f8b20c96e41cb7e04610191b2853378bf`.

**Objetivo atualizado após HOPE-23:** garantir exatamente **29 telas canônicas reais** com regras bem definidas e nenhuma tela antiga, duplicada, solta, escondida ou inalcançável fora do fluxo.

**Inventário esperado:** 29 telas. O plano original previa 30, mas HOPE-23 foi substituído por decisão do operador em 2026-09-26: a feature/tela `learn-the-keys` foi cancelada e sua opção removida das HOME. `searching-first` continua sendo a tela automática do HOPE-01 e permanece no inventário.

**Limpeza final obrigatória:** remover as quatro telas G06 legadas de status/help que sobreviveram fora do fluxo HOPE (`MOUSE_STATUS`, `OTHER_DEVICES_STATUS`, `MOUSE_HELP`, `DEVICES_HELP`) e remover qualquer tela/ID duplicado sem rota real. Não manter uma tela artificial apenas para preservar a contagem histórica de 30.

**Documentação final:** registrar arquitetura efetivamente resultante e regras em `remappingbridge/remappingbridge/docs`, descrevendo a implementação simples realmente existente, sem inventar contratos/Core que o programa excluiu.

**Aceitação física:** executar matriz final completa das 30 telas e regressão de pareamento, movimento, cliques, perfis, persistência/retorno aplicável e navegação.
