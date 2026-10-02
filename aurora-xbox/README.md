# Aurora Xbox — Xbox 360 E 1538

Registro operacional e rastreável da preparação do Xbox 360 E para executar Aurora temporariamente via ABadAvatar/XeUnshackle e consumir jogos mantidos no macOS via Ethernet/NetISO.

> **Status atual (2026-10-02):** NetISO foi validado fim a fim e permaneceu estável durante gameplay. `PES 2018` abriu a partir da ISO no Mac, o Xbox voltou normalmente ao dashboard retail/original sem o pendrive, e o servidor NetISO passou a executar como LaunchDaemon de sistema no macOS, servindo `/Users/Shared/xbox360` em TCP 4323. O autostart também foi validado após um reboot real do Mac. A NAND não foi modificada.

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
- [05-proximos-passos-netiso.md](05-proximos-passos-netiso.md) — próxima fase: plugin NetISO e teste de jogos.\n- [06-rede-macos.md](06-rede-macos.md) — rede privada MacBook ↔ Xbox e servidor NetISO, já validados.
- [07-netiso-package.md](07-netiso-package.md) — pacote NetISO validado no macOS.
- [08-netiso-installation.md](08-netiso-installation.md) — instalação e rollback do NetISO no Xbox.
- [09-netiso-end-to-end.md](09-netiso-end-to-end.md) — validação fim a fim com PES 2018.
- [10-netiso-launchdaemon.md](10-netiso-launchdaemon.md) — servidor NetISO automático no boot via LaunchDaemon.

## Estado atual do `launch.ini`

```ini
Default = Hdd:\Apps\Aurora\Aurora.xex

plugin1 = Usb:\\NetISO\\NetISO.xex
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
