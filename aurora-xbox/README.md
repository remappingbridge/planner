# Aurora Xbox — Xbox 360 E 1538

Registro operacional e rastreável do Xbox 360 E configurado para alternar entre dashboard retail/original e ambiente temporariamente desbloqueado com Aurora.

> **Status atual (2026-10-02):** NetISO está validado fim a fim, gameplay estável, recuperação após desconectar/reconectar Ethernet validada, retorno ao dashboard retail sem pendrive validado e servidor NetISO no Mac automatizado por LaunchDaemon. **Próxima implementação: ConnectX. Depois: GOD/local.**

## Console e estado comum

- Xbox 360 E model 1538.
- MFR Date: 2014-05-06.
- Dashboard/kernel: 2.0.17559.0.
- Aurora 0.7b.2 em `Hdd:\Apps\Aurora\Aurora.xex`.
- ABadAvatar/XeUnshackle permanecem no pendrive `Aurora-XBOX`.
- Nenhuma modificação persistente de NAND foi realizada.

Fluxos preservados:

```text
USB conectado
 -> ABadAvatar
 -> XeUnshackle
 -> Aurora/homebrew

USB removido
 -> reboot/power-on
 -> dashboard Microsoft retail/original
```

## Documentação comum

- [01-console-e-decisoes.md](01-console-e-decisoes.md) — inventário e decisões do console.
- [02-softmod-abadavatar-xeunshackle.md](02-softmod-abadavatar-xeunshackle.md) — exploit temporário.
- [03-backup-nand.md](03-backup-nand.md) — backup e recuperação.
- [04-aurora.md](04-aurora.md) — instalação/migração do Aurora.

## Abordagens de biblioteca

A documentação específica foi separada por abordagem em [approaches/](approaches/):

```text
aurora-xbox/
├── 01-console-e-decisoes.md
├── 02-softmod-abadavatar-xeunshackle.md
├── 03-backup-nand.md
├── 04-aurora.md
└── approaches/
    ├── README.md
    ├── netiso/
    ├── connectx/
    └── god-local/
```

Ordem definida:

1. **NetISO — VALIDADO / MANTER.** ISOs no Mac, montagem pela rede.
2. **ConnectX — EM IMPLEMENTAÇÃO.** CX-00 concluído; próximo gate CX-01. Jogos extraídos no Mac e biblioteca remota escaneável pelo Aurora/CoverFlow.
3. **GOD/local — IMPLEMENTAR POR ÚLTIMO.** Games on Demand no HDD interno para experiência local.

As três abordagens serão mantidas e testadas em coexistência. A implementação de uma não implica remover as anteriores.

## NetISO atualmente congelado

```text
MacBook Ethernet: 192.168.50.1/24
Xbox Ethernet:    192.168.50.2/24
NetISO:           TCP 4323
Aurora FTP:       TCP 21

Biblioteca ISO:
/Users/Shared/xbox360

Servidor:
/usr/local/libexec/netiso-srv

LaunchDaemon:
/Library/LaunchDaemons/io.remappingbridge.netiso-srv.plist
```

`launch.ini` atual:

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

Histórico completo: [approaches/netiso/](approaches/netiso/).

Planejamento ConnectX: [approaches/connectx/PLAN.md](approaches/connectx/PLAN.md).

Planejamento GOD/local: [approaches/god-local/PLAN.md](approaches/god-local/PLAN.md).

## Segurança

Não versionar ou compartilhar:

- CPUKey;
- DVDKey;
- `cpukey.txt`;
- `ConsoleInfo.txt`;
- dumps de NAND;
- senhas/credenciais SMB do futuro ConnectX;
- qualquer segredo único do console.

Backup sensível permanece fora do repositório em:

```text
/home/tiago/xbox360-1538-backup-20261001-190729/
```