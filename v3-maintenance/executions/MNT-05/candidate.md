# MNT-05 — candidato UF2 pronto para validação física

**STATUS: CI COMPLETA / 85 DE 85 TESTES HOST PASS / PICO 2 W PRODUÇÃO SUCCESS. ACEITE FÍSICO PENDING.**

## Proveniência
- Base: tag oficial `v3.0.4`.
- Branch: [maintenance/v3x-mnt-05](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-05).
- Commit exato: [dcf0010f164e3bfd079fd36c077e481ed40a1c53](https://github.com/remappingbridge/remappingbridge/commit/dcf0010f164e3bfd079fd36c077e481ed40a1c53).
- [PR #35 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/35) (não mesclado).
- [CI #471, run 38183600188](https://github.com/remappingbridge/remappingbridge/actions/runs/38183600188): host-architecture **85/85 PASS**, pico2-w-production **SUCCESS**.
- Artifact de produção GitHub Actions ID `11718766410`, digest ZIP `sha256:ce57354e1d09293a6f71df500d2d8c3f9546287127ce80551f7e6dd061775624`.
- Binário extraído: `remappingbridge-mnt05-pico2w.uf2`, **944640 bytes**, SHA256 `ba451e97766499813153203836e2d5244ee77302f367c084c73e21989ab859f6` verificado contra log da CI.
- Versão embarcada **3.0.4** (candidato). Somente após aceite físico criar versão oficial **v3.1.0 MINOR**.

## Implementação
- Uma única regra `is_help` cobre 10 Helps. KEY B retorna, Y bloqueia sem sair, o evento usado para desbloquear é consumido e conserva Help; A, X e JOY não modificam estado nem iniciam comandos.
- Os 10 templates de Help exibem `KEY B: BACK` na última linha, sem `ANY KEY: BACK`.
- Salvos seleção, tela de retorno e bond da remoção. Não foram alterados persistência, BLE, HID/USB, Movement ou Modifier.
- Teste novo `tests/test_mnt05_help_lock.c` cobre todos os Helps, os sete controles inertes, lock/unlock, B e retorno seguro; testes herdados preservados e adaptados às novas regras.

## Teste físico
Executar [physical-acceptance.md](physical-acceptance.md) desde HOME CONNECTED e verificar as telas e retorno. **Não publicar v3.1.0 nem iniciar MNT-06 antes do aceite explícito.**
