# 01 — Console e decisões

## Identificação

| Item | Valor confirmado |
|---|---|
| Família | Xbox 360 E |
| Model | 1538 |
| MFR Date | 2014-05-06 |
| Dashboard | 2.0.17559.0 |
| Kernel | 2.0.17559.0 |
| HDD interno | ~250 GB |
| Espaço livre observado | ~220 GB |
| Softmod | ABadAvatar v1.3-beta + XeUnshackle BETA v1.03 |
| Dashboard alternativo | Aurora 0.7b.2 |
| Persistência | Não persistente |

## Objetivo definido

Arquitetura desejada para a etapa final:

```text
macOS
├── biblioteca Xbox 360 em .iso
└── servidor NetISO
        |
        | Ethernet
        v
Xbox 360
└── ABadAvatar -> XeUnshackle -> Aurora -> NetISO
```

Requisitos do usuário:

- jogos permanecem no macOS;
- link físico MacBook ↔ Xbox por Ethernet;
- Xbox lê os jogos durante a sessão, sem manter a biblioteca permanentemente local;
- administração do lado macOS preferencialmente por terminal/SSH;
- evitar alterações físicas no Xbox enquanto houver solução software-only adequada.

## Decisões tomadas

### Não usar RGH agora

Embora a data de fabricação seja compatível com uma revisão possivelmente explorável por RGH, não houve abertura física do console e a placa não foi confirmada visualmente.

Foi escolhida uma rota software-only:

1. dashboard retail 17559;
2. ABadAvatar;
3. XeUnshackle;
4. DashLaunch em memória;
5. Aurora.

Isso evita soldagem e alteração permanente da NAND.

### Não restaurar o Xbox

O console já possuía três avatares/perfis. Eles não foram excluídos porque:

- não eram um impedimento ao exploit;
- os avatares apareceram normalmente;
- isso indicou que os dados adicionais de avatar do 17559 já estavam presentes.

### Internet desconectada durante exploit

Durante ABadAvatar/XeUnshackle, a rede foi mantida desconectada.

`liveblock = true` permaneceu habilitado no `launch.ini`.

### Pendrive precisa ser MBR + FAT32

O primeiro pendrive estava em FAT32, mas com tabela GPT.

Estado problemático observado:

```text
Partition Table: gpt
File system: fat32
```

Depois foi recriado como:

```text
Partition Table: msdos
File system: fat32
Flags: lba
Label: Aurora-XBOX
```

O dispositivo utilizado foi um SanDisk Ultra de 28,7 GiB.

## Nota sobre letras de dispositivos Linux

Durante a sessão, o mesmo pendrive apareceu como `/dev/sde1` e posteriormente como `/dev/sdd1`.

Nunca reutilizar uma letra antiga sem confirmar.

Comandos de identificação:

```bash
findmnt -no SOURCE,FSTYPE,LABEL,TARGET /media/tiago/Aurora-XBOX
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS
```

Antes de qualquer comando destrutivo:

```bash
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS /dev/sdX
```

e confirmar visualmente que o modelo é o pendrive correto.
