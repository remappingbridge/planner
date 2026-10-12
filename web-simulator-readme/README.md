# Programa WEB — Simulador estático e README didático RemappingBridge

**Estado em 12/10/2026: WEB-00 CONCLUÍDO, COM AUTORIZAÇÃO EXPLÍCITA DE PROSSEGUIR EM 12/10/2026. WEB-01 ACEITO PELO OPERADOR, PR #1 integrada; WEB-02 ACCEPTED, WEB-03 ACCEPTED, WEB-04 ACCEPTED (45 screens, physical HAT layout, fixed Gentle); WEB-05 AUTHORIZED (mouse state + English key legend), WEB-05..15 NOT STARTED. Todos os textos públicos de firmware/site/releases devem estar em inglês; testes manuais web apenas em navegador de produção.** A implementação do site e as mudanças no README do firmware continuam não iniciadas.

## Objetivo e destinos

Uma única série sequencial **WEB-00..WEB-15**, com dois destinos separados:
1. [remappingbridge/remappingbridge.github.io](https://github.com/remappingbridge/remappingbridge.github.io) — aplicativo web interativo em página única, HTML/CSS/JavaScript puro, sem Node.js/npm/bundler/API própria ou workflow de GitHub Actions mantido pelo projeto.
2. [remappingbridge/remappingbridge](https://github.com/remappingbridge/remappingbridge) — **apenas README.md e ilustrações/documentação editorial**, sem alterar firmware, sem compilar ou gerar UF2 por causa dos gates WEB.

Planejamento, contratos, critérios de aceite e evidências de execução ficam **somente neste repositório `planner`**.

## Fontes de verdade verificadas

| Fonte | Baseline na data de planejamento | Autoridade |
|---|---|---|
| [Firmware](https://github.com/remappingbridge/remappingbridge) | **v3.2.3**, commit `f38c5fd15c68ea9a36d3b05912727788d7b98e81` | UX real: 45 telas, interação HAT, render 240×240/9×21, MNT-12/MNT-13, perfil e atalhos por Mouse |
| [mouse-ui](https://github.com/remappingbridge/mouse-ui) | `main` `e1f5e98aba8bc436729b991de9ec22294e6ca78d` | Referência funcional do simulador desktop v3.2.3, controles virtuais, casos de uso; `mouse-ui-legacy-v1` só para ferramentas de laboratório |
| [Site](https://github.com/remappingbridge/remappingbridge.github.io) | `main` `84eaf2c144a081f935d70e78c2b9870a06c64467`, sem aplicação/site | Repositório a preencher **somente após autorização de gates**; licença AGPLv3 existente |
| [README firmware](https://github.com/remappingbridge/remappingbridge/blob/main/README.md) | Firmware v3.2.3, conteúdo técnico | Expansão editorial: negócios, ensino, hardware, demo web, download do UF2 |

**Atualidade:** a baseline é *ponto de partida*, não uma versão congelada para sempre. No início de cada gate conferir releases, `main` e `mouse-ui`; se o firmware mudar, registrar diff/paridade e rever gates/fixtures afetados *antes* da implementação. Não tomar documentos históricos HOPE/MUI-08 (v1) como UX atual. Não reativar funcionalidades removidas.

## Decisões aprovadas como requisitos de planejamento

- Um único `index.html` público para o aplicativo em `https://remappingbridge.github.io/`, com arquivos auxiliares estáticos relativos (`assets/js/*.js`, `assets/css/*.css`, imagens próprias). **Não** fazer landing page clássica, menu global, navbar, blog, header editorial ou footer; apenas dispositivo simulado, LCD e painel de controles de laboratório.
- O resultado deve mostrar fielmente a UX mais recente do **mouse-ui v3** e oferecer os controles úteis de experimentação do laboratório desktop, mas sem reintroduzir os menus/fluxos v1 aposentados. O fluxo de dispositivo, não os menus da página, é que deve ser navegável.
- Fidelidade visual: LCD lógico 240×240, grade 9×21, fontes bitmap/posições, seis tons, magenta de títulos, ciano, hints, seleção `|` única MNT-13 e regras MNT-12. Adaptar apenas o **fundo magenta muito escuro** para tonalidade web mais visível; preservar semântica e cores de informação.
- Brilho web **exclusivamente 0–100%**, sem 101–1000%, sem ganho artificial. Lock tem brilho efetivo 0% e desbloqueio restaura preferência. Ampliar pixels pela escala CSS/Canvas (não por backlight).
- Priorizar legibilidade, controles arredondados, estética contemporânea, alto contraste, acessibilidade por teclado e toque e uso em telas HiDPI.
- **Sem Node.js nem GitHub Actions próprias** no site. GitHub Pages por `main` / `(root)`; o serviço pode mostrar um workflow **interno do GitHub Pages**, o que não equivale a exigir Actions de build do projeto.
- **Limitação GitHub README:** o GitHub sanitiza `iframe`, `script` e conteúdo executável; não se pode embutir a aplicação JS *funcional* diretamente no README renderizado no github.com. Planejar imagem/GIF/SVG de prévia clicável + link direto ao GitHub Pages; o próprio app pode ser incorporado em outras páginas que permitam iframe. Não alegar que um link ou screenshot seja uma incorporação interativa.
- Firmware/hardware do produto: **Raspberry Pi Pico 2 W com RP2350** (variante com rádio Bluetooth), **Waveshare Pico-LCD-1.3** (SKU 19650, ST7789 SPI 240×240, joystick + botões A/B/X/Y), mouse BLE HID e cabo USB **de dados** para host. Não confundir com HAT 40 pinos de Raspberry Pi Linux ou Pico 2 sem W.
- README passa a explicar motivação, casos de uso, benefícios, arquitetura/limites, montagem, flashing seguro, uso guiado, imagens/diagramas e download da release UF2 mais recente.

## Documentos

- [01 — Contrato e arquitetura da aplicação](01-contract-and-architecture.md)
- [02 — Matriz de gates e dependências](02-gates-and-dependencies.md)
- [03 — Testes, paridade e aceite](03-acceptance-and-tests.md)
- [04 — README, hardware, ilustrações, download e embedding](04-readme-hardware-and-download.md)
- [gates/](gates/) — escopos e critérios individuais WEB-00..WEB-15.
- [English-only audit: firmware, website and 16 GitHub Releases — completed](executions/WEB-01/english-audit.md)
- [WEB-03: input/Help/Lock candidate](executions/WEB-03/candidate.md) and [production browser tests](executions/WEB-03/manual-tests.md).
- [WEB-02: Canvas LCD candidate](executions/WEB-02/candidate.md) and [production-browser tests](executions/WEB-02/manual-tests.md).
- [WEB-01: candidato e teste manual](executions/WEB-01/candidate.md) — site integrado à main, mas publicação Pages ainda exige verificação independente.
- [WEB-00: evidências](executions/WEB-00/candidate.md) e [fixtures versionadas](fixtures/README.md) — fonte v3.2.3 extraída; autorização para avançar registrada em [WEB-00/operator-acceptance.md](executions/WEB-00/operator-acceptance.md).

## Permanent language and browser testing rules

- All user-facing content in `remappingbridge/remappingbridge` and `remappingbridge/remappingbridge.github.io`, including every documentation page, README, page `<html lang>`, accessible label, browser test report and **all GitHub Release descriptions**, must be in **English**. Stable C identifiers, tags and checksums remain unchanged.
- Starting with WEB-02, operator-facing manual scenarios must run on the **production GitHub Pages website in a browser**, not from a local Debian clone. If Pages is not published, report the deployment blocker instead of claiming production acceptance.
- A separate documentation maintenance program translates existing release bodies and adds checks. Do not silently start WEB-02 while this requirement is unresolved.
- [WEB-01 operator acceptance and policy](executions/WEB-01/operator-acceptance.md).

## Princípio de aceite

Executar **apenas o próximo gate autorizado**, em branch própria do repositório-alvo; demonstrar o incremento funcional desde a HOME ou estado de primeiro uso, fornecer testes manuais e evidências. Não prosseguir automaticamente nem marcar ACEITO sem mensagem explícita do usuário. Nenhuma branch de implementação é criada nesta fase de planejamento.
