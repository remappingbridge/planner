# MOV-08 — Saved Devices | Contrato e implementação

Data: 2026-10-10 (America/Sao_Paulo). Firmware: `remappingbridge/remappingbridge`, branch `feature/movement-options-v1.0`. Base estável `release/v1.0.0` não modificada.

## Gates
MOV-01 a MOV-07: **ACCEPTED** pelo operador. MOV-08: candidato ainda **PENDING** até teste físico. MOV-09 (remoção) e MOV-10 ainda não aceitos.

## Fluxo acessível pela HOME real
`home-connected → SAVED DEVICES (terceira opção) → JOY RIGHT/LEFT`, com uma página para cada mouse pareado. Contador `1 OF N` ... `N OF N` e wrap. Mouse atualmente conectado aparece na primeira página; os demais seguem a ordem do índice lógico de bond. A posição da página pode mudar quando outro mouse se conecta; o índice da página **não** é a chave de persistência de H/V/rotação.

## Contrato de 9×21 caracteres
Exemplo de página de mouse conectado:
```text
1 OF 3
LOGITECH LIFT MOUSE
PROFILE: STANDARD
DPI: H 2 - V 0.75
ROTATION: 270 DEGREE
 REMOVE DEVICE

JOY RIGHT\LEFT: PAGE
JOY PRESS: ACCESS
```

- Título/contador, profile, DPI e Rotation refletem o respectivo mouse salvo (DPI e rotação por bond). **Exceção/proveniência:** PROFILE representa o perfil de remapeamento **global atualmente ativo** da v1.0, não o último perfil histórico de cada mouse. Não inventar persistência por mouse para profiles.
- Ao navegar, a linha de nome da página do mouse efetivamente **conectado** é a única a ficar em **ciano**. **Todas as demais letras de todas as páginas**, inclusive título, contador, nomes de mouses inativos, PROFILE, DPI, ROTATION, REMOVE DEVICE e legendas, têm o **amarelo padrão** (`BLU2USB_UI_TONE_STATIC`). Não mostrar branco/ciano de seleção ou tecla pressionada nas demais linhas.
- Ao desconectar, nomes ficam amarelos, sem alterar registro salvo e sem apagar valores de dispositivos inativos. Reconectar outro bond troca mouse na página inicial e destaque ciano para somente esse nome; cada DPI/Rotation mantém seu registro lógico correto. Clicar JOY PRESS acessa REMOVE THIS do mouse da página (cenário de remoção/commit completo pertence MOV-09); KEY B retorna à HOME real.
- Nomes longos devem ser normalizados/truncados pelo renderer sem ultrapassar 21 colunas. Página sem bonds exibe `0 OF 0` e não permite tentativa de remoção.
- Preservar toda a UI v1.0 e as configurações de Movement Options já aprovadas.

## Testes e riscos
Implementação destas telas estava presente antes, para integração MOV-01/MOV-03. Este gate adiciona **testes próprios**, sem duplicar telas ou rotas: `tests/test_mov08_saved_devices.c` verifica três mouses com preferências diferentes, promoção de mouse conectado a 1ª página, paginação e wrap, cada campo textual/cor, navegabilidade no release, identidade lógica para Remove This, volta B, desconexão/reconexão, valores distintos, profile global, nomes longos e lista vazia. CI CMake/CTest inclui esse gate com regressões anteriores.

Limite do teste host: simula os valores lidos de armazenamento BLE. Teste físico com dois ou mais mouses e reboot é necessário para comprovar dados persistentes reais.

Não marcar MOV-08 accepted sem a confirmação explícita do operador. O PR #22 fica Draft.
