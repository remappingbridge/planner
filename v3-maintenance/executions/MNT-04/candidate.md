# MNT-04 — candidato LCD slash

**Implementado e integrado; publicação v3.0.4 autorizada pelo operador; validação física individual ainda pendente.**

## Rastreabilidade
- Base do gate: tag oficial `v3.0.3`, branch `maintenance/v3x-mnt-04`.
- [PR #34](https://github.com/remappingbridge/remappingbridge/pull/34) mesclado na main, commit `b881b83bfdce3694b2b2b8047ce2d7c31c288aaa`.
- [CI candidata #461](https://github.com/remappingbridge/remappingbridge/actions/runs/38183078062): **84/84 host PASS**; Pico 2 W produção SUCCESS.
- [CI código versionado #465](https://github.com/remappingbridge/remappingbridge/actions/runs/38183214644), estado deve ser verificado na página de Actions antes do aceite e uso da versão oficial.
- [GitHub Release v3.0.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.4) depende do workflow de publicação da main.
- UF2 candidato sem bump final (versão interna 3.0.3), produzido no CI inicial #458: 945152 bytes, SHA256 `52faeab1a26703da440b8427e12f4158490214f61430b4ab8ec05cff28919785`; este binário tem as alterações MNT-04 mas não substitui o UF2 oficial v3.0.4.

## Alteração técnica
- `src/ux_model/ux_model.c`: alterados exclusivamente rótulos visuais JOY UP/DOWN, JOY RIGHT/LEFT, JOY LEFT/RIGHT, ENTER/RETURN, PLAY/PAUSE e HOME SCREEN/PAGE nos templates e catálogo.
- `src/renderer/renderer.c`: atualizada correspondência de foco `RIGHT/LEFT` preservando regra de joystick; mantidos glyph `\\` e tabela de caracteres.
- Testes legados atualizados para novo texto sem eliminar asserções de fluxo, cores e perfis.
- Novo `tests/test_mnt04_slash_source.py` integrado ao CTest, contratos 9x21 e preservação de backslash no código.

## Segurança / estado
A solicitação de publicação não é evidência de teste físico. Preservar a evidência do operador separadamente no arquivo de aceite. A atualização UF2 não requer `flash_nuke`.
