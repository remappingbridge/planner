# MOD-08 — Testes físicos Consumer Control desde HOME conectada

**Status: PENDENTE DE ACEITE FÍSICO.** Partir de Mouse BLE já pareado, Pico 2 W em USB de computador Linux desktop. Use o UF2 e SHA256 do [candidate.md](candidate.md) quando CI concluir; gravar via BOOTSEL sem apagar flash/pareamentos.

- [ ] **01 — Upgrade e reconhecimento USB:** fazer BOOTSEL sem flash_nuke, boot e reconexão automática do BLE. Rodar `lsusb -v` para verificar **2 interfaces HID**, mesmo VID/PID, Mouse separado e teclado com coleção Consumer (IDs 1 e 2 na interface 1). Se necessário inspecionar descritor via ferramenta local. Documentar erros de enumeração e logs do kernel.
- [ ] **02 — Keyboard regressão:** em editor Linux, confirmar COPY/CUT/PASTE/UNDO/REDO e Escape. Teclado existente 6KRO continua em 8 bytes de payload Report ID 1; Boot Keyboard deve continuar válido, se ambiente de teste permitir avaliar Boot Protocol.
- [ ] **03 — PLAY/PAUSE:** na HOME → Remapping Options → Custom Remapping → LEFT WILL BECOME → MODIFIER (se ainda não configurado) → KEY A → APPLY CUSTOM. HOME → Modifier Shortcuts → escolher MOD+RIGHT CLICK → catalog página 4/5 → PLAY/PAUSE → KEY A APPLY AND BACK. Abrir player de áudio/vídeo, acionar uma vez; alternância toca/pausa sem click direito nem Escape na liberação.
- [ ] **04 — NEXT/PREVIOUS:** atribuir NEXT TRACK e PREVIOUS TRACK em outro ciclo; verificar salto real de faixas no player e não falso teclado.
- [ ] **05 — Volume:** atribuir VOLUME UP, VOLUME DOWN, MUTE; verificar volume real do computador Linux e restaurar nível moderado. Nenhum ajuste involuntário enquanto Modifier não está apertado.
- [ ] **06 — BRIGHTNESS UP/DOWN:** com tela embutida e suporte de backlight, atribuir e acionar ambos; verificar **brilho real** com driver/compositor, não somente se um evento de tecla chegou. Se host externo não tiver suporte, registrar `HID recebido / efeito indisponível` sem aceitar falsamente essa função.
- [ ] **07 — Wheel e MOVE:** atribuir ações Consumer em MOD+WHEEL UP/DOWN e MOD+MOVE LEFT/RIGHT; confirmar envio uma vez por wheel unit / gesture, sem scroll/cursor indevido e sem Escape adicional.
- [ ] **08 — Códigos iguais e repetição:** múltiplas unidades de wheel geram keydown e keyup Consumer separados por unidade; botão mantido ou MOVE contínuo não repete evento sem novo gesto. MUTE não deve ficar preso.
- [ ] **09 — USB desconectado/ocupado:** testar desconectar/reconectar USB, bluetooth, perfil e HAT Lock durante um atalho; nenhuma tecla de volume/mídia deve ficar pressionada. Se endpoint ocupado não puder ser reproduzido, registrar limitação.
- [ ] **10 — Boot e Report Protocol:** se possível inspecionar comunicação em modo Boot Keyboard e modo Report; o Consumer só funciona em Report e a interface teclado não pode quebrar uso anterior nem enumeration em hosts Linux.
- [ ] **11 — Persistência e UX:** reiniciar Pico, confirmar 12 combos e 30 IDs preservados, UNAVAILABLE, Saved Devices apenas nome ativo ciano, Movement H/V e Rotation e Passthrough conservados.
- [ ] **12 — Plataforma e limite do brilho:** anotar desktop/compositor (KDE Plasma, GNOME etc.), versão do kernel, hardware de backlight e quais ações 19..24,29..30 tiveram **efeito funcional real**; não assumir Windows/macOS ou notebooks externos.

**Resultado do operador: PENDING.** 30 usages mapeados não significa 30 efeitos aprovados. Se brilho não funcionar, requer avaliação posterior da política e fallback; sem marcar MOD-08 aprovado somente por compilar. MOD-09 bloqueado, sem merge/tag/release.
