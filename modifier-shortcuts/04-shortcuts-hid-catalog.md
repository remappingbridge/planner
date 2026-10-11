# 04 — Catálogo 30/30, tradução HID e compatibilidade de host

## Distinção obrigatória
Os 30 nomes do anexo são **ações semânticas**, não códigos USB universais. Não assumir equivalência Mac/Windows/Linux; o firmware USB v2.0 possui Mouse e **Keyboard** (6KRO + 8 modificadores), sem **Consumer Control**. Para volume e mídia o HID Keyboard comum NÃO oferece usos Consumer equivalentes. Brightness também depende do host e de capacidades HID distintas. Não afirmar suporte integral sem resolver este bloqueio.

## Inventário indexado e proposta de tradução
| ID | Label literal | Classe | Exemplo provável em Linux/Windows; situação |
|---:|---|---|---|
| 1 | COPY | KeyboardChord | Ctrl+C |
| 2 | CUT | KeyboardChord | Ctrl+X |
| 3 | SELECT ALL | KeyboardChord | Ctrl+A |
| 4 | PASTE | KeyboardChord | Ctrl+V |
| 5 | UNDO | KeyboardChord | Ctrl+Z |
| 6 | REDO | HostSpecific | Ctrl+Shift+Z ou Ctrl+Y; depende do aplicativo |
| 7 | ESCAPE | KeyboardKey | HID Escape 0x29; existente |
| 8 | SPACE | KeyboardKey | Space 0x2C |
| 9 | ENTER\RETURN | KeyboardKey | Enter 0x28 |
| 10 | BACKSPACE | KeyboardKey | Backspace (Keyboard usage) |
| 11 | DELETE | KeyboardKey | Delete Forward, **não** Backspace |
| 12 | RENAME | HostSpecific | F2 em muitos gerenciadores; não universal |
| 13 | FULL SCREEN | HostSpecific | F11 em browsers; aplicativos podem usar outra tecla |
| 14 | SCREENSHOT FULL | HostSpecific | Print Screen / outro chord dependendo do desktop |
| 15 | SCREENSHOT AREA | HostSpecific | Shift+PrintScreen / Win+Shift+S / macOS Shift+Cmd+4 |
| 16 | REFRESH | HostSpecific | F5 ou Ctrl+R; depende do aplicativo |
| 17 | FIND | KeyboardChord | Ctrl+F em Linux/Windows |
| 18 | SAVE | KeyboardChord | Ctrl+S em Linux/Windows |
| 19 | PLAY\PAUSE | ConsumerUsage | Consumer Play/Pause; **não existe no descritor v2** |
| 20 | NEXT TRACK | ConsumerUsage | Consumer Scan Next Track; **gap HID** |
| 21 | PREVIOUS TRACK | ConsumerUsage | Consumer Scan Previous Track; **gap HID** |
| 22 | VOLUME UP | ConsumerUsage | Consumer Volume Increment; **gap HID** |
| 23 | VOLUME DOWN | ConsumerUsage | Consumer Volume Decrement; **gap HID** |
| 24 | MUTE | ConsumerUsage | Consumer Mute; **gap HID** |
| 25 | HOME SCREEN\PAGE | HostSpecific | Home (página) versus Show Desktop (sistema): **semântica ambígua** |
| 26 | ZOOM IN | HostSpecific | Ctrl++ em alguns aplicativos; navegador/desktop distintos |
| 27 | ZOOM OUT | HostSpecific | Ctrl+- em alguns aplicativos |
| 28 | RESET ZOOM | HostSpecific | Ctrl+0 em browsers; aplicativo-dependente |
| 29 | BRIGHTNESS UP | HostSpecific/Consumer | Suporte do OS/backlight dependente de HID/driver; **gap HID** |
| 30 | BRIGHTNESS DOWN | HostSpecific/Consumer | Idem; **gap HID** |

Para macOS, muitos atalhos de edição usam **Command** em vez de Ctrl; Full Screen, screenshots, zoom e outros variam. A Raspberry Pi Pico 2 W não recebe detecção confiável do SO apenas por ser USB HID. Portanto, não montar a lista como chords fixos e afirmar portabilidade universal.

## ADR-HID-01 (bloqueante antes da implementação)
**Alternativa A — preferida para cobertura dos 30**: adicionar Consumer Control por extensão do **descritor HID Keyboard atual**, com Report IDs, preservando VID/PID, quantidade de interfaces e Mouse interface. Isso altera o formato de reports e pode afetar Boot Keyboard, hosts e BIOS: fazer protótipo host+Pico em gate técnico, validar enumeração, teclado anterior, mídia e regressões. Decisão somente após evidência.

**Alternativa B**: terceiro HID interface Consumer dedicado, preservando a interface Keyboard v2 mas **mudando o número de interfaces e a identidade contratada**; exige decisão explícita de produto e testes no host. Não fazê-lo silenciosamente.

**Alternativa C**: manter descritor idêntico e mapear onde possível a chords de teclado; 19..24/29..30 **não seriam universalmente entregues**; produto 30/30 bloqueado se esta alternativa for exigida.

A arquitetura separa `ShortcutAction` de `USB representation` para avaliar A/B/C **sem alterar telas ou IDs**. IDs 1..30 estáveis; `UNAVAILABLE`/`NOT CUSTOMIZED` nunca geram evento USB.

## ADR-HOST-02 (bloqueante)
Definir alvo principal e política para Linux (ambiente desktop e compositor), Windows e macOS; não há nova tela de seleção de plataforma no anexo. Opções: preset fixo documentado com limitações; plataforma configurável por outro mecanismo aprovado; ou produto restrito a um host explicitamente suportado. Recomenda-se **Linux desktop como primeiro ambiente de prova**, mas sem assumir universalidade nem modificar layout. Definir:
- comportamento exato de RENAME, FULL SCREEN, REFRESH, SCREENSHOTs, REDO e HOME SCREEN\PAGE;
- se ZOOM significa navegador/aplicação ou zoom do sistema;
- política para BACKSPACE vs DELETE e variação de layout internacional `+/-`;
- mídia e brilho na máquina-alvo; evento HID recebido ≠ função executada pelo sistema;
- comportamento quando ação não suportada: nunca emití-la como falsa "sucesso"; UI continua mostrando a atribuição e documentação registra dependência.

## Contrato de testes por ação
Para os 30 IDs: 1 teste de catálogo/ordem/texto; 1 teste de encoding/executor/keyup; 1 teste integração saída USB na plataforma alvo (observando ação real, não apenas bytes); repetição em outras plataformas declaradas suportadas. Os oito IDs de Consumer/brightness (19..24,29..30) exigem validar interface/relatório HID antes da afirmação de cobertura. Critério de publicação **não é** "compila": é "30 IDs mapeados + comportamento aceito, ou suporte limitado explicitamente aprovado".
