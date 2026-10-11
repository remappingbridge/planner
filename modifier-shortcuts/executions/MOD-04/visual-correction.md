# MOD-04 — Correção após teste físico (quatro bugs de interface)

**Situação:** CORREÇÃO ACEITA pelo operador em 2026-10-11; MOD-05 autorizado. Commit corrigido `1147e79cb80d23412488cd10e92f14a9f75f26a5`.

## Defeitos informados pelo operador

1. Ao confirmar `MODIFIER` em uma das cinco telas `WILL BECOME`, a linha correspondente em `EDIT CUSTOM REMAP` aparecia como `LEFT IS` / `MIDDLE IS` sem o nome MODIFIER.
2. `JOY PRESS` estava aplicando nas telas `WILL BECOME`, mas somente `KEY A: APPLY AND BACK` deve pedir gravação e voltar após sucesso; `KEY B` cancela; `KEY Y` continua com o fluxo global Lock/Unlock que retorna à HOME. `JOY UP/DOWN` continuam sendo navegação de seleção, os outros botões não gravam.
3. Após `KEY A: APPLY CUSTOM`, a tela `EDIT CUSTOM REMAP` apresentava `JOY PRESS: ACCESS`, mas ocultava a dica `KEY B: BACK`.
4. Após alterar o alvo em uma `WILL BECOME` (p.ex. MIDDLE de FORWARD para BACKWARD), duas opções ficavam em ciano, quando só a opção atualmente confirmada deve receber o indicador ciano. Seleção branca tem precedência.

## Diagnóstico e correção

- A tabela em `src/renderer/profile_feedback.c` tinha seis entradas e não incluía MODIFIER ID 6. Agora há função explícita de nomes com os sete IDs, incluindo o legado ESCAPE para leitura e MODIFIER para o novo alvo. `EDIT CUSTOM` mostra ` LEFT IS MODIFIER` etc.
- `src/ux_model/ux_model.c`: `WILL BECOME` só gera `BLU2USB_UX_COMMAND_CUSTOM_SET_TARGET` em `KEY A`. O retorno visual continua subordinado ao sucesso da transação de flash; `JOY PRESS` não aplica nem retorna.
- `src/renderer/renderer.c`: em estado Custom aplicado e sem rascunho pendente, a linha 8 apresenta `KEY B: BACK`; o rodapé pré-aplicação permanece `KEY A: APPLY CUSTOM`. `profile_feedback.c` não apaga mais a linha 8.
- `src/renderer/renderer.c` remove sua regra de ciano `WILL BECOME` duplicada. `profile_feedback.c` se torna fonte única das seis linhas: primeiro deixa todas em cinza acionável, põe exclusivamente a linha atual em ciano (mapeamento LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD/MODIFIER → 1/2/3/4/5/6), depois destaca a seleção em branco. O valor anterior perde a cor ciano imediatamente após compromisso gravado.
- Novo `tests/test_mod04_ui_bugfix.c` verifica **todos os cinco** resumos `... IS MODIFIER`, todos os cinco menus bloqueando JOY PRESS, cancelamento e retorno após Lock/Unlock, dicas após APPLY CUSTOM e cenário FORWARD→BACKWARD→MODIFIER com uma única linha ciano. `-UNDEBUG` garante execução dos assertions mesmo na CI Release.
- Sem alterações no layout dos atalhos, engine de execução HID, armazenamento/bonds Bluetooth ou Movement.

## Próximo ensaio físico (HOME conectada)

1. Testar sequencialmente as cinco fontes como `MODIFIER`, confirmando `LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD IS MODIFIER` no `EDIT CUSTOM REMAP`.
2. Nas cinco `WILL BECOME`, `JOY PRESS` não pode sair nem salvar; `KEY B` deve cancelar; `KEY A` aplicar e voltar **após confirmação de armazenamento**.
3. Após `KEY A: APPLY CUSTOM`, verificar as duas dicas `JOY PRESS: ACCESS` e `KEY B: BACK`.
4. Em `MIDDLE WILL BECOME`, confirmar FORWARD, reabrir e confirmar BACKWARD; ao reabrir, somente BACKWARD deve estar ciano, FORWARD não. A linha selecionada continua branca.
5. Verificar `KEY Y` Lock e unlock com retorno à HOME, máscaras UNAVAILABLE, reconexão Bluetooth e configurações anteriores.

**Aceite:** operador confirmou explicitamente «gate aceito. prossiga» após o novo UF2 de produção e checklist físico. O firmware original MOD-04 em [candidate.md](candidate.md) é antecedente, não serve para validar as correções.

## Compilação corretiva verificada

- **Commit exato:** [`1147e79cb80d23412488cd10e92f14a9f75f26a5`](https://github.com/remappingbridge/remappingbridge/commit/1147e79cb80d23412488cd10e92f14a9f75f26a5), branch `feature/modifier-shortcuts-mod04`, draft PR #24. O arquivo de documentação do próprio firmware também foi corrigido para especificar que `JOY PRESS` não aplica.
- **CI:** [`BLU2USB Canonical CI #312`](https://github.com/remappingbridge/remappingbridge/actions/runs/38146526719), `host-architecture` SUCCESS, **66/66 CTests PASS** com asserts ativos em Release; `pico2-w-production` SUCCESS.
- **Artifact oficial:** [Pico 2 W production UF2](https://github.com/remappingbridge/remappingbridge/actions/runs/38146526719/artifacts/11704518123), artifact ID `11704518123`.
- **Firmware extraído:** `blu2usb_picow.uf2`, **936.960 bytes**, SHA256 **`a93cb3ec8b1289ad87e48b2f03ce4e1830589cc538fe3122a6fa24f98daf41f0`**, confirmado independentemente no container contra o job log.
- **SHA256 do ZIP** `e2af90a3dff42d40ac9fe183fe7eaa2ad4a94aa6548784c2be5109cf57d8e543` (não confundir com hash do UF2).
- Arquivo nomeado para entrega ao operador: `remappingbridge-mod04-corrigido-pico2w.uf2`, byte a byte igual ao UF2 oficial.
- **Estado:** correção CI 66/66 e UF2 aprovada fisicamente pelo operador; MOD-05 desbloqueado. Não foram fornecidos screenshots/medições individuais.
