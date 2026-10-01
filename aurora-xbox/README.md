# Aurora Xbox — Xbox 360 E 1538

Registro operacional e rastreável da preparação do Xbox 360 E para executar Aurora temporariamente via ABadAvatar/XeUnshackle e, em etapa futura, consumir jogos mantidos no macOS via Ethernet/NetISO.

> **Status atual (2026-10-01):** Aurora 0.7b.2 abriu com sucesso. O desbloqueio é **temporário e não persistente**. A NAND não foi modificada. Há duas leituras idênticas da NAND salvas localmente no Debian.

## Console e estado confirmado

- Console: Xbox 360 E, model 1538.
- MFR Date: **2014-05-06**.
- Dashboard: **2.0.17559.0**.
- Kernel: **2.0.17559.0**.
- HDD interno: aproximadamente 250 GB, com ~220 GB livres observados.
- Rede foi removida/desconectada durante os testes do exploit.
- Existem perfis/avatares antigos no console; não foi necessário removê-los.
- Nenhuma gravação de NAND, RGH físico ou instalação persistente foi executada.

A data de fabricação sugere uma revisão anterior à Winchester, mas isso **não foi usado como pré-condição**: o caminho escolhido foi software-only com ABadAvatar/XeUnshackle.

## Arquitetura atual

```text
Xbox 360 retail 17559
        |
        v
ABadAvatar v1.3-beta (USB FAT32 + MBR)
        |
        v
XeUnshackle BETA v1.03
        |
        v
DashLaunch em memória
        |
        v
Usb:\Apps\Aurora\Aurora.xex
        |
        v
Aurora 0.7b.2
```

Ao desligar/reiniciar o console, o softmod deixa de estar ativo. É necessário disparar o ABadAvatar novamente.

## Pendrive de trabalho

Pendrive usado:

- SanDisk Ultra.
- Capacidade mostrada pelo Linux: 28,7 GiB / 30,8 GB.
- Tabela de partições: **MBR/msdos**.
- Partição: FAT32.
- Label: `Aurora-XBOX`.

Importante: o nome de dispositivo Linux variou durante o trabalho (`/dev/sde1`, depois `/dev/sdd1`). **Nunca presumir a letra do dispositivo.** Confirmar sempre com:

```bash
findmnt -no SOURCE,FSTYPE,LABEL,TARGET /media/tiago/Aurora-XBOX
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS
```

## Arquivos do projeto

- [01-console-e-decisoes.md](01-console-e-decisoes.md) — inventário e decisões.
- [02-softmod-abadavatar-xeunshackle.md](02-softmod-abadavatar-xeunshackle.md) — processo de exploit e lições aprendidas.
- [03-backup-nand.md](03-backup-nand.md) — backup, validação, localização e cópia futura para armazenamento externo.
- [04-aurora.md](04-aurora.md) — download, validação, instalação e boot do Aurora.
- [05-proximos-passos-netiso.md](05-proximos-passos-netiso.md) — trabalho ainda não executado para macOS + Ethernet + NetISO.

## Estado do `launch.ini`

Configuração relevante validada antes do boot bem-sucedido do Aurora:

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

`Xbdm.xex` e `JRPC2.xex` continuam fisicamente no pendrive, mas foram removidos da lista de plugins do DashLaunch.

## Segurança

Não registrar neste repositório:

- CPUKey;
- DVDKey;
- conteúdo de `cpukey.txt`;
- conteúdo de `ConsoleInfo.txt`;
- dumps de NAND;
- qualquer segredo único do console.

Esses dados permanecem somente no backup local descrito em [03-backup-nand.md](03-backup-nand.md).

## Resultado já validado

Fluxo validado fisicamente:

```text
Boot
 -> seleção de perfis
 -> ABadAvatar dispara
 -> XeUnshackle abre
 -> botão BACK
 -> DashLaunch lê launch.ini
 -> Aurora 0.7b.2 abre com sucesso
```

Nenhuma configuração de NetISO foi executada ainda.
