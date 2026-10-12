# MNT-12 — candidato de firmware para teste físico

**STATUS: IMPLEMENTADO, CI completa PASS, UF2 PRODUÇÃO CONFIRMADO — ACEITE FÍSICO PENDING.** Não houve merge, nova tag ou release. Firmware segue com versão interna **3.2.1** até aprovação física explícita. **MNT-13 e MNT-14 não iniciados por esta entrega.**

- Baseline da branch: tag oficial `v3.2.1`, commit **`3846e8f4ee5fba40421c0db1f51387de6c51e953`**, confirmado antes do início.
- Branch: `maintenance/v3x-mnt-12`; HEAD do candidato **`2b3180810bd939ef7c3863e01c903fea7b700d26`**.
- [PR #42 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/42), não aprovado para merge/publicação.
- [GitHub Actions CI #541](https://github.com/remappingbridge/remappingbridge/actions/runs/38249366464): **94/94 testes host PASS; build Pico 2 W produção SUCCESS**, ambos no mesmo commit acima.
- Artefato GitHub Actions `11747317102`, `blu2usb-picow-production-pico2w`. SHA256 do **ZIP** `24dd653edee25b5b0dde0225ab846f50083ad908b11d50806b69ce9c1bfa6f2d` (não confundir com o UF2).
- UF2 extraído e validado: `remappingbridge-mnt12-modifier-cyan-pico2w.uf2`, **952.320 bytes**, SHA256 **`f1eb915180809f52d0e4bfde6a9b8a41a45e037664a7d282f5c97b0be5166c76`**; hash **idêntico ao output `sha256sum build-pico/blu2usb_picow.uf2` do job oficial `pico2-w-production`**.

## Mudanças incluídas

1. **Um predicado sem persistência:** `blu2usb_ux_modifier_shortcuts_active(ux)` retorna TRUE somente para perfil efetivamente `CUSTOM REMAPPING` mais `modifier_source` válido (0..4), lido de config Custom aplicada. PASSTHROUGH com Custom salvo contendo Modifier e CUSTOM sem Modifier retornam FALSE.
2. `src/renderer/profile_feedback.c`: recompõe REMAPPING OPTIONS; linha `MODIFIER SHORTCUTS` só adquire CURRENT com predicado TRUE, e SELECTED_CURRENT em foco. Demais itens continuam com contrato MNT-08 de perfil ativo.
3. `src/renderer/renderer.c`: na projeção de COMBINATIONS 1..6, após reset dos dois pares e antes do foco, aplica CURRENT **somente** a valores dos índices 2 e 4 quando atalho é atribuído, predicado TRUE e `blu2usb_ux_combination_unavailable(...)` é FALSE. Foco transforma para SELECTED_CURRENT; a restauração final de UNAVAILABLE como STATIC segue intacta, inclusive sob seleção. Linha de rótulo não recebe novo ciano.
4. `tests/test_mnt12_modifier_cyan.c`: percorre as quatro combinações de perfil × Modifier, foco da terceira opção, todos os 12 slots nas seis telas e ambos os focos, UNAVAILABLE com atalho armazenado, NOT CUSTOMIZED, RESET → reatribuir, draft sem APPLY, switching de perfil/mouse na UX, e efeitos invariantes na lista SHORTCUTS e na paleta.
5. As implementações modificaram apenas `include/blu2usb/ux_model/ux_model.h`, `src/ux_model/ux_model.c`, `src/renderer/profile_feedback.c`, `src/renderer/renderer.c` e adição/registro de teste. Sem alteração no BLE/USB/storage/paleta ou textos das telas.

## Teste manual e aceite

O operador precisa gravar UF2 por BOOTSEL **sem `flash_nuke`** e executar as verificações no [roteiro físico](physical-acceptance.md). Confirmar principalmente `MODIFIER SHORTCUTS` em CUSTOM+Modifier aplicado, contrastar PASSTHROUGH com Modifier salvo, testar `UNAVAILABLE` e `NOT CUSTOMIZED` na seleção, conferir todas as páginas e alternância de mouse/reboot.

**Gate MNT-12 aguarda aceite físico.** PATCH provável **v3.2.2**, somente depois de aceite e nova CI do código efetivamente versionado, merge e GitHub Release. Hash do candidato não deve ser atribuído a futuro asset recompilado de release sem verificação independente.
