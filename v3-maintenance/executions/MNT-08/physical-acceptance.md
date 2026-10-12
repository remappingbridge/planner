# MNT-08 — validação física conjunta MNT-07 + MNT-08

**STATUS: PENDING / sem aceite físico do MNT-08.** A versão MNT-07 (v3.1.2) já possui aceite formal para publicação, condicionado à avaliação física conjunta com este gate.

1. Gravar UF2 candidato do MNT-08 no Pico 2 W em BOOTSEL, sem `flash_nuke`; manter mouse pareado e configurações.
2. Desde HOME CONNECTED abrir **MOVEMENT OPTIONS**. O valor informativo do item não selecionado é ciano pastel `0xD7FF`; ao focar a linha o valor passa a ciano normal `0x07FF`, enquanto o texto da opção fica branco. Ao trocar de linha, o valor anterior retorna ao pastel. Verificar DPI Horizontal, Vertical e Rotation.
3. Entrar em configurações de **Slow/Fast DPI** e **Rotation**. Item CURRENT sem foco = pastel, CURRENT focado = ciano normal; item comum sem foco = cinza, item comum focado = branco. Não modificar valores inadvertidamente.
4. Na tela **REMAPPING OPTIONS**, percorrer PASSTHROUGH e CUSTOM. Perfil ativo normalmente pastel; com foco ciano normal; outras opções cinza/branco. Verificar os fluxos CUSTOM REMAPPING / WILL BECOME: mapeamento aplicado/atual recebe pastel sem foco e ciano normal ao ganhar foco, rascunho não aplicado permanece cinza/branco.
5. Nos **SHORTCUTS 1–5** navegar até uma ação atribuída: sua cor muda de pastel para ciano normal somente quando selecionada; ações não atribuídas continuam cinza/branco. Na tela COMBINATIONS, foco da dupla continua branco; valores UNAVAILABLE continuam estáticos e nunca são pintados de ciano.
6. Em **SAVED DEVICES**, o nome do mouse conectado é informativo e permanece em pastel mesmo ao paginar; o nome desconectado permanece amarelo; REMOVE DEVICE permanece branco; hints cinza; título magenta. Nenhum outro texto da tela vira ciano por receber foco.
7. Conferir legibilidade conjunta de **ciano pastel + ciano normal** sob iluminação real, sem regressão de contraste para baixa visão. Validar também HOME, HELP, mouse Bluetooth, USB HID e persistência sem mudanças.

**Aceite físico MNT-07 definitivo:** será registrado após o aceite físico MNT-08.
**Aceite físico MNT-08:** PENDING.
**Publicação SemVer v3.1.3:** somente após aprovação explícita.
