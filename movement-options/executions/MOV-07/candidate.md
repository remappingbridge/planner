# MOV-07 — HOME Connected | Candidato validado no host

**Status: host CI 55/55 PASS / Pico 2 W UF2 PASS / aceite físico PENDING.**

Branch do produto: `feature/movement-options-v1.0`.
Commit do candidato: `23657734a172f4bd9dc61665ff57acf5230b3568`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098381892
PR: https://github.com/remappingbridge/remappingbridge/pull/22

## Delta de código deste gate
O caminho Home Connected para Movement Options foi antecipado durante MOV-01, por pedido do operador para testar todos os gates desde a HOME real. O MOV-07 **não modifica o firmware runtime já aceito**; acrescenta cobertura de teste, não uma segunda HOME.

- `tests/test_mov07_home_connected.c`: verificações de grid 9x21, nome e resumo dinâmicos, as quatro rotas e retornos à HOME, seleção branca, navegação no release, wrap, Help pelo KEY X e retorno KEY Y preservando a quarta opção, Key B sem ação na HOME, lock/unlock que consome primeira tecla sem abrir menus e preserva Movement/Remap, estado HOME SEARCHING/RETRY de 2 opções e restabelecimento do fluxo com H=2x/V=0.75x/270°.
- `tests/test_mov07_home_runtime_source.py`: guarda dos ramos reais de BLE CONNECTED/DISCONNECTED, SEARCH TIMEOUT, perfil/identidade/TLV, continuidade do envio HID durante lock (a simulação de UX não equivale a teste do dispositivo físico).
- Registro de ambos em `tests/CMakeLists.txt`, suíte host de **55/55 PASS**.

O firmware de produção desta execução **passou** em CI no mesmo source SHA, foi baixado e verificado como UF2 RP2350 válido: **925.696 bytes, 1.808 blocos, SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`**, artifact GitHub Actions `11686122817`, nome `blu2usb-picow-production-pico2w`. A comparação byte a byte confirmou que o UF2 MOV-07 é **idêntico ao MOV-06 aceito**; portanto, não precisa regravar o Pico se o MOV-06 permanece instalado. O gate ainda exige aceite físico próprio do operador.

## Evidência final
CI final: https://github.com/remappingbridge/remappingbridge/actions/runs/38098381892. Ambos os jobs host e Pico 2 W concluídos com sucesso. Artifact `11686122817`. SHA-256 do arquivo UF2: `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`.

Registro do aceite ainda pendente: `physical-acceptance.md`.
