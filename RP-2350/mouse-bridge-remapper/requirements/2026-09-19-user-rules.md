# Regras gerais

- vários mouses podem estar conectados ao mesmo tempo, não apenas um por vez.
- no bloco que mostra os elementos da tela, o que estive entre parêntesis não é um elemento da tela, mas sim o nome da tela que será aberta ao acessar a respectiva opção da lista.
- no bloco que mostra os elementos da tela, quando `(nome do mouse)` estive entre parêntesis não é um elemento da tela, mas sim a indicação de que aquele texto muda de acordo com o nome do mouse.
- no bloco que mostra os elementos da tela, quando `(paginação)` estive entre parêntesis não é um elemento da tela, mas sim a indicação de que aquele texto muda de acordo com a quantidade de mouses salvos
- no bloco que mostra os elementos da tela, quando `(customizável)` estive entre parêntesis não é um elemento da tela, mas sim a indicação de que aquele texto muda de acordo com a escolha do usuário
- as informações de `Fluxo até a tela:` pode representar apenas um ou mais dos fluxos possíveis, e tem o objetivo de eliminar ambiguidades.

# Quando não há mouse salvo

## Searching first mouse

- Nome da tela: searching-first
- Fluxo até a tela: `ligar o RP-2350 sem device previamente salvo ou remover único device salvo > searching-first`
- Elementos da tela:

```
SEARCHING FIRST MOUSE
PRESS TO LEARN KEYS
WHILE WAIT CONNECTION
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN   
 KEY A         KEY X
 KEY B         KEY Y 

```

###### Regras da tela:

- Nenhum dispositivo ainda salvo previamente
- as palavras `PRESS A KEY TO LEARN` e `WHILE WAIT CONNECTION` devem ter a cor amarela esbranquiçada.
- Nenhuma tecla leva a nenhum lugar, apenas fica branca a palavra correspondente à quela tecla quando pressionada e volta à cor cinza quando solta. nada mais que isso.
- sempre que o último/único mouse salvo for removido, então deve voltar à tela searching-first-mouse e tentar parear automaticamente.
- Quando não houver nenhum dispositivo salvo então essa deve ser a primeira tela a ser mostrada ao ligar o RP-2350
- a busca pelo reconhecimento por um novo mouse deve continuar sendo feita por tempo indeterminado (ou por muito tempo se não for possível por tempo indeterminado) até encontrar um primeiro dispositivo

###### Cordenadas das teclas:

- Na linha do `JOY UP`  o `J` deve começar na coluna 8
- Na linha dos 3 `JOY`, o cada um começa nas colunas 3, 10, 17 respctivamente
- Na linha do `LEFT`, `PRESS`, `RIGHT`, cada um começa nas colunas 3, 9, 16 respectivamente
- Na linha do `JOY DOWN` o `J` começa na coluna 7
- Na linha do `KEY A`, `KEY X`, cada `K` começa nas colunas 2, 16 repectivamente
- Na linha do `KEY B`, `KEY Y`, cada `K` começa nas colunas 2, 16 repectivamente

## First mouse connected

- Nome da tela: first-mouse-connected
- Fluxo até a tela: `searching-first-mouse > first-mouse-connected`
- Elementos da tela:

```
FIRST MOUSE CONNECTED
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN   
               KEY A  
LOCK SCREEN    KEY B
 AND UNLOCK    KEY X
  OPEN HOME -> KEY Y

```

###### Regras da tela:

- quando o primeiro mouse é conectado com sucesso, então deve apresentar a tela first-mouse-connected

###### Cordenadas das teclas:

- Na linha do `JOY UP`  o `J` deve começar na coluna 8
- Na linha dos 3 `JOY`, o cada um começa nas colunas 3, 10, 17 respctivamente
- Na linha do `LEFT`, `PRESS`, `RIGHT`, cada um começa nas colunas 3, 9, 16 respectivamente
- Na linha do `JOY DOWN` o `J` começa na coluna 7
- Na linha do `KEY A`, o `K` começa na linha 16
- na linha do `LOCK SCREEN`, `KEY B`, o `L` começa na coluna 1, o `KEY B` começa na coluna 16
- na coluna do `AND UNLOCK`, `KEY X`, o `A` começa na coluna 2, o `KEY X` começa na coluna 16
- na coluna do `OPEN HOME -> KEY Y`, essa sequencia de palavras começa na coluna 3.

# Quando há pelo menos um mouse salvo

## Searching saved device

### enquanto está buscando reconhecer dispositivo

- Nome da tela: home-searching
- Fluxo até a tela: \`ligar o RP-2350 com device previamente salvo > home-searching
- Elementos da tela:

```
SEARCHING SAVED MOUSE
 PAIR NEW MOUSE (pair-new-mouse)
 SAVED DEVICES (saved-devices)
 LEARN THE KEYS (learn-the-keys)

KEY B: CANCEL SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP

```

###### Regras da tela:

- Deve haver pelo menos um dispositivo salvo para que essa tela seja mostrada
- Quando houver pelo menos um dispositivo salvo então essa deve ser a primeira tela a ser mostrada ao ligar o RP-2350
- a busca por um dispositivo não deve ser por tempo indeterminado.
- esta tela possui 4 dicas no rodapé

#### home searching Help

- Nome da tela: home-searching-help\`
- Elementos da tela:

```
HOME SEARCHING HELP
UNLESS IT IS CANCELED
THE SEARCH WILL TAKE 
A FEW SECONDS AND 
WILL BE TRIGGERED 
EVERY TIME YOU ACCESS
THIS SCREEN.

ANY KEY: BACK

```

### Retry on error/cancel (searching saved mouse)

- Nome da tela: home-retry
- Fluxo até a tela: `ligar o RP-2350 com device previamente salvo > home-searching > home-retry`
- Elementos da tela:

```
DEVICE NOT FOUND
 PAIR NEW MOUSE (pair-new-mouse)
 SAVED DEVICES (saved-devices)
 LEARN THE KEYS (learn-the-keys)

KEY A: RETRY SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP

```

###### Regras da tela:

- esta tela possui 4 dicas no rodapé
- Quando nenhum mouse for encontrado após o tempo de busca por dispositivo salvo na tela home-searching então deve ser exibida a tela home-retry
- Ao pressionar `KEY A` então o usuário volta para a tela home-searching que tenta  automaticamente parear um dispositivo já salvo

#### home retry help

- Nome da tela: home-retry-help
- Elementos da tela:

```
HOME RETRY HELP
THE MATCHING ATTEMPT 
TOOK PLACE ONLY FOR 
DEVICES ALREADY SAVED
IN THE PREFERENCES, 
BUT NOT FOR DEVICES 
THAT WERE NOT SAVED.

ANY KEY: BACK

```

## Pair new mouse

### Tentando conectar um mouse que não está na lista de salvos

- Nome da tela: pair-new
- Fluxo até a tela: `home-searching ou home-retry > pair-new`
- Elementos da tela:

```
PAIR NEW MOUSE
TRYING TO CONNECT
A NEW MOUSE THAT 
IS NOT LISTED
IN SAVED DEVICES

KEY B: CANCEL
KEY X: HELP
KEY Y: LOCK

```

###### Regras da tela:

- ao acessar esta tela, então deve tentar conectar um mouse que não esteja na lista de salvos. caso o mouse esteja na lista

#### HELP PAIR NEW DEVICE

- Nome da tela: help-pair-new
- Elementos da tela:

```
PAIR NEW DEVICE HELP
IF YOU'D LIKE TO TRY 
CONNECTING A DEVICE 
THAT ALREADY HAS A 
SAVED DEVICE, SIMPLY 
RETURN TO THE 
PREVIOUS SCREEN.

ANY KEY: BACK

```

### Retry on error

- Nome da tela: retry-pair-new
- Fluxo até a tela: 
- Elementos da tela:

```
PAIR NEW MOUSE
NO NEW MOUSE OUTSIDE
THE LIST OF SAVED 
DEVICES WAS FOUND

KEY A: RETRY NEW PAIR
KEY B: BACK TRY SAVED
KEY X: HELP
KEY Y: LOCK

```

###### regras da tela:

- Ao pressionar `KEY A` então o usuário volta para a tela pair-new que tenta  automaticamente parear um dispositivo não salvo

#### help retry pair new

- Nome da tela: help-retry-pair-new
- Elementos da tela:

```
DEVICE NOT FOUND HELP
THE MATCHING ATTEMPT 
TOOK PLACE ONLY FOR 
DEVICES NOT SAVED IN 
THE PREFERENCES, BUT 
NOT FOR DEVICES 
ALREADY SAVED.

ANY KEY: BACK

```

## Mouse Connected

- Nome da tela: home-connected
- Fluxo até a tela: `searching-first ou home-searching ou home-retry > home-connected`
- Elementos da tela:

```
MOUSE CONNECTED
LOGITECH LIFT
 REMAPPED T0 ESCAPE (remapper-options)
 SAVED DEVICES
 LEARN THE KEYS

JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP TO REMOVE

```

###### Regras da tela:

- a primeira linha da tela logo abaixo do título não é uma opção, mas sim um texto sem recuo na cor amarelo esbranquiçado. As palavras que devem aparecer nessa linha são o nome do dispositivo atualmente conectado.
- a primeira opção da lista deve levar à tela de remapper-options
- quando o perfil de mouse é `PASSTHROUGH` então a palavra na opção que leva á tela remapper-options deve ser `NO REMAP PASSTHROUGH `
- quando o perfil de mouse é `STANDARD REMAP` então a palavra na opção que leva á tela remapper-options deve ser `REMAPPED TO STANDARD`
- quando o perfil de mouse é `ESCAPE REMAP` então a palavra na opção que leva á tela remapper-options deve ser `REMAPPED TO ESCAPE`
- quando o perfil de mouse é `CUSTOM REMAP` então a palavra na opção que leva á tela remapper-options deve ser `REMAPPED TO CUSTOM`

#### HELP TO REMOVE

- Nome da tela: help-home-connected
- Elementos da tela:

```
HOME CONNECTED HELP
TO DISCONNECT THE 
CURRENTLY CONNECTED 
MOUSE, NAVIGATE TO: 
SAVED DEVICES > 
(MOUSE PAGE) > REMOVE
DEVICE > REMOVE

ANY KEY: BACK

```

### Remapper Options

- Nome da tela: remapper-options
- Titulo da tela: `home-searching ou home-retry ou home-connected > remapper-options`
- Fluxo até a tela: 
- Elementos da tela:

```
MOUSE OPTIONS
 PASSTHROUGH
 DEFAULT REMAP
 ESCAPE REMAP
 CUSTOM REMAP

JOY PRESS: ACCESS
JOY LEFT: BACK
KEY X: HELP

```

#### Help REMAPPER OPTIONS

- Nome da tela: help-remapper-options
- Elementos da tela:

```
REMAPPER OPTIONS HELP
CHOOSE FROM THE 
OPTIONS TO CHANGE THE
FUNCTIONS OF THE 
MOUSE BUTTONS. 
PASSTHROUGH IS THE 
DEFAULT OPTIONS.

ANY KEY: BACK

```

#### Passthrough

##### Passthrough ativado

- Nome da tela: passthrough-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > passthrough-active`
- Elementos da tela:

```
PASSTHROUGH ACTIVE
ORIGINAL MOUSE
BUTTONS POSITION
ARE ACTIVE NOW



KEY B: BACK
KEY Y: LOCK

```

##### Passthrough desativado

- Nome da tela: passthrough-not-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > passthrough-not-active`
- Elementos da tela:

```
APPLY PASSTHROUGH
ORIGINAL MOUSE
BUTTONS POSITION
ARE NOT ACTIVE


KEY A: APPLY
KEY B: CANCEL
KEY Y: LOCK

```

#### Standard Remap

##### Standard remap desativado

- Nome da tela:  standard-not-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > standard-not-active`
- Elementos da tela:

```
APPLY STANDARD REMAP
FORWARD IS LEFT
LEFT IS FORWARD
BACKWARD IS RIGHT
RIGHT IS BACKWARD

KEY A: APPLY
KEY B: CANCEL
kEY Y: LOCK

```

##### Standard remap ativado

- Nome da tela:  standard-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > standard-active`
- Elementos da tela:

```
STANDARD REMAP ACTIVE
FORWARD IS LEFT
LEFT IS FORWARD
BACKWARD IS RIGHT
RIGHT IS BACKWARD


KEY B: BACK
kEY Y: LOCK

```

#### Escape Remap

##### Escape remap inativo

- Nome da tela:  escape-not-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > escape-not-active`
- Elementos da tela:

```
APPLY ESCAPE REMAP
FORWARD IS LEFT
BACKWARD IS RIGHT
LEFT IS ESCAPE
RIGHT IS BACKWARD
MIDDLE IS FORWARED

KEY A: APPLY
KEY B: CANCEL

```

##### EScape remap ativado

- Nome da tela:  escape-active
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > escape-active`
- Elementos da tela:

```
ESCAPE APPLIED ACTIVE
FORWARD IS LEFT
BACKWARD IS RIGHT
LEFT IS ESCAPE
RIGHT IS BACKWARD
MIDDLE IS FORWARED

KEY B: BACK
JOY LEFT: GO TO HOME

```

#### Custom Remap

- Nome da tela: custom-edit
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit`
- Elementos da tela:

```
EDIT CUSTOM REMAP
 LEFT IS LEFT (customizável)
 RIGHT IS RIGHT (customizável)
 MIDDLE IS MIDDLE (customizável)
 FORWARD IS FORWARD (customizável)
 BACKWARD IS BACKWARD (customizável)

JOY PRESS: ACCESS
KEY A: APPLY CUSTOM

```

##### Left will become

- Nome da tela: left
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit > left`
- Elementos da tela:

```
LEFT WILL BECOME
 LEFT
 RIGHT
 MIDDLE
 ESCAPE
 FORWARD
 BACKWARD

KEY A: APPLY AND BACK

```

##### Right will become

- Nome da tela: right
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit > right`
- Elementos da tela:

```
RIGHT WILL BECOME
 LEFT
 RIGHT
 MIDDLE
 ESCAPE
 FORWARD
 BACKWARD

KEY A: APPLY AND BACK

```

##### Middle will become

- Nome da tela: middle
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit > middle`
- Elementos da tela:

```
MIDDLE WILL BECOME
 LEFT
 RIGHT
 MIDDLE
 ESCAPE
 FORWARD
 BACKWARD

KEY A: APPLY AND BACK

```

##### Forward will become

- Nome da tela: forward
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit > forward`
- Elementos da tela:

```
FORWARD WILL BECOME
 LEFT
 RIGHT
 MIDDLE
 ESCAPE
 FORWARD
 BACKWARD

KEY A: APPLY AND BACK

```

##### Backward will become

- Nome da tela: backward
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > remapper-options > custom-edit > backward`
- Elementos da tela:

```
BACKWARD WILL BECOME
 LEFT
 RIGHT
 MIDDLE
 ESCAPE
 FORWARD
 BACKWARD
 
KEY A: APPLY AND BACK

```

### Saved Devices

- Nome da tela: saved-devices
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > saved-devices (aqui podem ser várias telas de acordo com a quantidade de dispositivos salvos)`
- Elementos da tela:

```
3 OF 4 (paginação)
LOGITECH LIFT (nome do mouse)
STATUS: CONNECTED
PROFILE: STANDARD
 REMOVE DEVICE

JOY RIGHT\LEFT: PAGE
JOY PRESS: ACCESS
KEY B: BACK

```

###### Regras da tela:

- o titulo da tela muda de acordo com a quantidade de dispositivos (1 of 1, 1 of 2, 5 of 5, 6 of 8, etc)

#### Remove this mouse

- Nome da tela: remove-this
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > saved-devices (aqui podem ser várias telas de acordo com a quantidade de dispositivos salvos) > remove-this`
- Elementos da tela:

```
REMOVE THIS MOUSE
LOGITECH LIFT (nome do mouse)

PAIRING AND MAPPINGS
WILL BE DELETED

KEY A: REMOVE
KEY B: CANCEL
KEY X: HELP

```

###### Regras da tela:

- a primeira linha abaixo do título deve corresponder ao nome do dispositivo
- se for o único dispositivo salvo: Ao pressionar `KEY A` então deve remover o dispositivo e voltar à tela searching-first-mouse e tentar parear automaticamente.
- se não for o único dispositivo salvo: Ao pressionar `KEY A` então deve remover o dispositivo e voltar à tela saved-devices

##### HELP REMOVE

- Nome da tela: help-remove-this
- Elementos da tela:

```
REMOVE MOUSE HELP
COMPLETELY REMOVE THE 
AUTOMATIC CONNECTION 
WHEN TURNING ON THE 
DEVICE AND DELETE ITS 
BUTTON REMAPPING 
PROFILE.

ANY KEY: BACK

```

### Learn the keys

- Nome da tela: learn-the-keys
- Fluxo até a tela: `home-searching ou home-retry ou home-connected > learn-the-keys`
- Elementos da tela:

```
PRESS TO LEARN KEYS
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN   
               KEY A  
LOCK SCREEN    KEY B
 AND UNLOCK    KEY X
  OPEN HOME -> KEY Y

```

###### Regras da tela:

- nunca é a primeira tela que aparece ao ligar o RP-2350

###### Cordenadas das teclas:

- Na linha do `JOY UP`  o `J` deve começar na coluna 8
- Na linha dos 3 `JOY`, o cada um começa nas colunas 3, 10, 17 respctivamente
- Na linha do `LEFT`, `PRESS`, `RIGHT`, cada um começa nas colunas 3, 9, 16 respectivamente
- Na linha do `JOY DOWN` o `J` começa na coluna 7
- Na linha do `KEY A`, o `K` começa na linha 16
- na linha do `LOCK SCREEN`, `KEY B`, o `L` começa na coluna 1, o `KEY B` começa na coluna 16
- na coluna do `AND UNLOCK`, `KEY X`, o `A` começa na coluna 2, o `KEY X` começa na coluna 16
- na coluna do `OPEN HOME -> KEY Y`, essa sequencia de palavras começa na coluna 3.
