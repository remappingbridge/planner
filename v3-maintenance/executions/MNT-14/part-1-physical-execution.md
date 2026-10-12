# MNT-14 / Parte 1 — roteiro físico histórico (gate cancelado)

**STATUS FINAL (12/10/2026): CANCELADO PELO OPERADOR, após ele relatar que os testes físicos funcionaram em cenários variados e adversos.** O assistente não executou esses testes; sem logs/matriz detalhada recebidos, as células PENDING abaixo permanecem como documentação histórica e NÃO devem ser convertidas em PASS individual. A Parte 2 foi cancelada. **Baseline original do roteiro:** Baseline: [RemappingBridge v3.2.3 oficial](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), commit/tag `f38c5fd15c68ea9a36d3b05912727788d7b98e81`, [CI #38280962230](https://github.com/remappingbridge/remappingbridge/actions/runs/38280962230) PASS, UF2 SHA-256 `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`.

## Pré-condições (não pular)

- Mouse **A** conectado e movimentando ponteiro via USB no PC. Anotar modelo de A (sem serial/MAC).
- Mouse **B** compatível com Bluetooth Low Energy HID, **não presente em SAVED DEVICES**, com bateria e modo pairing ativo. Anotar modelo de B (sem serial/MAC).
- Verificar visualmente que Pico 2 W iniciou em **HOME CONNECTED** com o firmware v3.2.3. Não usar `flash_nuke`, não apagar bonds nem resetar perfis.
- **Importante:** se B for pareado com sucesso, ele passa a ser salvo e não serve mais de “B inédito” no próximo cenário. Usar outra identidade genuinamente nova ou remover **somente B** via fluxo oficial SAVED DEVICES, nunca A; registrar essa ação para preservar a comparabilidade.

## Sequência mínima (iniciar na HOME CONNECTED)

1. **A conectado; B novo em pairing:** na HOME CONNECTED, selecionar `PAIR NEW MOUSE`. Colocar B em modo pairing imediatamente (janela **15 s**), continuar movimentando A. Registrar hora/segundos aproximados, se A funciona durante busca, qual tela aparece e se houve troca para B. Não pressionar B nem realizar reset destrutivo.
2. **A conectado; timeout sem B:** navegar outra vez até PAIR NEW e **não** anunciar B. Após 15 s, observar `NEW MOUSE NOT FOUND`/RETRY e confirmar que A continua comandando USB.
3. **A conectado; cancelamento:** entrar em PAIR NEW e pressionar `KEY B` antes do timeout; confirmar retorno e A operacional.
4. **A desconectado; mesmo B genuinamente novo em pairing:** usar fluxo normal de desconexão/espera previsto pela UI, entrar em PAIR NEW e repetir na mesma distância, baterias e janela. Registrar sucesso/falha. **Não chamar o teste comparativo válido** se B foi salvo no cenário 1 sem restaurar as pré-condições.
5. **B previamente salvo:** apenas se já existir B em SAVED DEVICES, anunciar B em Pair New. Esperado: ignorar B salvo. Não chamar isso de falha de dispositivo novo.
6. **Repetição controlada:** repetir somente cenários falhos após reinicialização normal (sem apagar flash); anotar número de tentativas, modelo e condição de conexão de A/B.

## Quadro de registro — preencher após observação

| Cenário | Resultado observado | A permaneceu USB? | B ainda inédito? | Tempo/status | Evidência |
|---|---|---|---|---|---|
| 1. A conectado + B novo | PENDING | PENDING | PENDING | PENDING | Nenhuma ainda |
| 2. A conectado + sem B | PENDING | PENDING | não aplicável | PENDING | Nenhuma ainda |
| 3. A conectado + cancelar | PENDING | PENDING | não aplicável | PENDING | Nenhuma ainda |
| 4. A ausente + B novo | PENDING | não aplicável | PENDING | PENDING | Nenhuma ainda |
| 5. B já salvo (controle) | PENDING | PENDING | não | PENDING | Nenhuma ainda |
| 6. Repetição | PENDING | PENDING | PENDING | PENDING | Nenhuma ainda |

## Decisão após os resultados físicos

- **A conectado falha, A ausente funciona, B comprovadamente novo:** problema no caminho concorrente *reproduzido*, mas **a causa raiz ainda não está provada**. Inspecionar primeira etapa divergente com instrumentação reversível antes de decidir correção.
- **Funciona com A conectado:** registrar **NOT REPRODUCED** ou intermitência; não introduzir mudança em firmware.
- **B já salvo/incompatível/sem advertising:** comportamento de filtro pode ser correto; corrigir condição experimental.
- **Ambos falham:** investigar B, timing, pairing e HOGP antes de atribuir falha à coexistência.

## Se a reprodução exigir instrumentação

Não alterar o código funcional. Definir build diagnóstica separada, proveniente da tag v3.2.3, com observações mínimas por estágio: requisição UX, consumo no event loop, `start_pair_new` e motivo de recusa, scan/adv, filtros (saved/appearance/HID), `gap_connect` + status, eventos SM/security, GATT/HIDS, parser, timeout e handoff. Capturar dados sem endereços completos, sem IRK; usar caminhos de debug já disponíveis **sem adicionar interface USB persistente**. Registrar SHA/CI/UF2 e rollback **antes** de flash. Somente se a evidência física demandar; não gerar patch especulativo.

**Entrega ao operador:** resultados dos cenários 1 e 4 primeiro; depois 2 e 3 para verificar preservação de A. A Parte 1 terminará com `part-1-root-cause.md` atualizado para CONFIRMED/NOT REPRODUCED/INCONCLUSIVE/ENVIRONMENTAL e justificativas. A Parte 2 ficará bloqueada até o aceite desse relatório.
