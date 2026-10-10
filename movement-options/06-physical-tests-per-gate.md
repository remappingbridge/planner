# Movement Options — implementação contínua e testes físicos por gate

Status: MOV-01 ACEITO / MOV-02 CI VALIDADO E ACEITAÇÃO FÍSICA PENDENTE.
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

### MOV-02 — horizontal-slow-dpi (em validação física; MOV-01 aceito)
- C05: HOME > MOVEMENT OPTIONS > HORIZONTAL DPI abre Slow quando H=1x; opção NORMAL selecionada.
- C06: valores 1, 0.75, 0.5, 0.25 na coluna 16; selecionar 0.75 e pressionar KEY B: cancelar sem modificar.
- C07: selecionar 0.5, KEY A aplica e volta ao menu mostrando H 0.5X em ciano; movimentação horizontal proporcional e valores V/rotação preservados.
- C07A (refinamento solicitado no MOV-02): em ROTATION, confirmar a legenda exata `KEY A: APPLY AND BACK` na linha 7 (21 colunas), sem alterar o efeito da tecla; retornar ao menu e testar novamente o percurso pela HOME.
- C07B: em H Slow, testar Key X Help e qualquer tecla Back (inclusive Key Y), mantendo a opção em branco e a aplicada em ciano; reboot confirma o H persistido.

### MOV-03 — horizontal-fast-dpi
- C08: horizontal Slow > JOY RIGHT passa ao Fast sem sair do eixo, JOY LEFT volta ao Slow; confirmar col17.
- C09: escolher VERY FAST 2x, KEY A; menu H 2X. Movimento longitudinal do mouse percorre o dobro da distância padrão **somente se a rotação selecionada encaminhar esse movimento ao eixo horizontal**.
- C10: usar valores 1.25 e 3x, percorrer diagonais e testar continuidade de movimento rápido.

### MOV-04 — vertical-slow-dpi
- C11: entrar em VERTICAL DPI, Slow, selecionar 0.25X e aplicar; menu mostra V 0.25X, sem alterar H.
- C12: verificar deslocamento pequeno/diagonal e que retorno KEY B não aplica outro valor.

### MOV-05 — vertical-fast-dpi
- C13: navegar Vertical Slow <> Fast com JOY LEFT/RIGHT; escolher 1.5X e aplicar; H deve ficar idêntico.
- C14: verificar 1.25X, 2X, 3X, seleção branca contra valor aplicado em ciano, paginação sem vazamento entre eixos.

### MOV-06 — rotation
- C15: acessar ROTATION, escolher 0/90/180/270 e confirmar que KEY B cancela e KEY A persiste.
- C16: configurar H=2X, V=1X, 270-DEGREE; mouse frente -> ponteiro direita 2x, mouse trás -> esquerda 2x; esquerda -> cima 1x; direita -> baixo 1x.
- C17: desenhar círculo físico lento: elipse deitada; confirmar que roda, scroll, clique e arraste não rotacionam. Ciclos de movimento longo não perdem distância.

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
