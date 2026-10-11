# MOD-07 — Aceite físico desde HOME conectada

**Status: CI 72/72 PASS + UF2 VERIFIED / PENDING PHYSICAL ACCEPTANCE.** [Candidato](candidate.md): commit `0b62137494ce34a86bbecb8d8ee42a7cdfa42385`, [Actions #366](https://github.com/remappingbridge/remappingbridge/actions/runs/38149731598), UF2 **942592 bytes**, SHA256 **`2f934c507e8502029114ffc4075363b108e23185c51cf28abb022884fc35a576`**, [artifact original](https://github.com/remappingbridge/remappingbridge/actions/runs/38149731598/artifacts/11705632305). Gravar UF2 sem flash_nuke. Primeiro host de referência: **Linux desktop**, com editor, gerenciador de arquivos e navegador. Não iniciar MOD-08.

## Procedimento

Usar Mouse Bluetooth pareado e conectado ao Pico 2 W; Pico ligado por USB ao Linux. Na HOME: REMAPPING OPTIONS → CUSTOM REMAPPING → LEFT WILL BECOME → MODIFIER → KEY A APPLY AND BACK → KEY A APPLY CUSTOM. Para cada ação, HOME → REMAPPING OPTIONS → MODIFIER SHORTCUTS → COMBINATIONS → escolher uma combinação disponível (ex.: MOD+RIGHT CLICK, MOD+WHEEL UP ou MOD+MOVE LEFT) → JOY PRESS → SHORTCUTS página correta → ação → KEY A APPLY AND BACK. Acionar fisicamente a combinação e verificar efeito real no aplicativo, não apenas o nome no LCD.

- [ ] **01 — Upgrade/regressão:** dados de BT, Mouse Movement, Save Devices ciano somente nome conectado, telas e 12 slots, Mod Released Escape e Copy conservados.
- [ ] **02 — Edição:** COPY Ctrl+C, CUT Ctrl+X, SELECT ALL Ctrl+A, PASTE Ctrl+V, UNDO Ctrl+Z, REDO Ctrl+Shift+Z em editor Linux com texto de teste. REDO pode variar entre aplicativos; registrar qual funciona.
- [ ] **03 — Teclas independentes:** ESCAPE, SPACE, ENTER/RETURN, BACKSPACE e DELETE (Forward Delete) geram eventos corretos, especialmente diferença entre Backspace e Delete.
- [ ] **04 — Gerenciador de arquivos:** RENAME envia F2 em um arquivo de teste (sem renomear dados importantes).
- [ ] **05 — Browser/app:** FULL SCREEN F11; REFRESH Ctrl+R; FIND Ctrl+F; SAVE Ctrl+S em contextos de teste. Conferir dependência da aplicação.
- [ ] **06 — Captura:** SCREENSHOT FULL envia Print Screen; SCREENSHOT AREA envia Shift+Print Screen. Verificar comportamento do compositor Linux, registrando restrições de Wayland/X11 se houver.
- [ ] **07 — Home e zoom:** HOME SCREEN/PAGE apenas tecla Home (início do documento/página, não Mostrar Área de Trabalho); ZOOM IN Ctrl+Keypad Plus, ZOOM OUT Ctrl+Keypad Minus, RESET ZOOM Ctrl+0 em Firefox ou aplicação que reconheça esses comandos. Verificar layout BR ABNT2.
- [ ] **08 — Fontes físicas:** atribuir algumas ações novas tanto a MOD+RIGHT CLICK quanto MOD+WHEEL UP e MOD+MOVE LEFT. Cada botão, detent e gesto aciona o mesmo mapeamento HID; sem clique ou scroll/movimento capturado vazando.
- [ ] **09 — Estado de teclado e USB busy:** manter ação pressionada na combinação física: **um** comando somente, sem autorepeat. Na liberação do modificador não aparece Escape extra. Desconectar/reconectar USB e trocar perfil; nenhuma tecla Ctrl/Shift/Key fica presa. Se não reproduzir USB endpoint busy, registrar explicitamente.
- [ ] **10 — Fila e segurança:** executar várias ações em sequência, verificar ordem e liberação entre comandos. Backspace vs Delete e Ctrl+Shift devem liberar suas teclas e modificadores mesmo com outras teclas reais pressionadas. 6KRO original mantém integridade.
- [ ] **11 — Ações não implementadas:** atribuir PLAY/PAUSE, VOLUME UP e BRIGHTNESS UP a combos e acioná-los; não podem produzir teclas falsas nem serem alegadas funcionais. MOD-08 é responsável por Consumer HID.
- [ ] **12 — Persistência/reboot:** desligar e ligar Pico, reconectar Mouse, verificar ações, slots mascarados, DPI H/V e Rotation 90/270, lock Y/unlock e Passthrough (atalhos inertes) e volta ao Custom.

**Aceite exige mensagem explícita do operador.** A CI demonstra traduções USB, não a execução real em aplicativos ou no compositor. Nenhuma publicação/merge antes do aceite.
