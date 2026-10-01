# Aurora Xbox — Xbox 360 E 1538

Registro operacional e rastreável da preparação do Xbox 360 E para executar Aurora temporariamente via ABadAvatar/XeUnshackle e, em etapa futura, consumir jogos mantidos no macOS via Ethernet/NetISO.

> **Status atual (2026-10-01):** Aurora 0.7b.2 foi migrado para o HDD interno e abriu com sucesso via ABadAvatar/XeUnshackle. A alternância foi validada fisicamente: **USB conectado + exploit = Aurora desbloqueado; USB removido + reboot = dashboard retail/original**. A NAND não foi modificada. Há duas leituras idênticas da NAND salvas localmente no Debian.

## Console e estado confirmado

- Console: Xbox 360 E, model 1538.
- MFR Date: **2014-05-06**.
- Dashboard: **2.0.17559.0**.
- Kernel: **2.0.17559.0**.
- HDD interno: aproximadamente 250 GB, com ~220 GB livres observados antes da migração.
- Aurora 0.7b.2 atualmente em `Hdd:\Apps\Aurora\Aurora.xex`.
- ABadAvatar/XeUnshackle continuam no pendrive.
- Nenhuma gravação de NAND, RGH físico ou instalação persistente foi executada.

## Arquitetura validada

```text
HDD interno
└── Apps\Aurora\
    └── Aurora.xex
        ^
        | executado apenas após exploit
        |
USB Aurora-XBOX
├── Content\                <- ABadAvatar
├── BadUpdatePayload\       <- XeUnshackle
└── launch.ini               <- Default = Hdd:\Apps\Aurora\Aurora.xex
```

Fluxos validados:

```text
USB conectado
 -> ABadAvatar
 -> XeUnshackle
 -> DashLaunch em memória
 -> Hdd:\Apps\Aurora\Aurora.xex
 -> Aurora 0.7b.2
```

```text
USB removido
 -> reboot/power-on
 -> nenhum exploit
 -> dashboard Microsoft retail/original
```

A alternância retail/desbloqueado é agora um requisito permanente do projeto. **Não mover ABadAvatar/XeUnshackle para o HDD e não instalar mecanismo persistente na NAND.**

## Pendrive de trabalho

- SanDisk Ultra.
- 28,7 GiB / 30,8 GB.
- MBR/msdos + FAT32.
- Label: `Aurora-XBOX`.

A letra do device Linux variou (`/dev/sde1`, `/dev/sdd1`). Sempre confirmar com:

```bash
findmnt -no SOURCE,FSTYPE,LABEL,TARGET /media/tiago/Aurora-XBOX
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS
```

## Arquivos do projeto

- [01-console-e-decisoes.md](01-console-e-decisoes.md) — inventário e decisões.
- [02-softmod-abadavatar-xeunshackle.md](02-softmod-abadavatar-xeunshackle.md) — processo de exploit.
- [03-backup-nand.md](03-backup-nand.md) — backup e recuperação.
- [04-aurora.md](04-aurora.md) — instalação, migração e validação do Aurora.
- [05-proximos-passos-netiso.md](05-proximos-passos-netiso.md) — próxima fase: NetISO/macOS/Ethernet.

## Estado atual do `launch.ini`

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

## Segurança

Não versionar ou compartilhar:

- CPUKey;
- DVDKey;
- `cpukey.txt`;
- `ConsoleInfo.txt`;
- dumps de NAND;
- qualquer segredo único do console.

O backup permanece em:

```text
/home/tiago/xbox360-1538-backup-20261001-190729/
```

Consulte [03-backup-nand.md](03-backup-nand.md).
