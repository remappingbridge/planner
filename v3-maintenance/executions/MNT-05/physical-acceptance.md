# MNT-05 — teste físico de todos os Helps

**STATUS: PENDING / sem aceite físico.** Candidato feito a partir de v3.0.4, branch `maintenance/v3x-mnt-05`.

## Instalação
1. Regravar Pico 2 W em BOOTSEL com UF2 candidato, sem `flash_nuke`.
2. Verificar mouse Bluetooth pareado, conectar ao host USB e iniciar em HOME CONNECTED.

## Validação
- [ ] **01 — Home Connected Help:** abrir com KEY X; última linha `KEY B: BACK`; A, X, joystick 4 direções/press não saem. KEY Y bloqueia; primeira tecla usada para desbloquear é consumida, o desbloqueio retorna à HOME; somente B retorna ao item original da HOME.
- [ ] **02 — Remapping Options Help:** abrir Help; confirmar a mesma regra A/X/JOY inertes, Y Lock e desbloqueio para HOME, B volta para mesma seleção de REMAPPING OPTIONS.
- [ ] **03 — Searching Help:** com mouse desconectado e bonds existentes, abrir Help da busca; ao retornar com B, preservar fluxo anterior de HOME RETRY; Y bloqueia e o desbloqueio vai para HOME.
- [ ] **04 — Retry Help:** abrir Help na tela HOME RETRY e confirmar B, Y e demais controles.
- [ ] **05 — Pair New Device Help:** abrir ajuda na tela de pareamento; A e JOY não devem iniciar pareamento adicional; B retorna.
- [ ] **06 — Retry Pair New Help:** na tela MOUSE NOT FOUND, abrir Help; B volta ao Retry sem criar tentativa; Y bloqueia e desbloquear retorna HOME.
- [ ] **07 — Remove This Help:** a partir HOME CONNECTED → SAVED DEVICES → REMOVE THIS → KEY X. Pressionar A, X e JOY não apaga o mouse; Y bloqueia; desbloqueio vai para HOME; B volta a REMOVE THIS preservando o bond; outro B cancela. Não acionar A depois de sair do Help.
- [ ] **08 — Slow DPI Help:** percorrer Horizontal e Vertical Slow; apenas B retorna preservando seleção e ganho; Y bloqueia; desbloqueio volta para HOME.
- [ ] **09 — Fast DPI Help:** percorrer Horizontal e Vertical Fast; comportamento idêntico ao Slow DPI.
- [ ] **10 — Rotation Help:** somente B sai preservando seleção e rotação; A/X/JOY inertes; Y bloqueia e desbloquear retorna HOME.
- [ ] **11 — Layout/cores:** todas as dez telas Help exibem literalmente `KEY B: BACK`, nenhuma mostra `ANY KEY: BACK`; títulos magenta, texto dentro das 9 linhas x 21 colunas.
- [ ] **12 — Regressão:** Home, Movement, Saved Devices, Modifier Shortcuts, USB HID, BLE e persistência continuam operando; lock fora de o desbloqueio retorna à HOME obedecendo ao contrato anterior.

## Decisão
- Resultados individuais: não informados.
- Aceite físico global: **PENDING**.
- Publicação SemVer **v3.1.0 MINOR** exclusivamente depois de aceite explícito do operador.

## Revisão arquitetural solicitada
O desbloqueio deve seguir o mesmo fluxo global de todas as telas e retornar à HOME, inclusive se iniciado em Help. Para testar retorno via B, reentrar no Help sem acionar Lock. O controle usado para desbloquear não dispara sua ação normal.
