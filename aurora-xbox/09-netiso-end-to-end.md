# 09 — Validação fim a fim do NetISO

Data: 2026-10-01

## Resultado

A cadeia completa foi validada com sucesso até a abertura de um jogo real:

```text
MacBook
/Users/admin/Documents/xbox360/PES 2018 - Pro Evolution Soccer (USA) (En,Es).iso
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
├── /Users/admin/Documents/xbox360/*.iso
└── netiso-srv -r -v /Users/admin/Documents/xbox360
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

Ainda falta repetir o teste de modo retail depois desta instalação do NetISO e, opcionalmente, automatizar o servidor NetISO no macOS com launchd.
