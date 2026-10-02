# CX-00 — baseline congelado e rollback

> **Status: CONCLUÍDO em 2026-10-02.**

Este gate não instala ConnectX e não altera o Xbox. Ele congela o estado funcional anterior para que qualquer regressão futura possa ser atribuída à implementação ConnectX e revertida.

## Baseline funcional preservado

### Modo retail

Validado fisicamente:

```text
USB removido + reboot
-> dashboard Microsoft retail/original
```

Esse comportamento continuou válido depois da instalação do NetISO.

### Modo desbloqueado

Validado fisicamente:

```text
USB Aurora-XBOX
-> ABadAvatar
-> XeUnshackle
-> DashLaunch temporário
-> Hdd:\Apps\Aurora\Aurora.xex
-> Aurora 0.7b.2
```

### NetISO

Estado congelado:

```text
MacBook: 192.168.50.1/24
Xbox:    192.168.50.2/24
NetISO:  TCP 4323
Aurora FTP: TCP 21

ISOs:
/Users/Shared/xbox360

Servidor:
/usr/local/libexec/netiso-srv

LaunchDaemon:
/Library/LaunchDaemons/io.remappingbridge.netiso-srv.plist
```

Validações já concluídas:

- PES 2018 montado e iniciado por NetISO;
- gameplay sem travamento observado;
- desconectar Ethernet faz a ISO desaparecer;
- reconectar Ethernet faz a ISO reaparecer;
- LaunchDaemon inicia automaticamente após reboot do Mac;
- modo retail continua intacto sem o pendrive.

## Estado de plugins conhecido e congelado

### DashLaunch temporário — `launch.ini` no USB

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

Xbdm/JRPC2 permanecem desabilitados.

### Aurora

Estado relevante registrado:

```text
Hdd1:\Apps\Aurora\Aurora.xex
Hdd1:\Apps\Aurora\Plugins\Nova.xex   <- versão modificada para NetISO
Hdd1:\Apps\Aurora\Plugins\FtpDll.xex <- componente original do pacote Aurora
```

O `Nova.xex` modificado remoto foi validado byte a byte após upload.

Este snapshot registra os componentes que são relevantes para a coexistência com ConnectX; não é uma afirmação de inventário exaustivo de todos os arquivos internos do Aurora.

## Rollback disponível

### Nova original

Backup no Mac:

```text
/Users/admin/Documents/xbox360-tools/xbox-backup/Nova-original.xex
```

SHA-256:

```text
3fdf5175a4caaa74e075a839776b12d15982ac304807ebc9f8d9ff0b8ae218fa
```

Destino de restauração, se necessário:

```text
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```

### Aurora original

O pacote Aurora 0.7b.2 utilizado foi validado com SHA-256:

```text
0c7c765c3a5b938cfc64c71beda276a17d109b88df2a88e3f91eb1e74b7e46a0
```

A cópia de fallback em `Usb0:\Apps\Aurora\` pode permanecer disponível.

### NetISO

Arquivos atuais:

```text
Usb0:\NetISO\NetISO.xex
Usb0:\NetISO\NetISO.xex.txt
```

`NetISO.xex.txt` aponta para:

```text
192.168.50.1
```

Não remover nem alterar esses arquivos durante os gates ConnectX sem necessidade explícita.

## Regras para os próximos gates

- não alterar a biblioteca ISO `/Users/Shared/xbox360`;
- não remover NetISO do `plugin1`;
- não substituir o `Nova.xex` modificado sem backup/rollback;
- não instalar mecanismo persistente na NAND;
- não expor SMB1 ao Wi-Fi do Mac;
- testar ConnectX inicialmente com uma biblioteca separada;
- preservar `USB fora + reboot = retail`.

## Gate

Critério do CX-00:

```text
baseline NetISO funcional
+ rollback documentado
+ launch.ini congelado
+ modo retail validado
= CX-00 CONCLUÍDO
```

Próximo gate: [CX-01](PLAN.md#cx-01--backend-smb-isolado-no-mac).