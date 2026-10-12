# MNT-10 — release oficial v3.2.0

**ACEITO fisicamente, integrado e publicado.** O operador declarou `gate aceito. prossiga` em 11/10/2026 e autorizou publicação.

- PR [#40](https://github.com/remappingbridge/remappingbridge/pull/40) mesclado por squash à `main` — commit **`3d7c196ffa0fbda935a77ae0f386d39b2b293d2c`**.
- Tag oficial [v3.2.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.0) **verificada** em `CMakeLists.txt`, com versão `3.2.0`.
- CI do candidato aceito [#526](https://github.com/remappingbridge/remappingbridge/actions/runs/38190069355): **92/92 testes host e Pico 2 W produção aprovados**, SHA256 UF2 candidato `3f73e648134eb613b067f25eb34a4f9a21bf0a2abb029919ad73ec0ad7826dc7` (este hash não deve ser atribuído ao UF2 final recompilado da release sem verificar o asset).
- CI de versionamento [#530](https://github.com/remappingbridge/remappingbridge/actions/runs/38190588302): **host e Pico 2 W production SUCCESS** antes do merge.
- Metadados: `CMakeLists.txt`, `tests/test_bootstrap.c`, `README.md`, `docs/releases/v3.2.0.md` e `.github/workflows/release-v3.2.0.yml` foram preparados no PR aceito.
- Migração de perfil global pré-v3.2.0 para registros individualizados de mouse, preservação de outros dispositivos e novo pareamento em defaults. Não reivindicar exclusão forense física dos bytes flash antigos.
- Próximo gate liberado: **MNT-11 (nomes BLE)**, base branch do commit de publicação e tag v3.2.0.
