# 04 — Aurora 0.7b.2

## Pacote usado

Arquivo:

```text
Aurora_0.7b.2.rar
```

Origem utilizada:

```text
http://phoenix.xboxunity.net/downloads/Aurora%200.7b.2%20-%20Release%20Package.rar
```

Tamanho recebido:

```text
22647806 bytes
```

SHA-256 validado:

```text
0c7c765c3a5b938cfc64c71beda276a17d109b88df2a88e3f91eb1e74b7e46a0
```

## Problemas encontrados durante download/extração

### Mirror ConsoleMods

Uma tentativa direta contra um mirror em ConsoleMods retornou HTTP 403.

A solução foi usar o host Phoenix/XboxUnity.

### 7-Zip

`7z 25.01` conseguiu abrir o RAR5, porém retornou `Unsupported Method` em 122 itens.

A extração parcial foi descartada.

### unrar

Foi usado:

```text
UNRAR 7.12 freeware
```

Validação:

```bash
unrar t Aurora_0.7b.2.rar
```

Resultado:

```text
All OK
```

Extração:

```bash
rm -rf aurora-stage
mkdir aurora-stage

unrar x -o+ \
Aurora_0.7b.2.rar \
aurora-stage/
```

Resultado final:

```text
All OK
```

Arquivos essenciais confirmados:

```text
Aurora.xex               12333056 bytes
Plugins/Nova.xex           245760 bytes
Plugins/FtpDll.xex         200704 bytes
Skins/Default.xzp         5180269 bytes
```

## Instalação no pendrive

Destino:

```text
Usb:\Apps\Aurora\
```

No Debian:

```bash
MNT='/media/tiago/Aurora-XBOX'

mkdir -p "$MNT/Apps/Aurora"

rsync -a \
'/tmp/xbox360-softmod/aurora-stage/' \
"$MNT/Apps/Aurora/"
```

Validação manual executada para:

- `Aurora.xex`;
- `Plugins/FtpDll.xex`;
- `Plugins/Nova.xex`;
- `Skins/Default.xzp`.

Todos retornaram `OK`.

## DashLaunch / XeUnshackle

O `launch.ini` foi alterado de SimpleNAND para Aurora:

```ini
Default = Usb:\Apps\Aurora\Aurora.xex
```

Os plugins do XeUnshackle foram desabilitados:

```ini
plugin1 =
plugin2 =
plugin3 =
plugin4 =
plugin5 =
```

Configuração de Live mantida:

```ini
liveblock = true
livestrong = false
fakelive = false
autofake = false
```

## Teste físico concluído

Fluxo executado:

```text
Xbox liga
 -> tela de perfis
 -> ABadAvatar v1.3-beta dispara
 -> XeUnshackle BETA v1.03 abre
 -> BACK
 -> DashLaunch lê launch.ini
 -> Usb:\Apps\Aurora\Aurora.xex
 -> Aurora abre
```

**Resultado: sucesso.**

Este é o estado atual congelado da configuração.

## O que ainda não foi feito

- Aurora ainda não foi migrado para o HDD interno.
- NetISO ainda não foi configurado.
- Ethernet direto MacBook ↔ Xbox ainda não foi configurado.
- Biblioteca de ISOs ainda não foi servida pela rede.
- Não foi definida persistência do ABadAvatar no HDD.
- Nenhuma modificação permanente foi feita na NAND.
