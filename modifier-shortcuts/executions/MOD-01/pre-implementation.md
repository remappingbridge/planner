# MOD-01 — Pre-implementation

**Status:** CODE IMPLEMENTED / CI & PHYSICAL VALIDATION NOT YET FROZEN (2026-10-11).

- Fonte imutável: `remappingbridge/remappingbridge` tag `v2.0.0`.
- Branch isolada: [feature/modifier-shortcuts-mod01](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01).
- PR de revisão em draft: [#23](https://github.com/remappingbridge/remappingbridge/pull/23), **sem merge**.
- Contrato aprovado: [MOD-00](../MOD-00/operator-acceptance.md).
- Limites: apenas menu Remapping Options, retire Standard/Escape, Help e indicadores. Sem novas telas de combinações ou atalhos, sem consumer HID, sem schema v3, sem mudanças em BLE ou Movement.
- Preservação: v2 schema/valores antigos ainda decodificáveis; perfil ativo Standard/Escape convertido em Passthrough em RAM no boot, sem gravação imediata. Quatro telas de confirmação Standard/Escape e comandos de UX removidos; custom target ESCAPE ainda existe (MOD-04); migração permanente (MOD-03).
- Inventário: 38 telas `v2.0.0` menos 4 antigas = **34** após MOD-01, antes de criar as 11 previstas nos MOD-02/03.
- Terceira opção `MODIFIER SHORTCUTS`: foco/navegação funcional; `JOY PRESS` **intencionalmente no-op** até MOD-02, não abre um legado.
- Código: `src/ux_model`, `src/renderer`, `src/app/main.c`, `include/blu2usb/ux_model/ux_model.h`; testes herdados adaptados em `tests/`, CI ajustado para publicar candidato UF2 na feature branch.

## Critérios
- Host CTest PASS (todos os casos).
- Build Release Pico 2 W PASS e artifact `blu2usb-picow-production-pico2w` com arquivo `blu2usb_picow.uf2` + SHA256.
- Testes manuais exigidos desde Home Connected; aceite explícito do operador antes de MOD-02.
- Sem modificar tag estável, merge automático, publicação de release, apagar bonds ou apagar flash.
