# MNT-10 — aceite físico do operador

Em 11/10/2026 o operador declarou **"gate aceito. prossiga"** após receber o firmware MNT-10 para teste físico.

**Decisão: MNT-10 ACEITO, versionamento/autorização de publicação v3.2.0 e início do MNT-11 após publicação verificada.** O aceite é global; não inventar resultados individuais de cenários que não foram reportados.

- Branch candidata: `maintenance/v3x-mnt-10`, commit `a4c2bd9e45f08ec748cc40a6281a18b3e11b8ace`.
- PR: [#40](https://github.com/remappingbridge/remappingbridge/pull/40).
- CI candidata [#526](https://github.com/remappingbridge/remappingbridge/actions/runs/38190069355): **92/92 host PASS**, **Pico 2 W produção SUCCESS**.
- SHA256 UF2 candidato aceito: `3f73e648134eb613b067f25eb34a4f9a21bf0a2abb029919ad73ec0ad7826dc7`.
- Mudança de arquitetura: perfis, remap, modifier e atalhos bond-scoped; migração de registro global legado para bonds pré-existentes; re-pareamento pós-exclusão em defaults, Saved Devices exibe perfil específico do mouse.
- Próxima versão deve ser MINOR **v3.2.0**, não v4.0.0, seguindo plano.
