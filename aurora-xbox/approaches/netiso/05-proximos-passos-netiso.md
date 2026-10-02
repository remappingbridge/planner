# 05 — Próximos passos: macOS + Ethernet + NetISO

> A migração do Aurora para HDD, a alternância retail/desbloqueado e a rede Ethernet ponto a ponto foram concluídas em 2026-10-01.

## Estado de entrada

Validado:

```text
sem USB + reboot
 -> Xbox retail/original

USB Aurora-XBOX + ABadAvatar
 -> XeUnshackle
 -> DashLaunch temporário
 -> Hdd:\Apps\Aurora\Aurora.xex
 -> Aurora 0.7b.2
```

Rede validada:

```text
MacBook en7: 192.168.50.1/24
Xbox wired:  192.168.50.2/24
NetISO:      TCP 4323
Aurora FTP:  TCP 21
```

O pendrive continua sendo a **chave do desbloqueio**.

Detalhes e evidências: [06-rede-macos.md](06-rede-macos.md).

## Objetivo

```text
MacBook/macOS
├── /Users/admin/Documents/xbox360/*.iso
└── netiso-srv :4323
        |
        | Ethernet direto
        v
Xbox 360
└── ABadAvatar -> XeUnshackle -> Aurora -> NetISO
```

Os jogos devem permanecer no Mac, sem cópia integral para o HDD interno.

## Regras permanentes

- não mover ABadAvatar/XeUnshackle para o HDD;
- não instalar DashLaunch na flash/NAND;
- manter `liveblock = true`;
- preservar `USB fora = retail`;
- usar `plugin1` para NetISO;
- manter Xbdm/JRPC2 desabilitados enquanto NetISO estiver em teste;
- não ativar Internet Sharing/NAT no Mac para esta rede;
- manter IPs fixos `192.168.50.1` e `192.168.50.2`.

## Concluído

1. Aurora no HDD interno.
2. Alternância retail/desbloqueado validada.
3. Ethernet direto configurado e persistente.
4. Mac `192.168.50.1/24`.
5. Xbox `192.168.50.2/24`.
6. ARP Mac ↔ Xbox validado.
7. FTP Aurora em `192.168.50.2:21` validado.
8. `netiso-srv` compilado no Mac ARM64.
9. Servidor NetISO escutando em `*:4323`.
10. TCP local e Ethernet para `192.168.50.1:4323` validado.

## Próximas etapas

1. Obter o pacote de NetISO/Aurora e validar sua origem.
2. Fazer backup do `Hdd1:\Apps\Aurora\Plugins\Nova.xex` original antes da substituição.
3. Instalar o `Nova.xex` modificado no Aurora do HDD.
4. Colocar `NetISO.xex` e `NetISO.xex.txt` no pendrive/chave.
5. Configurar `NetISO.xex.txt` com `192.168.50.1`.
6. Alterar `launch.ini` do USB para NetISO em `plugin1`.
7. Reiniciar a sessão desbloqueada.
8. Abrir NetISO no Guide/File Browser.
9. Montar uma ISO real.
10. Iniciar o jogo e validar leitura pela rede.
11. Confirmar novamente `USB fora + reboot = retail`.
12. Automatizar `netiso-srv` com `launchd` depois que o funcionamento fim a fim estiver confirmado.

## Critério de conclusão

```text
ISO permanece no macOS
 -> netiso-srv
 -> Ethernet direto
 -> NetISO no Xbox lista/monta ISO
 -> jogo inicia
```

sem quebrar:

```text
USB fora + reboot -> retail
USB + exploit     -> Aurora/NetISO
```
