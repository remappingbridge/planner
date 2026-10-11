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
- Uma única regra `is_help` cobre 10 Helps. KEY B retorna, Y bloqueia sem sair, o evento usado para desbloquear é consumido e retorna à HOME pelo fluxo global; A, X e JOY não modificam estado nem iniciam comandos.
- Os 10 templates de Help exibem `KEY B: BACK` na última linha, sem `ANY KEY: BACK`.
- Salvos seleção, tela de retorno e bond da remoção. Não foram alterados persistência, BLE, HID/USB, Movement ou Modifier.
- Teste novo `tests/test_mnt05_help_lock.c` cobre todos os Helps, os sete controles inertes, lock/unlock universal para HOME, B e retorno seguro; testes herdados preservados e adaptados às novas regras.

## Teste físico
Executar [physical-acceptance.md](physical-acceptance.md) desde HOME CONNECTED e verificar as telas e retorno. **Não publicar v3.1.0 nem iniciar MNT-06 antes do aceite explícito.**

## Correção posterior ao candidato inicial
Por solicitação do operador, foi removida a exceção `if (!is_help(ux->screen))` no tratamento global de `BLU2USB_INTERACTION_UNLOCK`. Agora toda tela, incluindo Help, retorna à HOME ao desbloquear, sem workaround exclusivo. O UF2 e o SHA acima correspondem ao candidato **anterior** e não devem ser usados para testar esta revisão; aguardar artefato da CI 473 para a revisão atual.

## Candidato corrigido — desbloqueio global para HOME
- Fonte: [commit 308e6a266000e1c1babb5d385bd102dff75330f5](https://github.com/remappingbridge/remappingbridge/commit/308e6a266000e1c1babb5d385bd102dff75330f5), branch MNT-05.
- [CI #473, run 38184271662](https://github.com/remappingbridge/remappingbridge/actions/runs/38184271662): host 85/85 PASS e Pico 2 W produção SUCCESS.
- Artifact de produção ID `11718792476`, arquivo `blu2usb_picow.uf2`, 945152 bytes, SHA256 `fb862630cd367f03d83d2914480706cde409832f5dade91096bfb79fab00fd31` confirmado com log de produção.
- Código remove apenas a guarda `!is_help(ux->screen)` do caminho global de unlock; KEY Y segue bloqueando a partir de Help, desbloqueio sempre retorna HOME. Sem nova tela, estado ou workaround.
- **Este substitui todos candidatos MNT-05 anteriores**. Versão embarcada ainda 3.0.4; v3.1.0 permanece condicionada ao aceite físico.
