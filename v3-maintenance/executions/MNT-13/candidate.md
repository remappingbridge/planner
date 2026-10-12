# MNT-13 — candidato de firmware atualizado (pipe na segunda linha)

**STATUS: IMPLEMENTADO / CI COMPLETA PASS / UF2 PICO 2 W VERIFICADO / ACEITE FÍSICO PENDING.** O candidato anterior com `>` está **substituído** por esta revisão com `|`. Ainda não houve merge, tag nova nem release. Firmware conserva a versão interna `v3.2.2` até aceite.

## Fonte e execução oficial

- Base imutável da implementação: [tag `v3.2.2`](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.2), SHA `0d35397e6a1619f2a5dc314d0f2659206912d177`.
- Branch: `maintenance/v3x-mnt-13`; **HEAD final `c1d20493c208651ddac1a433de96d5fc44eedfae`**.
- [PR #43 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/43), sem merge até aceite físico.
- [CI oficial #38257166557](https://github.com/remappingbridge/remappingbridge/actions/runs/38257166557): **96/96 testes host PASS** + **Pico 2 W Release PASS** no mesmo commit do candidato.
- GitHub Actions artifact: **ID 11750892982**, `blu2usb-picow-production-pico2w`.
- UF2 extraído: **`remappingbridge-mnt13-pipe-pico2w.uf2`**, **953344 bytes**; SHA-256 **`1bac0b9f63dee762ad63e63cdf9b1b6db1193877b3d8e18d92bffc9ce32d93c7`**. Hash verificado localmente contra o log de `sha256sum build-pico/blu2usb_picow.uf2` do job oficial (iguais). O ZIP do GitHub Actions não é o UF2.
- Candidato anterior, **SUPERADO**: SHA `e19030b7a721c43ecae172a78be1ab623c86a95c`, CI #38254486989, UF2 `f11285d82c3768bd48c8b91d0614f2d73a2c701f67aea1996a1eed1851c0a3ee`; **não instalar este arquivo para validar a revisão atual**.

## Mudanças no mesmo gate

1. Em `src/renderer/renderer.c`, `blu2usb_ui_apply_selection_marker` mantém o indicador exclusivo na coluna física 0, mas agora utiliza **`|`**, sem criar estado/persistência ou alterar comandos. Um glifo vertical ASCII **`|`** foi adicionado à fonte interna em `glyph_row()` (nenhuma fonte ou dependência externa).
2. **Opção de duas linhas sempre marcada na segunda linha**. Nas seis telas `COMBINATIONS`, o marcador fica na **linha de valor/status 2 ou 4**, e nunca no rótulo 1/3. A seleção lógica, os shortcuts e a coloração MNT-12 permanecem inalterados.
3. Para **UNAVAILABLE** (valor com tom STATIC), o pipe permanece com tom de foco branco herdado do rótulo superior; o valor textual `UNAVAILABLE` conserva seu tom STATIC. Para valores atuais atribuídos e focados, o pipe fica ciano claro, acompanhando o próprio valor.
4. Em `MOVEMENT OPTIONS`, ROTATION continua sendo a segunda linha da opção de duas linhas (índice 4). Nas demais listas de uma linha e em `SAVED DEVICES`, o pipe continua sobre a linha da única opção em foco; telas sem menu não exibem marcador.
5. `src/app/main.c` preserva a ordem `project → enforce_applied_visual_contract → apply_selection_marker → renderer_render`; UX, BLE, HID, armazenamento, textos e arquitetura de display 9×21 continuam intactos.
6. `tests/test_mnt13_selection_marker.c` e `tests/test_mnt13_source.py` cobrem todos os menus, as duas linhas de COMBINATIONS, casos `UNAVAILABLE`/`NOT CUSTOMIZED`/atalho CURRENT, seleção inválida, Saved Devices, idempotência e ordem/glyph físicos. Todas as regressões anteriores mantidas pela CI.

## Teste manual

Gravar **este** UF2 por BOOTSEL **sem `flash_nuke`** (manter bonds e perfis), guardar o UF2 estável anterior como reversão e executar o [roteiro físico atualizado](physical-acceptance.md) **desde HOME CONNECTED**. Verificar que `|` ocupa a primeira coluna da segunda linha de cada opção de duas linhas, sem aparecer em linhas informativas ou rótulos de COMBINATIONS.

**ACEITE FÍSICO PENDING.** Somente após `gate aceito` será feito bump PATCH com CI do commit versionado, merge, tag e Release final; **MNT-14** e **MNT-15** permanecem não iniciados.
