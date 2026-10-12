# WEB-00 — Preflight: fontes, licenças e escopo

**Execução iniciada:** 12/10/2026. **Status:** CANDIDATO DOCUMENTAL — aguarda revisão/aceite. **Branch:** `web/web-00-authoritative-baseline` no `planner`. **Base:** `main` `93ea33be0b6a37fb8facc2cbf54a2bd4b41bf789`.

## Inventário verificado no GitHub

| Repositório | Ref de partida exata | Situação |
|---|---|---|
| [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge) | `main`/`v3.2.3` `f38c5fd15c68ea9a36d3b05912727788d7b98e81` | Release latest confirmada em 12/10/2026, 16:59 UTC; UF2 `remappingbridge-v3.2.3-pico2w.uf2` + SHA256SUMS.txt |
| [remappingbridge/mouse-ui](https://github.com/remappingbridge/mouse-ui) | `main` `e1f5e98aba8bc436729b991de9ec22294e6ca78d` | Simulador desktop v3.2.3; fonte C vendorizada do firmware correspondente. Arquivos centrais `ux_model.c`, `renderer.c`, `profile_feedback.c` e `profile_state.c` têm SHAs Git blob idênticos ao firmware; não executar o v1 legacy como UX normativa |
| [remappingbridge/remappingbridge.github.io](https://github.com/remappingbridge/remappingbridge.github.io) | `main` `84eaf2c144a081f935d70e78c2b9870a06c64467` | Sem `index.html` nem app; apenas `.gitignore`, `LICENSE` e `README.md`. Site será criado **somente em WEB-01** |
| [remappingbridge/planner](https://github.com/remappingbridge/planner) | `main` `93ea33be0b6a37fb8facc2cbf54a2bd4b41bf789` | Programa planejado WEB-00..15; branch isolada WEB-00 criada |

Fonte imutável usada nos snapshots:
- [ux_model.h](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/include/blu2usb/ux_model/ux_model.h), Git blob `include/.../ux_model.h`;
- [ux_model.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/ux_model/ux_model.c), blob `132010179de09ea81f4543e9ca83def09c0a743f`;
- [renderer.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/renderer/renderer.c), blob `61c4fe3d547ba05c3e24de86518d807047b50a77`;
- [profile_feedback.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/src/renderer/profile_feedback.c), blob `071a320a55c7fb8cacc7a1e4b83ad9b6281788d0`;
- [test_mnt12_modifier_cyan.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/tests/test_mnt12_modifier_cyan.c), blob `0870f84791de3b980f97bfa4bd88dafc099c6636`;
- [test_mnt13_selection_marker.c](https://github.com/remappingbridge/remappingbridge/blob/f38c5fd15c68ea9a36d3b05912727788d7b98e81/tests/test_mnt13_selection_marker.c), blob `90e4fac7f044e93c358739b1a7971e7218326068`.

## Diretrizes contratuais para a web

- Autoridade: firmware C v3.2.3; `mouse-ui` desktop atual (não v1) é modelo de simulação. Nenhum port direto de binário/WASM ou nova fonte de UX independente por chute.
- 45 screen IDs em 9×21; 27 com opções seletivas em MNT-13, 1 ação implícita Saved Devices, 12 combinações, 30 atalhos, 9 controles HAT e 8 salvos.
- Pipeline físico: `project → enforce_applied_visual_contract → apply_selection_marker → render`. O port JS deve manter esta composição; modelos de cenário reproduzem estados e comandos, não o hardware físico.
- Exclusões verificadas: STANDARD REMAP e ESCAPE REMAP não aparecem na tela `MOUSE_OPTIONS`, embora enums legados existam no `profile.h` para compatibilidade; `LEARN THE KEYS` como rota foi aposentado, embora `SEARCHING_FIRST` seja didático.
- Render do firmware deliberadamente trunca 2 linhas do template de `HELP_REMAPPER_OPTIONS` com comprimento de origem 22; não corrigir/apagar textos como “bug” sem autorização.
- MNT-14 foi **cancelado** no planejamento de manutenção em 12/10/2026; MNT-15 foi **suspenso**. Não criar correção BLE/HID especulativa nem ressuscitar gates nesses trabalhos.
- Web: CSS arredondado e legível, sem navbar/footer/landing, brilho 0–100%, único delta visual autorizado é fundo dark-magenta discretamente suavizado; sem Node ou GitHub Actions de build autoriais.

## Licenciamento e proveniência de mídia

- Firmware `remappingbridge`: licença **CC0 1.0** (repositório `LICENSE`); textos/UX/fontes vendorizadas precisam ser rastreados ao commit de origem.
- `mouse-ui` e `remappingbridge.github.io`: **GNU AGPLv3** (licenças atuais dos repositórios). Em WEB-01 preservar o `LICENSE` existente do site, adicionar créditos e verificar obrigações de terceiros. Não substituir a licença sem autorização.
- Fotos/ícones e bibliotecas CDN de terceiros exigem licença/proveniência revisadas; priorizar diagramas próprios SVG e CSS/JS sem dependências.
- Modelos confirmados na documentação do produto: Raspberry Pi Pico **2 W** com RP2350 e Waveshare **Pico-LCD-1.3** para placa Pico (não HAT 40 pinos de Raspberry Pi Linux). A verificação técnica fina e o material ilustrado ocorrerão em WEB-12.

## Riscos conhecidos / achados de documentação

- A primeira linha do README principal de `mouse-ui` menciona firmware v3.2.3, mas ainda contém o SHA antigo `3846e8f4...` de v3.2.1. **A fonte e `docs/verification/remappingbridge-v3-parity.md` apontam corretamente `f38c5fd...`; tomar o código/blob e essa ficha de paridade como autoridade.** Não alterar repo `mouse-ui` fora do escopo WEB.
- Testes de paridade física de firmware/UF2 **não** são executados no WEB-00; o que se valida são referências e fixtures.
- O README do GitHub não executa iframe/JavaScript de aplicativo; publicar prévia clicável para o Pages quando houver site.

## Exclusões expressas

**Não tocar:** `remappingbridge.github.io`, firmware C/README em `remappingbridge`, `mouse-ui`, tag/release, deploy Pages, nenhum arquivo `.uf2` ou branch de implementação no site nesta etapa.
