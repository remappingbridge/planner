# 01 — Contrato técnico e arquitetura da versão web

## Escopo exato

**Produto-alvo:** port web do executável principal `mouse-ui` v3.2.3, com a matriz de telas e transições do firmware `remappingbridge` como autoridade. A UI desktop antiga `mouse-ui-legacy-v1` é referência **somente** para ideias do laboratório (Inspector, cenários, evidência, fault injection), não para conteúdos de telas removidas. O usuário nunca deve confundir evento virtual com pareamento/atalho físico real.

## Arquitetura estática proposta

```text
remappingbridge.github.io/
  index.html                      # único documento público/aplicação
  .nojekyll                       # tratar arquivos como conteúdo estático
  assets/
    css/app.css                   # shell responsivo; não altera LCD lógico
    js/constants.js               # IDs canônicos e geometria/cores
    js/screens.js                 # templates de 45 telas; checksum/proveniência
    js/ux-model.js                # transições HAT e resultado de comandos
    js/virtual-world.js           # Mouse, BLE mock, relógio e persistência local
    js/lcd-renderer.js            # RGB565/Canvas, glyph 5x7, tons, composição
    js/controls.js                # HAT virtual, teclado/pointer/touch, Lock
    js/lab.js                     # cenários, inspector, log, export
    js/app.js                     # bootstrap; sem lógica de negócio duplicada
    img/                          # recursos originais documentados/licenciados
  tests/                           # harness HTML browser-local, sem Node/npm
  README.md                        # somente documentação do repositório do site
```

Estrutura indicativa e ajustável por gate; separar funções puras de efeitos DOM. Scripts clássicos `<script src=... defer>` ou namespace isolado para abrir em `file://` e via HTTP. Sem React, framework obrigatório, Node.js, npm, bundler, CDNs obrigatórias, serviço de aplicação, APIs próprias, telemetria, cookies de tracking ou GitHub Actions do projeto. CDN é opcional, documentado e com fallback local, mas dar preferência a CSS/JS puros. **Não** gravar tokens GitHub e não exigir login.

**GitHub Pages:** configurar *Settings → Pages → Deploy from a branch → main → /(root)* e publicar arquivos finais na raiz; URL pretendida `https://remappingbridge.github.io/` depende da configuração da organização. Não é necessário um workflow autoral. `.nojekyll` para servir assets sem pipeline de tema.

## Paridade visual inegociável

1. Manter modelo **240×240** e matriz textual **9 linhas × 21 colunas**, glyph 5×7 ampliado 2×, espaçamento da fonte e separação corpo/rodapé como `renderer.c` da versão-alvo; não criar layout de texto HTML que quebre caracteres/linhas.
2. Paleta semântica de firmware: title magenta, body amarelo claro, actionable cinza, emphasized branco, current ciano, selected current ciano pastel; aplicar foco somente na opção apropriada.
3. Pipeline canônico, na ordem: `blu2usb_ui_project` → `blu2usb_ui_enforce_applied_visual_contract` → `blu2usb_ui_apply_selection_marker` → `blu2usb_renderer_render`. O port JS deve preservar a mesma ordem e invariantes. Extração de fixtures da fonte C (commit registrado) com ferramentas de biblioteca padrão, quando cabível; não usar o antigo conjunto de 29 telas.
4. **MNT-12:** indicador ciano de MODIFIER SHORTCUTS apenas se `CUSTOM` **aplicado** e botão `MODIFIER` **aplicado**. `COMBINATIONS`: valores atribuídos, disponíveis e foco ciano; `UNAVAILABLE` e `NOT CUSTOMIZED` mantêm regra própria; não promover draft não aplicado.
5. **MNT-13:** exatamente um pipe `|` em coluna zero da linha focada, nenhuma opção desmarcada com pipe. Em opções de duas linhas COMBINATIONS, colocar em **linha de status 2/4**, nunca 1/3. `SAVED DEVICES` mostra marcador somente em `REMOVE DEVICE` válido; nenhum marcador em telas meramente informativas.
6. HOME conectado, buscando salvo, retry e primeiro pareamento; editor de Custom com `MODIFIER`, 6 páginas/12 combinações, 5 páginas/30 shortcuts, Movement H/V, rotação, Saved Devices, Help, Lock, Delete, dados por Mouse e aliases de display. Contrato novo (firmware) prevalece sobre textos legados.

### Única exceção gráfica autorizada

O magenta/roxo de **fundo** do LCD (área de dicas e estado didático) pode ser clareado/discretamente suavizado **somente para o browser** para ficar naturalmente perceptível, sem alterar o magenta vivo de títulos nem a cor semântica dos textos. Propor 2–3 variantes discretas e congelar uma após aceite visual; nunca vender como paridade RGB565 bit a bit nesse fundo. O corpo preto permanece preto, exceto ajustes controlados e aprovados. Registrar o delta original→web nos goldens web. Não alterar paleta física do firmware.

## UX da página única, sem site tradicional

- Tela HAT estilizada e LCD central como componente dominante; joystick à esquerda, botões arredondados A/B/X/Y à direita; dashboard compacto de simulação (não menu global de site).
- Controles de cenário, Mouse virtual, CONNECT/DISCONNECT, TIMEOUT/RETRY, REBOOT, RESET, ajuda de uso, zoom, brilho, Inspector/Event Log/Evidence opcionais como painéis no **mesmo documento**, sem páginas/rotas de site.
- Design visual: bordas arredondadas, sombras discretas, estados hover/focus/pressed, cores coerentes com LCD, controles grandes, click/touch targets ≥44 px, rótulos claros, não depender só de cor.
- Zoom visual progressivo e HiDPI sem alterar resolução lógica; no mobile painel reorganiza ao redor/abaixo do LCD, nunca cortar botão. Não sequestrar setas quando input do painel está em foco. `prefers-reduced-motion`, foco visível, contraste de controles e equivalentes de teclado para HAT.
- Brilho `0…100%` (slider nativo ou estilizado) controlando **apresentação** sem canal >100; Lock efetivo 0%; reter selecionado ao desbloquear. Escurecimento/clareamento de fundo magenta base **não** é um ganho de brilho >100.
- Não realizar HID real, BLE real, salvar/alterar firmware ou criar impressão de que o mouse no browser está conectado ao Pico.

## Modelo simulado e segurança

- Máquina de estados determinística para transições HAT `pressed/released`, comandos, resultado commit-first, help/lock, busca de salvo/P at, remoção e restauração; mock de múltiplos mouses BLE; perfis, draft/applied, Movement e shortcuts **por identidade**.
- `localStorage` versionado, validado e com recuperação segura para campos inválidos/corrompidos; só guarda dados de simulação. `RESET` demanda confirmação; cenário isolado não altera persistência permanente; export de evidências sem upload.
- `setTimeout`/relógio virtual devem preservar causalidade e ignorar respostas atrasadas; opção de avanço manual do relógio para testes. Falhas simuladas nunca alteram configurações aplicadas por engano.
- HTML sempre por text nodes para nomes de mouses informados pelo usuário, sem `innerHTML` não confiável; sem `eval`, token, armazenamento remoto ou transferência de dados. Aviso explícito: simulação não faz flash/USB/Bluetooth.
- Versões: `firmwareVersion`, `firmwareCommit`, `uiPortRevision`, `fixtureVersion` mostrados em Inspector/Evidence; qualquer sincronização futura passa por teste de paridade e revalidação visual.

## Matriz de exclusões

Não implementar: menus globais do site, landing/catálogo/editorial no Pages, atualização firmware física no browser, WebBluetooth obrigatório, backend/API, build npm/Node/WASM obrigatório, conexão ao repositório privado, instalação de dependências, deploy via workflow próprio, edição de firmware durante gates de site, métricas não autorizadas, logins, ou alegação de iframe funcional dentro do README do GitHub.
