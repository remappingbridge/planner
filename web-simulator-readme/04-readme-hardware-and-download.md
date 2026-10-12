# 04 — Conteúdo editorial do README, hardware e download

## Papel do README

O README raiz do `remappingbridge/remappingbridge` deve ser o **manual público de apresentação** do produto, não transcrição das 45 telas nem índice técnico gigantesco. Linguagem didática, acessível a iniciantes, com argumentos de negócios verificáveis e sem propaganda enganosa. A aplicação interativa integral fica no GitHub Pages, **sem navbar, landing page, footer ou header editorial**. Dividir trabalhos editoriais em WEB-11..WEB-14, com auditoria WEB-15.

### Roteiro editorial previsto (ordem)

1. **Hero:** nome, descrição curta — Mouse Bluetooth → Pico 2 W + display → USB HID (Mouse + Keyboard/Consumer) em computadores compatíveis; uma figura de arquitetura.
2. **O problema / valor:** remapeamento portátil entre hosts, controles físicos e perfis por Mouse sem driver específico do projeto no computador; casos de produtividade, acessibilidade e adaptação de entrada, limitações de apps/OS expostas.
3. **Como funciona:** o rádio BLE recebe HOGP do Mouse; firmware processa remap, modifier/shortcuts/movement, envia USB HID ao host. Não vende como emulação que acessa dados do computador, não promete 100% compatibilidade de Mouse/SO e não confunde Bluetooth do host com Bluetooth do Pico.
4. **Funcionalidades exemplificadas:** Passthrough vs Custom, Movement H/V/Rotation, um Modifier entre cinco botões, 12 combinações/30 atalhos, Saved Devices, Lock/Help e visibilidade das opções; passos curtos ilustrados com capturas reais e link para experimentar.
5. **Hardware necessário e montagem:** peças claramente identificadas, microcontrolador RP2350, modelo de HAT 1.3", quatro teclas/joystick, conectores, conexão com host, imagem frontal, vista de conjunto e diagrama de conexões de alto nível.
6. **Experimente no navegador:** imagem/GIF/preview com alt-text e link para a página web, nota “simulador virtual; não conecta o Mouse físico nem instala firmware”.
7. **Baixar e instalar firmware:** versão estável publicada, botão/link Markdown para o arquivo UF2 exato da última release verificada e link fixo `/releases/latest`; `SHA256SUMS.txt`; BOOTSEL, montar unidade `RPI-RP2`, copiar arquivo `.uf2`, reiniciar; avisar uso do cabo USB **com dados** e nunca apagar flash/bonds desnecessariamente.
8. **Começar a usar:** HAT conectado, ligar Mouse em pareamento BLE, controles JOY+KEY A/B/X/Y, fluxo HOME de configuração e ajuda. Não apresentar comportamento virtual da aplicação como hardware demonstrado.
9. **Compatibilidade e limitações:** mouse Bluetooth LE HOGP, host com USB HID; zoom/brilho do host dependentes de suporte real; avisos de dados existentes em firmware/downgrade, segurança de updates; páginas de release e documentação técnica.
10. **Licenças, créditos, fontes e suporte:** links para código, planner, issues/release, screenshots e permissões de imagem; FAQ sem copiar extensivamente docs do fabricante.

## Hardware correto e imagens

**Obrigatório:**
- [Raspberry Pi Pico 2 W](https://www.raspberrypi.com/news/raspberry-pi-pico-2-w-on-sale-now/) (**RP2350** com rádio Bluetooth LE/Wi-Fi). RP2350 é o **chip**; Pico 2 W é a **placa**. **Pico 2 sem W não satisfaz o BLE do firmware**.
- [Waveshare **Pico-LCD-1.3** (SKU 19650)](https://www.waveshare.com/Pico-LCD-1.3.htm) para Raspberry Pi Pico, LCD IPS **240×240**, **ST7789/SPI**, **joystick direcional com pressionamento e 4 botões A, B, X, Y**. É a variante Pico com header de encaixe, **não** `1.3inch LCD HAT` para Raspberry Pi Linux com GPIO de 40 pinos.
- Mouse compatível Bluetooth Low Energy HID-over-GATT (HOGP). Port de USB para PC/host compatível, **cabo Micro-USB de dados** para Pico 2 W; usar pinos/header apropriados se a placa não vier com pinos montados. Não prometer funcionamento de rádios/dongles/qualquer Mouse sem validação.
- Computador host com USB e uma forma de colocar o Pico em modo BOOTSEL para firmware.

**Imagens previstas:** (a) ilustração vetorial original do Pico 2 W e HAT com nomenclatura exata e orientação; (b) diagrama original “Mouse BLE → Pico 2 W (RP2350 + HAT LCD) → USB HID → host”; (c) legenda annotated HAT “JOY UP/DOWN/LEFT/RIGHT/PRESS, KEY A/B/X/Y”, baseada nas fontes `include/blu2usb/hat/hat.h` e fabricante; (d) screenshot real da UI web, sem fingir que é fotografia do hardware; (e) fotos de componentes somente se com licença/permissão expressamente verificada, ou usar **links externos para fabricante** (não copiar imagens por padrão).

Referências técnicas e imagem externa: [Pico 2 W oficial](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html), [Waveshare Pico-LCD-1.3 oficial](https://www.waveshare.com/Pico-LCD-1.3.htm), [pinagem fonte firmware](https://github.com/remappingbridge/remappingbridge/blob/main/include/blu2usb/hat/hat.h). Garantir texto alternativo, legendas de origem/licença, e não incorporar fotos externas sem checar direito de redistribuição. Diagramas SVG originais são preferíveis para legibilidade.

## Interatividade no README do github.com: limite real

O GitHub não permite executar scripts/iframe dentro de README renderizado. **Logo, embed interativo dentro do README não é viável.** Critério implementável:
- Uma ilustração/GIF/screenshot legível em Markdown clicável, apontando para `https://remappingbridge.github.io/` (após verificar Pages publicado).
- Texto “Abra o simulador interativo” com link direto permanente e convite a experimentar HOME, Movement e Modifier.
- Se no futuro houver documentação hospedada em domínio externo com iframe permitido, a página separada pode incorporar o app (sem mudar o README GitHub). Não burlar políticas Markdown com SVG scripts ou HTML inseguro.
- Testar clique, viewport e mobile: a prévia tem alt text e link textual redundante; a prévia estática não pode ser descrita como uma interface interativa no github.com.

## Link para UF2 sempre correto

À data do planejamento (12/10/2026), última release verificada:
- [Release v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3)
- [UF2 v3.2.3 **direto**](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.3/remappingbridge-v3.2.3-pico2w.uf2)
- [Checksum SHA256SUMS.txt v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.3/SHA256SUMS.txt)
- **URL que se mantém atual:** https://github.com/remappingbridge/remappingbridge/releases/latest

Como os nomes reais dos assets incluem a versão, **não existe link direto de UF2 versionado que se atualize sozinho no README estático**. No WEB-14 verificar a release atual por GitHub API/CLI, nome real do `.uf2`, checksums e tags; apresentar **o link direto da versão conferida e o link estável `/releases/latest` lado a lado**. A cada nova release alterar o link versionado do README manualmente, ou obter autorização **em programa separado** para padronizar um nome de asset estável em futuras releases. Não inventar uma URL `releases/latest/download/<arquivo-com-versão>` como permanente. O simulador web pode ter um link para `/releases/latest` (sem depender de API/CDN), mas a aplicação não deve baixar/escrever firmware no Pico.

**Importante:** atualizações de documentação WEB nunca implicam gerar novo UF2, tag ou release de firmware. Não usar `flash_nuke` como passo normal de atualização e explicar riscos de downgrade v3→v2.

## Critérios editoriais de aceite

- Um leitor não técnico entende o propósito em 20–30 segundos, distingue Mouse, controlador, HAT e host; a apresentação tem diagrama e exemplos que podem ser testados na UI web.
- Um leitor técnico identifica exatamente o modelo de hardware, interfaces, firmware v3 e limitações; nenhuma alegação de suporte sem fonte.
- Toda imagem tem alt/legenda/proveniência; leitura confortável mobile e baixa visão, contrastes em SVG.
- UF2, nome de arquivo, tag e SHA/checksum da release corrente coerentes, sem afirmar download automático eterno para URL versionada.
- Links funcionais; parágrafo explicita que README é entrada para o **site interativo**, não local de execução do JS.
