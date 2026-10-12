# MNT-13 / Parte 1 — protocolo de diagnóstico da causa raiz

**STATUS: PLANNED / NÃO EXECUTADO.** Este documento é um **roteiro**, não contém dados coletados, resultado físico, logs, firmware ou autorização para corrigir. Ver [contrato integral MNT-13](../../gates/MNT-13.md) e [evidência estática anterior](../../investigations/pair-new-with-connected-mouse-2026-10-11.md).

## Pergunta central

Por que `PAIR NEW MOUSE`, segundo relato do operador, só associa B (mouse genuinamente novo) quando A já não está conectado, se o produto foi concebido e fisicamente aprovado para **manter A enquanto descobre e qualifica B**, fazendo handoff só depois?

## Baseline conhecido de fonte (levantamento prévio, não teste atual)

- Última release ao redigir este plano: **v3.2.1**. Na execução, confirmar tag/SHA, CI, UF2 efetivamente instalado e hashes antes de comparar.
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

**Não declarar PASS ou causa raiz neste roteiro. A parte 1 só muda de status após execução e evidência.**
