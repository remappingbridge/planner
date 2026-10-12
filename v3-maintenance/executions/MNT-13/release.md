# MNT-13 — release oficial RemappingBridge v3.2.3

**STATUS: ACEITO E PUBLICADO.** Operador declarou **"gate aceito. implemente o proximo"** em 12/10/2026. Publicação automática oficial foi concluída com sucesso.

- [PR #43](https://github.com/remappingbridge/remappingbridge/pull/43) foi mesclado via **squash** na `main`: **`f38c5fd15c68ea9a36d3b05912727788d7b98e81`**.
- Tag [**v3.2.3**](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3) aponta **diretamente ao mesmo commit** `f38c5fd15c68ea9a36d3b05912727788d7b98e81` (sem tag anotada; workflow `gh release create --target` gera tag de commit). GitHub Release ID `410830118`, sucesso.
- [CI final da branch versionada #38280690767](https://github.com/remappingbridge/remappingbridge/actions/runs/38280690767): **96/96 testes host PASS e produção Pico 2 W PASS** no commit pré-merge `03673c48093adf2f5d18b2d9b795b0da75182f23`.
- [Release CI da main #38280962230](https://github.com/remappingbridge/remappingbridge/actions/runs/38280962230): **96/96 testes host PASS**, build Pico 2 W produção PASS, checksum PASS e GitHub Release criada.
- **Assets oficiais:** `remappingbridge-v3.2.3-pico2w.uf2`, **953344 bytes**, [download](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.3/remappingbridge-v3.2.3-pico2w.uf2); `SHA256SUMS.txt`, [download](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.3/SHA256SUMS.txt).
- **SHA-256 do firmware oficial:** `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`, conforme log `sha256sum --check` PASS do workflow da release. Diferente do SHA do UF2 candidato fisicamente aceito `1bac0b9f63dee762ad63e63cdf9b1b6db1193877b3d8e18d92bffc9ce32d93c7`, devido ao bump da versão interna.
- Fontes versionadas: `CMakeLists.txt` declara `project(... VERSION 3.2.3 ...)` e `BLU2USB_VERSION_STRING=\"3.2.3\"`; `tests/test_bootstrap.c` espera `3.2.3`, `README.md`, `docs/releases/v3.2.3.md` e `.github/workflows/release-v3.2.3.yml` no mesmo commit.
- Funcionalidade aceita: marcador de opção focada **pipe `|` na coluna 0**, **na segunda linha de toda opção com duas linhas**, inclusive status/valor das seis páginas COMBINATIONS; não altera o tom de UNAVAILABLE nem as demais regras MNT-12.
- **Gate seguinte autorizado:** **MNT-14**, exclusivamente Parte 1 de investigação da causa raiz PAIR NEW → depois Parte 2 GO/NO-GO/BLOCKED, mediante aceite dos resultados. Parte 2 não significa liberação de patch. **MNT-15** continua suspenso.

**MNT-13 encerrado/publicado; base oficial para MNT-14: `v3.2.3` commit `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.**
