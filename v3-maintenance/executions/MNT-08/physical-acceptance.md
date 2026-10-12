# MNT-08 — validação física conjunta MNT-07 + MNT-08

**STATUS: PENDING / sem aceite físico do MNT-08.** A versão MNT-07 (v3.1.2) já possui aceite formal para publicação, condicionado à avaliação física conjunta com este gate.

1. Gravar UF2 candidato do MNT-08 no Pico 2 W em BOOTSEL, sem `flash_nuke`; manter mouse pareado e configurações.
2. Desde HOME CONNECTED abrir **MOVEMENT OPTIONS**. O valor informativo do item não selecionado é ciano normal `0x07FF`; ao focar a linha o valor passa a ciano clarinho `0xD7FF`, enquanto o texto da opção fica branco. Ao trocar de linha, o valor anterior retorna ao ciano normal. Verificar DPI Horizontal, Vertical e Rotation.
3. Entrar em configurações de **Slow/Fast DPI** e **Rotation**. Item CURRENT sem foco = ciano normal, CURRENT focado = ciano clarinho; item comum sem foco = cinza, item comum focado = branco. Não modificar valores inadvertidamente.
4. Na tela **REMAPPING OPTIONS**, percorrer PASSTHROUGH e CUSTOM. Perfil ativo normalmente ciano normal; com foco ciano clarinho; outras opções cinza/branco. Verificar os fluxos CUSTOM REMAPPING / WILL BECOME: mapeamento aplicado/atual recebe ciano normal sem foco e ciano clarinho ao ganhar foco, rascunho não aplicado permanece cinza/branco.
5. Nos **SHORTCUTS 1–5** navegar até uma ação atribuída: sua cor muda de ciano normal para ciano clarinho somente quando selecionada; ações não atribuídas continuam cinza/branco. Na tela COMBINATIONS, foco da dupla continua branco; valores UNAVAILABLE continuam estáticos e nunca são pintados de ciano.
6. Em **SAVED DEVICES**, o nome do mouse conectado é informativo e permanece em ciano normal (sem foco) mesmo ao paginar; o nome desconectado permanece amarelo; REMOVE DEVICE permanece branco; hints cinza; título magenta. Nenhum outro texto da tela vira ciano por receber foco.
7. Conferir legibilidade conjunta de **ciano normal sem foco + ciano clarinho selecionado** sob iluminação real, sem regressão de contraste para baixa visão. Validar também HOME, HELP, mouse Bluetooth, USB HID e persistência sem mudanças.

**Aceite físico MNT-07 definitivo:** será registrado após o aceite físico MNT-08.
**Aceite físico MNT-08:** PENDING.
**Publicação SemVer v3.1.3:** somente após aprovação explícita.

## Revisão solicitada antes do aceite
O usuário aprovou a aparência dos dois tons, mas **inverteu os papéis**: o ciano normal `0x07FF` deve voltar ao estado padrão; o ciano clarinho `0xD7FF` deve identificar a seleção de CURRENT. A alteração é semântica, não de valores RGB. Estes cenários substituem os da primeira versão candidata; não inferir aceite físico.
