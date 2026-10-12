# MNT-08 — histórico e candidato vigente

**ATENÇÃO: o candidato descrito nesta seção está OBSOLETO e não deve ser testado.** Foi substituído por uma revisão que inverte o papel dos dois cianos, conforme pedido expresso do operador. MNT-08 ainda aguarda aceite físico.

- Base imutável: release oficial **v3.1.2**, commit `9ccc3f38b1bb697546d756f2fca3475d33204f2a`. MNT-07 está formalmente aceito para versão, mas seu aceite físico final será concluído junto com MNT-08.
- Branch: `maintenance/v3x-mnt-08`, HEAD do candidato `c858938e51f8cf4f713def2e9fd6d778ccec3032`.
- PR draft: https://github.com/remappingbridge/remappingbridge/pull/38
- CI completa: https://github.com/remappingbridge/remappingbridge/actions/runs/38187193897 (run #495), **89/89 host PASS**, **Pico 2 W production SUCCESS**.
- Artifact Actions: id `11719648221`, `blu2usb-picow-production-pico2w`.
- UF2 entregue no chat: `remappingbridge-mnt08-focused-cyan-pico2w.uf2`, **945152 bytes**.
- SHA-256 UF2: **`346660ea1e7c2bdc0aa981c7b3e9880a8ba141d8089f41634371224bd6626751`**, verificado por `sha256sum` no container e conferido com o log de produção Pico 2 W.

## Alterações
- `BLU2USB_UI_TONE_CURRENT`: ciano pastel **0xD7FF** (mantido de MNT-07).
- Novo `BLU2USB_UI_TONE_SELECTED_CURRENT`: ciano normal **0x07FF**, aplicado apenas a células com papel CURRENT **quando sua opção recebe foco**.
- Função central `blu2usb_ui_tone_on_focus()` preserva cinza→branco em opções padrão e CURRENT→ciano normal em opções selecionáveis.
- `renderer.c` respeita os trechos cianos nas linhas de Movement e foca opções de DPI, Rotation, Shortcuts; `profile_feedback.c` usa a mesma regra em perfis e mapeamentos. Rascunhos não aplicados continuam cinza/branco.
- Nome conectado em SAVED DEVICES continua pastel informativo (não selecionável), demais nomes amarelos, remoção branca, dicas cinzas e título magenta. UNAVAILABLE e hints sem recoloração indevida.
- Inclusos testes C específicos MNT-08 e atualização dos testes herdados que pressupunham branco no item CURRENT selecionado.

## Aceite físico conjunto
Usar `physical-acceptance.md` e conferir cores em hardware real. **MNT-08 ainda NÃO está aceito e v3.1.3 NÃO deve ser publicada**. Quando o operador aceitar o MNT-08, registrar também a conclusão do aceite físico conjunto do MNT-07 e só então criar v3.1.3.

## Inversão dos cianos (nova regra aprovada para implementação, NÃO para aceite físico)
- O operador aprovou a aparência dos tons, mas solicitou **inverter seus papéis**.
- `BLU2USB_UI_TONE_CURRENT` / sem seleção: **ciano normal 0x07FF**.
- `BLU2USB_UI_TONE_SELECTED_CURRENT` / selecionado: **ciano claro pastel 0xD7FF**.
- Cinza comum → branco no foco; CURRENT meramente informativo (nome de mouse conectado em SAVED DEVICES) permanece ciano normal.
- Sem novas cores: somente mapeamento semântico central e testes de paleta modificados; comportamentos e controles não mudam.
- Branch e PR mantidos: `maintenance/v3x-mnt-08`, [#38](https://github.com/remappingbridge/remappingbridge/pull/38).
- Última revisão de fonte: `965aa62aa68069765417a26da56b5a7177617246`; CI [#498](https://github.com/remappingbridge/remappingbridge/actions/runs/38187661315) (89/89 testes host aprovados; compilação Pico 2 W a confirmar no relatório de artefato).
- A versão prevista continua **v3.1.3 após aceite físico conjunto MNT-07/MNT-08**.

## Novo candidato MNT-08 — papéis de ciano invertidos (VIGENTE)

**STATUS: CANDIDATO PRONTO, CI COMPLETA. ACEITE FÍSICO PENDENTE.** Este firmware substitui por completo o primeiro candidato MNT-08 citado acima.

- Branch: `maintenance/v3x-mnt-08`, commit **`965aa62aa68069765417a26da56b5a7177617246`**; [PR #38](https://github.com/remappingbridge/remappingbridge/pull/38) segue draft.
- Valor **CURRENT sem seleção**: RGB565 **`0x07FF`**, ciano normal.
- Valor **SELECTED_CURRENT selecionado**: RGB565 **`0xD7FF`**, ciano clarinho pastel.
- Itens não-CURRENT continuam **cinza/branco**. SAVED DEVICES: o nome do mouse conectado informa CURRENT e fica em ciano normal, não selecionável; nome desconectado amarelo; REMOVE DEVICE branco; dicas cinza.
- [CI #498](https://github.com/remappingbridge/remappingbridge/actions/runs/38187661315): **89/89 testes host aprovados**, **build Pico 2 W produção aprovado**. O teste MNT-07 foi atualizado para verificar que o tom pastel `0xD7FF` permanece na paleta, agora atribuído a SELECTED_CURRENT.
- Artefato GitHub Actions **11720491873** de commit exato; firmware entregue `remappingbridge-mnt08-inverted-cyans-pico2w.uf2`, **945.152 bytes**.
- SHA-256 do UF2: **`05832da337ebdfc03d9a5239154726287d431df59254a28e121131396efbab40`**, aferido no arquivo extraído e conferido igual ao hash dos logs de CI.
- O firmware candidato contém a versão base **3.1.2**. Somente após aceite físico conjunto MNT-07/MNT-08 versionar como **3.1.3** e publicar.
