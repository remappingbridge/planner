# MNT-14 / Parte 1 — protocolo de diagnóstico da causa raiz

**STATUS: PLANO ORIGINAL / auditoria estática executada posteriormente; reprodução física NÃO EXECUTADA.** Renumerado de MNT-13 para MNT-14 em 12/10/2026; os critérios e evidências requeridas permanecem os mesmos. Este documento é o **roteiro original**. Os dados estáticos verificados e o status INCONCLUSIVE estão em [part-1-preflight.md](part-1-preflight.md) e [part-1-root-cause.md](part-1-root-cause.md), com [experimentos físicos pendentes](part-1-physical-execution.md). Sem logs físicos nem autorização para corrigir. Ver [contrato integral MNT-14](../../gates/MNT-14.md) e [evidência estática anterior](../../investigations/pair-new-with-connected-mouse-2026-10-11.md).

## Pergunta central

Por que `PAIR NEW MOUSE`, segundo relato do operador, só associa B (mouse genuinamente novo) quando A já não está conectado, se o produto foi concebido e fisicamente aprovado para **manter A enquanto descobre e qualifica B**, fazendo handoff só depois?

## Baseline conhecido de fonte (levantamento prévio, não teste atual)

- Última release ao redigir este plano: **v3.2.1**. Na execução atual verificou-se **v3.2.3**, tag/main `f38c5fd15c68ea9a36d3b05912727788d7b98e81`, [CI/release](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), UF2 SHA-256 `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`. Ainda falta confirmar firmware efetivamente instalado em hardware.
- Decisões do produto: `RP-2350/mouse-bridge-remapper/requirements/2026-09-20-connected-home-pair-new.md`, `2026-09-20-pair-new-help-and-handoff.md`, `2026-09-20-single-connected-mouse.md`.
- HOPE-06: falha inicial de pools 1/1/1; rework passou a 2/2/2 e teve aceite físico em 23/09/2026.
- Inspeção de v3.2.0: pools **2/2/2** ainda presentes; HOME aceita o fluxo; `start_pair_new()` admite `READY`; 15.000 ms; candidata separada; HIDS/descriptor e handoff sem desconectar A na entrada. **Nenhuma causa física demonstrada**.

## Sequência de trabalho futura

- [ ] Verificar tag de origem, versão do UF2 instalado, branch/SHA comparados, dois mouses/modelos, versão SDK/BTstack e ambiente sem interferência.
- [ ] Mouse A conectado/funcional; mouse B **ainda não salvo**, em pairing e BLE HOGP. Iniciar PAIR NEW; marcar timestamps (entrada, advertising, tentativa B, timeout/handoff) e estado de A.
- [ ] Repetir com A ausente e **B ainda não salvo**; se B já foi cadastrado em teste anterior, escolher outra identidade inédita ou remover B por fluxo oficial para restaurar pré-condições sem afetar A.
- [ ] Controles de cancelamento/15s, B previamente salvo ignorado, identidade RPA/IRK, reboot e repetibilidade; não confundir conexão automática de saved com Pair New.
- [ ] Se necessário e autorizado, criar instrumentação diagnóstica **reversível**, por UI/request/start/gap scan/report/connect/SM security/GATT HIDS/parser/handoff/cancel; não alterar comportamento, fluxos de UX, USB, flash ou bonds.
- [ ] Registrar logs com IDs anonimizados, contadores de advertising e códigos de retorno/reason; manter handles e session IDs correlacionados por linha do tempo.
- [ ] Localizar **primeira divergência** e testar ao menos hipótese causal separando recusa de scan, falha de radio/conn, classificação como salvo e falha após conexão; examinar diff HOPE-06 → release atual além das rotinas centrais.
- [ ] Escrever relatório `part-1-root-cause.md` com condição de reprodução, conclusão **CONFIRMED / NOT REPRODUCED / INCONCLUSIVE / ENVIRONMENTAL**, alternativas excluídas, limites, SHA/CI/logs.
- [ ] Apresentar diagnóstico ao operador para revisão antes de abrir a Parte 2. **Sem correção e sem release.**

**Não declarar PASS nem causa raiz neste roteiro. Auditoria estática executada; Parte 1 continua INCONCLUSIVE até teste físico e evidência.**
