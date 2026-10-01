# 05 — Próximos passos: macOS + Ethernet + NetISO

> Este arquivo registra **planejamento ainda não executado**. Não tratar os itens abaixo como configuração já validada.

## Objetivo

Manter os jogos exclusivamente no MacBook/macOS:

```text
MacBook
├── biblioteca de jogos Xbox 360 (.iso)
└── servidor NetISO
        |
        | Ethernet
        v
Xbox 360
└── ABadAvatar -> XeUnshackle -> Aurora -> NetISO
```

O Xbox deve consumir o conteúdo pela rede durante a sessão, sem copiar permanentemente a biblioteca para o HDD interno.

## Requisito de alternância retail / desbloqueado

A arquitetura futura deve manter o pendrive `Aurora-XBOX` como **chave do desbloqueio**.

```text
HDD interno:
  Apps\Aurora\...
  (arquivos inertes quando o Xbox está retail)

USB Aurora-XBOX:
  Content\
  BadUpdatePayload\
  launch.ini
  (ABadAvatar + XeUnshackle)
```

Regras:

- **não mover** ABadAvatar/XeUnshackle para o HDD;
- **não instalar** DashLaunch na flash/NAND;
- sem USB/exploit, o console deve iniciar retail;
- com USB/exploit, o DashLaunch temporário deverá iniciar o Aurora no HDD.

## Etapas planejadas

1. Copiar Aurora do USB para `Hdd1:\Apps\Aurora\`, mantendo uma cópia no USB até o teste terminar.
2. Alterar somente o `launch.ini` do USB para apontar `Default` para o Aurora no HDD e confirmar o boot.
3. Testar o modo retail: desligar, retirar USB e confirmar dashboard Microsoft normal.
4. Testar novamente o modo desbloqueado: recolocar USB, disparar ABadAvatar e confirmar Aurora no HDD.
5. Somente depois remover a cópia redundante de Aurora do USB, se desejado.
6. Instalar/configurar plugin NetISO.
7. Manter `liveblock = true`.
8. Reservar `plugin1` para NetISO se a implementação escolhida exigir isso.
9. Configurar link Ethernet direto MacBook ↔ Xbox.
10. Definir IPs estáticos em uma sub-rede dedicada.
11. Iniciar o servidor NetISO no macOS.
12. Apontar o cliente/plugin do Xbox para o endereço do Mac.
13. Validar uma ISO conhecida antes de migrar a biblioteca completa.

## Rede proposta

Exemplo de sub-rede dedicada:

```text
MacBook Ethernet: 192.168.50.1/24
Xbox Ethernet:    192.168.50.2/24
```

Inicialmente sem gateway, para manter o Xbox isolado da Internet.

Depois, se necessário, o MacBook pode compartilhar sua conexão Wi-Fi para a interface Ethernet.

## Administração

O Xbox/Aurora não deve ser tratado como servidor SSH Unix.

Administração esperada:

- SSH no MacBook para gerenciar biblioteca e NetISO;
- FTP/Aurora para arquivos no Xbox quando necessário;
- interface do Aurora para configurações específicas do dashboard.

## Critério de conclusão futuro

A próxima fase só será considerada concluída quando este fluxo for validado:

```text
ISO permanece no macOS
 -> servidor NetISO lê ISO
 -> Ethernet direto MacBook/Xbox
 -> Aurora/NetISO monta o jogo
 -> jogo inicia e executa sem cópia integral local
```

E a alternância deve continuar válida:

```text
sem USB -> retail
com USB + exploit -> Aurora/NetISO
```

Após validar, atualizar este arquivo com:

- versão exata do NetISO;
- origem/hash dos binários;
- comandos de instalação;
- configuração de rede efetivamente usada;
- paths no macOS;
- configuração final do `launch.ini`;
- testes realizados;
- limitações observadas.
