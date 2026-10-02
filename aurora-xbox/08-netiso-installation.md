# 08 — Instalação NetISO no Xbox

Data: 2026-10-01

## Backup do Nova original

Origem:

```text
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```

Backup no Mac:

```text
/Users/admin/Documents/xbox360-tools/xbox-backup/Nova-original.xex
```

Tamanho observado:

```text
240K
```

SHA-256:

```text
3fdf5175a4caaa74e075a839776b12d15982ac304807ebc9f8d9ff0b8ae218fa
```

## NetISO no pendrive

Arquivos enviados via FTP:

```text
Usb0:\NetISO\NetISO.xex      28672 bytes
Usb0:\NetISO\NetISO.xex.txt     14 bytes
```

Conteúdo de `NetISO.xex.txt`:

```text
192.168.50.1
```

## Nova modificado no HDD

Destino:

```text
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```

Tamanho remoto observado após upload:

```text
192512 bytes
```

## launch.ini

Configuração enviada de volta ao pendrive:

```ini
Default = Hdd:\Apps\Aurora\Aurora.xex
plugin1 = Usb:\NetISO\NetISO.xex
plugin2 =
plugin3 =
plugin4 =
plugin5 =
liveblock = true
livestrong = false
fakelive = false
autofake = false
```

## Estado

Concluído:

- backup do Nova original;
- NetISO.xex instalado no USB;
- NetISO.xex.txt configurado para o Mac em 192.168.50.1;
- Nova modificado instalado no Aurora do HDD;
- NetISO definido como plugin1;
- Xbdm/JRPC2 permanecem desabilitados.

Pendente:

- reboot da sessão desbloqueada;
- confirmar Aurora abre normalmente;
- abrir Xbox Guide > File Browser > NetISO;
- confirmar que as ISOs do Mac aparecem;
- montar uma ISO;
- iniciar o jogo pelo Aurora;
- validar novamente USB removido + reboot = retail;
- automatizar netiso-srv com launchd.

## Rollback do Nova

Se o Aurora falhar após o reboot, restaurar:

```text
origem:
~/Documents/xbox360-tools/xbox-backup/Nova-original.xex

destino:
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```
