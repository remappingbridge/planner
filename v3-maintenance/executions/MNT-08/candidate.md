# MNT-08 — firmware candidato com seleção ciano normal

**STATUS: IMPLEMENTADO, CI COMPLETA / 89 DE 89 TESTES HOST PASS / PICO 2 W PRODUÇÃO SUCCESS. ACEITE FÍSICO PENDING.**

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
