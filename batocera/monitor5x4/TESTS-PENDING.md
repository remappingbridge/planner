# Testes pendentes — monitor 5:4

Status: a detecção do Dell P1917S, a seleção de 1280x1024 @ 75.02, a troca manual `gameStart` -> 60.02, a volta `gameStop` -> 75.02 e `global.ratio=full` foram validadas.

Ainda falta validar em uso real:

- [ ] Reiniciar o Batocera e confirmar que `display_manager` inicia automaticamente.
- [ ] Confirmar após reboot: Dell P1917S -> 1280x1024 @ 75.02 Hz.
- [ ] Abrir um jogo real e confirmar via SSH que `gameStart` muda para 60.02 Hz.
- [ ] Sair do jogo e confirmar que `gameStop` retorna para 75.02 Hz.
- [ ] Validar visualmente `global.ratio=full` em um core Libretro (ex.: SNES, Mega Drive ou arcade).
- [ ] Validar `global.ratio=full` em emuladores standalone, especialmente PS2 e GameCube/Wii.
- [ ] Registrar quais emuladores ignoram `global.ratio=full` e precisam de regra específica.
- [ ] Reiniciar sem o Dell/sem HDMI e confirmar que a tela interna usa seu modo preferido e `global.ratio=auto`.
- [ ] Conectar outro monitor HDMI, reiniciar e confirmar `--preferred` + `global.ratio=auto`.
- [ ] Confirmar que trocar para outro monitor não deixa `global.ratio=full` residual.
- [ ] Testar o SSD do Batocera em outro notebook.
- [ ] Verificar nesse outro notebook os nomes DRM/Xrandr usados para HDMI e display interno.
- [ ] Tornar a descoberta de conectores dinâmica se o outro notebook não usar `card0-HDMI-A-1`, `HDMI-1` e `LVDS-1`.
- [ ] Avaliar suporte dinâmico também para DisplayPort/VGA/eDP.
- [ ] Decidir se hotplug durante a sessão precisa ser suportado; hoje a detecção principal ocorre no start do serviço.
- [ ] Se hotplug for necessário, implementar e validar reação a conectar/desconectar o Dell sem reboot.
- [ ] Confirmar que bezel/overlays e configurações por sistema não anulam o efeito de stretch desejado.
- [ ] Confirmar que configurações específicas de jogos/sistemas não sobrescrevem o `global.ratio`.

## Critério de conclusão

A configuração será considerada portátil e concluída quando:

1. o Dell P1917S for reconhecido por EDID em todos os computadores-alvo;
2. frontend e jogos alternarem 75.02/60.02 Hz corretamente;
3. stretch funcionar nos emuladores desejados;
4. qualquer outro display usar automaticamente seu modo preferido sem stretch;
5. não houver dependência incorreta de nomes fixos de conector entre os computadores.
