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

SHA-256 do `Nova.xex` modificado atualmente instalado, reconfirmado imediatamente antes da instalação do ConnectX em 2026-10-03:

```text
7be2e01f60065ac642e4393228fa845d4e7b7fa02e8c1183636ee20907e05eee
```

Esse hash é do **Nova modificado para NetISO**. O hash `3fdf5175...` acima continua sendo o backup do Nova original.

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


## Verificação pós-upload via FTP

Após a instalação, os três arquivos foram baixados novamente do Xbox e comparados byte a byte com as cópias locais usando `cmp -s`.

Resultado:

```text
Nova remoto: IDENTICO
NetISO remoto: IDENTICO
Config remota: IDENTICA
```

Isso valida que não houve corrupção nos uploads FTP de:

```text
Hdd1:\Apps\Aurora\Plugins\Nova.xex
Usb0:\NetISO\NetISO.xex
Usb0:\NetISO\NetISO.xex.txt
```

O servidor NetISO também permaneceu ativo no Mac:

```text
netiso-srv ... TCP *:4323 (LISTEN)
```

Processo observado:

```text
./target/release/netiso-srv -r -v /Users/admin/Documents/xbox360
```

A saída inicial de `ps` apareceu truncada por largura de coluna, portanto o caminho completo deve ser conferido com `ps -ww` se necessário.

Estado agora:

- arquivos locais e remotos: validados byte a byte;
- servidor NetISO: ativo em TCP 4323;
- próximo passo: reboot completo do Xbox com USB conectado, executar exploit, confirmar Aurora e então abrir File Browser > NetISO.
