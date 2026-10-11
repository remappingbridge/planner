# MNT-01 — candidato de firmware para teste físico

**Status: CANDIDATE READY — CI HOST E PICO 2 W APROVADAS — ACEITE FÍSICO PENDENTE** (2026-10-11).

## Proveniência imutável
- Baseline oficial: [v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0), tag aponta para `d7c7950fe595bd0e14a970cf60a29d085f065db4`.
- Branch: [`maintenance/v3x-mnt-01`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-01).
- Código-fonte final do **candidato**, não uma release: [`ad73f0d90929b2f373eeca1abbccb0f15b20dcd3`](https://github.com/remappingbridge/remappingbridge/commit/ad73f0d90929b2f373eeca1abbccb0f15b20dcd3).
- [PR **#31 draft**](https://github.com/remappingbridge/remappingbridge/pull/31), não mesclado.
- [CI GitHub Actions **#433**, run ID `38179192254`](https://github.com/remappingbridge/remappingbridge/actions/runs/38179192254): `host-architecture` **SUCCESS 81/81** testes; `pico2-w-production` **SUCCESS**.
- [Artifact oficial `blu2usb-picow-production-pico2w` **ID 11716943391**](https://github.com/remappingbridge/remappingbridge/actions/runs/38179192254/artifacts/11716943391); arquivo ZIP de CI SHA256 `918a904f1fffee3863d248b729a553d11b0f5ffc3e330d3490f500443855069a`.
- Dentro do ZIP: `blu2usb_picow.uf2` **945152 bytes**, SHA256 **`977ec34ffe16de2f8c16345d4fb13fdd35102488795039b0d14e7729c060bd20`**. Extração do artifact e hash conferidos localmente contra a linha `sha256sum build-pico/blu2usb_picow.uf2` do job de produção.
- Arquivo de entrega nesta conversa: `remappingbridge-mnt01-pico2w.uf2` (bytes idênticos ao nome original da CI). Não há novo tag, GitHub Release, version bump nem firmware debug.

## Diff de escopo
- `src/renderer/renderer.c`: a projeção Saved Devices mantém título/PROFILE/DPI/ROTATION em STATIC (amarelo padrão); somente nome do mouse conectado em CURRENT (ciano v3). As duas dicas de navegação recebem ACTIONABLE (**LIGHT_GRAY**). A ação única `REMOVE DEVICE` recebe EMPHASIZED (**WHITE**) se `blu2usb_ux_saved_bond_for_page` fornece bond; quando 0 OF 0, é cinza inativa. Regra aplicada após destaque genérico HAT, sem leakage temporário.
- `tests/test_mov08_saved_devices.c`: assertivas antigas de "todas as letras em STATIC" atualizadas **somente** para a alteração MNT-01, preservando todos cenários de identity/paging/MOV legado.
- `tests/test_mnt01_saved_devices_colors.c`: teste novo real de projeção grade 9×21 e cores RGB565 por célula, de HOME CONNECTED → SAVED DEVICES com três mouses, mudança de página, HOLD HAT, retorno de REMOVE THIS sem exclusão, nome conectado isolado, mouse desconectado e estado zero bonds.
- `tests/CMakeLists.txt`: registro do CTest adicional: 80 originais + 1 = **81 PASS**.
- Nenhuma alteração em `ux_model`, `ble_hogp`, storage, perfil, Movement, Modifier Shortcuts, descritores USB, paleta ou versionamento. MNT-02 e seguintes NÃO iniciados.

## Validação solicitada ao operador
Seguir [roteiro físico](physical-acceptance.md) **começando na HOME CONNECTED**. Atualizar por BOOTSEL com UF2, **sem flash_nuke**, conferir o contraste de branco da opção, cinza das dicas e ciano exclusivo do nome conectado. Não remover dispositivos para criar estado 0 OF 0: cenário pode ser N/A.

**Decisão:** PENDING. Sem mensagem explícita `gate aceito`, não fazer merge, tag ou publicar v3.0.1. A aprovação da CI não implica aprovação física da legibilidade no LCD.
