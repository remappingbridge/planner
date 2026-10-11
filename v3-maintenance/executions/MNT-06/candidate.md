# MNT-06 — candidato para teste físico

- **Status:** implementado, PR #36 draft, aguardando aceite físico; não publicar v3.1.1.
- Base exata: commit release de v3.1.0 `d5a36ddf3ef7a1161a375fc3046c57e606b5e27e` (tag oficial verificada).
- Branch: `maintenance/v3x-mnt-06`, HEAD `b0320dc170d9f6e017d228e9045fde38ea1ec152`.
- Alteração: apenas `BLU2USB_SCREEN_MOUSE_SAVED` mostra `KEY Y: LOCKS ANYWHERE` (21 caracteres). Contrato automático 9 linhas e HOME no desbloqueio.
- PR: https://github.com/remappingbridge/remappingbridge/pull/36
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38184865836 — **86/86 testes host PASS**, **Pico 2 W production SUCCESS**.
- UF2 de produção: `remappingbridge-mnt06-pico2w.uf2`, **945152 bytes**, SHA256 **`0b5ab77bbde1fcc45e172934f0d735fa5f7f49cb7bd9101a1b2a782314678373`** (calculado sobre arquivo extraído do artefato Actions #11718679253).
- Versão interna do candidato **v3.1.0**. Versão **v3.1.1** somente após aceite físico.
- Cenários de teste: `physical-acceptance.md`.
