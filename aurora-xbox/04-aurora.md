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

## Extração

`7z 25.01` abriu o RAR5, mas não suportou o método usado em 122 itens. A extração parcial foi descartada.

Com `UNRAR 7.12`:

```bash
unrar t Aurora_0.7b.2.rar
```

Resultado: `All OK`.

Extração:

```bash
rm -rf aurora-stage
mkdir aurora-stage
unrar x -o+ Aurora_0.7b.2.rar aurora-stage/
```

Resultado: `All OK`.

Arquivos essenciais:

```text
Aurora.xex               12333056 bytes
Plugins/Nova.xex           245760 bytes
Plugins/FtpDll.xex         200704 bytes
Skins/Default.xzp         5180269 bytes
```

## Primeira instalação — USB

A pasta completa foi inicialmente copiada para:

```text
Usb:\Apps\Aurora\
```

O `launch.ini` usado no primeiro teste:

```ini
Default = Usb:\Apps\Aurora\Aurora.xex
plugin1 =
plugin2 =
plugin3 =
plugin4 =
plugin5 =
liveblock = true
livestrong = false
fakelive = false
autofake = false
```

Teste físico: **Aurora abriu com sucesso**.

## Migração para HDD interno

Em 2026-10-01, usando o File Manager do próprio Aurora, a pasta `Aurora` foi **copiada**, não movida, de:

```text
Usb0:\Apps\Aurora\
```

para:

```text
Hdd1:\Apps\Aurora\
```

A cópia no USB foi mantida como fallback durante a validação.

Depois o `launch.ini` no USB foi alterado para:

```ini
Default = Hdd:\Apps\Aurora\Aurora.xex
plugin1 =
plugin2 =
plugin3 =
plugin4 =
plugin5 =
liveblock = true
livestrong = false
fakelive = false
autofake = false
```

A configuração foi sincronizada e o USB desmontado corretamente no Debian.

## Validação da alternância

### Modo desbloqueado

Teste físico concluído:

```text
USB Aurora-XBOX conectado
 -> ABadAvatar
 -> XeUnshackle
 -> BACK
 -> DashLaunch temporário
 -> Hdd:\Apps\Aurora\Aurora.xex
 -> Aurora
```

**Resultado: sucesso.**

### Modo retail/original

Teste físico concluído:

```text
Xbox desligado
 -> USB Aurora-XBOX removido
 -> power-on/reboot
 -> nenhum ABadAvatar
 -> dashboard Microsoft retail
```

**Resultado: sucesso.**

A arquitetura desejada está, portanto, validada: o HDD pode conter o Aurora sem tornar o console persistentemente desbloqueado.

## Estado congelado desta etapa

- Aurora principal: `Hdd1:\Apps\Aurora\`.
- ABadAvatar/XeUnshackle: USB `Aurora-XBOX`.
- `launch.ini`: USB.
- cópia redundante do Aurora ainda pode permanecer em `Usb0:\Apps\Aurora\` como fallback;
- NAND intacta;
- modo retail e modo desbloqueado ambos validados.

Próxima fase: NetISO + Ethernet direto com o MacBook.
