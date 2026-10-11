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
