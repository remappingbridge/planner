# Plano de implementação — GOD/local

## Princípios

- executar somente depois de ConnectX estar validado;
- manter NetISO e ConnectX funcionais;
- testar inicialmente com um único jogo;
- preservar a ISO original no Mac;
- medir espaço usado antes e depois;
- armazenar o GOD no HDD interno do Xbox para testar experiência realmente local.

## GOD-00 — baseline das três cópias

Para o jogo piloto, o estado pretendido será:

```text
NetISO:
  /Users/Shared/xbox360/<jogo>.iso

ConnectX:
  /Users/Shared/xbox360-connectx/<jogo>/default.xex

GOD/local:
  Hdd1:\Content\0000000000000000\<TitleID>\00007000\...
```

As três formas devem coexistir durante a avaliação.

**Gate:** NetISO e ConnectX continuam funcionando antes de criar o GOD.

## GOD-01 — escolher e validar ferramenta de conversão

Candidatos previstos:

- `xtafkit`, que suporta conversão de XISO para GOD;
- ISO2GOD, caso seja necessário usar ambiente Windows/compatível.

Preferir uma conversão compacta que remova padding desnecessário sem alterar a ISO original.

Antes da conversão registrar SHA-256 da ISO, tamanho da ISO, espaço livre do HDD interno e TitleID/MediaID quando disponível.

**Gate:** ferramenta escolhida produz estrutura GOD reconhecível sem modificar o arquivo ISO original.

## GOD-02 — converter um jogo em staging no Mac

Criar staging separado, por exemplo:

```text
/Users/Shared/xbox360-god-staging/<TitleID>/00007000/
```

Verificar estrutura de arquivos, tamanho total convertido, TitleID e presença do container/dados segmentados.

**Gate:** conversão local concluída e validada antes de qualquer upload.

## GOD-03 — transferir para o HDD interno

Destino canônico para integração com o dashboard Microsoft:

```text
Hdd1:\Content\0000000000000000\<TitleID>\00007000\
```

Transferir por FTP e validar tamanho/arquivos após upload. Não apagar a cópia staging até concluir os testes.

**Gate:** GOD completo no HDD e integridade pós-transferência confirmada.

## GOD-04 — testar no Aurora

- garantir que o caminho de conteúdo local inclui a árvore necessária;
- executar rescan;
- confirmar que o jogo aparece no CoverFlow;
- abrir o jogo;
- testar gameplay;
- confirmar capa/metadados.

**Gate:** jogo GOD abre diretamente do HDD pelo Aurora.

## GOD-05 — testar integração com dashboard Microsoft

Objetivo separado do lançamento no Aurora:

- verificar se a instalação em `Content\0000000000000000\<TitleID>\00007000` é listada no dashboard Microsoft;
- registrar comportamento com USB/exploit ativo;
- registrar comportamento no modo retail/original sem USB.

Não assumir que visibilidade e capacidade de executar são a mesma coisa; registrar cada comportamento separadamente.

**Gate:** comportamento no dashboard Microsoft documentado fisicamente.

## GOD-06 — testar modo offline total

Desconectar Ethernet e validar:

```text
GOD/local -> continua disponível e jogável
ConnectX  -> indisponível sem rede
NetISO    -> indisponível sem rede
```

Depois reconectar Ethernet e confirmar retorno das duas abordagens remotas.

**Gate:** GOD funciona sem Mac/cabo e as abordagens remotas se recuperam após reconexão.

## GOD-07 — comparação final das três abordagens

| Critério | NetISO | ConnectX | GOD/local |
|---|---|---|---|
| formato | ISO | extraído/default.xex | GOD |
| armazenamento | Mac | Mac | Xbox |
| CoverFlow Aurora | via montagem | direto após scan | direto após scan |
| funciona sem Ethernet | não | não | sim |
| preserva ISO original | sim | sim | sim |
| espaço no HDD Xbox | mínimo | mínimo | alto |
| integração dashboard Microsoft | não é objetivo | não é objetivo | testar |

Adicionar medições reais: tamanho, tempo de início, loading, estabilidade, capas/metadados, manutenção e facilidade de adicionar/remover jogos.

**Gate de conclusão:** três abordagens validadas e documentadas, sem escolher uma única vencedora por obrigação.