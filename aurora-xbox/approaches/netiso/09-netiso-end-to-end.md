# 09 — Validação fim a fim do NetISO

Data: 2026-10-01

## Resultado

A cadeia completa foi validada com sucesso até a abertura de um jogo real:

```text
MacBook
/Users/Shared/xbox360/PES 2018 - Pro Evolution Soccer (USA) (En,Es).iso
        |
        | netiso-srv TCP 4323
        v
Ethernet direta 192.168.50.1/24 <-> 192.168.50.2/24
        |
        v
Xbox 360
ABadAvatar
 -> XeUnshackle
 -> Aurora 0.7b.2
 -> Xbox Guide
 -> File Browser
 -> NetISO
 -> PES 2018
 -> jogo abriu
```

## Itens confirmados

- Aurora abriu normalmente após instalar o Nova.xex modificado.
- NetISO apareceu no File Browser.
- As ISOs servidas pelo Mac ficaram acessíveis no Xbox.
- PES 2018 foi selecionado e montado via NetISO.
- PES 2018 abriu no Xbox 360 a partir da ISO mantida no Mac.
- Não foi necessário copiar a ISO integralmente para o HDD interno do Xbox.

## Estado atual da arquitetura

```text
USB Aurora-XBOX
├── ABadAvatar
├── XeUnshackle
├── launch.ini
└── NetISO
    ├── NetISO.xex
    └── NetISO.xex.txt

HDD Xbox
└── Apps\Aurora
    ├── Aurora.xex
    └── Plugins\Nova.xex   <- versão modificada para NetISO

MacBook
├── /Users/Shared/xbox360/*.iso
└── netiso-srv -r -v /Users/Shared/xbox360
```

## Rede

```text
MacBook: 192.168.50.1/24
Xbox:    192.168.50.2/24
NetISO:  TCP 4323
Aurora:  FTP TCP 21
```

## Requisito permanente

Preservar:

```text
USB fora + reboot -> dashboard retail/original
USB + exploit     -> Aurora + NetISO
```

## Validação de estabilidade e retorno ao modo retail

Em 2026-10-02 o usuário confirmou:

- gameplay via NetISO sem travamentos;
- reinicialização do Xbox sem o pendrive retorna normalmente ao dashboard retail/original;
- portanto a instalação do Nova modificado no HDD não alterou o comportamento retail sem o exploit.

Requisito permanente novamente validado:

```text
USB fora + reboot -> dashboard retail/original
USB + exploit     -> Aurora + NetISO
```

## Validação dinâmica do enlace

Em 2026-10-02 também foi validado o comportamento durante perda e retorno do cabo Ethernet:

```text
cabo conectado    -> ISO remota disponível
cabo desconectado -> ISO remota desaparece
cabo reconectado  -> ISO remota reaparece
```

Não houve travamento no teste. Isso confirma recuperação normal do NetISO quando o enlace físico volta.

O servidor foi posteriormente migrado para um LaunchDaemon de sistema e a biblioteca para `/Users/Shared/xbox360`; consulte [10-netiso-launchdaemon.md](10-netiso-launchdaemon.md).
