# Automação ConnectX / Aurora

Data do plano: 2026-10-03

## Integração com XboxMac UI

Esta automação será exposta ao usuário pelo painel planejado em [../../xboxmac-ui/PLAN.md](../../xboxmac-ui/PLAN.md). O painel será o control plane; não deve existir um segundo pipeline de conversão concorrente.

## Objetivo

Automatizar o fluxo entre a biblioteca ISO do Mac, a árvore ConnectX e os assets locais do Aurora, mantendo:

- NetISO intacto;
- ISOs originais intactas;
- ConnectX read-only no SMB;
- operações idempotentes;
- cache local de metadata/artwork;
- nenhuma sobrescrita silenciosa de capa escolhida manualmente;
- nenhum write direto em `content.db` até haver documentação, backup e gate específico.

Alvo de longo prazo:

```text
nova ISO em /Users/Shared/xbox360
        ↓
detectar
        ↓
extrair para staging temporário
        ↓
validar default.xex
        ↓
TitleID + MediaID + hashes
        ↓
promover para /Users/Shared/xbox360-connectx/<jogo>
        ↓
metadata/artwork
        ↓
descobrir ContentID interno do Aurora
        ↓
gerar assets nativos do Aurora
        ↓
FTP somente dos deltas
        ↓
capa/artwork disponível no CoverFlow
```

## Decisão principal

A automação não dependerá de tentar clicar remotamente em:

```text
Start > Assets > Import
```

Para artwork, o alvo é gerar diretamente os arquivos nativos que o Aurora usa em:

```text
Aurora/Data/GameData/<TitleID>_<ContentID>/
```

A documentação do formato do Aurora define `ContentID` como o valor de `ContentItems.id` no banco:

```text
Aurora/Data/Databases/content.db
```

Portanto, `ContentID` não deve ser confundido com MediaID.

Arquivos nativos relevantes:

```text
BK<TitleID>.asset  -> background
GC<TitleID>.asset  -> cover
GL<TitleID>.asset  -> icon + banner
SS<TitleID>.asset  -> screenshots
```

Screenshots ficam fora da primeira versão automática.

## Limite deliberado da v1

A v1 automatizará artwork sem escrever diretamente em `content.db`.

Motivo: a geração dos `.asset` está documentada e existe implementação aberta em `libaustralis`; já a alteração do banco do Aurora pode causar perda de catálogo se feita enquanto o dashboard estiver usando o arquivo.

Metadata textual continuará sendo preparada no staging `User/Import/<TitleID>`. A automação direta de título, descrição, publisher, developer, gênero e data será uma fase separada depois que o schema e a estratégia de atualização transacional do banco forem validados.

## Estado persistente no Mac

Raiz:

```text
/usr/local/var/xbox-connectx/
```

Estrutura planejada:

```text
catalog.json
sync-state.json
cover-overrides.json
cache/
staging/
aurora-db-snapshots/
generated-assets/
logs/
locks/
```

Cada jogo deve ter estado equivalente a:

```json
{
  "title_id": "4A3007D3",
  "media_id": "1CB7BE36",
  "iso_sha256": "...",
  "xex_sha256": "...",
  "source_iso": "...",
  "connectx_dir": "...",
  "aurora_content_id": 0,
  "asset_source": "...",
  "asset_hashes": {},
  "status": "..."
}
```

## AUTO-00 — baseline e rollback

Antes de qualquer upload automático para `Data/GameData`:

- baixar snapshot de `Aurora/Data/Databases/content.db`;
- baixar o diretório `Data/GameData/<TitleID>_<ContentID>` do jogo piloto, se existir;
- registrar hashes;
- nunca alterar o banco nesta fase;
- qualquer asset existente deve ser salvo localmente antes de substituição.

Gate: rollback completo possível sem depender do servidor de metadata.

### Evidências AUTO-00 — snapshot inicial 2026-10-03

- snapshot de `content.db` salvo em `/Users/admin/Documents/xbox360-tools/xbox-backup/aurora-automation-20261003-070309/content.db`;
- SHA-256 do snapshot: `04dbac6de2b8100461f4d5ca8b8a5a68074fbe29a14607a87ac5724c7c03c0db`;
- `PRAGMA integrity_check` retornou `ok`;
- schema de `ContentItems` confirmado; `Id` é a primary key e existem campos `Directory`, `Executable`, `TitleId`, `MediaId`, `TitleName`, `ScanPathId` e `FoundAtDepth` relevantes para correlação;
- foram encontrados dois diretórios `GameData` com o mesmo TitleID `4A3007D3`: `4A3007D3_002DC6C1` e `4A3007D3_00000001`;
- não assumir qual deles pertence à entrada ConnectX: o próximo passo é consultar `ContentItems.Id`/`Directory` e correlacionar o `ContentID` real;
- a primeira tentativa de backup de GameData falhou apenas na construção do path local/remoto porque o FTP do Aurora retornou uma linha LIST detalhada em `--list-only`; nenhum arquivo no Xbox foi alterado.

AUTO-00 permanece em andamento até o backup dos diretórios candidatos e a correlação do ContentID serem concluídos.

## AUTO-01 — orquestrador one-shot

### Auditoria dos componentes existentes — 2026-10-03

Componentes locais existentes foram revisados antes de criar o orquestrador:

- `/usr/local/libexec/xbox-connectx-scan`: scanner Python independente;
  - raiz fixa `/Users/Shared/xbox360-connectx`;
  - localiza `default.xex` recursivamente;
  - ignora `$SystemUpdate`;
  - lê XEX1/XEX2 e extrai TitleID, MediaID, versões e dados de disco;
  - calcula SHA-256 do `default.xex`;
  - grava `catalog.json` de forma atômica com schema `xbox-connectx-catalog-v1`.
- `/usr/local/libexec/xbox-connectx-stage-assets`: staging Python independente;
  - lê `catalog.json`;
  - consulta/cacheia x360db por TitleID;
  - valida MediaID;
  - prepara metadata textual e artwork em `staging/Aurora/User/Import/<TitleID>`;
  - preserva arquivos já existentes, portanto escolhas manuais não são substituídas;
  - grava `staging-manifest.json` com hashes;
  - atualmente não implementa a lógica completa de fallback XboxUnity nem normalização genérica de dimensões/formato para jogos futuros.

Estado observado do PES 2018:

- `catalog.json`: TitleID `4A3007D3`, MediaID `1CB7BE36`, XEX SHA-256 `57185a354d728081f88675ffeee081e1e982c6ef7cd6369db3fd9abaf6e7cc72`;
- staging possui cover/background/banner/icon e metadata textual com hashes registrados;
- os scripts atuais não conhecem `content.db`, ContentID, FTP, assets nativos, dry-run/apply, lock global ou estado de upload.

Decisão: **não reescrever scanner nem staging agora**. `xbox-connectx-sync` será inicialmente um orquestrador sobre esses componentes comprovados, adicionando ContentID, geração `.asset`, comparação remota, backup, deploy idempotente e estado de sincronização. Depois o código poderá ser refatorado para a biblioteca compartilhada do XboxMac UI.

Criar um comando único:

```text
xbox-connectx-sync
```

Primeiro modo:

```text
xbox-connectx-sync --dry-run
xbox-connectx-sync --apply
```

Responsabilidades:

1. adquirir lock para impedir duas execuções simultâneas;
2. inventariar ISOs;
3. comparar com `sync-state.json`;
4. processar somente novidades/alterações;
5. manter log por execução;
6. não falhar globalmente porque o Xbox está desligado;
7. deixar uploads pendentes para a próxima execução.

Gate: duas execuções consecutivas sem mudanças produzem zero alterações.

### Evidências AUTO-01 — primeiro dry-run idempotente

- `/usr/local/libexec/xbox-connectx-sync` instalado no Mac;
- modo `--dry-run` executou scanner, staging, conexão FTP, snapshot íntegro de `content.db`, correlação de ContentID e comparação de assets;
- snapshot de `content.db` obtido com SHA-256 `686d42c5d8c8c0c0928cd730017e6966f6840f9c5081191668d3b40500bdd204`;
- PES 2018 correlacionado como `4A3007D3 / 1CB7BE36 / ContentID 00000001`;
- `BK`, `GL` e `GC` retornaram `SAME`;
- resumo: `games=1`, `assets_changed=0`, `assets_uploaded=0`, `waiting_for_aurora_scan=0`;
- estado persistido em `/usr/local/var/xbox-connectx/sync-state.json`;
- nenhum arquivo foi alterado no Xbox.

Validação complementar executada:

- segundo `--dry-run` consecutivo: `BK`, `GL` e `GC` permaneceram `SAME`;
- `--apply` executado em seguida: zero alterações e zero uploads;
- resumo em ambos: `games=1`, `assets_changed=0`, `assets_uploaded=0`, `waiting_for_aurora_scan=0`;
- `sync-state.json` terminou com `status = SYNCED`, ContentID `00000001` e hashes locais/remotos idênticos para os três assets;
- snapshot usado pelo último apply: SHA-256 `686d42c5d8c8c0c0928cd730017e6966f6840f9c5081191668d3b40500bdd204`.

**AUTO-01: CONCLUÍDO.** O orquestrador one-shot é idempotente no jogo piloto tanto em `--dry-run` quanto em `--apply` no-op.

### Reboot liberado para validações

A partir de 2026-10-03 o MacBook pode ser reiniciado durante os testes quando necessário. Isso libera a validação real de persistência que estava adiada, especialmente Samba/NetBIOS do ConnectX, NetISO e posteriormente o backend/scheduler da automação. O reboot deve ser usado apenas em gates que explicitamente testam autostart/recuperação.

## Política de retenção da ISO

A ISO em `/Users/Shared/xbox360` é tratada como **fonte de ingestão**, não como arquivo necessário para execução via ConnectX.

Depois que uma ISO for extraída, validada e promovida com sucesso para:

```text
/Users/Shared/xbox360-connectx/<jogo>/
```

essa árvore extraída passa a ser a cópia de execução usada pelo ConnectX.

Consequências:

- remover apenas a ISO original **não remove** a árvore extraída;
- o jogo continua disponível via ConnectX enquanto `/Users/Shared/xbox360-connectx/<jogo>/` existir;
- a automação não deve reextrair nem apagar um jogo apenas porque a ISO de origem não existe mais;
- ausência intencional da ISO será registrada como `SOURCE_PRUNED`, não como `ORPHANED`;
- `ORPHANED` fica reservado para casos em que a árvore ConnectX desapareceu ou a entrada local perdeu sua origem/estado de forma inconsistente.

A exclusão automática da ISO não será comportamento padrão. Uma futura opção explícita poderá ser adicionada:

```text
xbox-connectx-sync --delete-source-after-verify
```

Ela só poderá apagar a ISO após:

- extração concluída;
- `default.xex` validado;
- TitleID/MediaID lidos;
- hash do XEX registrado;
- pasta final promovida com sucesso;
- tamanho/arquivo-contagem registrados;
- opcionalmente, lançamento real do jogo já validado pelo menos uma vez.

## AUTO-02 — ingestão de novas ISOs

Para cada ISO nova:

1. calcular hash;
2. extrair em diretório temporário com `extract-xiso -s`;
3. exigir `default.xex`;
4. ler TitleID/MediaID;
5. validar contra x360db quando disponível;
6. promover atomicamente a pasta para `/Users/Shared/xbox360-connectx/<jogo>`;
7. nunca apagar ou modificar a ISO.

Falha de metadata não deve apagar uma extração funcional.

Gate: jogo novo aparece corretamente no share ConnectX e a reexecução não extrai novamente a mesma ISO.

### Evidências AUTO-02 — descoberta inicial

Primeiro `xbox-connectx-ingest --dry-run` executado em 2026-10-03:

- 14 ISOs detectadas em `/Users/Shared/xbox360`;
- PES 2018 foi reconhecido corretamente como `ALREADY_INGESTED`, sem nova extração;
- SHA-256 da ISO do PES permaneceu `12c32bf93d23e237c18fc345dc9c7984b8767de24eb866dccd930d599dd04601`;
- SHA-256 do `default.xex` permaneceu `57185a354d728081f88675ffeee081e1e982c6ef7cd6369db3fd9abaf6e7cc72`;
- 13 ISOs adicionais foram detectadas como `NEW_ISO`;
- `ingest-state.json` contém somente o jogo já promovido, portanto o dry-run não marcou jogos novos como ingeridos;
- nenhuma extração foi iniciada durante o dry-run.

Isso valida a detecção incremental básica e a preservação de um jogo existente. O próximo teste de AUTO-02 será feito com **um único segundo jogo**, para evitar processar as 13 ISOs simultaneamente e permitir observar promoção, TitleID/MediaID e idempotência de forma controlada.

### AUTO-02 — piloto NBA Jam selecionado

Validação seletiva executada antes do primeiro `--apply`:

- nova opção `--iso` permite limitar a ingestão a uma única ISO dentro de `/Users/Shared/xbox360`;
- `NBA Jam (USA, Europe).iso` foi selecionado como segundo jogo piloto;
- dry-run retornou exatamente `isos=1`;
- ISO reconhecida como `NEW_ISO`;
- SHA-256: `9d2961302f5a1f3f2146ca17ff234903b35418d77daf3c034fe3bc2c839d5caf`;
- tamanho observado da ISO: ~7.3 GiB;
- volume de destino tinha ~607 GiB livres;
- nenhum outro jogo foi processado e nenhuma extração ocorreu no dry-run.

Pré-condições para o primeiro `--apply` seletivo estão satisfeitas.

### Evidências finais AUTO-02 — NBA Jam

O primeiro `--apply` seletivo do segundo jogo foi concluído com sucesso:

- ISO: `NBA Jam (USA, Europe).iso`;
- SHA-256 da ISO: `9d2961302f5a1f3f2146ca17ff234903b35418d77daf3c034fe3bc2c839d5caf`;
- extração concluída com 445 arquivos e ~1.30 GB de conteúdo útil;
- `TitleID = 4541094C`;
- `MediaID = 72098D69`;
- SHA-256 de `default.xex`: `17515add563b8902f79e782c386da51d7f2717f456bd3e3c88bdcd4cc0648f6a`;
- validação x360db retornou `MATCH`;
- título: `NBA JAM`;
- edição: `Original`;
- região: `USA, Europe`;
- promoção concluída para `/Users/Shared/xbox360-connectx/NBA Jam (USA, Europe)`;
- estado persistido como `CONNECTX_READY`;
- segundo `--apply` retornou `ALREADY_INGESTED` e não executou nova extração;
- PES 2018 permaneceu intacto no estado de ingestão.

**AUTO-02: CONCLUÍDO.** A ingestão incremental foi comprovada com um jogo previamente existente e um segundo jogo adicionado depois, incluindo promoção e reexecução idempotente.

## AUTO-03 — metadata e artwork

Fontes:

- x360db: identidade, metadata, banner, background e icon;
- XboxUnity: fallback/preferência para full cover;
- `cover-overrides.json`: escolha manual persistente.

Normalização:

```text
cover      900x600
banner     420x95
background 1280x720
icon       64x64
```

Regra de capa:

1. preservar override/manual;
2. preferir candidata oficial;
3. aplicar seleção determinística;
4. converter para formato real esperado;
5. armazenar hash e origem.

Gate: novo jogo recebe o mesmo resultado em execuções repetidas.

### Evidências finais AUTO-03 — NBA Jam

A normalização genérica de artwork foi validada com o segundo jogo:

- `NBA Jam` recebeu full cover do XboxUnity, `CoverID=416`;
- a capa automática vertical do x360db (`219x300`) foi substituída por JPEG real `900x600`;
- SHA-256 da nova capa: `2e169e5af8039073bf1eed65fe3d267110f44653d53415281765890a28ea8273`;
- banner permaneceu `420x95`;
- background permaneceu `1280x720`;
- icon permaneceu `64x64`;
- a capa já validada do PES 2018 foi preservada byte a byte, SHA-256 `092fecf6440814ae8ecb3693cfbb3ba39ab4f6d3dece55b53074b654265e76b0`;
- segunda execução reconheceu ambas as capas como válidas `900x600`;
- `staging-manifest.json` permaneceu byte-identical entre as execuções (`manifest_idempotent=0`).

A regra agora é genérica: artwork x360db continua sendo a fonte primária, mas cover automática fora de `900x600` recebe fallback determinístico para full cover XboxUnity. Uma capa que não é reconhecida como pertencente à automação é preservada como escolha manual.

**AUTO-03: CONCLUÍDO.** Metadata/artwork incremental e idempotente foi comprovado com PES 2018 + NBA Jam.

### AUTO-03 — segundo jogo NBA Jam: staging bruto

O staging automático do segundo jogo foi executado sem alterações manuais:

- scanner registrou `NBA Jam (USA, Europe)` com TitleID `4541094C`, MediaID `72098D69`, XEX `0.0.0.2` e SHA-256 `17515add563b8902f79e782c386da51d7f2717f456bd3e3c88bdcd4cc0648f6a`;
- staging identificou `NBA JAM`, edição `Original`, região `USA, Europe`;
- `banner.png`: `420x95` — válido;
- `background.jpg`: `1280x720` — válido;
- `icon.png`: `64x64` — válido;
- `cover.jpg`: `219x300` — boxart vertical do x360db, inválida para o full-cover `900x600` usado pelo pipeline Aurora;
- hash da cover vertical atual: `f61977e5a5528a93dbe5349b77bbea311833aba6764cd464b6413ff5295738ef`.

O mesmo padrão observado no PES 2018 se repetiu no segundo jogo. Portanto, a correção deixa de ser exceção por jogo: o `xbox-connectx-stage-assets` deve validar dimensões da cover e aplicar automaticamente fallback determinístico para full cover quando a fonte primária não for `900x600`, sem sobrescrever uma escolha manual protegida.


### AUTO-04 — NBA Jam visível no Aurora, mas ainda ausente do snapshot principal

Diagnóstico pós-Scan Now:

- snapshot local analisado: `content-20261003-083534.db`;
- SHA-256: `5d0884106481f3cc7d4a4632cd7b60a06d79bebc3dc2dfc1f927162e391037cf`;
- `ContentItems` contém apenas a linha antiga do PES 2018 (Id 1);
- nenhuma linha com NBA Jam / TitleID 4541094C foi encontrada;
- nenhum diretório `4541094C_*` existe ainda em `Aurora/Data/GameData`;
- apesar disso, o jogo apareceu no Aurora após Scan Now e iniciou normalmente via ConnectX.

Hipótese operacional prioritária: o Aurora ainda não persistiu/flushou a nova entrada no arquivo principal `content.db` que o FTP entregou. Antes de alterar a regra de lookup do orquestrador, verificar arquivos auxiliares/journal do SQLite e repetir o snapshot após reinício limpo do Aurora. Se a linha aparecer após restart, a correlação atual está correta e o problema era apenas timing/persistência do banco.


### AUTO-04 — remoto sem journal auxiliar

Verificação FTP de `/Hdd1/Apps/Aurora/Data/Databases` mostrou apenas `content.db` (20480 bytes), sem `content.db-wal`, `content.db-shm` ou journal visível. Isso reduz a chance de a nova entrada estar apenas em um arquivo auxiliar exposto por FTP. O próximo teste continua sendo reiniciar somente o Aurora e refazer o snapshot para verificar se a entrada do NBA Jam é persistida no `content.db` principal.


### Pós-restart: diretório de banco sem journal/WAL

Após reiniciar apenas o Aurora e aguardar ~15 segundos, a listagem FTP de `/Hdd1/Apps/Aurora/Data/Databases` mostrou apenas `content.db` (20480 bytes). Não havia `content.db-wal`, `content.db-journal` ou outro arquivo auxiliar visível. Isso reduz a hipótese de uma linha nova estar somente em WAL/journal remoto; ainda é necessário executar o novo dry-run e consultar o snapshot pós-restart para verificar se a linha de NBA Jam foi persistida no `content.db` principal.

## AUTO-04 — descobrir ContentID do Aurora

Pré-condição: o Aurora já precisa ter descoberto o jogo no path ConnectX.

Procedimento:

1. testar FTP em `192.168.50.2`;
2. baixar uma cópia de `Aurora/Data/Databases/content.db` para snapshot local;
3. abrir somente a cópia local com SQLite;
4. localizar a entrada do jogo por TitleID e, quando necessário, path;
5. obter `ContentItems.id`;
6. formatar como 8 hex digits para compor:

```text
<TitleID>_<ContentID>
```

Se a entrada não existir:

```text
status = WAITING_FOR_AURORA_SCAN
```

A v1 não criará linhas no banco.

Gate: PES 2018 tem ContentID determinado de forma reproduzível e a pasta nativa correspondente é confirmada no Xbox.

### Evidências AUTO-04 — PES 2018

- consulta de `ContentItems` para TitleID `4A3007D3` retornou uma única entrada ativa;
- `ContentItems.Id = 1`, portanto `ContentID = 00000001`;
- `TitleId = 4A3007D3`, `MediaId = 1CB7BE36`;
- `TitleName = PRO EVOLUTION SOCCER 2018`;
- `Directory = \\PES 2018`;
- `Executable = default.xex`;
- `ScanPathId = 1`, `FoundAtDepth = 1`;
- o diretório nativo ativo esperado pelo Aurora é `4A3007D3_00000001`;
- existe também `4A3007D3_002DC6C1`, mas não há linha correspondente em `ContentItems` para esse TitleID no snapshot atual; tratar como diretório histórico/stale até prova em contrário e não utilizá-lo como destino automático;
- assets do diretório ativo foram copiados para o backup local:
  - `GL4A3007D3.asset` SHA-256 `6dce362c2258627a084cc0163d271ecdfb57948c63eb11326a63f6cc4324fcd2`;
  - `GC4A3007D3.asset` SHA-256 `a1a0fb1ac04ea4ed190288c134f6315e8f5e926dec4708737676dacbda85fd38`;
  - `BK4A3007D3.asset` SHA-256 `3b76e98804f86d6c6abd45a347d7e1d76b5821a1eae651049311343ce721493f`;
  - `SS4A3007D3.asset` SHA-256 `83f9860b9a37f6f7368e84ce476d12daabcf7a0170fd5cce36da9d23ce0ad503`.

**AUTO-04: CONCLUÍDO para o jogo piloto PES 2018.** A descoberta de ContentID é reproduzível a partir de `ContentItems.Id` e o diretório GameData correspondente foi confirmado.

`PluginData` do diretório ativo `4A3007D3_00000001` foi verificado e estava vazio.

**AUTO-00: CONCLUÍDO para o jogo piloto.** Snapshot íntegro de `content.db`, assets ativos e estado de `PluginData` foram registrados. O rollback do estado relevante do PES 2018 está coberto.

### Observação sobre ScanPathId

A busca por tabelas no `content.db` contendo `scan` ou `path` no nome não retornou tabelas. Portanto, neste snapshot o mapeamento de `ScanPathId = 1` não está disponível no mesmo banco por uma tabela óbvia. Isso não bloqueia a correlação do jogo, porque `ContentItems.Id`, `TitleId`, `Directory` e `Executable` já identificaram unicamente a entrada ativa.

## AUTO-05 — gerar assets nativos

### Tentativa AUTO-05 — ajuste de tipo de erro Rust

- `libaustralis` foi baixado e compilado com sucesso no commit fixado `9769ac0248876d1cb38f7e84229db784b0c4202c`;
- o helper local `aurora-asset-engine-test` falhou na compilação antes de gerar qualquer asset;
- causa: o helper declarou `Result<_, Box<dyn Error>>`, enquanto `libaustralis::utils::GenericError` é `Box<dyn Error + Send + Sync + 'static>`;
- correção: alinhar o retorno de `main()` e `check_magic()` para `Box<dyn Error + Send + Sync>` ou usar `GenericResult`;
- os erros posteriores de arquivo inexistente ocorreram apenas porque o binário não foi gerado;
- nenhum arquivo foi enviado ou alterado no Xbox nesta tentativa.

Usar como referência/implementação o formato aberto documentado e a biblioteca `libaustralis`.

Gerar:

```text
GC<TitleID>.asset  cover
BK<TitleID>.asset  background
GL<TitleID>.asset  icon + banner
```

Não gerar `SS*.asset` na v1.

Validação local obrigatória antes de FTP:

- magic `RXEA`;
- dimensões decodificadas iguais às fontes;
- exportar novamente cada imagem do `.asset` gerado e comparar visual/dimensionalmente;
- hashes registrados.

Gate: assets gerados para o PES são equivalentes aos assets produzidos pelo importador do próprio Aurora ou são aceitos pelo Aurora sem corrupção.

### Evidências AUTO-05 — geração local válida

- helper `aurora-asset-engine-test` compilado com sucesso contra `libaustralis` fixado no commit `9769ac0248876d1cb38f7e84229db784b0c4202c`;
- assets gerados localmente para `4A3007D3_00000001`:
  - `GC4A3007D3.asset` SHA-256 `b5c92a6a1b4a7dc077801032fc9e642259639876b26ce1a43952faa642d47cc7` (~553 KiB);
  - `BK4A3007D3.asset` SHA-256 `e408253f8327b456985fa59c50a0bfe7ec1c11d6977952dfa351f03abe1970c1` (~922 KiB);
  - `GL4A3007D3.asset` SHA-256 `0c9e4557b30dc5ae264c8d1969dd9d251505a4e21aa1102bec228f93387b2c32` (~48 KiB);
  - `SS4A3007D3.asset` SHA-256 `83f9860b9a37f6f7368e84ce476d12daabcf7a0170fd5cce36da9d23ce0ad503` (2048 bytes).
- todos começam com magic `RXEA` (`52584541`);
- todos os assets gerados puderam ser reabertos/decodificados pelo próprio `libaustralis`;
- dimensões redecodificadas:
  - cover `900x600`;
  - background `1280x720`;
  - banner `420x95`;
  - icon `64x64`;
- `SS4A3007D3.asset` é byte-identical ao asset vazio produzido pelo Aurora;
- `GC/BK/GL` são diferentes byte a byte dos assets produzidos pelo Aurora, o que é aceitável nesta fase porque podem existir diferenças válidas de codificação BC3; a aceitação final exige teste real no Aurora.

**AUTO-05: CONCLUÍDO para o jogo piloto.** O `GC4A3007D3.asset` gerado no Mac foi instalado diretamente, o Aurora reiniciado sem `Assets > Import`, a capa permaneceu correta no CoverFlow e o PES 2018 iniciou normalmente.

## AUTO-06 — deploy transacional por FTP

Para cada jogo:

1. descobrir pasta `Data/GameData/<TitleID>_<ContentID>`;
2. baixar os assets atuais como backup;
3. enviar arquivos novos com nome temporário quando possível;
4. verificar download de retorno/hash;
5. promover/substituir somente após validação;
6. manter rollback local.

Política de overwrite:

- asset criado pela automação: pode ser atualizado se a fonte mudou;
- asset marcado como manual/protegido: nunca sobrescrever sem `--force`;
- falha no FTP: manter estado `PENDING_UPLOAD`.

Gate: capa aparece no CoverFlow sem executar manualmente `Start > Assets > Import`.

### Evidências AUTO-06A — deploy controlado do GC

- antes do upload, o `GC4A3007D3.asset` remoto tinha SHA-256 `a1a0fb1ac04ea4ed190288c134f6315e8f5e926dec4708737676dacbda85fd38`, idêntico ao backup de referência;
- foi enviado somente o `GC4A3007D3.asset` gerado localmente;
- SHA-256 do asset gerado/enviado: `b5c92a6a1b4a7dc077801032fc9e642259639876b26ce1a43952faa642d47cc7`;
- download de retorno após o upload teve o mesmo SHA-256;
- `remote_matches_backup=0` antes da substituição e `remote_matches_generated=0` depois dela;
- nenhum outro asset (`BK`, `GL`, `SS`) foi alterado;
- próximo passo: reiniciar apenas o Aurora, sem `Assets > Import`, e validar CoverFlow + abertura do jogo.

Validação no Xbox:

- Aurora reiniciado sem executar `Assets > Import`;
- PES 2018 continuou aparecendo no CoverFlow;
- capa exibida corretamente;
- jogo iniciou e rodou normalmente;
- isso prova que o Aurora aceita diretamente o `GC*.asset` gerado no Mac.

Estado: **AUTO-06A concluído para cover (`GC`)**. A leitura de hash pós-restart ainda pode ser feita como evidência adicional quando o Aurora/FTP estiver novamente ativo, mas não bloqueia a validação funcional.

### Evidências AUTO-06B — deploy BK/GL

- `BK4A3007D3.asset` remoto antes do upload: SHA-256 `3b76e98804f86d6c6abd45a347d7e1d76b5821a1eae651049311343ce721493f`, idêntico ao backup;
- `BK4A3007D3.asset` gerado/enviado: SHA-256 `e408253f8327b456985fa59c50a0bfe7ec1c11d6977952dfa351f03abe1970c1`;
- download de retorno do `BK` bateu byte a byte com o gerado (`remote_matches_generated=0`);
- `GL4A3007D3.asset` remoto antes do upload: SHA-256 `6dce362c2258627a084cc0163d271ecdfb57948c63eb11326a63f6cc4324fcd2`, idêntico ao backup;
- `GL4A3007D3.asset` gerado/enviado: SHA-256 `0c9e4557b30dc5ae264c8d1969dd9d251505a4e21aa1102bec228f93387b2c32`;
- download de retorno do `GL` bateu byte a byte com o gerado (`remote_matches_generated=0`);
- a capa (`GC`) permaneceu correta após restart;
- validação visual específica de background/banner/icon ainda pendente.

### Validação visual AUTO-06B — BK/GL

- após restart do Aurora, os detalhes do PES 2018 permaneceram visualmente normais;
- background exibido corretamente;
- banner/ícone sem corrupção perceptível;
- cover permaneceu correta;
- nenhuma execução de `Assets > Import` foi necessária;
- a validação funcional do conjunto `GC + BK + GL` está concluída.

Falta apenas registrar os hashes pós-restart de `BK`, `GL` e `GC` como evidência adicional de persistência byte a byte.

### Evidência pós-restart — GC preservado

- após retornar ao Aurora, FTP na porta 21 voltou a responder;
- `GC4A3007D3.asset` foi baixado novamente após restart;
- SHA-256 pós-restart: `b5c92a6a1b4a7dc077801032fc9e642259639876b26ce1a43952faa642d47cc7`;
- hash idêntico ao asset gerado no Mac;
- o Aurora não sobrescreveu/regenerou o `GC` durante o restart;
- CoverFlow e execução do PES 2018 permaneceram normais.

Conclusão: o caminho de deploy direto de cover (`GC`) é persistente e compatível com o Aurora.

### Evidência final AUTO-06 — persistência pós-restart

- `BK4A3007D3.asset` pós-restart: SHA-256 `e408253f8327b456985fa59c50a0bfe7ec1c11d6977952dfa351f03abe1970c1`;
- `GL4A3007D3.asset` pós-restart: SHA-256 `0c9e4557b30dc5ae264c8d1969dd9d251505a4e21aa1102bec228f93387b2c32`;
- `GC4A3007D3.asset` pós-restart: SHA-256 `b5c92a6a1b4a7dc077801032fc9e642259639876b26ce1a43952faa642d47cc7`;
- os três hashes são exatamente os mesmos dos assets gerados no Mac e enviados por FTP;
- o Aurora não reescreveu os assets após restart;
- cover, background, banner/icon e execução do jogo permaneceram normais;
- nenhum `Assets > Import` foi executado.

**AUTO-06: CONCLUÍDO para o jogo piloto PES 2018.** O deploy direto, verificação de retorno, persistência pós-restart e compatibilidade visual/funcional de `GC + BK + GL` foram comprovados.

### Observação operacional — FTP durante execução do jogo

O FTP do Aurora pode ficar indisponível enquanto um jogo está em execução, porque o servidor FTP pertence ao ambiente Aurora/Nova e não deve ser tratado como serviço persistente do Xbox durante gameplay. Falha de conexão à porta 21 após iniciar o jogo não invalida o teste de asset. Para operações de sync/backup, retornar ao Aurora e aguardar o FTP responder antes de transferir arquivos.



### Evidências AUTO-06 — segundo jogo NBA Jam

Deploy incremental real concluído para o segundo jogo:

- NBA Jam correlacionado como TitleID `4541094C`, MediaID `72098D69`, ContentID `00000002`;
- `BK4541094C.asset`, `GL4541094C.asset` e `GC4541094C.asset` estavam diferentes dos assets criados automaticamente pelo Aurora;
- `xbox-connectx-sync --apply` fez backup dos três assets remotos antigos;
- os três assets foram enviados e verificados por download de retorno;
- hashes verificados:
  - BK: `a935d528a6c8dbd8b13e5094b0bcb553c8c6b8eb49a17fc52272f8f741e388f6`;
  - GL: `cd7c3502fd51ab65757f2cdb9a1c614941670f8967073083033351bd84d12d1a`;
  - GC: `2266257620192937ab9051bd807e69b44e321d82bf25927d877a04add7029910`;
- comparação FTP independente confirmou que os três arquivos remotos são byte-identical aos assets locais gerados;
- PES 2018 permaneceu `SAME` nos três assets durante o mesmo apply;
- `waiting_for_aurora_scan=0`.

O estado `CHANGED` persistido imediatamente após esse apply representa que houve alterações nessa execução; ele não é evidência de falha. A próxima execução sem mudanças deve resultar em `SAME` e `SYNCED`.

Validação física ainda necessária: reiniciar apenas o Aurora e confirmar visualmente cover/background/icon do NBA Jam e abertura do jogo. Metadata textual detalhada continua fora desta fase; a automação atual instala BK/GL/GC, enquanto escrita direta de campos textuais em `content.db` permanece reservada ao AUTO-08.

## AUTO-07 — remoção e órfãos

A exclusão no Mac não deve apagar automaticamente banco/assets do Xbox na primeira versão.

Estados:

```text
ACTIVE
SOURCE_PRUNED
PENDING_UPLOAD
WAITING_FOR_AURORA_SCAN
ORPHANED
```

Quando apenas a ISO desaparecer, mas a pasta ConnectX continuar válida:

- marcar `SOURCE_PRUNED`;
- manter o jogo ativo;
- não reextrair;
- não remover assets/catálogo.

Quando a pasta ConnectX desaparecer de forma inesperada:

- marcar `ORPHANED`;
- não apagar `content.db`;
- não apagar assets automaticamente;
- gerar relatório.

Uma futura opção explícita:

```text
xbox-connectx-sync --prune
```

só será implementada após validar uma forma segura de remover a entrada do Aurora e seu diretório GameData.



### AUTO-07 — baseline do reconciliador validado

O reconciliador `/usr/local/libexec/xbox-connectx-reconcile` foi instalado e validado em dry-run e apply sem mutação de biblioteca:

- PES 2018: `ACTIVE`, source presente, árvore ConnectX presente, `default.xex` presente e hash válido;
- NBA Jam: `ACTIVE`, source presente, árvore ConnectX presente, `default.xex` presente e hash válido;
- resumo: `ACTIVE=2`, `SOURCE_PRUNED=0`, `ORPHANED=0`;
- `ingest-state.json` passou a registrar `lifecycle_status` sem substituir o estado operacional já existente;
- relatório persistente: `/usr/local/var/xbox-connectx/reconcile-state.json`.

Próximo teste AUTO-07: simular de forma reversível a ausência somente da ISO do NBA Jam e depois a ausência somente da árvore ConnectX, confirmando `SOURCE_PRUNED` e `ORPHANED` sem apagar catálogo ou assets do Aurora.



### Evidências finais AUTO-07 — lifecycle e órfãos

O reconciliador foi validado com dois cenários reversíveis usando NBA Jam:

1. ausência somente da ISO:
   - `lifecycle=SOURCE_PRUNED`;
   - `source_present=False`;
   - árvore ConnectX preservada;
   - `default.xex` preservado e hash válido;
   - após restaurar a ISO, o estado voltou para `ACTIVE`.

2. ausência somente da árvore ConnectX:
   - `lifecycle=ORPHANED`;
   - ISO permaneceu presente;
   - `connectx_present=False`;
   - `xex_present=False`;
   - após restaurar a pasta, o estado voltou para `ACTIVE`.

Estado final:

- PES 2018: `ACTIVE`;
- NBA Jam: `ACTIVE`;
- `SOURCE_PRUNED=0`;
- `ORPHANED=0`.

Nenhuma operação do AUTO-07 apagou ou alterou `content.db`, `Data/GameData` ou assets do Aurora.

**AUTO-07: CONCLUÍDO.** A automação distingue de forma idempotente jogo ativo, ISO deliberadamente removida e árvore ConnectX ausente sem destruição automática do catálogo.

## AUTO-08 — metadata textual sem clique

Fase posterior à automação do artwork.

Investigar o schema documentado de `content.db` e o comportamento do importador do Aurora para:

- titlename;
- description;
- publisher;
- developer;
- releasedate;
- genre.

Requisitos antes de qualquer write:

- snapshot do banco;
- Aurora não pode estar escrevendo no banco;
- transação SQLite;
- `PRAGMA integrity_check`;
- comparação antes/depois;
- rollback;
- validação em jogo piloto e segundo jogo.

Até esse gate, `User/Import/<TitleID>` continua sendo o fallback seguro para metadata textual.

## AUTO-09 — automação contínua no macOS

Somente depois de AUTO-00..AUTO-08 estarem estáveis.

Executar `xbox-connectx-sync --apply` por LaunchDaemon.

Comportamento:

- processo periódico, não watcher complexo;
- se Xbox estiver offline, preparar tudo localmente e manter upload pendente;
- se Mac estiver sem Internet, reutilizar cache;
- se SMB estiver indisponível, não alterar biblioteca;
- logs rotacionados;
- lock único.

Não acoplar esse serviço ao LaunchDaemon do NetISO.

## Gate final de automação

Validar com:

1. PES 2018 já existente;
2. um segundo jogo adicionado depois;
3. uma reexecução sem mudanças;
4. Xbox desligado durante uma execução;
5. Xbox ligado novamente e sincronização pendente;
6. capa manual protegida;
7. remoção de jogo sem destruição automática do catálogo;
8. NetISO funcionando durante todo o processo.

A automação só será considerada fechada quando o segundo jogo passar do estado de ISO nova até CoverFlow com artwork sem precisar executar manualmente `Start > Assets > Import`.

## Fontes técnicas

- Aurora developer documentation — assets e caminho `Data/GameData/<TitleID>_<ContentID>`;
- `libaustralis` — leitura/escrita do formato `.asset`;
- ConsoleMods — Aurora Import Format;
- x360db — metadata e artwork;
- XboxUnity — covers.


### AUTO-06 — idempotência pós-deploy do segundo jogo

Após o deploy real dos assets do NBA Jam, uma nova execução de `xbox-connectx-sync --apply` sem alterações retornou:

- NBA Jam: BK = `SAME`, GL = `SAME`, GC = `SAME`;
- PES 2018: BK = `SAME`, GL = `SAME`, GC = `SAME`;
- `games=2`;
- `assets_changed=0`;
- `assets_uploaded=0`;
- `waiting_for_aurora_scan=0`.

Isso confirma idempotência pós-upload para dois jogos e que o orquestrador não reenvia assets já sincronizados.

Resta somente a validação física pós-restart do Aurora para o NBA Jam: cover, background/icon e abertura do jogo. Metadata textual detalhada continua fora desta fase e será tratada no AUTO-08.


### AUTO-06 — validação física final do segundo jogo

Após o deploy e a execução idempotente, o Aurora foi reiniciado e o NBA Jam foi validado fisicamente:

- capa exibida corretamente no CoverFlow;
- background/icon exibidos corretamente;
- jogo abriu e rodou normalmente;
- nenhum `Assets > Import` foi necessário;
- PES 2018 permaneceu íntegro;
- uma execução subsequente de `xbox-connectx-sync --apply` retornou zero mudanças e zero uploads.

**AUTO-06: CONCLUÍDO.** O deploy transacional de assets nativos foi comprovado com o jogo piloto e com um segundo jogo adicionado depois.
