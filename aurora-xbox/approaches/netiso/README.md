# Abordagem 1 — NetISO

> **Status: VALIDADO E MANTIDO.**

NetISO é a implementação de referência já funcional. Ela não será removida durante os testes de ConnectX ou GOD/local.

## Estado final

```text
MacBook
├── /Users/Shared/xbox360/*.iso
└── /usr/local/libexec/netiso-srv
        |
        | TCP 4323 / 192.168.50.1
        v
Xbox 360
├── ABadAvatar/XeUnshackle via USB
├── NetISO.xex via USB
└── Aurora 0.7b.2 + Nova.xex modificado
```

Validações concluídas:

- ISO listada em Xbox Guide → File Browser → NetISO;
- PES 2018 montado e iniciado pela rede;
- gameplay sem travamento observado;
- desconectar Ethernet faz a ISO desaparecer;
- reconectar Ethernet faz a ISO reaparecer;
- Mac reiniciado: LaunchDaemon sobe sozinho;
- USB removido + reboot: console continua retail/original.

## Arquivos históricos desta abordagem

- [05-proximos-passos-netiso.md](05-proximos-passos-netiso.md)
- [06-rede-macos.md](06-rede-macos.md)
- [07-netiso-package.md](07-netiso-package.md)
- [08-netiso-installation.md](08-netiso-installation.md)
- [09-netiso-end-to-end.md](09-netiso-end-to-end.md)
- [10-netiso-launchdaemon.md](10-netiso-launchdaemon.md)

## Congelado enquanto outras abordagens são testadas

Não alterar sem necessidade:

```text
/Library/LaunchDaemons/io.remappingbridge.netiso-srv.plist
/usr/local/libexec/netiso-srv
/Users/Shared/xbox360
Usb0:\NetISO\NetISO.xex
Usb0:\NetISO\NetISO.xex.txt
Hdd1:\Apps\Aurora\Plugins\Nova.xex
```

O `launch.ini` deve continuar com NetISO como `plugin1`.