# MOD-08 — Consumer Control dentro da interface Keyboard

**Status: CÓDIGO EM CI / ACEITE FÍSICO PENDENTE (2026-10-11).**

Dependência: MOD-07 aceito pelo operador por mensagem «gate aceito prossiga» após o UF2 do commit `0b62137494ce34a86bbecb8d8ee42a7cdfa42385`, SHA256 `2f934c507e8502029114ffc4075363b108e23185c51cf28abb022884fc35a576`. Branch exclusiva [feature/modifier-shortcuts-mod08](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod08) criada a partir desse commit. [PR #28 draft](https://github.com/remappingbridge/remappingbridge/pull/28). Não alterar main ou publicar release.

## ADR-HID-01 — Alternativa A escolhida em caráter experimental

A decisão MOD-00 aprovou tentar Consumer na interface Keyboard existente e validar enumeração, 6KRO, compatibilidade Boot e comportamento real. Neste gate o descritor da interface 1 agrega HID Keyboard (Report ID 1) e HID Consumer Control (Report ID 2). Mouse permanece na interface 0, VID/PID, `CFG_TUD_HID=2` e número de endpoints não mudam. No protocolo **Boot Keyboard** a emissão de teclado mantém exatamente o relatório legado de 8 bytes, sem Report ID, e Consumer não é enviado; no protocolo Report, TinyUSB acrescenta Report ID 1 antes dos 8 bytes de teclado e Report ID 2 antes dos 2 bytes do Consumer. Isso NÃO comprova compatibilidade sem inspeção real do host; é hipótese a testar no Linux.

### Catálogo Consumer (HID Usage Page 0x0C)
- ID 19 PLAY/PAUSE → 0xCD
- ID 20 NEXT TRACK → 0xB5
- ID 21 PREVIOUS TRACK → 0xB6
- ID 22 VOLUME UP → 0xE9
- ID 23 VOLUME DOWN → 0xEA
- ID 24 MUTE → 0xE2
- ID 29 BRIGHTNESS UP → 0x6F
- ID 30 BRIGHTNESS DOWN → 0x70

Ações semânticas continuam globais, salvas nos slots 0..11, configuráveis desde HOME via Modifier Shortcuts. Mapeamento de teclado IDs 1..18,25..28 do MOD-07 segue intacto. Os oito usages não são códigos Keyboard; enviá-los não significa que o Linux ou backlight físico os aceitará. Brilho depende especialmente do compositor e do driver/tela. Se backlight não reagir, registrar essa limitação e **não** declarar 30/30 funcionais; proposta de fallback exigirá aprovação separada, sem alterar silenciosamente arquitetura.

### Transporte e segurança
Um único executor mantém FIFO limitada a oito, ação classificada Keyboard ou Consumer. Report ID 2 usa um usage 16-bit não nulo no keydown, espera TinyUSB aceitar, envia usage zero no keyup e espera novo aceite. O endpoint da interface 1 é serializado com a emissão Keyboard e o próximo evento não começa antes do release aceito. Um cancelamento por BLE/USB/perfil/Lock ou outro mecanismo do MOD-05/09 limpa fila e garante envio de Consumer zero se uma emissão não nula anterior tinha sido aceita no host USB da mesma sessão. USB unmount descarta estado da sessão anterior, não envia reports de sessão velha após reconexão. Em Boot Protocol não executar Consumer; teclado segue compatível.

### Validações
Host tests: oito IDs e usages exatos, IDs Keyboard preservados, descritivo de duas interfaces e Report IDs, teclas/controladores liberados, FIFO Consumer/Keyboard serializada, busy/ack, cancelamento, Mouse/6KRO regressão. Build real Pico 2 W CI e SHA256. Host Linux precisa inspecionar `lsusb -v`, `evtest` ou `libinput debug-events`, tocar mídia, mudar volume e tentar brilho com backlight real. Nenhuma captura de host substitui o resultado do operador.

**MOD-09 fica bloqueado até aceite físico explícito.**
