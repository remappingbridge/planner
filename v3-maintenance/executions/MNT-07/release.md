# MNT-07 — publicação v3.1.2

**Status: FORMALLY ACCEPTED, RELEASED; validação física visual final condicionada ao MNT-08.**

- Autorização do operador em 11/10/2026: o MNT-07 está formalmente aceito para versionamento; a aceitação física final será conjunta com o próximo gate.
- Implementação aceita: `BLU2USB_COLOR_CYAN = 0xD7FF` RGB565, ciano pastel claro.
- PR [#37](https://github.com/remappingbridge/remappingbridge/pull/37) integrado via squash; commit de release `9ccc3f38b1bb697546d756f2fca3475d33204f2a`.
- Tag GitHub [v3.1.2](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.1.2) **verificada**, com CMakeLists.txt apontando para versão 3.1.2.
- Documentação de lançamento: `docs/releases/v3.1.2.md`; workflow `.github/workflows/release-v3.1.2.yml` publica UF2 e SHA256SUMS.
- Último candidato antes de versionar: [CI #486](https://github.com/remappingbridge/remappingbridge/actions/runs/38186522000), 87/87 testes host e Pico 2 W produção sucesso.
- Liberação MNT-08 na branch `maintenance/v3x-mnt-08` criada do **mesmo SHA de publicação**.
- Não confundir aceite formal para publicação com registros individuais PASS de testes físicos MNT-07/MNT-08: estes dependem da validação conjunta do operador.
