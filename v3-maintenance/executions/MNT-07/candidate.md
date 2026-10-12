# MNT-07 — candidato LCD ciano claro

- **Estado:** PR aberto draft e candidato pronto; teste físico e aceite pendentes.
- Base do gate: commit exato `324e60613b33a960486c7ab29bed6ba01aac717c`, correspondente à tag verificada [`v3.1.1`](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.1.1).
- Branch: `maintenance/v3x-mnt-07`, commit `930796758bb6874c35e26b5c36b0247156420158`.
- [PR #37](https://github.com/remappingbridge/remappingbridge/pull/37).
- CI #483: https://github.com/remappingbridge/remappingbridge/actions/runs/38185229845 — **87/87 testes host PASS**, **Pico 2 W produção SUCCESS**.
- UF2 candidato: `remappingbridge-mnt07-pico2w.uf2`, 945152 bytes, SHA256 **`2c4c4637746b432330a3a2b057c992fea3c3eb5f93be6fb8c2c5ab16be6a4324`**, arquivo extraído do artifact 11719008551 e comparado com hash no log CI.
- Versão interna do firmware permanece **3.1.1** (candidato), não é a release 3.1.2.
- Alteração exclusivamente de token: `BLU2USB_COLOR_CYAN = 0xBFFF`, atual era 0x07FF; os demais tokens permanecem intactos. Aprovação da aparência e contraste pendente do operador.
- Futuro release v3.1.2 PATCH somente após aceite físico explícito.

## Revisão de cor solicitada pelo operador
O operador avaliou o primeiro ciano `0xBFFF` como razoável, mas pediu um tom mais fraco e próximo do cinza claro padrão. A branch e o PR #37 foram atualizados com **`BLU2USB_COLOR_CYAN = 0xB65A`** (R 22/31, G 50/63, B 26/31). Comparação: cinza claro do sistema `0xC618` (R 24/31, G 48/63, B 24/31). Assim o destaque mantém leve tendência ciano, com luminosidade próxima do cinza. Teste host 87/87 passou no workflow #484. Artefato e hash do candidato anterior estão obsoletos; validar somente o novo UF2 do commit `902a0e06d8801971d6e85981b1d73c121cfecd4d`.

## Novo UF2 revisado — válido para teste físico
- Commit `902a0e06d8801971d6e85981b1d73c121cfecd4d`; PR #37 permanece draft.
- CI [#484](https://github.com/remappingbridge/remappingbridge/actions/runs/38185774233): **87/87 testes host PASS** e **Pico 2 W production SUCCESS**.
- Artifact ID `11719059430`; firmware `remappingbridge-mnt07-muted-cyan-pico2w.uf2`, **945152 bytes**.
- SHA-256 do UF2: `1ffb230f36e9c84ede884ba06c5b254c7a5b9fdfe85ced90c6efec32590d2dfa` — conferido localmente e comparado ao log de produção GitHub Actions.
- Cor revisada `0xB65A`; contraste/aceite físico continuam pendentes. Substitui integralmente o firmware MNT-07 anterior (`0xBFFF`).

## Segunda revisão do ciano: ciano pastel sem escurecer
O operador rejeitou o candidato `0xB65A` como muito escuro; solicitou retornar ao estilo do primeiro ciano `0xBFFF`, porém ainda mais fraco. Portanto, a fonte na mesma branch MNT-07 usa agora **`0xD7FF` (RGB565 R=26/31, G=63/63, B=31/31)**: a componente vermelha sobe de 23 para 26, enquanto verde e azul permanecem máximos, reduzindo a saturação e aumentando a claridade. O cinza padrão `0xC618` não foi alterado. Teste automatizado atualizado para validar preservação de brilho e semântica. Commit `091716c1476e81690ddaebe7309e09d026e4b652`; execução CI [#486](https://github.com/remappingbridge/remappingbridge/actions/runs/38186522000). **Os candidatos MNT-07 anteriores (0xBFFF e 0xB65A) estão substituídos.** Nenhum aceite físico foi informado para esta revisão.

## Candidato vigente para teste — ciano pastel 0xD7FF

**Este é o único candidato MNT-07 válido agora; os anteriores estão substituídos.**

- Código: commit `091716c1476e81690ddaebe7309e09d026e4b652`, mesma branch `maintenance/v3x-mnt-07` e [PR #37](https://github.com/remappingbridge/remappingbridge/pull/37).
- Cor RGB565 `BLU2USB_COLOR_CYAN = 0xD7FF`, tom claro e menos saturado que `0xBFFF`, sem a perda de brilho observada com `0xB65A`.
- [CI #486](https://github.com/remappingbridge/remappingbridge/actions/runs/38186522000): **87/87 testes host aprovados**; **build produção Pico 2 W aprovado**.
- Artefato de firmware Actions: `11720106308`, arquivo `blu2usb_picow.uf2`; arquivo entregue ao operador como `remappingbridge-mnt07-pastel-cyan-pico2w.uf2`.
- Tamanho: **945.152 bytes**.
- SHA-256 do UF2: `f72a20c54666d09f13d9f18486a0258d4a2d0948bf1c79b0e7ea918674065d9a`. Hash do arquivo extraído **igual ao registrado no log de produção**.
- Status: **aguardando teste e aceite físico**, **sem publicação v3.1.2**.
