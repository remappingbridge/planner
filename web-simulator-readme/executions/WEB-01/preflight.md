# WEB-01 — Preflight (12/10/2026)

**Estado:** execução de WEB-01 iniciada; aceite pendente.

## Dependência e refs de partida

- WEB-00 teve autorização inequívoca do operador para prosseguir ("prossiga"), registrada em [operator-acceptance.md](../WEB-00/operator-acceptance.md), e foi integrado à `main` do `planner` no commit `8056ef6055d0b2c73c18c48f4ad3ab8ca432859a` ([PR #17](https://github.com/remappingbridge/planner/pull/17)).
- Fonte do firmware: `remappingbridge/remappingbridge` v3.2.3 / `f38c5fd15c68ea9a36d3b05912727788d7b98e81`; segue a versão mais recente verificada no início do gate.
- Simulador desktop principal: `remappingbridge/mouse-ui`, `main` `e1f5e98aba8bc436729b991de9ec22294e6ca78d`, sincronizado à v3.2.3.
- Repositório de implementação: `remappingbridge/remappingbridge.github.io`, baseline `main` `84eaf2c144a081f935d70e78c2b9870a06c64467` com `README.md`, `LICENSE` AGPLv3 e `.gitignore` — sem aplicativo.
- Branch candidata no site: `web/web-01-static-app-foundation`.
- Branch de evidências no planner: `web/web-01-evidence`.

## Limites assumidos e preservados

WEB-01 implementa **apenas a página e bootstrap estáticos**: `index.html` único, assets locais, CSS simples porém responsivo, mock visual do LCD + nove controles de HAT, resposta visual/contador em JavaScript sem runtime de firmware, documentação e harness browser-only. **Não** portar o framebuffer/render/UX, BLE virtual, Movement, Modifier, shortcuts, persistência ou botão de brightness neste gate.

O LCD mostra o template literal de `BLU2USB_SCREEN_SEARCHING_FIRST` como **prévia textual**, não Canvas de pixels. A referência fonte está em [screen-templates.json](../../fixtures/v3.2.3/screen-templates.json). O app informa explicitamente ao visitante que ainda não conecta hardware real nem navega pelas telas.

Critérios inegociáveis: sem Node.js/npm/bundler, framework ou CDN exigidos; sem `nav`, footer ou landing page; sem workflow do projeto; preservar `LICENSE`; CSS e JS relativos para funcionar por `file://` e HTTP; não publicar Pages antes de saber seu estado real nem tocar no README/firmware do outro repo.

## Publicação GitHub Pages

O plano prevê `Settings → Pages → Deploy from a branch → main → /(root)`. Não havia site publicado validado no início do WEB-01. A branch candidata **não é equivalente** a Pages online; habilitação da hospedagem e teste da URL são feitos apenas após condições de publicação/aceite apropriadas. Não há permissão da conexão usada para configurar a interface Settings de Pages; nenhuma configuração foi inventada ou declarada realizada.

## Rollback

Abandonar/reverter apenas a branch `web/web-01-static-app-foundation` e a PR se rejeitada, sem afetar a `main` do site, as fixtures WEB-00, o firmware, a release UF2 ou o README público do firmware.
