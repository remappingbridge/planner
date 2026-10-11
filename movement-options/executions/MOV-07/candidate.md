# MOV-07 — HOME Connected | Candidato validado no host

**Status: host CI 55/55 PASS / Pico 2 W em compilação / aceite físico PENDING.**

Branch do produto: `feature/movement-options-v1.0`.
Commit do candidato: `23657734a172f4bd9dc61665ff57acf5230b3568`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098381892
PR: https://github.com/remappingbridge/remappingbridge/pull/22

## Delta de código deste gate
O caminho Home Connected para Movement Options foi antecipado durante MOV-01, por pedido do operador para testar todos os gates desde a HOME real. O MOV-07 **não modifica o firmware runtime já aceito**; acrescenta cobertura de teste, não uma segunda HOME.

- `tests/test_mov07_home_connected.c`: verificações de grid 9x21, nome e resumo dinâmicos, as quatro rotas e retornos à HOME, seleção branca, navegação no release, wrap, Help pelo KEY X e retorno KEY Y preservando a quarta opção, Key B sem ação na HOME, lock/unlock que consome primeira tecla sem abrir menus e preserva Movement/Remap, estado HOME SEARCHING/RETRY de 2 opções e restabelecimento do fluxo com H=2x/V=0.75x/270°.
- `tests/test_mov07_home_runtime_source.py`: guarda dos ramos reais de BLE CONNECTED/DISCONNECTED, SEARCH TIMEOUT, perfil/identidade/TLV, continuidade do envio HID durante lock (a simulação de UX não equivale a teste do dispositivo físico).
- Registro de ambos em `tests/CMakeLists.txt`, suíte host de **55/55 PASS**.

O binário de produção deverá ser igual ao MOV-06 já aceito, se o build for reprodutível. A igualdade só será declarada após a extração do artefato da execução `38098381892` e comparação SHA-256. O gate ainda requer teste físico próprio do operador.

## Evidência final
Anexar artifact ID e UF2 SHA-256 depois da conclusão do job `pico2-w-production`.

Registro do aceite ainda pendente: `physical-acceptance.md`.
