# Batocera v43 — Dell P1917S 5:4

## Objetivo

Automatizar a configuração de vídeo do Batocera v43 para um Dell P1917S 5:4 e preservar um comportamento seguro quando esse monitor não estiver presente.

Com o Dell P1917S identificado:

- frontend/EmulationStation: **1280x1024 @ 75.02 Hz**;
- jogos: **1280x1024 @ 60.02 Hz**;
- aspect ratio global: **full**, para preencher a tela 5:4.

Com outro monitor HDMI:

- usar o modo `--preferred` anunciado pelo EDID;
- usar `global.ratio=auto`.

Sem HDMI:

- usar `LVDS-1 --preferred`;
- usar `global.ratio=auto`.

## Monitor identificado

Monitor validado:

- modelo: **Dell P1917S**;
- formato físico: **5:4**;
- área informada pelo EDID: **375 mm x 300 mm**;
- resolução nativa/preferida: **1280x1024**;
- modos validados para 1280x1024:
  - **60.02 Hz**;
  - **75.02 Hz**;
- EDID MD5: `9f48548fb72095984c204928a4fa9e80`.

A identificação não depende apenas da resolução: o serviço compara o hash do EDID.

## Evidência validada

A detecção manual retornou:

```text
Dell P1917S detectado
```

No frontend:

```text
1280x1024     60.02 +  75.02*
```

Ao simular `gameStart`:

```text
1280x1024     60.02*+  75.02
```

Ao simular `gameStop`, o modo retornou a 75.02 Hz.

Também foi validado:

```text
batocera-settings-get global.ratio
full
```

quando o Dell P1917S é detectado.

## Arquivos

A configuração é composta por:

```text
/userdata/system/services/display_manager
/userdata/system/scripts/display_manager_game.sh
```

As cópias versionadas desses arquivos estão neste diretório.

## Instalação

Copiar `display_manager` para:

```text
/userdata/system/services/display_manager
```

e executar:

```bash
chmod +x /userdata/system/services/display_manager
batocera-services enable display_manager
```

Copiar `display_manager_game.sh` para:

```text
/userdata/system/scripts/display_manager_game.sh
```

e executar:

```bash
mkdir -p /userdata/system/scripts
chmod +x /userdata/system/scripts/display_manager_game.sh
```

## Teste manual do serviço

```bash
/userdata/system/services/display_manager start
batocera-settings-get global.ratio
export DISPLAY=:0.0
xrandr | grep -A2 '^HDMI-1 connected'
```

Com o Dell conectado, o esperado é:

- mensagem `Dell P1917S detectado`;
- `global.ratio=full`;
- `1280x1024 @ 75.02 Hz`.

## Teste manual dos eventos de jogo

Simular início:

```bash
/userdata/system/scripts/display_manager_game.sh gameStart
xrandr | grep -A2 '^HDMI-1 connected'
```

Esperado: `1280x1024 @ 60.02 Hz`.

Simular encerramento:

```bash
/userdata/system/scripts/display_manager_game.sh gameStop
xrandr | grep -A2 '^HDMI-1 connected'
```

Esperado: `1280x1024 @ 75.02 Hz`.

## Como funciona

O serviço de boot:

1. aguarda o Xorg;
2. verifica `/sys/class/drm/card0-HDMI-A-1/status`;
3. calcula o MD5 do EDID;
4. se o hash for o Dell P1917S, força 1280x1024 @ 75.02 e `global.ratio=full`;
5. se houver outro HDMI, usa `--preferred` e `global.ratio=auto`;
6. se não houver HDMI, usa `LVDS-1 --preferred` e `global.ratio=auto`.

O script de eventos de jogo não muda o aspect ratio. Ele apenas troca a frequência do Dell conhecido:

- `gameStart` -> 60.02 Hz;
- `gameStop` -> 75.02 Hz.

## Limitações atuais

A implementação validada referencia explicitamente:

```text
/sys/class/drm/card0-HDMI-A-1
HDMI-1
LVDS-1
```

Isso corresponde ao hardware em que a configuração foi criada. Em outro notebook, nomes como `card1-HDMI-A-2`, `HDMI-2`, `eDP-1`, `DP-1` ou outros podem ser usados.

A configuração atual também é aplicada no início do serviço e nos eventos de jogos; ela ainda não implementa um daemon de hotplug para reagir continuamente a conectar/desconectar monitores durante a sessão.

Veja `TESTS-PENDING.md` antes de considerar a configuração portátil definitivamente validada.
