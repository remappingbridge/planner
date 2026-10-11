# MNT-01 — release oficial RemappingBridge v3.0.1

**Status: PUBLICADA E VERIFICADA, 2026-10-11.**

- Operador aceitou o MNT-01 corrigido: [operator-acceptance.md](operator-acceptance.md).
- PR [#31](https://github.com/remappingbridge/remappingbridge/pull/31) mesclado com squash em main.
- **Tag `v3.0.1` = main = commit `b776fec2cf2c89788d1bdfed7aa257aa766f2dc6`**: verificado via API GitHub `git/ref/tags/v3.0.1`.
- [GitHub Release v3.0.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.1) publicada e não prerelease às 22:30:27 UTC.
- [Workflow release v3.0.1](https://github.com/remappingbridge/remappingbridge/actions/runs/38180559115) `release-v3` SUCCESS; recompilou host (81/81 tests PASS) e Pico 2 W do commit exato de main.
- [UF2 oficial](https://github.com/remappingbridge/remappingbridge/releases/download/v3.0.1/remappingbridge-v3.0.1-pico2w.uf2): **945152 bytes**, SHA256 `c7ec5c2a3ef0c91af3aaec4ff27b1f86695a79cbaef1baac844a42f90ea1389f`, coincidente com log SHA256SUMS e digest do GitHub asset.
- [SHA256SUMS.txt](https://github.com/remappingbridge/remappingbridge/releases/download/v3.0.1/SHA256SUMS.txt) presente, tamanho 100 bytes, digest SHA256 `de61b68af52b5d96bdebfd69c1bf46500d7c2eede4d6811d1fb367f648a68456`.
- CI de PR do commit final versionado: [#442](https://github.com/remappingbridge/remappingbridge/actions/runs/38180375747), host 81/81 + Pico produção PASS.
- Diagnósticos de versionamento corrigidos **antes da publicação**: `BLU2USB_VERSION_STRING` deve coincidir com projeto CMake; verificação arquitetural G06 agora é independente de versão fixa.
- O UF2 de release tem SHA diferente do candidato por conter firmware versionado **3.0.1**, como esperado.
- **MNT-02 autorizado e iniciado somente a partir da tag oficial v3.0.1**, não do antigo branch/UF2 MNT-01.

Nenhuma melhoria dos gates MNT-02..11 está incluída no release v3.0.1.
