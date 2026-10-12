# MNT-12 — publicação v3.2.2

**STATUS: ACEITO E PUBLICADO.** O operador declarou **"gate aceito"** em 12/10/2026 e autorizou encerrar o MNT-12, sem implementar outros gates.

- PR [#42](https://github.com/remappingbridge/remappingbridge/pull/42) integrado à `main` via squash — commit **`0d35397e6a1619f2a5dc314d0f2659206912d177`**.
- Tag oficial **[v3.2.2](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.2)** conferida com commit **`0d35397e6a1619f2a5dc314d0f2659206912d177`**. A tag contém `project(blu2usb_picow VERSION 3.2.2 ...)` e `BLU2USB_VERSION_STRING="3.2.2"`.
- Candidato fisicamente aceito: `maintenance/v3x-mnt-12` commit `2b3180810bd939ef7c3863e01c903fea7b700d26`; [CI #541](https://github.com/remappingbridge/remappingbridge/actions/runs/38249366464) **94/94 testes host e build Pico 2 W produção PASS**. SHA-256 **do UF2 candidato**, não do asset final: `f1eb915180809f52d0e4bfde6a9b8a41a45e037664a7d282f5c97b0be5166c76`.
- [CI versionada #545](https://github.com/remappingbridge/remappingbridge/actions/runs/38251135767) com **host SUCCESS e Pico 2 W production SUCCESS** após bump 3.2.2, antes do merge.
- Fontes versionadas: `CMakeLists.txt`, `tests/test_bootstrap.c`, `README.md`, `docs/releases/v3.2.2.md` e `.github/workflows/release-v3.2.2.yml`. O workflow de publicação recompila UF2 versionado e entrega checksums; não atribuir SHA do candidato ao artefato final sem nova conferência.
- Funcionalidade: indicador ciano (normal 0x07FF; selecionado 0xD7FF) em MODIFIER SHORTCUTS e somente valores atribuídos/disponíveis nas seis páginas COMBINATIONS, exclusivamente para CUSTOM aplicado com Modifier efetivo.
- **Nova ordem após aceite:** MNT-13 (seta `>` na primeira coluna, apenas planejado), MNT-14 (PAIR NEW, duas partes preservadas, não iniciado) e MNT-15 (Zoom/Obsidian, suspenso). **Nenhum foi implementado**.

**Gate MNT-12 encerrado.**
