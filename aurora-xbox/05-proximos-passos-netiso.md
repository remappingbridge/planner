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

## Etapas planejadas

1. Migrar Aurora do USB para o HDD interno do Xbox.
2. Confirmar boot do Aurora apontando `Default` para `Hdd:\...`.
3. Instalar/configurar plugin NetISO.
4. Manter `liveblock = true`.
5. Reservar `plugin1` para NetISO se a implementação escolhida exigir isso.
6. Configurar link Ethernet direto MacBook ↔ Xbox.
7. Definir IPs estáticos em uma sub-rede dedicada.
8. Iniciar o servidor NetISO no macOS.
9. Apontar o cliente/plugin do Xbox para o endereço do Mac.
10. Validar uma ISO conhecida antes de migrar a biblioteca completa.

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

Após validar, atualizar este arquivo com:

- versão exata do NetISO;
- origem/hash dos binários;
- comandos de instalação;
- configuração de rede efetivamente usada;
- paths no macOS;
- configuração final do `launch.ini`;
- testes realizados;
- limitações observadas.
