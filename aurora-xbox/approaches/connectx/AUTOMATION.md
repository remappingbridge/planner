# Automação ConnectX / Aurora

Data do plano: 2026-10-03

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

## AUTO-01 — orquestrador one-shot

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

## AUTO-05 — gerar assets nativos

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
