# WEB-01 — Cenários manuais de aceite (PENDENTES)

Antes de testar, usar a branch `web/web-01-static-app-foundation` do repositório `remappingbridge.github.io`. Por ser uma PR draft, a URL pública Pages **não** é alegada disponível.

### Cenários, em sequência

- [ ] **01. Abrir local:** `index.html` pelo navegador via `file://`. Confirmar CSS/JS carregados sem erro e nenhuma navbar/footer/landing.
- [ ] **02. Fonte simples:** a prévia textual exibe `SEARCHING FIRST MOUSE`, joystick e linhas KEY A/B/X/Y; nenhum texto é cortado pela borda. Trata-se de texto HTML, não pixel-perfect LCD.
- [ ] **03. HAT:** clicar cada uma das nove teclas virtuais; todas exibem feedback com o identificador correto e incrementam o contador.
- [ ] **04. Botão Limpar:** após pelo menos dois eventos, Limpar retorna a contagem a `00` e ao texto inicial. Não altera o firmware.
- [ ] **05. Estado pressionado:** pointer/touch mantém feedback de botão pressionado enquanto houver pressão e restaura o aspecto após soltar/cancelar.
- [ ] **06. Keyboard-only:** usar Tab e Enter/Espaço nos botões HTML nativos, verificar foco visível e acionamento por acessibilidade de controles, sem confundir com as futuras teclas de mapeamento global HAT (WEB-03).
- [ ] **07. Responsividade:** desktop amplo, janela estreita, 320px e orientação de celular; no móvel estreito joystick e teclas ficam empilhados para evitar corte.
- [ ] **08. Testes automáticos no navegador:** abrir `tests/index.html` diretamente, confirmar **14/14 PASS** visíveis. Se falhar, enviar erro/texto; não marcar PASS antecipadamente.
- [ ] **09. HTTP sem toolchain:** na raiz do repo, opcionalmente executar `python3 -m http.server 8000`; abrir `http://localhost:8000/` e `http://localhost:8000/tests/`; confirmar assets relativos.
- [ ] **10. Sem build/Actions/UF2:** verificar ausência de npm/Node/package.json, scripts remotos, workflows autorais e comandos que acessem BLE/USB físico.
- [ ] **11. Escopo:** confirmar que o site anuncia “WEB-01 prévia” e explicitamente não oferece navegação, Canvas, perfis/Movement, BLE ou controle de brilho ainda.

**Resultado atual:** NÃO EXECUTADO PELO OPERADOR — aguardando teste/aceite. Se reportar bug, corrigir na mesma branch/gate e revalidar; não adiantar WEB-02.
