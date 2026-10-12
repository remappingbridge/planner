# MNT-09 — publicação v3.1.4

**Status: GATE ACEITO E TAG v3.1.4 VERIFICADA.** O operador aceitou MNT-09 em 11/10/2026.

- PR [#39](https://github.com/remappingbridge/remappingbridge/pull/39) mesclado por squash, commit `9efaaaa17b5ab94a9b28927460fd5720787a74dc` na `main`.
- Tag [v3.1.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.1.4) confirmada no GitHub: `CMakeLists.txt` na tag possui versão **3.1.4**.
- Código final da branch antes do merge `7a6ce96524f81db41a4edf44c519f40685ac7932`, com `docs/releases/v3.1.4.md`, workflow `.github/workflows/release-v3.1.4.yml` e teste `test_bootstrap.c` na mesma versão.
- [CI versionada #507](https://github.com/remappingbridge/remappingbridge/actions/runs/38188735880): testes host **PASS**, build Pico 2 W produção **SUCCESS**. Artefato de produção `11719784829`, SHA256 do UF2 no log `0cdf5e59684526783155eae89dbf7ac16ca8148a3e9cb87b142f339a3e0bf8c9`. Esse hash refere-se **à build do branch antes do squash**, não é atestado de identidade binária do asset final publicado pelo workflow de release.
- Gate seguinte: **MNT-10 NOVO**, planejado para limpeza integral de dispositivo removido. MNT-11 permanece nome BLE e MNT-12 é o antigo diagnóstico Zoom.
- Ainda não foi conferido separadamente o hash do asset da página de Release oficial; tag, versão e workflow de publicação estão verificados.
