# Movement Options — implementação contínua e testes físicos por gate

Status: MOV-01–MOV-05 ACEITOS / MOV-06 HOST 53/53 PASS; PICO E ACEITAÇÃO FÍSICA PENDENTES.
MOV-05 commit `59c01a2bcec78267fa2b0baa0ddfa4989353a4c7`, CI https://github.com/remappingbridge/remappingbridge/actions/runs/38097711254, artifact `11686186807`, UF2 SHA256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e` (mesmo firmware MOV-04; não precisa gravar novamente).
MOV-04 SHA `036e5bd930b11b3c79ceeac6332dac7c21844d57`; CI https://github.com/remappingbridge/remappingbridge/actions/runs/38097344728; artifact `11686156439`; SHA256 UF2 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e` (mesmo binário do MOV-03, com novos testes host).
Commit MOV-03: `326c5f11164932aad5415783197d01cbc180de2e`; CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38096841875
Artefato GitHub Actions MOV-03: `11686925370`. UF2 SHA-256: `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`; 925.696 bytes.
Commit MOV-02: `f13425c2c1ec8642803fa2398cd3f67606d440e6`. CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38095384245
Artefato MOV-02: `11685218547`, UF2 `blu2usb_picow.uf2`, SHA-256 `ef6b259dc2f75a8b71f441a94873aa2d23ed49b06ada23ad2c1fd70256d9e91d`, 49/49 testes host.
Candidate commit: `ba64fdf9e1edd75c3f4f9be5116da8bb9f79fde8`.
CI run: https://github.com/remappingbridge/remappingbridge/actions/runs/38093980816
UF2 artifact ID: `11685815375` (`blu2usb-picow-production-pico2w`).
Extracted UF2 SHA256: `1fc96263e95d682347b27f54f9831b92b948836d89001cedbbfda29321d00930`.
Início: 2026-10-10.
Produto: remappingbridge/remappingbridge, branch `feature/movement-options-v1.0`.
Base congelada: `release/v1.0.0` @ `30c4dd87922bb566248832ba4716774c0cb29755`.
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Alteração da ordem de integração, autorizada pelo usuário

O usuário exigiu que cada candidato possa ser experimentado fisicamente a partir da HOME conectada e acompanhado por teste manual + UF2. Consequentemente, a entrada `HOME > MOVEMENT OPTIONS` foi conectada desde o primeiro estágio, antecipando exclusivamente a integração necessária da antiga MOV-07. A ordem de **aceitação** de telas permanece uma por gate; múltiplas telas preparadas na mesma branch NÃO equivalem a aceitação. Ações novas só podem anunciar sucesso depois da confirmação do armazenamento.

O PR é Draft; nunca mesclar para a versão 1.0 ou marcar um gate ACCEPTED sem a confirmação física do operador. O fluxo é construído sobre as telas reais, sem tela debug/fake. Arquivos de teste foram atualizados para a nova contagem de 38 telas, mantendo cenários de pareamento, desconexão, remapeamento, lock e remoção.

## Como obter e usar o candidato UF2

Cada revisão é compilada pelo job `pico2-w-production` do workflow `BLU2USB Canonical CI`, com Pico SDK/toolchain fixados. Um job bem-sucedido publica o artefato `blu2usb-picow-production-pico2w`, contendo `blu2usb_picow.uf2`. O artefato pertence ao **SHA exato** testado; não usar UF2 de run anterior para aceitar SHA posterior.

1. Abrir o CI do PR #22 e escolher a execução do SHA do candidato documentado.
2. Conferir `host-architecture: success` e `pico2-w-production: success`.
3. Baixar o artefato `blu2usb-picow-production-pico2w` e extrair `blu2usb_picow.uf2`.
4. Com o Pico 2 W desconectado, segurar BOOTSEL, conectar USB, soltar e copiar UF2 para a unidade RPI-RP2. Não apagar flash inteira: os bonds e preferências devem sobreviver.
5. Validar primeiro um mouse já salvo e a HOME conectada. Desabilitar Input Remapper/xinput que duplique a rotação.

## Cenários manuais separados por gate (executar na mesma ordem)

### MOV-01 — MOVEMENT OPTIONS
- C01: ligar Pico com mouse salvo, aguardar `home-connected`, observar 4 opções e selecionar a segunda `MOVEMENT OPTIONS`; JOY PRESS abre o menu verdadeiro.
- C02: confirmar título e HORIZONTAL DPI 1X, VERTICAL DPI 1X, COUNTERCLOCKWISE/ROTATION 0-DEGREE para mouse sem preferências preexistentes.
- C03: mover joystick Up/Down, confirmar envolvimento em 3 opções, seleção branca e valores confirmados ciano; duas linhas de rotação selecionadas como 1 item.
- C04: KEY B retorna à HOME; remapeamento da primeira opção, Saved Devices e Pair New continuam acessíveis.

### MOV-02 — horizontal-slow-dpi (aceito pelo operador em 2026-10-10)
- C05: HOME > MOVEMENT OPTIONS > HORIZONTAL DPI abre Slow quando H=1x; opção NORMAL selecionada.
- C06: valores 1, 0.75, 0.5, 0.25 na coluna 16; selecionar 0.75 e pressionar KEY B: cancelar sem modificar.
- C07: selecionar 0.5, KEY A aplica e volta ao menu mostrando H 0.5X em ciano; movimentação horizontal proporcional e valores V/rotação preservados.
- C07A (refinamento solicitado no MOV-02): em ROTATION, confirmar a legenda exata `KEY A: APPLY AND BACK` na linha 7 (21 colunas), sem alterar o efeito da tecla; retornar ao menu e testar novamente o percurso pela HOME.
- C07B: em H Slow, testar Key X Help e qualquer tecla Back (inclusive Key Y), mantendo a opção em branco e a aplicada em ciano; reboot confirma o H persistido.

### MOV-03 — horizontal-fast-dpi (ACCEPTED pelo operador em 2026-10-10)
- C08: horizontal Slow > JOY RIGHT passa ao Fast sem sair do eixo, JOY LEFT volta ao Slow; confirmar col17.
- C09: escolher VERY FAST 2x, KEY A; menu H 2X. Movimento longitudinal do mouse percorre o dobro da distância padrão **somente se a rotação selecionada encaminhar esse movimento ao eixo horizontal**.
- C10: usar 1.25x, 1.5x, 2x e 3x, percorrer diagonais e testar continuidade de movimento rápido; verificar que vertical e rotação não são alterados ao aplicar horizontal.
- C10A — melhoria de Saved Devices: HOME > SAVED DEVICES; na página do mouse conectado, SOMENTE o nome é ciano; contador, PROFILE, DPI, ROTATION, REMOVE DEVICE e hints são amarelos. Na página de qualquer outro mouse, TODOS os textos, incluindo nome, são amarelos. Desconectar e reconectar, verificar que o ciano desaparece do nome inativo e passa exclusivamente para o nome do novo mouse conectado.
- C10B — testar JOY LEFT/RIGHT em Saved Devices e a tecla pressionada: nenhum destaque branco ou ciano extra além do nome conectado. Conferir que o amarelo corresponde ao tom STATIC padrão do sistema. A regra não deve alterar cores das outras telas.
- C10C — Fast DPI: HELP via KEY X, voltar com KEY Y sem ativar lock, KEY B cancela, JOY LEFT/RIGHT alterna Fast↔Slow preservando página e preferências.

### MOV-04 — vertical-slow-dpi (ACCEPTED pelo operador em 2026-10-10)
- C11: partir de HOME conectada > MOVEMENT OPTIONS > VERTICAL DPI; abrir VERTICAL SLOW DPI. Conferir linhas 9×21, opções 1x/0.75x/0.5x/0.25x alinhadas na coluna 16.
- C12: selecionar 0.75x, KEY B cancela sem gravar. Retornar pela HOME/MOVEMENT OPTIONS para reabrir Vertical DPI.
- C12A: selecionar 0.25x, KEY A aplica e volta. Confirmar somente V 0.25X ciano, H e Rotation inalterados. Testar deslocamento lento e diagonal; quatro deltas verticais pequenos devem produzir distância proporcional, sem perda.
- C12B: alternar Vertical Slow ↔ Vertical Fast com JOY LEFT/RIGHT e verificar que nunca abre Horizontal; UP/DOWN envolve a seleção. KEY X abre Help Slow; KEY Y dentro do Help somente retorna à escolha exata, sem travar ou aplicar.
- C12C: reiniciar Pico 2 W sem apagar bonds e confirmar persistência de V; testar que perfis, scroll, drag e Saved Devices com a cor ciano restrita ao nome ativo permanecem corretos. Aceite físico só com confirmação do operador.

### MOV-05 — vertical-fast-dpi (ACEITO pelo operador em 2026-10-10)
- C13: HOME conectada → MOVEMENT OPTIONS (segunda opção) → VERTICAL DPI (segunda opção) → VERTICAL SLOW DPI → JOY RIGHT para Vertical Fast. Confirmar layout 9×21, valores 1.25X/1.5X/2X/3X iniciando na coluna 17, hint KEY A: APPLY AND BACK e KEY X: HELP FAST DPI.
- C14: selecionar 1.5X e cancelar com KEY B: não alterar valor confirmado. Reabrir Vertical Fast, aplicar 1.5X com KEY A; menu mostra V 1.5X ciano e mantém H e ROTATION.
- C14A: com V>1X, entrar diretamente em Fast pelo VERTICAL DPI; ver valor aplicado selecionado branco, mover foco para ver valor confirmado ciano; voltar com KEY B sem gravar outro candidato.
- C14B: navegar Vertical Slow<>Fast com JOY LEFT/RIGHT; preservar a seleção própria de cada página sem alternar para Horizontal. KEY X abre Help Fast; KEY Y retorna sem Lock.
- C14C: testar 1.25X, 2X e 3X, movimentos verticais e diagonais, continuidade sem truncamento em movimentos grandes; confirmar que perfis de botões, wheel, pan e Saved Devices preservam comportamentos aceitos.
- C14D: reiniciar Pico sem apagar bonds; reconectar mouse e conferir persistência; selecionar V=3X e H=1X/rot=270° para conferir que ganho V age sobre a direção USB vertical pós-rotação.

### MOV-06 — rotation (candidato atual, aceite físico pendente)
- C15: HOME conectada > MOVEMENT OPTIONS > ROTATION; conferir layout 9×21, 0/90/180/270 graus, KEY A: APPLY AND BACK (21 colunas), KEY B: CANCEL, KEY X: HELP; UP/DOWN deve fazer wrap.
- C16: selecionar ângulo diferente e cancelar com KEY B: ângulo persistido não muda. Depois aplicar separadamente 90, 180 e 270 graus com KEY A, confirmar retorno a Movement Options, valor ciano e H/V preservados. Reabrir: atual branco; mover seleção: atual ciano.
- C17: KEY X abre ROTATION HELP; procurar texto ANTICLOCKWISE; KEY Y retorna ao item exato sem Lock. Verificar persistência após reinicialização e reconexão.
- C17A: configurar H=2X, V=1X, ROT=270-DEGREE; mouse frente/trás -> ponteiro horizontal 2x; mouse esquerda/direita -> ponteiro vertical 1x. Desenhar círculo físico lento: elipse deitada. Scroll, pan, clique e arraste NÃO giram.
- C17B: verificar sentido de giro para 0/90/180/270, movimentos diagonais e deslocamentos longos sem perda por saturação USB. Aplicar KEY A RESET ALL no menu Movement Options e confirmar H=1X, V=1X, Rotation=0-DEGREE, com persistência após reinicializar. Detalhes em executions/MOV-06/physical-acceptance.md.

### MOV-07 — home-connected
- C18: confirmar 4 opções em ordem (Remapping, Movement, Saved, Pair), ida/volta e HELP original da HOME (KEY X).
- C19: desconectar mouse e confirmar Home Searching/Retry SEM MOVEMENT OPTIONS; reconectar e abrir Movement novamente, preservando valores.
- C20: KEY Y bloqueia tela comum; ponteiro continua andando com valores configurados; primeira tecla somente desbloqueia e retorna à HOME.

### MOV-08 — saved-devices
- C21: na HOME, Saved Devices mostra PROFILE e `DPI: H ... - V ...` e ROTATION; paginação direita/esquerda por mouse, dados não se confundem quando conectado aparece primeiro.
- C22: parear outro mouse, definir valores diferentes, alternar; desconectado mantém os valores próprios; reiniciar Pico e reconectar.
- C23: verificar nomes longos/truncamento dentro da tela 9x21 sem caracteres fora da área.

### MOV-09 — remove-this
- C24: Saved Devices > REMOVE DEVICE mostra o mouse certo, aviso de pareamento e preferências excluídas; KEY B cancela e mantém tudo.
- C25: KEY A remove somente mouse selecionado e seus valores; outro mouse salvo permanece intacto. Depois de re-parear mouse removido, valores voltam a 1x/1x/0°.
- C26: pressionar KEY A repetidamente enquanto remoção pendente não deve apagar outro mouse.

### MOV-10 — Help unificado
- C27: KEY X de H/V Slow abre SLOW DPI HELP, ANY KEY retorna à página exata sem mudar opção/candidato.
- C28: KEY X de H/V Fast abre FAST DPI HELP idem, KEY Y em Help apenas volta, jamais trava a tela.
- C29: KEY X de ROTATION abre ROTATION HELP, confirma explicação anticlockwise, retorno restaura seleção.
- C30: REMOVE THIS > KEY Y abre REMOVE MOUSE HELP; qualquer tecla retorna ao mesmo alvo, sem apagar/travar. O aviso cita custom movements.

## Regressão cruzada obrigatória
- R01: Passthrough, Standard, Escape e Custom continuam aplicando botões corretamente.
- R02: Bluetooth bonding, preferidos, reconexão e promoção Pair New continuam operando.
- R03: Logitech Lift Forward/HID++, wheel/pan, clique mantido, drag e Escape sintético não ficam presos.
- R04: persistência antiga v1.0 permanece intacta. Nunca usar endereço Bluetooth privado rotativo ou ordinal de Saved Devices como chave persistente.
- R05: desligar/religar Pico 3 vezes mantendo configurações; testar fractional 0.25X com 4 pequenas etapas equivalentes a 1 passo HID, sem perda.
- R06: ativar Input Remapper apenas se ele não acrescentar ganhos ou rotações; caso contrário desativar para evitar composição duplicada.

## Registro de resultado do operador
Marcar cada `MOV-XX` como PASS, FAIL ou NOT TESTED com SHA, UF2 SHA-256, mouse/hardware, ambiente e descrição de falha. Somente usuário pode conceder aceite físico. Não aceitar automaticamente após CI.
