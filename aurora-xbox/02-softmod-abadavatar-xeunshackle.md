# 02 — ABadAvatar + XeUnshackle

## Pré-condições confirmadas

O Xbox mostrou:

```text
D: 2.0.17559.0
K: 2.0.17559.0
```

O HDD interno tinha aproximadamente 220 GB livres.

## Tentativa de `$SystemUpdate` 17559

Foi baixado o pacote oficial de atualização 17559:

```text
SystemUpdate_17559_USB.zip
115992188 bytes
```

A árvore `$SystemUpdate` foi copiada para a raiz do pendrive FAT32 e validada com `rsync -rcn`.

O Xbox **não mostrou prompt de atualização**.

Depois foi confirmado que já existiam três avatares normais no console. Portanto, os assets adicionais já estavam instalados e o `$SystemUpdate` foi removido do pendrive.

## Primeira tentativa — ABadAvatar Public Beta 1.0

Pacote usado inicialmente:

- ABadAvatar Public Beta 1.0;
- XeUnshackle BETA v1.03.

A estrutura do PB1.0 continha:

```text
BadUpdatePayload/
├── BadUpdateExploit-2ndStage.bin
├── BadUpdateExploit-3rdStage.bin
├── BadUpdateExploit-4thStage.bin
├── update_data.bin
└── xke_update.bin

Content/
└── E0002FF78DFBDE7B/FFFE07D1/00010000/E0002FF78DFBDE7B
```

XeUnshackle v1.03 adicionou:

```text
BadUpdatePayload/
├── BadStorage.xex.dll
└── default.xex

JRPC2.xex
Xbdm.xex
launch.ini
README - IMPORTANT.txt
```

Resultado: após cerca de 30 minutos na tela de perfis, o exploit não disparou.

Depois foi identificado que o pendrive estava em **GPT**, apesar de FAT32.

## Correção — recriar USB como MBR/FAT32

O dispositivo foi confirmado como SanDisk Ultra de ~30,8 GB e recriado:

```bash
sudo umount /dev/sde1 2>/dev/null || true
sudo wipefs -a /dev/sde

sudo parted -s /dev/sde \
  mklabel msdos \
  mkpart primary fat32 1MiB 100% \
  set 1 lba on

sudo mkfs.vfat -F 32 -n Aurora-XBOX /dev/sde1
```

Validação:

```text
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  30.8GB  30.8GB  primary  fat32        lba
```

## ABadAvatar v1.3-beta

Release usado:

- tag: `avatar-v1.3-beta`;
- arquivo: `ABadAvatar_v1.3-beta.zip`;
- origem: https://github.com/bibarub/Xbox360BadUpdate/releases/tag/avatar-v1.3-beta

Estrutura observada:

```text
BadUpdatePayload/BadUpdateExploit-4thStage.bin
BadUpdatePayload/BadUpdateExploit-Avatar-2ndStage.bin
BadUpdatePayload/BadUpdateExploit-Avatar-3rdStage.bin
BadUpdatePayload/BadUpdateExploit-Avatar-Data.bin
BadUpdatePayload/GamerProfile.xex
BadUpdatePayload/update_data.bin
BadUpdatePayload/xke_update.bin
Content/E0002FF78DFBDE7B/FFFE07D1/00010000/E0002FF78DFBDE7B
```

## XeUnshackle BETA v1.03

Release:

https://github.com/Byrom90/XeUnshackle/releases/tag/v1.03

Arquivos usados:

```text
BadUpdatePayload/BadStorage.xex.dll
BadUpdatePayload/default.xex
JRPC2.xex
launch.ini
README - IMPORTANT.txt
Xbdm.xex
```

O `default.xex` do XeUnshackle foi colocado em `BadUpdatePayload/`.

Configuração original relevante:

```ini
[Paths]
Default =

[Plugins]
plugin1 = Usb:\Xbdm.xex
plugin2 =
plugin3 = Usb:\JRPC2.xex
plugin4 =
plugin5 =

[Settings]
liveblock = true
livestrong = false
fakelive = false
autofake = false
```

## Resultado

Com ABadAvatar v1.3-beta em USB MBR/FAT32:

- exploit disparou;
- XeUnshackle abriu;
- CPUKey e DVDKey foram mostradas na tela;
- essas chaves **não foram registradas neste repositório**;
- `OriginalMACAddress.bin` foi criado;
- o estado continuou não persistente.

No XeUnshackle:

- `X` salva informações;
- `Y` despeja 1BL;
- `BACK` sai do aplicativo;
- `BACK` **não é** o botão vermelho `B`; é o botão pequeno à esquerda do botão Guide em um controle Xbox 360 tradicional.

## Regras de segurança adotadas

- não gravar NAND modificada;
- não usar funções de flash;
- não substituir arquivos da flash;
- manter CPUKey/DVDKey privadas;
- manter o console fora da Internet durante o exploit;
- usar somente o DashLaunch carregado temporariamente pelo XeUnshackle.
