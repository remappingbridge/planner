# WEB-12 — Hardware necessário, imagens e montagem segura

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge/remappingbridge (README.md/assets)`. **Dependência:** WEB-11 aceito.

## Escopo fechado

Ilustrar por SVG original Raspberry Pi Pico 2 W RP2350+Bluetooth, Waveshare Pico-LCD-1.3 SKU 19650 ST7789 240×240 com joystick e 4 keys, mouse BLE HOGP, cabo Micro-USB dados, headers e host.

## Entrega observável

BOM com itens necessários/opcionais, diagrama Mouse BLE→Pico+HAT→USB HID→host, mapa de teclas A/B/X/Y e direções, etapas mecânicas seguras, créditos e links oficiais.

## Aceite e cenários manuais

Conferir produto Waveshare correto, modelo Pico2W vs Pico2, pinagem na fonte hat.h, alt-text e licenças de fotos/desenhos, legibilidade mobile.

## Limites

Não confundir a HAT 40-pin para Raspberry Pi Linux com Pico-LCD-1.3; não copiar fotos sem direito nem exigir solda se header já instalado.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-12/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
