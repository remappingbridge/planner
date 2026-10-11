# MOD-08 — Correção após relato físico (2026-10-11)

**Estado:** bugs reportados pelo operador; correções candidatas na MESMA branch `feature/modifier-shortcuts-mod08`, sem liberar MOD-09. Não confundir PASS dos testes de host com sucesso das ações no hardware do usuário.

## Evidência física recebida
O operador constatou no firmware MOD-08 inicial:
1. `SCREENSHOT AREA` fazia screenshot integral no KDE Plasma, não seleção retangular por arraste enquanto mantendo o Modifier.
2. VOLUME UP/DOWN e MUTE não se manifestavam no KDE Plasma.
3. PLAY/PAUSE, NEXT TRACK, PREVIOUS TRACK não se manifestavam em player de música nem navegador KDE.
4. BRIGHTNESS UP/DOWN não se manifestavam no KDE.
5. HOME SCREEN/PAGE (HID Keyboard Home 0x4A) não retornava à tela inicial do Android/Google TV; significado desejado: **Home do sistema**, não início de texto/página.
6. ZOOM IN/OUT funcionavam em navegador mas não no Obsidian KDE; RESET ZOOM funcionava.

## Hipóteses fundamentadas e implementação
- **Screenshot KDE:** Documentação oficial do Spectacle confirma `Meta+Shift+Print Screen` para selecionar região; `Shift+Print Screen` captura desktop completo. Corrigido ID 15 em `keyboard_catalog.c` para HID PrintScreen + Left Meta + Left Shift. `Modifier + botão` invoca overlay de região. Enquanto esse modo estiver armado, movimento do Mouse é encaminhado ao cursor mesmo se houver MOVE configurado. Após **soltar apenas o botão secundário que acionou a captura, mantendo Modifier**, pressioná-lo outra vez inicia um **clique LEFT sintético** que permite arrastar a seleção e soltar para concluir. Release do Modifier durante o drag libera Left; BLE/USB/profile cancel libera fonte sintética independente. Não é possível assumir que a janela de seleção já exista no instante da primeira pressão; o segundo pressionamento explícito evita iniciar drag antes de o Spectacle estar pronto. O cursor deve ficar livre até a seleção ser concluída. Se o usuário atribuiu Screenshot Area a WHEEL/MOVE, somente abertura do overlay é implementada; para seleção arrastada enquanto Modifier held, usar MOD+botão.
- **HOME Android/Google TV:** documentação do subsistema de entrada Android relaciona HID Consumer AC Home usage 0x0223 → Linux KEY_HOMEPAGE → Android KEYCODE_HOME. Mudamos ID 25 de Keyboard Home 0x4A (movimentação textual) para HID Consumer AC Home 0x0223. **Comportamento real no Google TV depende do suporte da implementação Android**; precisa validação em USB.
- **Zoom Obsidian:** mudança de ID 26 para Ctrl+Shift+HID Equal (equivalente a `Ctrl++` em layout US) e ID 27 para Ctrl+HID Minus na linha principal, em vez de Ctrl+teclado numérico +/-; RESET ZOOM Ctrl+0 preservado. Isso é candidato para Obsidian/Electron e KDE ABNT2; não garantir sem teste da aplicação/layout.
- **Media/Volume/Brightness KDE:** IDs 19..24,29..30 já tinham usos HID Consumer semanticamente corretos. Não foram trocados por falsos atalhos Keyboard. Como tentativa de aumentar observabilidade em USB e KDE, o domínio agora segura Consumer pressionado por **pelo menos 60ms** após o primeiro relatório aceito, antes de enviar o relatório 0 de release; Keyboard mantém pelo menos 25ms. Timings via tick não-bloqueante; endpoint busy e FIFO/ACK preservados. Essa correção NÃO prova que o Linux expõe `KEY_PLAYPAUSE`, `KEY_VOLUMEUP`, `KEY_BRIGHTNESSUP` nem que Plasma/driver tratará tais eventos. Pode persistir falta de função por enumeração/report protocol, KDE policy ou hardware backlight.
- A contagem semântica continua 30 IDs; agora **21 IDs Keyboard + 9 IDs Consumer** (HOME migrou de classe, não houve remoção de função).

## Cenários manuais direcionados — iniciar HOME CONNECTED
1. Regravar somente UF2 candidato MOD-08 corrigido (não flash_nuke). Verificar HID Mouse, Keyboard e Consumer no Linux.
2. Custom LEFT=MODIFIER. Em MODIFIER SHORTCUTS atribuir SCREENSHOT AREA ao MOD+RIGHT. Pressionar e segurar LEFT; clicar RIGHT e soltar RIGHT (continuar LEFT held): Spectacle deve mostrar seleção retangular, não screenshot completo. Com o overlay visível, pressionar RIGHT outra vez, arrastar Mouse para desenhar a região e soltar RIGHT para concluir. Só então soltar LEFT. Confirmar arquivo/captura na região escolhida, sem cursor congelado e sem clique esquerdo preso. Repetir com MOVE directional já atribuído, arrastando mesmo assim.
3. Testar ZOOM IN, ZOOM OUT e RESET ZOOM tanto em Obsidian KDE quanto Firefox. Documentar layout de teclado do KDE e diferenças.
4. Testar HOME no Android/Google TV por USB: sair de um aplicativo ou tela interna para a HOME do sistema; confirmar que não é apenas mover o cursor para início de texto.
5. No KDE Plasma, abrir player que aceita comandos multimídia e testar PLAY/PAUSE, NEXT/PREVIOUS, VOLUME UP/DOWN, MUTE, BRIGHTNESS UP/DOWN. Anotar eventos recebidos e efeito real separadamente.
6. Diagnóstico KDE se mídia/volume não responder: instalar `evtest` e `usbutils` via apt se necessário; executar `sudo evtest`; selecionar evento HID `BLU2USB` Keyboard/Consumer e acionar ações. Esperar `KEY_PLAYPAUSE`, `KEY_NEXTSONG`, `KEY_PREVIOUSSONG`, `KEY_VOLUMEUP`, `KEY_VOLUMEDOWN`, `KEY_MUTE`, `KEY_BRIGHTNESSUP`, `KEY_BRIGHTNESSDOWN`. Nenhum evento: verificar report IDs/boot mode/descriptor. Eventos sem efeito: diagnosticar atalhos globais Plasma, sessões/compositor, player e suporte a backlight sem presumir falha do firmware.
7. Repetir Copy/Paste/UNDO, mod-release Escape, Wheel/MOVE, rotação, DPI, mouse desconectar/reconectar, USB hotplug, Lock/unlock, persistência de atribuições e Save Devices, incluindo cancelamento de drag da seleção durante perda de BLE/USB.

**Gate:** aceite MOD-08 ainda PENDENTE. Não avançar ao MOD-09 nem publicar firmware. Resultado deve distinguir comandos HID emitidos, eventos Linux recebidos e efeitos funcionais reais; brilho pode não ser controlável via Consumer na tela usada.

## Evidência adicional do operador — zoom Obsidian (2026-10-11)

O operador confirmou no **mesmo Debian 13 KDE Plasma** que **ZOOM IN e ZOOM OUT funcionam perfeitamente no Obsidian pelo teclado físico do notebook**, porém continuam **sem efeito quando gerados pelo RemappingBridge corrigido**. **RESET ZOOM funciona pelos dois**; ZOOM IN/OUT do RemappingBridge continuam funcionando no navegador. Portanto, a limitação NÃO deve ser tratada apenas como "Obsidian não suporta Ctrl+Plus/Minus", nem considerada aceite da ação para o Obsidian.

Mapeamento atual do firmware, independente do Obsidian:
- ID 26: HID Keyboard **Left Ctrl + Left Shift + Equal (usage 0x2E)**, previsto para produzir Ctrl+Plus no layout.
- ID 27: HID Keyboard **Left Ctrl + Minus (usage 0x2D)**.
- ID 28: HID Keyboard **Left Ctrl + 0 (usage 0x27)**, comprovado fisicamente.
- XKB brasileiro ABNT2 associa `AE12` a `equal, plus` (Shift), mas variantes/layouts e teclas efetivamente pressionadas podem diferir. A correção precisa se apoiar nos códigos reais usados pelo notebook.

**Decisão técnica:** NÃO alterar temporariamente o mapa HID com teclas específicas do Obsidian ou duplicar códigos cegamente. Executar no host:
1. `sudo apt install evtest`; `sudo evtest`; selecionar teclado integrado do notebook; pressionar os mesmos Ctrl+Plus e Ctrl+Minus que funcionam no Obsidian; registrar `KEY_*` e `EV_KEY value` de cada tecla, inclusive Ctrl e Shift.
2. `sudo evtest`; selecionar **BLU2USB** Keyboard; disparar ZOOM IN e ZOOM OUT pelo Modifier. Comparar códigos EV_KEY e ordem press/release com teclado integrado.
3. Se **códigos diferirem**, corrigir HID usages/configuração de layout de modo genérico e repetir navegador+Obsidian+RESET; se **iguais**, investigar estado de modificadores, down/up de 25ms, sequência e repetição sem criar mapeamento de aplicativo. O EV_KEY registra entrada mesmo em sessão Wayland, sem depender de X11.
4. **Não registrar comportamento como PASS no Obsidian** até evidencia física equivalente, e manter o MOD-08 pendente de aceite/decisão do operador. Nenhum código/UF2 adicional foi gerado por este relato.

Evidência baseada na reprodução real reportada, não em alegação de teste no computador por CI.
