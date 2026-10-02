# 07 — Pacote NetISO validado no macOS

Data: 2026-10-01

## Arquivo baixado

Arquivo original:

```text
~/Downloads/Nova+NetISO-Aurora0.7b.zip
```

Cópia de trabalho:

```text
~/Documents/xbox360-tools/Nova-NetISO-Aurora0.7b.zip
```

Tamanho observado:

```text
402K
```

Tipo identificado pelo macOS:

```text
Zip archive data, at least v2.0 to extract, compression method=deflate
```

SHA-256:

```text
b029bb60e1b740d3dfcb307e9ed1f413518795da354a3f50bae2501435c2b16f
```

## Integridade

Foi executado:

```bash
unzip -t Nova-NetISO-Aurora0.7b.zip
```

Resultado:

```text
No errors detected in compressed data of Nova-NetISO-Aurora0.7b.zip.
```

## Conteúdo extraído

```text
netiso-stage/netiso/NetISO.xex
netiso-stage/netiso/NetISO.xex.txt
netiso-stage/netiso/server.exe
netiso-stage/netiso/README.txt
netiso-stage/modified-freestyleplugin.xex/FreestylePlugin.xex
netiso-stage/modified-nova.xex/Nova.xex
```

Arquivos relevantes para Aurora:

```text
Nova:   netiso-stage/modified-nova.xex/Nova.xex
NetISO: netiso-stage/netiso/NetISO.xex
Config: netiso-stage/netiso/NetISO.xex.txt
```

Nesta arquitetura:

- usar o `Nova.xex` modificado;
- usar `NetISO.xex`;
- usar `NetISO.xex.txt`;
- não usar `FreestylePlugin.xex`, pois o dashboard é Aurora;
- não usar `server.exe`, pois o servidor escolhido no Mac é `tuxuser/netiso-srv`.

## Próximo passo

Antes de substituir qualquer arquivo no Xbox:

1. fazer backup do `Hdd1:\Apps\Aurora\Plugins\Nova.xex` original;
2. configurar `NetISO.xex.txt` com `192.168.50.1`;
3. copiar o `Nova.xex` modificado para o Aurora no HDD;
4. colocar `NetISO.xex` e sua configuração no pendrive/chave;
5. definir NetISO como `plugin1` no `launch.ini`;
6. reiniciar a sessão desbloqueada e testar uma ISO real.

A alternância deve continuar preservada:

```text
USB fora + reboot -> retail
USB + exploit     -> Aurora/NetISO
```


## Instalação no Xbox concluída — aguardando teste após reboot

Backup do `Nova.xex` original do Aurora foi copiado via FTP para:

```text
/Users/admin/Documents/xbox360-tools/xbox-backup/Nova-original.xex
```

Tamanho:

```text
240K
```

SHA-256:

```text
3fdf5175a4caaa74e075a839776b12d15982ac304807ebc9f8d9ff0b8ae218fa
```

Configuração criada:

```text
NetISO.xex.txt = 192.168.50.1
```

Arquivos enviados ao pendrive:

```text
Usb0:\NetISO\NetISO.xex      28672 bytes
Usb0:\NetISO\NetISO.xex.txt     14 bytes
```

O `Nova.xex` modificado foi enviado para:

```text
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```

Tamanho remoto observado:

```text
192512 bytes
```

O `launch.ini` no pendrive foi alterado e reenviado com:

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

Estado desta etapa:

- backup original do Nova: concluído;
- NetISO.xex no USB: concluído;
- NetISO.xex.txt com IP do Mac: concluído;
- Nova modificado no HDD: concluído;
- plugin1 no launch.ini: concluído;
- **teste pós-reboot ainda pendente**;
- **montagem de ISO ainda pendente**.

Rollback do Nova, se necessário:

```text
origem no Mac:
~/Documents/xbox360-tools/xbox-backup/Nova-original.xex

destino:
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```
