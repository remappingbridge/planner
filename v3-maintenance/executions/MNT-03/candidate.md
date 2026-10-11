# MNT-03 — candidato de firmware para teste físico

**STATUS: CANDIDATO PRONTO — CI HOST 83/83 PASS + PICO 2 W PRODUÇÃO PASS; ACEITE FÍSICO PENDING** (2026-10-11).

## Proveniência
- Baseline: [release/tag oficial v3.0.2](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.2), SHA `4ac38c50b8ad96c4d8b7fc7d80033c7a97807300`.
- Branch [`maintenance/v3x-mnt-03`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-03), commit exato [`4af26e01c2fbc844a48c0483d43298f8ede8a98e`](https://github.com/remappingbridge/remappingbridge/commit/4af26e01c2fbc844a48c0483d43298f8ede8a98e).
- [PR #33 **DRAFT**](https://github.com/remappingbridge/remappingbridge/pull/33), não mesclado.
- [CI #453 / run `38182141370`](https://github.com/remappingbridge/remappingbridge/actions/runs/38182141370): `host-architecture` **SUCCESS**, **83/83 CTests PASS**, `pico2-w-production` **SUCCESS**.
- Artifact CI oficial [`11718640452`](https://github.com/remappingbridge/remappingbridge/actions/runs/38182141370/artifacts/11718640452), ZIP digest SHA256 `ea9926ea62ac37791b6e3ee83790489c2cbc1cc9125357ad0b764d9ea0404921`.
- **UF2 extraído e verificado localmente** contra o log de `sha256sum build-pico/blu2usb_picow.uf2`: `f3b7c0c387f589be3cf9fab6006427c575f86a0c1865f324f59e3ee3c40ee74d`, 945152 bytes.
- Nome de arquivo para entrega: `remappingbridge-mnt03-pico2w.uf2`, cópia binariamente idêntica ao artifact de produção.
- A versão embarcada no candidato ainda é **3.0.2**. Tag/release futura v3.0.3 somente depois de aceite explícito.

## Implementação
- `src/renderer/renderer.c`: helper `movement_summary_gain_name` deriva os valores da rotina canônica e retira apenas o `X` final **para as linhas 1 e 2 do resumo MOVEMENT OPTIONS**. Spans dinâmicos cianos preservados com comprimento corrigido, colunas 16 e 14. Grade 9×21, título magenta, rotação e foco inalterados.
- `src/ux_model/ux_model.c`: template estático MOVEMENT OPTIONS atualizado para o novo texto default ` HORIZONTAL DPI 1` e ` VERTICAL DPI 1`.
- Testes herdados MOV-01, MOV-02, MOV-03, MOV-04, MOV-05, MOV-06 e MOV-07 atualizados para o novo texto sem desativar as demais asserções.
- Teste novo `tests/test_mnt03_movement_summary_dpi.c`: todas **64 combinações** dos oito níveis de ganho H×V, com tons cianos, ausência de `X` nas duas linhas, preservação das legendas com `x` em Slow/Fast e do formato Saved Devices.
- **Nenhuma modificação da matemática de ganho**, zoom, dados BLE/USB, schema flash, perfil, teclas ou outros textos.
- MNT-01 cores e MNT-02 KEY X Help/KEY Y Lock permanecem disponíveis.

## Gate físico
Seguir [physical-acceptance.md](physical-acceptance.md) começando em HOME CONNECTED, comprovando que o resumo mostra números sem X enquanto as telas Slow/Fast ainda mostram x, Movimento/Rotation continuam corretos e Saved Devices/Remove This não regrediram.

**PENDING: usuário ainda não confirmou o aceite físico. Não publicar v3.0.3 ou implementar MNT-04.**
