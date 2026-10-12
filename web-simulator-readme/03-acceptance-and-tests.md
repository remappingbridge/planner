# 03 — Matriz de testes, critérios de aceite e evidências

A suíte web deverá usar exclusivamente JavaScript de navegador e HTML de harness, por exemplo `tests/index.html`, que pode rodar localmente ou por `python3 -m http.server` (o servidor Python é **opcional**, não uma dependência de runtime). Sem Node/npm, Playwright que exija Node, Babel, Vite, npm/CDN de testes ou workflow próprio do repositório. Validar automaticamente quando possível; evidência visual humana continua obrigatória.

## Contrato fonte → port

| Dimensão | Prova necessária |
|---|---|
| Proveniência | URL upstream, tag/commit do firmware, commit `mouse-ui`, versões dos testes/fixtures registradas no relatório |
| Inventário | **45 telas** `BLU2USB_SCREEN_*` na v3.2.3, sem inventar telas v1 removidas; se upstream mudar, recontar |
| Estrutura LCD | framebuffer lógico 240×240; 9×21 posições; glyph 5×7, escala, alinhamento corpo/dicas e ausência de overflow |
| Cores | títulos magenta, estático amarelo, actionable cinza, enfatizado branco, current ciano, foco current ciano claro; fundo magenta **explicitamente ajustado na web**, medido separadamente |
| MNT-12 | Custom aplicado + Modifier aplicado é a conjunção necessária; Passthrough, Custom sem Modifier e Custom draft ainda não aplicado não habilitam ciano; UNAVAILABLE e NOT CUSTOMIZED preservam regras |
| MNT-13 | Um único pipe por seleção em coluna zero; **COMBINATIONS em segunda linha de 2/4**; Saved Devices apenas com remoção válida; nenhum pipe em Help/Pair/dialog informativo |
| UX | mesmo resultado de press/release HAT e fluxo HOME, volta, ajuda, lock, setas, páginas, confirmação; nenhuma repetição fantasma |
| Transações | comandos SET/RESET/APPLY/REMOVE só mudam aplicado após sucesso mock; erro ou cancelamento mantém estado anterior, sem alias entre mouses |
| Clock/falhas | busca/reconexão/timeout de cenários, eventos tardios ignorados, erro sem apagar bond; fábrica limpa apenas simulação |
| State isolation | dados de perfil, draft/applied, movimento e slots por Mouse; re-pair depois de remoção nunca herda preferências |
| Persistência | localStorage schema versionado, entradas inválidas ignoradas, quota/disabled tolerados, reset com confirmação |
| Desktop + mobile | Firefox e Chromium desktop; Android/browser móvel, mouse/teclado/touch; zoom 200/300/400%, HiDPI, orientação e telas estreitas |
| Brilho e Lock | 0 a 100 inclusivos, nunca 101+, foco/restauração; locked totalmente apagado; magenta web de base suavizado, sem aumentar brilho por cima do teto |
| Inspector e evidência | identificador semântico estável, bounds em coordenadas lógicas, copy ref, screenshot/JSON/textos exportáveis locais sem modificar Product State |
| Segurança/privacidade | sem analytics, sem bibliotecas exigindo backend, sem uso de WebBluetooth real, sem coleta de dados, CSP/escapamento conforme viabilidade em host estático |

## Cenários mínimos de aceite manual da série

1. **Primeiro uso:** dispositivo sem Mouse salvo → SEARCHING FIRST MOUSE, joystick didático, botão virtual conecta e primeira conexão.
2. **Conectado e navegação:** HOME CONNECTED com quatro rotas; todas alcançáveis via Joy Press e retorno via B; Help e Lock independentes.
3. **Mouse salvo desconectado:** busca, cancelamento, Help, timeout, retry e reconexão sem perda de salvos.
4. **Novo par:** Pair New e retry; novo Mouse ganha ID separado; mouse atual e dados de outros bonds não são apagados.
5. **Passthrough/Custom:** edição e apply, cancelar edição não aplicada, fonte MODIFIER única, trocar Modifier preservando slots não destruídos.
6. **Movement:** velocidades de 0.25× a 3×, quatro rotações, eixos independentes, Reset All; teste em dois Mouses e depois de recarregar o browser.
7. **Combinations:** 6 páginas, duas opções em duas linhas, UNAVAILABLE, foco na segunda linha com pipe; `RESET SELECTED` sem limpar outros slots; 5 páginas/30 atalhos.
8. **MNT-12:** todos quatro estados de predicado aplicado (Custom com/sem modifier, Passthrough com/sem dados salvos), ciano correto em remap e combinações; status UNAVAILABLE intacto.
9. **MNT-13:** varrer todas as telas com listas e verificar pipe único `|`; sem deslocamentos horizontais ou texto sobreposto.
10. **Delete:** remover Mouse conectado/desconectado, confirmar/voltar/Help, reordenar página, re-pair com nome igual e assegurar defaults sem vazamentos.
11. **Inspector:** selecionar por click/Tab, conferir bounds/ID, copiar referência e exportar PNG/JSON local; desabilitar Inspector não muda framebuffer.
12. **Responsive/accessibility:** janela grande, notebook 1366px, 2K/HiDPI, smartphone portrait/landscape, zoom do browser, navegação só teclado, foco visível e toque; botão jamais fora de alcance.
13. **Brilho:** 0/1/50/100%, out-of-range/NaN/clamping, Lock→apagado→unlock→último valor; magenta web ajustado sem introduzir gain 750%.
14. **Deploy/README:** `https://remappingbridge.github.io/` carrega sem 404, recursos relativos têm caminhos corretos, browser console sem erros, prévia README abre app, links UF2 e checksums correspondem à release mais recente realmente publicada.

## Goldens e testes de regressão

- Extrair de firmware C em SHA declarado: ID de tela, 9 strings/linhas, número/índice de opções, transições por controle, paleta nominal e limites; portar como fixtures JSON sem runtime/Node.
- Gerar matriz de screenshot por cenário/foco no desktop `mouse-ui` e comparar com Canvas web (pixel exato onde possível). Comparação de fundo magenta em máscara separada pelo desvio aprovado; preferir checks semânticos para diferença de composição do display/browser.
- Portar ao harness browser os testes originais `tests/vendor/test_mnt12_modifier_cyan.c` e `test_mnt13_selection_marker.c` do `mouse-ui`/firmware; executar mesma matriz de estados em JS. Não confundir “testes C importados” com testes realmente executados no navegador.
- Criar casos específicos para overflow da grade 21 colunas, limites de 8 Mouse salvos, foco na segunda linha, nomes `MOUSE` em qualquer posição, 100% brightness, URL e cache.
- Inspeções visuais por operador em cada gate, e varredura end-to-end completa em WEB-10 e WEB-15. Documentar claramente cobertura **simulada**, não testes de hardware/UF2.
- Não mudar test fixture automaticamente para esconder regressão; qualquer diff C↔JS precisa explicação, revisão e aceite.

## Estado de aceite

Por enquanto **PENDING** em todas as linhas. Falha de testes bloqueia gate. “Website publicado” prova hospedagem, não validade dos controles, paridade ou acessibilidade. Documentação escrita não prova montagem real. Integração entre os dois repositórios só é fechada após WEB-15 aceito.
