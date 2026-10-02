# Xbox 360 — abordagens de biblioteca de jogos

Este diretório separa as três abordagens que serão mantidas e avaliadas no mesmo console. **Nenhuma abordagem substitui automaticamente a anterior.**

## Ordem do projeto

| Ordem | Abordagem | Formato principal | Armazenamento | Objetivo de UX | Status |
|---|---|---|---|---|---|
| 1 | [NetISO](netiso/) | ISO | MacBook | montar ISO pela rede | **VALIDADO / manter** |
| 2 | [ConnectX](connectx/) | jogo extraído (`default.xex`) | MacBook | biblioteca remota no CoverFlow do Aurora | **PRÓXIMA IMPLEMENTAÇÃO** |
| 3 | [GOD/local](god-local/) | Games on Demand | HDD do Xbox | biblioteca local e integração com dashboards | **IMPLEMENTAR POR ÚLTIMO** |

## Regra do projeto

As três abordagens devem coexistir enquanto forem úteis:

```text
NetISO
  -> mantém as ISOs originais no Mac
  -> continua disponível e funcional

ConnectX
  -> usa uma biblioteca extraída separada no Mac
  -> será testado sem desmontar NetISO

GOD/local
  -> usa uma cópia convertida e armazenada localmente no Xbox
  -> será testado depois do ConnectX
```

A ISO original nunca deve ser apagada apenas porque um jogo foi extraído ou convertido para GOD.

## Infraestrutura comum congelada

```text
MacBook Ethernet: 192.168.50.1/24
Xbox Ethernet:    192.168.50.2/24
Aurora FTP:       TCP 21
NetISO:           TCP 4323
```

Requisito permanente:

```text
USB fora + reboot -> dashboard Microsoft retail/original
USB + exploit     -> Aurora e recursos homebrew
```

ABadAvatar/XeUnshackle continuam no pendrive. Não instalar mecanismo persistente na NAND.

## Critério da comparação

Ao final das três implementações, comparar por experiência real e não por substituição teórica:

- acesso pelo carrossel/CoverFlow;
- capas e metadados;
- tempo para iniciar um jogo;
- espaço usado no Mac e no Xbox;
- comportamento sem rede;
- facilidade de adicionar/remover jogos;
- compatibilidade;
- capacidade de coexistir com as outras duas abordagens;
- manutenção/rollback.