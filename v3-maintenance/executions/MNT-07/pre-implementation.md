# MNT-07 — baseline e implementação

- MNT-06 aceito explicitamente; PR #36 mesclado na main como commit `324e60613b33a960486c7ab29bed6ba01aac717c` com versionamento v3.1.1.
- Branch `maintenance/v3x-mnt-07` criada do commit de release exato, não de código anterior.
- Escopo: token global `BLU2USB_COLOR_CYAN` de `0x07FF` para `0xBFFF` (RGB565: vermelho 23/31, verde 63/63, azul 31/31, equivalente aproximado #BDFFFF); ciano mais pálido com branco e ciano legíveis contra fundo preto. Nenhum tom amarelo, magenta, branco ou cinza alterado.
- Fonte `include/blu2usb/renderer/renderer.h`; todos os locais ciano usam `BLU2USB_UI_TONE_CURRENT` via renderer sem edição de fluxo ou ST7789.
- Novo teste `tests/test_mnt07_pale_cyan.py`: contrato do token e da paleta restante, canal RGB565, preservação de mapeamento semântico.
- PR candidato [#37](https://github.com/remappingbridge/remappingbridge/pull/37); CI [#483](https://github.com/remappingbridge/remappingbridge/actions/runs/38185229845).
- A cor ainda precisa ser aceita fisicamente no hardware; não foi observada pelo assistente. v3.1.2 somente após aceite.
