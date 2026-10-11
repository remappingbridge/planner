# MOD-08 — Candidato Consumer HID, CI PASS e UF2 Pico 2 W

**Status: HOST CI 74/74 PASS + PICO 2 W UF2 VERIFICADO / ACEITE FÍSICO PENDENTE (2026-10-11).**

## Base de aceite e proveniência
- MOD-07 aceito pelo operador em 2026-10-11 («gate aceito prossiga»), sobre commit **`0b62137494ce34a86bbecb8d8ee42a7cdfa42385`** e UF2 SHA256 `2f934c507e8502029114ffc4075363b108e23185c51cf28abb022884fc35a576`; [registro](../MOD-07/physical-acceptance.md).
- Branch [`feature/modifier-shortcuts-mod08`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod08) criada exatamente a partir do commit aprovado. [PR #28 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/28); sem merge, release ou tag, main/v2.0.0 intocados.
- Commit candidato exato [`daf05b6302aee17a33d11fbf383b9ff623f72ae4`](https://github.com/remappingbridge/remappingbridge/commit/daf05b6302aee17a33d11fbf383b9ff623f72ae4).
- GitHub Actions [CI #391](https://github.com/remappingbridge/remappingbridge/actions/runs/38150938822): `host-architecture` **SUCCESS 74/74 CTests PASS**, `pico2-w-production` **SUCCESS** com SDK 2.2.0/ARM toolchain pinados.
- [Artefato oficial 11706980027](https://github.com/remappingbridge/remappingbridge/actions/runs/38150938822/artifacts/11706980027), ZIP digest `e66a09bde0422b881c29a49e4e5b5d5facadd6ef3531010baaefbeac71d325b3` (hash do ZIP, **não** do firmware).
- Arquivo `blu2usb_picow.uf2` extraído, **943616 bytes**, SHA256 **`6440583a4563add26b651072f1aac419ae7d72686362ffc59df775c3ee0d2008`**. Extração com `unzip` e `sha256sum` no container reproduziu exatamente o valor do log de build do Pico. Entregue como `remappingbridge-mod08-pico2w.uf2`, binariamente idêntico.

## O que o firmware efetivamente implementa
- ADR-HID-01 **alternativa A experimental**. Interface 0 Mouse, interface 1 Keyboard com coleção Consumer em Report Protocol. Report IDs **1 Keyboard** (8 bytes de payload) e **2 Consumer** (16-bit little endian). Em modo Boot Keyboard, interface 1 envia o Keyboard report legado de 8 bytes sem ID; não emite Consumer. Nenhum terceiro interface ou alteração de VID/PID, descritor Mouse ou endpoint count.
- Consumidor HID Usage Page 0x0C: IDs **19 PLAY/PAUSE 0xCD; 20 NEXT 0xB5; 21 PREVIOUS 0xB6; 22 VOLUME UP 0xE9; 23 VOLUME DOWN 0xEA; 24 MUTE 0xE2; 29 BRIGHTNESS UP 0x6F; 30 BRIGHTNESS DOWN 0x70**. Catálogo Keyboard MOD-07 (22 IDs) integralmente mantido, juntamente com v3 flash e 12 combos.
- FIFO limitada 8; ação serializada Keyboard/Consumer na interface 1. Report Consumer press nonzero → aguarda transporte USB aceitar → release zero → aguarda aceite. Neutraliza um Consumer aceite/pressionado mesmo se a ação for cancelada por BLE/USB/Lock/perfil; se o host muda para Boot, teclado continua utilizável sem ficar bloqueado à espera de um report Consumer incompatível, e a neutralização ocorre quando Report voltar. USB dismount reseta estado da sessão.
- Regressões: HID Keyboard 6KRO com source ownership, teclado Ctrl/Shift/Key ACK, Mouse, slots de atalho, captura gestos MOVE na rotação pre-DPI e Wheel por detent, Saved Devices/movimento/Bluetooth e páginas UI. Nenhuma customização de gestos, UI ou storage adicional neste gate.

## Evidências e limites
- CTests novos `mod08_consumer_8_usages_ack`, `mod08_combined_descriptor_boot_source`, herança de todos os tests 01..07. Testes MOD-05/06 passaram a usar ID de ação inválido 31 como caso negative, pois Media/Volume 19..24 agora têm execução Consumer correta; teste MOD-07 diferencia catálogo Keyboard de catálogo Consumer.
- **74 testes de host e compilação não provam enumeração nem efeito funcional no host real.** Especialmente os usages de brilho podem chegar ao Linux sem alterar a iluminação de notebook/monitor; isso **não** é sucesso completo da ação. Validação exige observação no equipamento do operador (hardware, compositor, driver e painel).
- [12 cenários de validação física](physical-acceptance.md) aguardam aceite explícito. Não avançar ao MOD-09 em caso de falha/limitação sem análise do operador; nenhum merge/publicação autorizada.
