# 05 — Próximos passos: macOS + Ethernet + NetISO

> A fase de migração do Aurora para HDD e alternância retail/desbloqueado foi concluída em 2026-10-01. O restante deste arquivo registra a próxima fase ainda não validada.

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

O pendrive continua sendo a **chave do desbloqueio**.

## Objetivo

```text
MacBook/macOS
├── biblioteca Xbox 360 (.iso)
└── servidor NetISO
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
- usar `plugin1` para NetISO quando essa fase for instalada;
- manter Xbdm/JRPC2 desabilitados enquanto NetISO estiver em teste, evitando conflito de plugins.

## Próximas etapas

1. Obter o pacote de NetISO/Aurora e validar sua origem.
2. Fazer backup do `Hdd1:\Apps\Aurora\Plugins\Nova.xex` original antes da substituição.
3. Instalar o `Nova.xex` modificado no Aurora do HDD.
4. Colocar `NetISO.xex` e `NetISO.xex.txt` em local rastreável.
5. Configurar `NetISO.xex.txt` com o IP do MacBook.
6. Alterar o `launch.ini` do USB para carregar NetISO em `plugin1`.
7. Configurar Ethernet direto MacBook ↔ Xbox.
8. Usar inicialmente uma sub-rede isolada, sem gateway.
9. Executar servidor NetISO no macOS.
10. Testar descoberta/montagem de uma ISO Xbox 360.
11. Confirmar novamente que a remoção do USB + reboot mantém o modo retail.

## Rede inicialmente planejada

```text
MacBook Ethernet: 192.168.50.1/24
Xbox Ethernet:    192.168.50.2/24
Gateway:          nenhum durante os primeiros testes
NetISO TCP:       4323
```

A rede efetivamente usada deverá substituir este bloco depois da validação.

## Critério de conclusão

```text
ISO permanece no macOS
 -> servidor NetISO
 -> Ethernet direto
 -> NetISO no Xbox lista/monta ISO
 -> jogo inicia
```

sem quebrar:

```text
USB fora + reboot -> retail
USB + exploit     -> Aurora/NetISO
```
