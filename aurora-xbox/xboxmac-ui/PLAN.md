# Plano — XboxMac UI

Data inicial: 2026-10-03

Repositório do produto:

```text
https://github.com/remappingbridge/xboxmac-ui
```

Este documento fica no `planner` e é a fonte de verdade para a arquitetura e a experiência do usuário.

### Decisão de repositório — 2026-10-03

`remappingbridge/xboxmac-ui` será um **monorepo do produto**, não apenas um repositório de frontend.

Ele reunirá:

- interface web;
- backend local;
- engine ConnectX já validada no Mac;
- gerador nativo de assets do Aurora;
- integração Lua instalada no Aurora;
- scripts de instalação/diagnóstico;
- documentação e testes.

O código de infraestrutura/automação já comprovado pode ser incorporado ao repositório **antes** do início da implementação da UI web, desde que seja copiado como baseline estável e não seja refatorado durante essa migração.

Jogos, ISOs, XEX extraídos, assets gerados, bancos baixados, caches, manifests transitórios, backups e demais dados de runtime não serão versionados.

## Modelo de execução do desenvolvimento

Decisão operacional a partir de 2026-10-03:

### Backend e integração de sistema

O desenvolvimento de backend, automação, CLI, integração macOS/ConnectX/Aurora, jobs, contratos de API, persistência e demais componentes de sistema pode ser feito diretamente neste fluxo de chat.

Fluxo padrão:

```text
ChatGPT
→ edita o repositório remappingbridge/xboxmac-ui
→ executa validações estáticas/unitárias disponíveis
→ faz commit/push

usuário
→ git pull
→ build local quando necessário
→ testes físicos no Mac/Xbox
→ retorna evidências

ChatGPT
→ corrige/avança a partir dessas evidências
```

Regras:

- não exigir que o usuário copie patches manualmente quando a edição direta do repositório estiver disponível;
- cada alteração de backend deve ser rastreável por commit;
- não quebrar o baseline marcado por `connectx-v1.0.0`;
- mudanças que dependam do hardware real devem parar no ponto em que o teste físico do usuário seja necessário;
- após o teste físico, registrar a evidência relevante no planner antes de consolidar a próxima etapa;
- preservar a CLI existente como interface de diagnóstico e recuperação durante a evolução para serviços internos.

### Frontend web

A implementação pesada do frontend/browser será delegada ao **ChatGPT Work** em uma execução concentrada, usando este planner e o backend já estabilizado como contrato.

Antes desse handoff, este fluxo de chat pode:

- definir contratos da API;
- definir estados/jobs;
- definir payloads JSON;
- preparar endpoints;
- preparar fixtures e testes de integração;
- documentar UX e estados manuais;
- criar apenas o mínimo de HTML necessário para diagnóstico técnico, se indispensável ao backend.

Ele não deve antecipar a construção completa da experiência visual que será entregue pelo Work.

### Fonte de verdade

O repositório `remappingbridge/xboxmac-ui` é a fonte de código.

O repositório `remappingbridge/planner` é a fonte de verdade para arquitetura, decisões, gates, evidências e handoff.

Arquivos instalados em `/usr/local/libexec` ou no Xbox/Aurora são artefatos implantados e não devem se tornar uma segunda fonte de desenvolvimento.

## Regra de handoff para implementação

A implementação da interface web/browser **não será feita incrementalmente neste chat**.

Entretanto, a incorporação do backend/CLI já validado ao monorepo `remappingbridge/xboxmac-ui` faz parte da preparação do baseline e pode ser realizada antes do handoff.

Essa incorporação deve preservar os arquivos funcionais atuais como fonte inicial, sem reescrever o pipeline durante a migração.

Quando chegar o momento de iniciar a aplicação web/browser propriamente dita, este fluxo deve parar antes de criar a UI.

Nesse ponto, deve ser produzido **um único prompt de handoff para ChatGPT Work**, com contexto suficiente para que o Work implemente o aplicativo inteiro de uma vez, usando este plano e os documentos relacionados como fonte de verdade.

O prompt deve instruir o Work a:

- trabalhar diretamente no repositório privado `remappingbridge/xboxmac-ui`;
- ler primeiro este `PLAN.md` e `../approaches/connectx/AUTOMATION.md`, além dos documentos de NetISO/ConnectX/Aurora relevantes;
- preservar a arquitetura validada e os paths/portas/serviços congelados;
- reutilizar o pipeline de domínio já comprovado, sem criar uma segunda automação concorrente;
- implementar backend, frontend web, persistência, jobs, launcher macOS, testes e empacotamento previstos nos gates XM-00..XM-10 aplicáveis;
- tratar o ambiente real já validado no Mac/Xbox como baseline, não como hipótese;
- não alterar o contrato `USB + exploit = desbloqueado / USB removido + reboot = retail`;
- preservar NetISO e ConnectX durante toda a implementação;
- executar testes, corrigir regressões e deixar documentação suficiente para manutenção;
- não exigir que o usuário acompanhe gate por gate da construção da UI: o objetivo do handoff é uma execução completa pelo Work, seguida de validação do resultado.

Este chat pode continuar implementando e validando infraestrutura, CLI, automação, ingestão, assets e serviços de sistema antes desse handoff. Também pode migrar esses componentes comprovados para a estrutura definitiva do monorepo. Ele não deve iniciar a implementação do aplicativo web/browser propriamente dito.

## Objetivo

Criar um aplicativo macOS que funcione como painel de controle do ambiente Xbox 360 ↔ Mac.

Ao clicar no ícone do aplicativo:

```text
XboxMac.app
    ↓
garantir que o backend local esteja disponível
    ↓
verificar/garantir serviços NetISO e ConnectX
    ↓
abrir automaticamente o navegador
    ↓
http://127.0.0.1:8742
```

O usuário deve conseguir administrar jogos e conexões sem conhecer:

- `launchctl`;
- `smbd`/`nmbd`;
- NetBIOS;
- portas TCP;
- FTP do Aurora;
- `extract-xiso`;
- TitleID/MediaID/ContentID;
- caminhos internos do Aurora.

O painel será a camada de controle. Ele **não** substituirá NetISO, Samba, ConnectX ou Aurora.

## Princípios

- NetISO e ConnectX continuam independentes.
- Abrir a UI não deve reiniciar serviços saudáveis.
- A ação padrão é `ensure_ready()`, não `restart_everything()`.
- O backend web nunca roda como root.
- O painel HTTP escuta somente em `127.0.0.1`.
- Exclusões locais vão para a Lixeira do macOS sempre que possível.
- Nenhum endpoint aceita caminho arbitrário enviado pelo navegador.
- Toda operação destrutiva trabalha sobre um jogo conhecido pelo catálogo interno.
- A automação ConnectX existente será incorporada como serviço do backend, não duplicada em scripts paralelos.
- O estado real do backend é fonte de verdade; a UI apenas o apresenta e aciona operações.
- NetISO deve continuar utilizável durante desenvolvimento e falhas da UI.

## Arquitetura

```text
                    XboxMac.app
                         │
                         ▼
                     xboxmacd
                Python + FastAPI
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
   NetISOManager   ConnectXManager  LibraryManager
          │              │              │
      netiso-srv      Samba/nmbd    AutomationService
                                         │
                              ┌──────────┴──────────┐
                              ▼                     ▼
                         extract-xiso           AssetEngine
                                                   │
                                                   ▼
                                               Aurora FTP

                         │
                         ▼
                  127.0.0.1:8742
                         │
                         ▼
                  navegador padrão
```

### Componentes

`XboxMac.app`
- launcher macOS;
- inicia ou encontra `xboxmacd`;
- chama a operação idempotente de readiness;
- abre o navegador padrão;
- não contém a lógica de negócio.

`xboxmacd`
- backend local;
- estado de conexões;
- catálogo;
- jobs;
- integração NetISO;
- integração ConnectX;
- FTP Aurora;
- automação de biblioteca;
- API/UI local.

`NetISOManager`
- verifica LaunchDaemon/processo;
- verifica TCP 4323;
- verifica diretório de ISOs;
- expõe start/stop/restart apenas quando explicitamente solicitado;
- nunca reinicia NetISO apenas porque o painel foi aberto.

`ConnectXManager`
- verifica Ethernet privada;
- verifica Samba/SMB1 restrito à interface privada;
- verifica `nmbd`/resolução `XBOXMAC`;
- verifica share `XBOX360`;
- testa reachability do Xbox;
- testa Aurora FTP;
- não altera `launch.ini`.

`LibraryManager`
- inventaria ISO e árvore ConnectX;
- relaciona TitleID/MediaID;
- calcula uso em disco;
- controla estados dos jogos;
- envia arquivos para a Lixeira;
- não recebe caminhos arbitrários da UI.

`AutomationService`
- incorpora o fluxo de [../approaches/connectx/AUTOMATION.md](../approaches/connectx/AUTOMATION.md);
- permite dry-run e apply;
- mantém lock;
- publica progresso;
- prepara assets;
- coordena uploads pendentes.

`AssetEngine`
- componente isolado para formato nativo do Aurora;
- gera `.asset` sem espalhar detalhes de textura Xbox pelo backend;
- inicialmente pode ser helper Rust separado;
- eventual reutilização de código GPL deve ter compatibilidade de licença decidida antes da distribuição.

## Stack

### Backend

Escolha principal:

```text
Python 3
FastAPI
Uvicorn
```

Motivos:

- o problema é majoritariamente backend/sistema operacional;
- integração natural com filesystem, subprocessos, SQLite, FTP e jobs;
- menor complexidade do que Electron/React para esta aplicação;
- permite reutilizar a mesma camada de serviços numa CLI futura.

### Frontend

Escolha principal:

```text
Jinja2
HTMX
JavaScript mínimo
```

Atualizações de status:

```text
SSE
ou
polling HTMX
```

Preferir SSE quando houver jobs longos com progresso; polling simples é aceitável para status de conexão.

Não exigir Node/npm na primeira versão.

### Persistência

```text
SQLite
SQLAlchemy 2
Alembic
```

O banco do XboxMac é separado do `content.db` do Aurora.

Guardar:

- jogos;
- paths;
- TitleID;
- MediaID;
- hashes;
- estado de conversão;
- asset source;
- estado de sync;
- jobs;
- histórico resumido;
- preferências/overrides.

Credenciais não devem ficar em texto puro no SQLite; usar Keychain do macOS quando a persistência for necessária.

### Jobs

```text
asyncio
fila interna de jobs
APScheduler
```

Não começar com Celery/Redis.

A aplicação é single-host e o custo operacional de infraestrutura extra não se justifica.

### Filesystem

Detecção de novos arquivos deve usar **reconciliação periódica** como fonte de verdade.

`watchfiles` pode ser usado apenas como acelerador.

Nunca processar uma ISO apenas porque ela apareceu no diretório. Antes:

```text
arquivo detectado
→ tamanho/mtime registrados
→ aguardar outra reconciliação
→ tamanho/mtime estáveis
→ considerar READY
```

Isso evita extrair uma ISO ainda sendo copiada.

### Lixeira

Preferência:

```text
Send2Trash
```

Não usar `rm -rf` para operações normais da UI.

Se uma operação não puder ser movida para a Lixeira, não degradar silenciosamente para deleção permanente.

### Testes

```text
pytest
Playwright
```

Testes unitários para serviços e state machine.

Playwright para fluxos críticos da interface.

### Empacotamento macOS

Primeira estratégia:

```text
PyInstaller
→ XboxMac.app
```

Posteriormente avaliar assinatura/notarização.

A aplicação deve poder localizar seus helpers sem depender do diretório atual.

## Serviços e privilégios

Serviços de sistema permanecem separados da UI.

Modelo planejado:

```text
/Library/LaunchDaemons/
    io.remappingbridge.netiso-srv.plist
    io.remappingbridge.connectx-smbd.plist
    io.remappingbridge.connectx-nmbd.plist

~/Library/LaunchAgents/
    io.remappingbridge.xboxmac.plist
```

Observação: os LaunchDaemons ConnectX só serão promovidos depois da validação de persistência já prevista no CX-07.

O servidor FastAPI:

```text
127.0.0.1:8742
```

não precisa e não deve rodar como root.

Instalação/configuração de componentes privilegiados deve ser uma etapa explícita de setup. Não pedir senha administrativa toda vez que o painel abre.

## Comportamento ao clicar no app

```text
XboxMac.app
→ detectar xboxmacd
→ iniciar se necessário
→ GET/POST local de readiness
→ backend verifica:
     Ethernet
     Xbox
     NetISO
     Samba
     NetBIOS
     Aurora FTP
→ tentar iniciar apenas componentes necessários e autorizados
→ abrir navegador
```

Se algo falhar, abrir o painel mesmo assim e apresentar o erro.

Exemplo:

```text
Ethernet       CONECTADO
Xbox 360       OFFLINE
NetISO         ATIVO
ConnectX SMB   ATIVO
Aurora FTP     INDISPONÍVEL
```

A UI nunca deve esconder o painel porque o Xbox está desligado.

## Dashboard

### Conexões

Exemplo:

```text
Xbox 360

Ethernet       CONECTADO
Xbox           ONLINE
NetISO         ATIVO
ConnectX       ATIVO
Aurora FTP     ATIVO

[ Garantir conexões ]
[ Diagnóstico ]
```

A ação `Garantir conexões` é idempotente.

Um botão separado poderá oferecer restart explícito por serviço.

### Automação

```text
Automação de jogos

Novas ISOs:       2
Aguardando cópia: 1
Em processamento: 1
Pendentes Aurora: 0
Erros:            0

[ Procurar novos jogos ]
[ Simular automação ]
[ Executar automação agora ]
```

Jobs longos devem mostrar:

- etapa;
- progresso quando determinável;
- bytes;
- jogo atual;
- erro;
- log resumido;
- botão de detalhes.

### Biblioteca

Cada jogo deve ser uma entidade única, não uma linha por arquivo.

Exemplo:

```text
PRO EVOLUTION SOCCER 2018

ISO
✓ presente
6.8 GB

ConnectX
✓ convertido
6.4 GB

Aurora
✓ escaneado
✓ capa instalada
✓ CoverFlow

[ Detalhes ]
[ Mover ISO para Lixeira ]
[ Mover ConnectX para Lixeira ]
```

Filtros planejados:

- todos;
- ISO somente;
- convertido;
- pronto no Aurora;
- SOURCE_PRUNED;
- erro;
- órfão.

Ordenação:

- título;
- data de adição;
- tamanho ISO;
- tamanho ConnectX;
- status.

## Experiência do usuário para ações manuais do Aurora

### Decisão atual

O pipeline validado ainda depende de ações no próprio Aurora que não possuem automação remota comprovada.

Na v1, isso **não será escondido** do usuário. A interface deve transformar cada dependência manual em um estado explícito, orientado e detectável automaticamente.

O usuário não deve precisar:

- lembrar a sequência;
- voltar ao terminal;
- executar novamente um comando;
- informar manualmente à UI que concluiu uma ação quando o backend puder detectar isso sozinho.

### Ação manual 1 — Rescan do caminho ConnectX

Depois da extração e promoção do jogo:

```text
ISO
→ extração
→ TitleID/MediaID
→ metadata/artwork staging
→ CONNECTX_READY
→ WAITING_FOR_AURORA_SCAN
```

A UI deve apresentar uma chamada clara, por exemplo:

```text
Ação necessária no Xbox

No Aurora, execute Rescan no caminho ConnectX.

Não é necessário confirmar nesta tela.
O XboxMac continuará automaticamente quando o jogo aparecer no catálogo.
```

O backend deve consultar periodicamente uma cópia do `content.db` via FTP e correlacionar:

```text
TitleID + MediaID
        ↓
ContentItems.Id
        ↓
ContentID
```

Assim que o ContentID aparecer, o job continua sozinho.

**Não criar botão obrigatório "Já fiz".** Um botão opcional de `Verificar agora` pode existir, mas a reconciliação automática é a fonte de verdade.

Exemplo de estado da API:

```json
{
  "state": "WAITING_FOR_AURORA_SCAN",
  "manual_action": {
    "required": true,
    "type": "aurora_rescan",
    "message": "Execute Rescan no caminho ConnectX do Aurora."
  }
}
```

### Ação manual 2 — refresh/reload do Aurora

Depois que o ContentID existe, o backend pode:

- gerar o manifesto de metadata apenas para jogos pendentes;
- gerar `GC<TitleID>.asset` a partir da capa;
- enviar a capa ao `GameData/<TitleID>_<ContentID>`;
- aguardar o processador Lua do Aurora consumir o manifesto.

Nos testes atuais, para que metadata/capa sejam refletidos no CoverFlow pode ser necessário atualizar, recarregar ou reiniciar o Aurora.

Enquanto não houver mecanismo remoto validado para isso, a UI deve assumir:

```text
APPLYING_METADATA
→ SYNCING_COVER
→ WAITING_FOR_AURORA_REFRESH
```

Mensagem proposta:

```text
Instalação preparada no Xbox

Metadados enviados.
Capa instalada.

Recarregue ou reinicie o Aurora para concluir a atualização da biblioteca.
O XboxMac verificará o resultado automaticamente.
```

O backend deve continuar verificando:

- manifesto remoto ausente;
- resultado do filtro presente;
- `status=VERIFIED`;
- valores esperados no `content.db`;
- asset de capa não-placeholder no GameData.

Quando tudo estiver confirmado:

```text
WAITING_FOR_AURORA_REFRESH
→ VERIFYING
→ AURORA_READY
```

Exemplo de estado:

```json
{
  "state": "WAITING_FOR_AURORA_REFRESH",
  "manual_action": {
    "required": true,
    "type": "aurora_refresh",
    "message": "Recarregue ou reinicie o Aurora."
  }
}
```

### Evolução futura

Se um método seguro e suportado de Rescan ou refresh remoto for validado posteriormente, o backend passa a executá-lo e simplesmente deixa de retornar `manual_action.required = true`.

A UI não deve depender da existência permanente dessas etapas manuais.

### Fluxo de UX alvo da v1

```text
usuário seleciona uma ou várias ISOs
        ↓
backend processa
        ↓
UI: AÇÃO NECESSÁRIA — Rescan no Aurora
        ↓
usuário faz Rescan
        ↓
backend detecta ContentID automaticamente
        ↓
backend aplica metadata + capa
        ↓
UI: AÇÃO NECESSÁRIA — recarregar/reiniciar Aurora
        ↓
usuário recarrega/reinicia
        ↓
backend verifica automaticamente
        ↓
CONCLUÍDO
```

Do ponto de vista do usuário, o Mac não exige comandos durante esse fluxo.

## Identidade e estado do jogo

A identidade não é o filename.

Chaves principais:

```text
TitleID
MediaID
```

A entidade também registra:

```text
source_iso
connectx_directory
aurora_content_id
iso_sha256
xex_sha256
```

Estados conceituais:

```text
ISO_ONLY
COPYING
READY_TO_PROCESS
PROCESSING
CONNECTX_READY
WAITING_FOR_AURORA_SCAN
APPLYING_METADATA
SYNCING_COVER
WAITING_FOR_AURORA_REFRESH
VERIFYING
AURORA_READY
SOURCE_PRUNED
PENDING_UPLOAD
ORPHANED
ERROR
```

Transição típica:

```text
ISO_ONLY
→ READY_TO_PROCESS
→ PROCESSING
→ CONNECTX_READY
→ WAITING_FOR_AURORA_SCAN
→ APPLYING_METADATA
→ SYNCING_COVER
→ WAITING_FOR_AURORA_REFRESH
→ VERIFYING
→ AURORA_READY
```

Depois de apagar somente a ISO:

```text
AURORA_READY
→ SOURCE_PRUNED
```

O jogo continua disponível via ConnectX.

Se a pasta ConnectX for removida e a ISO ainda existir:

```text
AURORA_READY
→ ISO_ONLY
```

A interface pode oferecer conversão novamente.

## Semântica das exclusões

Evitar um botão genérico `Excluir jogo`.

### Mover ISO para Lixeira

Exemplo:

```text
/Users/Shared/xbox360/PES.iso
→ ~/.Trash/...
```

Preservar:

```text
/Users/Shared/xbox360-connectx/PES 2018/
```

Resultado:

- libera espaço da ISO;
- jogo continua no ConnectX;
- estado vira `SOURCE_PRUNED`;
- assets Aurora permanecem.

Confirmação deve informar exatamente quanto espaço será liberado.

### Mover ConnectX para Lixeira

Exemplo:

```text
/Users/Shared/xbox360-connectx/PES 2018/
→ Lixeira
```

Preservar a ISO, se existir.

Resultado:

- jogo deixa de ser executável pelo ConnectX;
- ISO continua disponível para NetISO/reconversão;
- entrada/cache do Aurora pode continuar no CoverFlow até limpeza separada.

Não rotular essa operação como `Remover do Xbox`.

### Remover também do Aurora

Operação futura e separada.

Somente depois de gate específico que valide:

```text
backup content.db
backup Data/GameData
→ alteração/removal segura
→ PRAGMA integrity_check
→ confirmação de CoverFlow
→ rollback testado
```

Até lá, a UI apenas informa que a entrada/cache pode continuar no Aurora.

## Segurança da API local

Binding obrigatório:

```text
127.0.0.1
```

Nunca por padrão:

```text
0.0.0.0
```

Endpoints destrutivos recebem `game_id`, nunca path arbitrário.

Fluxo:

```text
POST /games/123/trash-iso
→ buscar jogo 123 no banco
→ resolver source_iso internamente
→ canonicalizar path
→ confirmar que está sob /Users/Shared/xbox360
→ confirmar tipo/estado
→ Send2Trash
→ reconciliar catálogo
```

Para ConnectX:

```text
POST /games/123/trash-connectx
→ canonicalizar
→ confirmar que está sob /Users/Shared/xbox360-connectx
→ Send2Trash
```

Proteções:

- rejeitar symlink que escape das raízes autorizadas;
- rejeitar `..`;
- confirmar inode/path canonical;
- não permitir deleção de raiz da biblioteca;
- confirmação na UI para operação destrutiva;
- CSRF token para POSTs;
- não expor segredos nos logs.

## Layout do monorepo

Estrutura oficial planejada para `remappingbridge/xboxmac-ui`:

```text
xboxmac-ui/
├── web/
│   ├── templates/
│   ├── static/
│   └── ...
│
├── backend/
│   ├── server/
│   │   ├── pyproject.toml
│   │   ├── src/
│   │   │   └── xboxmac/
│   │   │       ├── app.py
│   │   │       ├── api/
│   │   │       ├── services/
│   │   │       ├── jobs/
│   │   │       └── db/
│   │   └── tests/
│   │
│   ├── connectx/
│   │   ├── xbox-connectx-add
│   │   ├── xbox-connectx-ingest
│   │   ├── xbox-connectx-scan
│   │   ├── xbox-connectx-stage-assets
│   │   ├── xbox-connectx-sync-metadata
│   │   └── xbox-connectx-sync-covers
│   │
│   └── asset-engine/
│       ├── Cargo.toml
│       ├── Cargo.lock
│       └── src/main.rs
│
├── aurora/
│   └── User/
│       └── Scripts/
│           └── Content/
│               └── Filters/
│                   └── XboxMacProbe.lua
│
├── scripts/
│   ├── install-macos
│   ├── update-macos
│   └── doctor
│
├── docs/
│   ├── architecture.md
│   ├── installation.md
│   ├── aurora-setup.md
│   └── troubleshooting.md
│
├── runtime/                 # gitignored; opcional para desenvolvimento
├── .gitignore
└── README.md
```

### Regra de migração do backend validado

A primeira incorporação deve copiar para o monorepo, sem refatoração funcional:

- os seis comandos `xbox-connectx-*` validados;
- o gerador Rust de assets RXEA;
- `XboxMacProbe.lua`;
- documentação do snapshot funcional.

No ambiente instalado, os executáveis podem continuar em:

```text
/usr/local/libexec/
```

mas esses arquivos instalados passam a ser **artefatos de instalação**, não a fonte de código.

Fluxo:

```text
repositório
backend/connectx/xbox-connectx-add
        ↓ install-macos
/usr/local/libexec/xbox-connectx-add
```

Depois dessa migração, alterações devem nascer no repositório, ser testadas e somente então instaladas no Mac.

### Conteúdo que nunca deve entrar no Git

```text
/Users/Shared/xbox360/
/Users/Shared/xbox360-connectx/
/Users/Shared/.xbox360-connectx-staging/
/usr/local/var/xbox-connectx/
```

Também ignorar, conforme aplicável:

- `*.iso`;
- `*.xex`;
- `*.asset`;
- `*.db` obtido do Aurora;
- caches;
- manifests transitórios;
- backups operacionais;
- jogos extraídos.

## API interna planejada

Não congelada, mas direção inicial:

```text
GET  /api/status
POST /api/connections/ensure

GET  /api/games
GET  /api/games/{id}

POST /api/automation/dry-run
POST /api/automation/run
GET  /api/jobs/{id}

POST /api/games/{id}/trash-iso
POST /api/games/{id}/trash-connectx

POST /api/services/netiso/restart
POST /api/services/connectx/restart
```

A UI HTML pode usar diretamente endpoints HTML/HTMX; a API JSON fica disponível para testes e futura CLI.

## CLI futura

A lógica não deve depender da interface HTML.

Possível:

```text
xboxmac status
xboxmac games
xboxmac sync --dry-run
xboxmac sync
xboxmac trash-iso <game-id>
```

CLI e web chamam a mesma camada `services/`.

## Relação com a automação ConnectX

O planejamento de baixo nível continua em:

```text
aurora-xbox/approaches/connectx/AUTOMATION.md
```

O XboxMac será o frontend/control plane dessa automação.

O baseline funcional já validado no Mac deve ser migrado para `backend/connectx/`, mantendo os comandos CLI como ferramentas de diagnóstico e recuperação.

A implementação não deve criar dois pipelines concorrentes.

Direção:

```text
AutomationService
      ↓
mesmas funções de domínio
      ├── chamadas pela UI
      ├── chamadas pela CLI
      └── chamadas pelo scheduler
```

No longo prazo, `xbox-connectx-sync` pode se tornar um comando thin-wrapper da mesma biblioteca Python usada pelo XboxMac.

## Gates de implementação

### XM-00 — contrato, baseline e migração do backend validado — CONCLUÍDO

- congelar paths;
- congelar portas;
- registrar serviços atuais;
- definir catálogo/schema;
- definir regras de privilégio;
- definir comportamento offline;
- incorporar ao monorepo os scripts ConnectX validados;
- incorporar o AssetEngine Rust;
- incorporar `XboxMacProbe.lua`;
- definir `.gitignore` para impedir versionamento de jogos/runtime;
- preservar CLI funcional;
- nenhum código destrutivo;
- nenhuma refatoração funcional durante a migração inicial.

Gate: monorepo contém o baseline reproduzível e documentado, sem dados de runtime, suficiente para implementar a UI sem decisões implícitas.

#### Evidências de implementação — 2026-10-03

Implementação publicada em `remappingbridge/xboxmac-ui/main`.

Entregas:

- `backend/contracts/defaults.json`: paths, rede, portas, serviços e schemas atuais sem segredos;
- `backend/contracts/config.schema.json`: contrato da configuração;
- `backend/contracts/game.schema.json`: entidade e estados do jogo;
- `backend/contracts/job.schema.json`: jobs e ações manuais;
- `backend/contracts/models.py`: enums/validação reutilizáveis;
- `backend/contracts/baseline.json`: hashes Git blob dos arquivos congelados em `connectx-v1.0.0`;
- `scripts/verify-xm00.py`: verificação local do gate;
- testes em `backend/contracts/tests/`;
- `docs/architecture.md`, `docs/contracts.md` e `docs/XM-00.md`;
- `backend/server/README.md`: fronteira reservada para XM-01, sem antecipar FastAPI.

Verificação GitHub entre `connectx-v1.0.0` e `main` confirmou que os seis scripts ConnectX, o AssetEngine e `XboxMacProbe.lua` **não foram modificados**. As diferenças são somente contratos, documentação, testes, verificador e README.

A validação estática da sintaxe dos novos módulos Python passou no ambiente de desenvolvimento do chat.

Validação pendente no Mac:

```text
git pull
python3 scripts/verify-xm00.py
python3 -m unittest discover -s backend/contracts/tests -v
python3 -m py_compile backend/connectx/xbox-connectx-ingest backend/connectx/xbox-connectx-scan backend/connectx/xbox-connectx-stage-assets backend/connectx/xbox-connectx-sync-metadata backend/connectx/xbox-connectx-sync-covers
bash -n backend/connectx/xbox-connectx-add
cargo check --manifest-path backend/asset-engine/Cargo.toml
```

#### Validação local — CONCLUÍDA em 2026-10-03

No Mac real, após `git pull`:

- `python3 scripts/verify-xm00.py` retornou `XM-00: OK`;
- baseline retornou `legacy_pipeline=UNCHANGED`;
- proteção de runtime retornou `runtime_data=IGNORED`;
- configuração versionada retornou `sensitive_values_in_versioned_defaults=NONE`;
- 4/4 testes unitários passaram;
- `py_compile` dos cinco scripts Python ConnectX passou;
- `bash -n backend/connectx/xbox-connectx-add` passou;
- `cargo check --manifest-path backend/asset-engine/Cargo.toml` terminou com sucesso.

**XM-00: CONCLUÍDO.** Próximo gate: XM-01.

### XM-01 — backend local mínimo — CONCLUÍDO

- FastAPI/Uvicorn;
- bind `127.0.0.1:8742`;
- página inicial;
- health check;
- logging;
- shutdown limpo.

Gate: backend abre localmente e não fica exposto na LAN.

#### Evidências de implementação — 2026-10-03

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/app.py`: FastAPI mínimo com lifespan e logging;
- `backend/server/xboxmac/cli.py`: launcher Uvicorn;
- bind lido do contrato XM-00 e rejeição explícita de host diferente de `127.0.0.1`;
- execução como root rejeitada pelo launcher;
- `GET /`: página diagnóstica mínima;
- `GET /healthz`: contrato `xboxmac-health-v1`;
- Swagger/ReDoc/OpenAPI públicos desabilitados neste baseline mínimo;
- dependências em `backend/server/requirements.txt`;
- testes em `backend/server/tests/test_xm01_server.py`;
- verificação estática em `scripts/verify-xm01.py`;
- documentação em `docs/XM-01.md`.

Nenhum código do pipeline ConnectX congelado foi alterado para implementar o XM-01.

Validação pendente no Mac:

1. instalar FastAPI/Uvicorn em `.venv`;
2. executar verificador e testes;
3. iniciar `python -m backend.server.xboxmac.cli`;
4. confirmar `GET /healthz`;
5. confirmar listener exclusivamente `127.0.0.1:8742`;
6. encerrar com Ctrl+C e confirmar `xboxmacd shutdown complete`.

#### Validação runtime — CONCLUÍDA em 2026-10-03

No Mac real:

- dependências FastAPI/Uvicorn instaladas na venv;
- `scripts/verify-xm00.py`: OK;
- `scripts/verify-xm01.py`: `STATIC_OK`;
- 4/4 testes XM-00: OK;
- 4/4 testes XM-01: OK;
- `GET /healthz`: HTTP 200 com schema `xboxmac-health-v1`;
- `GET /`: HTTP 200;
- `lsof` confirmou listener exclusivamente `127.0.0.1:8742`;
- nenhum bind `0.0.0.0`, wildcard ou IPv6 wildcard foi observado;
- encerramento por SIGINT produziu `xboxmacd shutdown complete` e finalização limpa do Uvicorn.

**XM-01: CONCLUÍDO.** Próximo gate: XM-02.

### XM-02 — status de conexões — CONCLUÍDO

- Ethernet;
- Xbox reachability;
- NetISO;
- Samba;
- NetBIOS;
- Aurora FTP.

Gate: painel reflete corretamente estados online/offline sem modificar serviços.

#### Evidências de implementação — 2026-10-03

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/status.py`: probes somente-leitura;
- `GET /api/status` com schema `xboxmac-status-v1`;
- Ethernet validada por `ifconfig`, link ativo e IP privado esperado;
- Xbox por ICMP;
- NetISO por estado launchd + TCP 4323;
- Samba por estado launchd + TCP 139/445;
- NetBIOS por estado launchd + `nmblookup` broadcast, com fallback read-only de listeners UDP;
- Aurora FTP por disponibilidade TCP 21, sem necessidade de credenciais;
- página diagnóstica mínima exibe os seis estados via `/api/status`;
- testes unitários em `backend/server/tests/test_xm02_status.py`;
- `scripts/verify-xm02.py` verifica componentes, ausência de operações mutáveis e integridade do baseline;
- `scripts/test-xm02-local.sh` valida estado conectado → desconectado → recuperado;
- documentação em `docs/XM-02.md`.

O XM-02 não contém ação de start/stop/restart e não modifica configuração, LaunchDaemons ou Xbox.

Validação física pendente:

```text
git pull
.venv/bin/python scripts/verify-xm00.py
.venv/bin/python scripts/verify-xm01.py
.venv/bin/python scripts/verify-xm02.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
bash scripts/test-xm02-local.sh
```

O teste físico deve comprovar os seis componentes `up` no estado saudável, mudança observável após desconectar a Ethernet privada e recuperação completa após reconexão.

#### Ajuste após primeira validação física

Na primeira execução física, Ethernet, NetISO, Samba, NetBIOS e Aurora FTP ficaram `up`, mas o componente `xbox` ficou `down` porque o console não respondeu a ICMP.

Ao mesmo tempo, `192.168.50.2:21` estava aberto e Aurora FTP estava `up`, comprovando que o console estava acessível.

Conclusão: ICMP não pode ser requisito obrigatório para reachability do Xbox.

O probe foi corrigido para considerar o console `up` quando qualquer sinal confiável responder:

- ICMP;
- Aurora FTP/TCP 21;
- Aurora WebUI/TCP 9999.

ICMP permanece apenas como evidência adicional.

Foi acrescentado teste unitário específico para o caso "FTP acessível + ICMP indisponível".

#### Validação física final — CONCLUÍDA em 2026-10-03

No Mac real, após a correção do probe de reachability:

- 11/11 testes do backend passaram;
- estado saudável retornou `overall=ready`;
- Ethernet, Xbox, NetISO, Samba, NetBIOS e Aurora FTP ficaram `up`;
- o Xbox foi corretamente considerado `up` por TCP 21 e TCP 9999 mesmo sem ICMP;
- ao desconectar fisicamente a Ethernet, `overall=degraded` e os seis componentes refletiram indisponibilidade coerente;
- `launchd=running` permaneceu verdadeiro para NetISO/Samba/NetBIOS durante a queda física, comprovando que XM-02 não reiniciou serviços;
- após reconexão, os seis componentes retornaram a `up` e `overall=ready`;
- o teste terminou com `service_mutation=NONE`;
- shutdown do xboxmacd permaneceu limpo.

**XM-02: CONCLUÍDO.** Próximo gate: XM-03.

### XM-03 — ensure connections — CONCLUÍDO

- iniciar somente serviços faltantes;
- não reiniciar saudáveis;
- apresentar falha específica;
- NetISO não pode ser interrompido ao abrir o app.

Gate: abrir painel em estados variados converge para o estado saudável possível.

#### Evidências de implementação — 2026-10-03

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/ensure.py`: serviço idempotente de ensure;
- `POST /api/connections/ensure`;
- painel diagnóstica chama ensure antes de consultar status;
- NetISO/Samba/NetBIOS com `launchd=running` recebem `already_running` e não são reiniciados;
- somente job launchd não-running pode receber `launchctl kickstart system/<label>`;
- não existe uso de `kickstart -k`, `bootstrap`, `bootout`, `load/unload`, `kill` ou `sudo`;
- Ethernet física, Xbox e Aurora indisponíveis retornam ação externa explícita, sem tentativa destrutiva;
- falhas de start são classificadas como `permission_required`, `not_loaded` ou `failed`;
- testes unitários em `backend/server/tests/test_xm03_ensure.py`;
- verificação estática em `scripts/verify-xm03.py`;
- teste físico seguro em `scripts/test-xm03-local.sh`;
- documentação em `docs/XM-03.md`.

A evidência do XM-02 mostrou que, durante perda física da Ethernet, os três LaunchDaemons permanecem `running` enquanto os sockets ficam indisponíveis. Por isso XM-03 usa o estado launchd — e não apenas TCP — para decidir se um serviço precisa ser iniciado.

Validação física pendente:

```text
git pull
.venv/bin/python scripts/verify-xm03.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
bash scripts/test-xm03-local.sh
```

O teste físico deve comprovar:

- ensure saudável sem mudança de PID;
- perda física da Ethernet sem restart de NetISO/Samba/NetBIOS;
- recuperação após reconexão;
- PID do NetISO preservado durante todo o ciclo.

O caminho "serviço realmente ausente → iniciar somente aquele serviço" é validado por teste unitário para evitar derrubar LaunchDaemons funcionais apenas para testar o gate.

#### Primeira validação física — SUCESSO / ajuste de teste unitário pendente

No Mac real:

- ensure saudável retornou `ready`;
- NetISO, Samba e NetBIOS retornaram `already_running`;
- PIDs permaneceram inalterados:
  - NetISO: 300;
  - smbd: 301;
  - nmbd: 299;
- `healthy_service_restarts=0`;
- com Ethernet fisicamente desconectada, o ensure retornou `waiting_external`;
- nenhum dos três serviços foi reiniciado durante a queda física;
- após reconexão, `result=ready`;
- os mesmos PIDs foram preservados até o fim;
- teste físico terminou com `XM-03: OK` e `netiso_pid_preserved=YES`.

A suíte unitária teve uma única falha em `test_home_requests_ensure_before_status`. A falha era do próprio teste: ele comparava a primeira ocorrência textual de `/api/status` na página inteira, que aparece dentro da definição de `refreshStatus()`, com a ocorrência de `/api/connections/ensure`.

O comportamento real da página e do endpoint foi validado fisicamente. O teste foi corrigido para inspecionar especificamente o corpo de `ensureThenRefresh()` e confirmar a ordem:

```text
POST /api/connections/ensure
→ await refreshStatus()
```

Nenhum código funcional do ensure foi alterado nessa correção.

#### Validação final — CONCLUÍDA

Após a correção exclusiva do teste de sequência da página:

- `scripts/verify-xm03.py` retornou `STATIC_OK`;
- 17/17 testes do backend passaram;
- nenhum código funcional do ensure foi alterado;
- permanecem válidas as evidências físicas de zero restarts e preservação dos PIDs de NetISO, smbd e nmbd.

**XM-03: CONCLUÍDO.**

### XM-04 — biblioteca read-only — CONCLUÍDO

- inventário ISO;
- inventário ConnectX;
- correlação por TitleID/MediaID;
- tamanhos;
- estados;
- filtros.

Gate: biblioteca exibida sem permitir alterações.

#### Evidências de implementação — 2026-10-03

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/library.py`: inventário somente-leitura;
- leitura de `/Users/Shared/xbox360`;
- leitura de `/Users/Shared/xbox360-connectx`;
- leitura de `ingest-state.json` e `catalog.json`;
- correlação de ingestão ↔ catálogo por `TitleID + MediaID`, independentemente do nome das pastas;
- ISOs sem ingestão aparecem como `ISO_ONLY`;
- estados locais: `ISO_ONLY`, `CONNECTX_READY`, `SOURCE_PRUNED`, `ORPHANED`, `ERROR`;
- tamanho individual de ISO e árvore ConnectX;
- totais agregados;
- `GET /api/library` com filtros `query`, `state`, `has_iso` e `has_connectx`;
- schema `xboxmac-library-v1` em `backend/contracts/library.schema.json`;
- tabela diagnóstica read-only na página local;
- testes em `backend/server/tests/test_xm04_library.py`;
- verificador estático `scripts/verify-xm04.py`;
- validação local read-only `scripts/test-xm04-library.py`;
- documentação em `docs/XM-04.md`.

O XM-04 não executa o scanner legado e não contém endpoints de mutação da biblioteca.

Validação pendente no Mac:

```text
git pull
.venv/bin/python scripts/verify-xm04.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Depois deve ser validado o endpoint real `GET /api/library`, confirmando os nove pares TitleID/MediaID já conhecidos e a preservação dos hashes de `ingest-state.json` e `catalog.json`.

#### Validação local — CONCLUÍDA em 2026-10-03

No Mac real:

- `scripts/verify-xm04.py`: `STATIC_OK`;
- 24/24 testes do backend passaram;
- biblioteca real contém 15 jogos;
- estados: 9 `CONNECTX_READY` e 6 `ISO_ONLY`;
- 9/9 pares TitleID/MediaID conhecidos foram encontrados;
- correlação por TitleID + MediaID: OK;
- filtro real: OK;
- bytes ISO agregados: 119358312448;
- bytes ConnectX agregados: 39254235826;
- hashes de `ingest-state.json` e `catalog.json` permaneceram inalterados;
- `runtime_mutation=NONE`.

**XM-04: CONCLUÍDO.** Próximo gate: XM-05.

### XM-05 — integração da automação — CONCLUÍDO

- dry-run;
- execução;
- fila;
- progresso;
- erro por jogo;
- idempotência.

Gate: um novo jogo pode ser preparado a partir da UI sem terminal; quando houver ação manual no Aurora, a UI entra em estado explícito, orienta o usuário e continua automaticamente após detectar a mudança.

#### Evidências de implementação — 2026-10-03

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/automation.py`: fila persistente e worker único;
- persistência em `/usr/local/var/xbox-connectx/xboxmac-jobs.json`;
- seleção limitada a nomes de ISO dentro da raiz permitida;
- path traversal rejeitado;
- subprocessos diretos, sem shell;
- dry-run sem execução dos comandos ConnectX;
- ingestão individual por ISO para preservar erro por jogo;
- sincronização de metadata/capas reutilizando os executáveis validados em `/usr/local/libexec`;
- estado `WAITING_FOR_XBOX` recuperável quando Aurora FTP estiver temporariamente offline;
- `WAITING_FOR_AURORA_SCAN` com ação `aurora_rescan`;
- retry automático após Rescan;
- `WAITING_FOR_AURORA_REFRESH` com ação `aurora_refresh`;
- verificação automática por `xbox-connectx-sync-metadata --status`;
- retomada de jobs não terminais após restart do backend;
- log limitado por job;
- `POST /api/jobs/dry-run`;
- `POST /api/jobs`;
- `GET /api/jobs`;
- `GET /api/jobs/{job_id}`;
- schema de job atualizado em `backend/contracts/job.schema.json`;
- controles diagnósticos mínimos na página local para selecionar ISO, dry-run, execução e acompanhamento da fila;
- testes em `backend/server/tests/test_xm05_automation.py`;
- verificador `scripts/verify-xm05.py`;
- dry-run real `scripts/test-xm05-dry-run.py`;
- documentação em `docs/XM-05.md`.

O worker mantém o pipeline `connectx-v1.0.0` como adaptador externo; nenhum dos scripts congelados foi modificado.

Validação necessária:

```text
git pull
.venv/bin/python scripts/verify-xm05.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
.venv/bin/python scripts/test-xm05-dry-run.py
```

Depois, teste físico pela página local com uma única ISO `ISO_ONLY`:

- Dry-run pela UI;
- iniciar job;
- acompanhar progresso sem terminal;
- fazer Rescan somente quando solicitado;
- fazer refresh/restart somente quando solicitado;
- confirmar continuação automática;
- confirmar estado terminal;
- repetir a mesma ISO e validar idempotência.

#### Primeira validação estática/dry-run — 2026-10-03

No Mac real:

- `scripts/verify-xm05.py`: `STATIC_OK`;
- dry-run real: `XM-05 DRY-RUN: OK`;
- 6 ISOs `ISO_ONLY` detectadas;
- bytes planejados: 47022563328;
- path traversal rejeitado;
- `runtime_mutation=NONE`;
- nenhuma ISO foi extraída e nenhum job foi criado pelo dry-run.

A suíte unitária apresentou 1 falha em 32 testes:

```text
test_dry_run_is_read_only_and_detects_idempotence
already_ingested: esperado 1, obtido 0
```

Causa: no macOS o diretório temporário pode aparecer textualmente como `/var/...`, enquanto `Path.resolve()` canonicaliza para `/private/var/...`. A comparação de `source_iso` era textual, embora ambos apontassem para o mesmo arquivo.

Correção aplicada:

- canonicalização de paths do catálogo/biblioteca antes de comparar `source_iso`;
- a mesma canonicalização foi aplicada à recuperação de identidade pós-ingestão;
- acrescentado teste específico com path semanticamente equivalente contendo `..`.

O pipeline ConnectX congelado não foi alterado.

#### Validação estática/dry-run final — CONCLUÍDA em 2026-10-03

No Mac real, após a correção de canonicalização de paths:

- `scripts/verify-xm05.py`: `STATIC_OK`;
- 33/33 testes do backend passaram;
- `test_dry_run_is_read_only_and_detects_idempotence`: OK;
- `test_dry_run_canonicalizes_source_paths`: OK;
- dry-run real: `XM-05 DRY-RUN: OK`;
- 6 ISOs `ISO_ONLY` detectadas;
- bytes planejados: 47022563328;
- path traversal rejeitado;
- `runtime_mutation=NONE`;
- pipeline `connectx-v1.0.0` permanece inalterado.

ISOs disponíveis para o teste físico:

- Grand Theft Auto IV;
- Guitar Hero Van Halen;
- Guitar Hero Warriors of Rock;
- Guitar Hero 5;
- Guitar Hero II;
- Guitar Hero III Legends of Rock.

Resta apenas a validação física end-to-end pela interface local do XboxMac.

A interface diagnóstica foi ajustada antes do teste físico para manter também ISOs já ingeridas na lista de seleção. Isso permite repetir exatamente a mesma ISO após a primeira execução e validar idempotência pela própria UI. O estado atual do item é exibido ao lado do nome.

#### Bloqueio encontrado no primeiro teste da página

Ao abrir a página com o backend ativo, o HTML carregou, mas todos os placeholders permaneceram estáticos:

- `Preparando conexões...`;
- `Verificando...`;
- `Carregando biblioteca...`;
- `Carregando ISOs...`;
- fila vazia sem atualização.

Diagnóstico: o script embutido não era analisado pelo navegador. Duas rotinas de erro usavam strings JavaScript contendo HTML com aspas duplas escapadas dentro de uma string Python tripla. Na renderização, Python consumia as barras e produzia JavaScript inválido, por exemplo um atributo `colspan="3"` quebrando a própria string JS.

Correção aplicada:

- removido o uso de `innerHTML` nessas rotinas;
- erros passam a ser montados exclusivamente via `document.createElement`, `cell.colSpan` e `textContent`;
- acrescentado teste do HTML efetivamente retornado por `home()`, exigindo handlers seguros e as quatro chamadas iniciais:
  - `ensureThenRefresh()`;
  - `refreshLibrary()`;
  - `refreshAutomationCandidates()`;
  - `refreshJobs()`.

O backend/API não foi alterado por essa correção.

#### Validação da integração navegador ↔ backend — CONCLUÍDA em 2026-10-03

Após corrigir o JavaScript renderizado:

- 35/35 testes do backend passaram;
- `GET /healthz`: OK;
- `GET /api/status`: `overall=ready`;
- Ethernet, Xbox, NetISO, Samba, NetBIOS e Aurora FTP: `up`;
- `GET /api/library?has_iso=true`: 15 jogos;
- biblioteca: 9 `CONNECTX_READY` + 6 `ISO_ONLY`;
- `GET /api/jobs`: acessível, fila inicialmente vazia;
- no navegador, Conexões, Biblioteca e lista de ISOs passaram a carregar corretamente;
- filtro da biblioteca por `ISO_ONLY` foi validado manualmente.

Resta somente o teste físico end-to-end de um job real e a repetição da mesma ISO para comprovar idempotência pela UI.

#### Validação física end-to-end — CONCLUÍDA em 2026-10-03

O usuário validou o fluxo real pela interface local:

- execução automática funcionou corretamente;
- as ações manuais orientadas pelo painel funcionaram corretamente;
- o fluxo continuou após as ações no Aurora;
- o jogo chegou ao estado funcional final;
- o jogo foi iniciado e rodou no Xbox ao final da preparação;
- a integração navegador ↔ backend permaneceu funcional durante o fluxo.

**XM-05: CONCLUÍDO.** Próximo gate: XM-06.

### XM-06 — exclusão e reconciliação pelo filesystem — CONCLUÍDO

- excluir ISO;
- excluir ConnectX;
- confirmação;
- path guards;
- Lixo nativo do macOS como destino preferencial;
- `~/Downloads` como fallback;
- filesystem como fonte de verdade;
- restauração exclusivamente pelo Finder/macOS;
- reconhecimento automático de remoção/restauração/instalação manual;
- nunca `rm -rf`.

Gate: conteúdo real das pastas canônicas define a biblioteca; exclusões são recuperáveis pelo macOS quando possível, restaurações e instalações manuais válidas são reconhecidas automaticamente, e nenhum path externo pode ser atingido.

#### Regra definitiva — 2026-10-03

- não existe Lixeira privada do XboxMac;
- não existe estado `TRASHED`;
- não existe tombstone permanente de exclusão;
- não existe botão ou endpoint de restore;
- excluir pela aplicação tenta Lixo do macOS e usa `~/Downloads` como fallback;
- remover manualmente pelo Finder é equivalente a excluir pela aplicação;
- restaurar manualmente para a pasta canônica é reconhecido automaticamente;
- um jogo restaurado pode ser tratado como instalação nova;
- ISO nova colocada manualmente na raiz é reconhecida como `ISO_ONLY`;
- ConnectX novo colocado manualmente é reconhecido somente se possuir `default.xex` XEX1/XEX2 parseável com `Execution Info`, `TitleID` e `MediaID`;
- registros stale de `ingest-state.json`/`catalog.json` não mantêm jogo ausente na biblioteca.

#### Implementação

Implementação atual em `remappingbridge/xboxmac-ui/main`: `779ba9ae2a4e0fe2809e7ba313c6e7c43e9546eb`.

Publicado em `remappingbridge/xboxmac-ui/main`:

- `backend/server/xboxmac/connectx_discovery.py`: descoberta read-only de ConnectX no filesystem;
- parser de `default.xex` compatível com o mínimo usado pelo scanner legado, sem alterar o scanner congelado;
- biblioteca cruza estado histórico com presença real de ISO/ConnectX;
- stale record sem componente físico deixa de aparecer;
- remover ISO externamente + manter ConnectX => `SOURCE_PRUNED`;
- remover ConnectX externamente + manter ISO => `ISO_ONLY`;
- remover ambos => jogo sai da biblioteca ativa;
- restaurar os componentes => jogo reaparece automaticamente;
- arquivo diferente reutilizando o mesmo path de ISO não herda identidade antiga quando `source_size/source_mtime_ns` divergem;
- ConnectX manual válido entra como `CONNECTX_READY` com correlação `filesystem`;
- ConnectX inválido não entra na biblioteca e é contabilizado em `sources.connectx_live.invalid_entries`;
- endpoint leve `GET /api/library/revision`;
- frontend consulta revisão a cada 3 segundos e só reconstrói biblioteca quando o filesystem muda;
- `POST /api/delete/plan` e `POST /api/delete/execute` substituem a nomenclatura `/api/trash/*`;
- exclusão pela aplicação usa Finder via `/usr/bin/osascript`;
- fallback usa `os.rename` para `~/Downloads`, sem sobrescrever e sem copy+delete;
- exclusão continua bloqueada enquanto houver job não terminal;
- UI oferece `Excluir ISO`, `Excluir ConnectX` e `Excluir ambos`;
- testes em `backend/server/tests/test_xm06_trash.py`;
- verificador `scripts/verify-xm06.py`;
- fixture manual temporário `scripts/make-xm06-connectx-fixture.py` para validar descoberta ConnectX sem copiar um jogo grande;
- documentação em `docs/XM-06.md`.

#### Requisito mínimo de instalação manual

ISO:

- arquivo regular;
- não symlink;
- filha direta de `/Users/Shared/xbox360`;
- extensão `.iso`.

ConnectX:

- árvore dentro de `/Users/Shared/xbox360-connectx`;
- `default.xex` presente;
- `default.xex` e pasta não-symlink;
- magic `XEX1` ou `XEX2`;
- header table estruturalmente válida;
- `XEX Execution Info` presente;
- `TitleID` e `MediaID` extraíveis.

Arquivos adicionais variam por jogo; não existe conjunto universal além do executável principal que possa garantir genericamente todos os dados game-specific.

#### Validação necessária

```text
git pull
.venv/bin/python scripts/verify-xm06.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Depois, teste físico deve validar:

- exclusão pela UI para Lixo do macOS/fallback;
- remoção manual pelo Finder;
- restauração manual pelo Finder;
- ISO manual nova;
- ConnectX manual válido;
- rejeição de ConnectX inválido;
- atualização automática da página sem reload manual.

#### Primeira validação estática — 2026-10-03

No Mac real:

- `scripts/verify-xm06.py`: `STATIC_OK`;
- 49/50 testes passaram;
- única falha: `test_stale_plan_is_rejected`;
- o alvo foi modificado entre `plan` e `execute`;
- a biblioteca corretamente deixou de associar a ISO modificada ao jogo antigo;
- por isso a execução retornou `ISO não está disponível para excluir` antes da comparação final do `plan_id`.

Correção aplicada:

- qualquer desaparecimento, substituição ou mudança estrutural do alvo entre `plan` e `execute` agora é normalizado para:
  `o estado mudou desde a confirmação; gere um novo plano`;
- isso mantém a semântica de confirmação em duas fases consistente sem reduzir os guards de path/fingerprint.

#### Validação estática final — CONCLUÍDA em 2026-10-03

No Mac real:

- `scripts/verify-xm06.py`: `STATIC_OK`;
- 50/50 testes do backend passaram;
- Lixo nativo do macOS: contrato presente;
- fallback `~/Downloads`: contrato presente;
- Lixeira privada: proibida;
- restauração pela aplicação: proibida;
- filesystem: fonte de verdade;
- remoção pelo Finder: reconciliável;
- restauração pelo Finder: reconhecível;
- ISO manual: reconhecível;
- ConnectX manual: exige XEX válido;
- revisão leve da biblioteca: ativa;
- path guards: ativos;
- pipeline `connectx-v1.0.0`: inalterado.

Resta somente a validação física de filesystem/Finder. O `xboxmac-ui/main` está em `9d1bdf4f14eebe37fda0e5a3f6402a4225d1f39b` para essa etapa.

#### Validação após ajuste mínimo de UX — CONCLUÍDA em 2026-10-03

No Mac real:

- 50/50 testes passaram;
- compatibilidade XM-01…XM-06 preservada;
- nenhum contrato/API foi alterado;
- a página permanece pronta para validação física do XM-06.

Próxima evidência exigida: inspeção visual da página com a coluna `Ações de exclusão` e os controles destrutivos claramente visíveis antes de executar qualquer exclusão real.

#### Inspeção visual — APROVADA em 2026-10-03

No Mac real, após garantir que a instância atual do backend estava servindo a porta 8742:

- seção `Biblioteca e exclusão` visível;
- coluna `Ações de exclusão` visível;
- controles `Excluir ISO`, `Excluir ConnectX` e `Excluir ISO + ConnectX` visíveis;
- nenhum arquivo foi excluído durante esta inspeção.

Próximo teste físico: usar PES 2018 como primeiro alvo real de exclusão e restauração pelo Finder.

#### Validação física final — APROVADA em 2026-10-03

Validação realizada em múltiplos jogos reais:

- excluir somente ISO: OK;
- excluir somente ConnectX: OK;
- excluir ISO + ConnectX: OK;
- restaurar somente ISO pelo Finder: OK;
- restaurar somente ConnectX pelo Finder: OK;
- restaurar ISO + ConnectX pelo Finder: OK.

Resultado: o filesystem se comportou como fonte de verdade conforme definido; exclusão e restauração funcionaram tanto separadamente quanto em conjunto. XM-06 aceito e concluído.




#### Ajuste mínimo de UX para validação física — 2026-10-03

A sequência oficial permanece no XM-06; nenhum gate intermediário será executado.

Antes de retomar a validação física, a página diagnóstica receberá somente melhorias mínimas de clareza:

- seções visualmente separadas;
- tabela da biblioteca com scroll horizontal;
- coluna de ações explicitamente destacada;
- badges de estado;
- botões de exclusão claramente destrutivos e visíveis;
- tipografia e espaçamento suficientes para leitura e teste;
- nenhuma mudança de endpoint, schema ou fluxo;
- nenhuma introdução de framework frontend.

Esse ajuste pertence ao próprio XM-06 e existe apenas para tornar o teste físico seguro e inequívoco.

#### Segunda regressão textual corrigida

A validação seguinte manteve `STATIC_OK` e novamente 49/50 testes passaram. O único teste legado restante exigia também a presença literal de `XM-01` na home.

Correção aplicada:

- cabeçalho agora usa `Backend local ativo. Interface diagnóstica XM-01…XM-06.`;
- preserva simultaneamente os marcadores históricos do XM-01 e o contexto atual do XM-06;
- nenhuma API, schema ou lógica funcional foi alterada.

#### Regressão de compatibilidade textual corrigida

Na primeira validação após a melhoria visual, 49/50 testes passaram. O único erro foi o teste legado do XM-01 exigir a frase literal `Backend local ativo.`, enquanto a UI havia mudado para `Backend local ativo · interface diagnóstica do XM-06`.

Correção aplicada sem alterar comportamento:

- restaurada a frase literal `Backend local ativo.`;
- mantida a identificação visual `Interface diagnóstica do XM-06`;
- nenhuma API, schema ou fluxo funcional foi alterado.



Implementação mínima aplicada no `xboxmac-ui/main`:

- página continua sendo HTML/CSS/JS embutido, sem framework;
- seções Conexões, Biblioteca e Automação agora são visualmente separadas;
- biblioteca possui aviso explícito de que exclusão usa Lixo do macOS e fallback `~/Downloads`;
- tabela possui container com scroll horizontal;
- coluna renomeada para `Ações de exclusão`;
- estados de conexão e biblioteca usam badges;
- ações `Excluir ISO` e `Excluir ConnectX` usam estilo destrutivo outline;
- `Excluir ISO + ConnectX` usa estilo destrutivo preenchido;
- área de ações possui largura e espaçamento próprios;
- botão principal de automação é destacado;
- verificações automatizadas exigem esses marcadores visuais.


### XM-07 — assets/Aurora e ações manuais guiadas — EM VALIDAÇÃO FÍSICA

- estado de scan;
- ContentID;
- manifesto de metadata seletivo;
- filtro Lua via API `Content.*`;
- geração de `GC<TitleID>.asset`;
- uploads pendentes;
- CoverFlow;
- `WAITING_FOR_AURORA_SCAN` com instrução de Rescan;
- detecção automática do ContentID, sem botão obrigatório de confirmação;
- `WAITING_FOR_AURORA_REFRESH` quando refresh/restart ainda for necessário;
- verificação automática até `AURORA_READY`;
- sem clique manual `Assets > Import`;
- nenhuma escrita externa direta em `content.db`.

Gate: jogo novo chega a `AURORA_READY` pela UI, com metadata e capa verificadas; qualquer ação ainda manual no Xbox é explicitamente orientada e detectada automaticamente pelo backend.

#### Implementação XM-07

Implementação adicionada sem alterar o pipeline congelado:

- jobs persistem `content_id`, `metadata_state`, `cover_state` e `aurora_verified` por jogo;
- saída de `xbox-connectx-sync-metadata` é interpretada para capturar ContentID e estado do manifesto/metadata;
- saída de `xbox-connectx-sync-covers` é interpretada para verificar capa/GC por ContentID + TitleID;
- correlação de capa usa ContentID para evitar ambiguidade em jogos com mesmo TitleID;
- `AURORA_READY` exige ContentID conhecido + metadata `VERIFIED` + capa/GC `VERIFIED`;
- UI ganhou coluna `Jogos / Aurora` com TitleID, MediaID, ContentID, metadata, capa/GC e verificação final;
- `WAITING_FOR_AURORA_SCAN` orienta Rescan sem botão `Já fiz`;
- `WAITING_FOR_AURORA_REFRESH` orienta refresh/restart sem confirmação manual no Mac;
- backend continua detectando automaticamente quando avançar;
- nenhuma escrita direta em `content.db`;
- scripts congelados `backend/connectx/*` e filtro Lua não foram modificados;
- testes específicos em `backend/server/tests/test_xm07_aurora.py`;
- verificador `scripts/verify-xm07.py`;
- documentação em `docs/XM-07.md`.

Validação necessária:

```text
git pull
.venv/bin/python scripts/verify-xm07.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Depois, validação física com uma ISO nova deve comprovar:

- chegada automática a `WAITING_FOR_AURORA_SCAN` quando necessário;
- continuação automática depois do Rescan;
- ContentID visível na UI;
- metadata `VERIFIED`;
- capa/GC `VERIFIED`;
- orientação de refresh/restart quando necessária;
- continuação automática depois do refresh/restart;
- estado final `AURORA_READY`;
- capa visível no CoverFlow do Aurora.



#### Replanejamento após validação física — 2026-10-04

A validação física revelou duas divergências de produto que precisam ser corrigidas antes de aceitar o XM-07.

##### XM-07A — Automação atual reconciliada com a biblioteca

Problema observado:

- jobs concluídos permanecem na tabela principal de Automação indefinidamente;
- PES 2018 continua aparecendo ali mesmo depois de ISO e ConnectX terem sido removidos;
- isso mistura histórico técnico com estado operacional atual.

Regra planejada:

- a seção principal `Automação` representa somente trabalho atual;
- jobs em estados não terminais continuam sempre visíveis:
  `QUEUED`, `RUNNING`, `WAITING_FOR_XBOX`,
  `WAITING_FOR_AURORA_SCAN`, `APPLYING_METADATA`,
  `SYNCING_COVER`, `WAITING_FOR_AURORA_REFRESH`,
  `VERIFYING` e qualquer novo estado de espera do XM-07B;
- jobs `SUCCEEDED`, `FAILED` e `CANCELLED` deixam a área principal e passam a pertencer ao Histórico;
- nenhuma remoção automática apaga registros de `xboxmac-jobs.json`;
- cada game de job terminal é reconciliado com a biblioteca atual por identidade estável
  (preferência: `game_id`; fallback controlado: `TitleID + MediaID`);
- presença atual deve ser derivada do filesystem:
  `ISO_PRESENT`, `CONNECTX_PRESENT`, `BOTH_PRESENT` ou `ABSENT`;
- jogo sem ISO e sem ConnectX deve aparecer como `ABSENT` apenas no Histórico, nunca como trabalho atual;
- restauração pelo Finder volta a alterar a presença atual sem reescrever o histórico;
- nenhuma ação dessa reconciliação remove arquivos ou altera o catálogo do Aurora.

Compatibilidade/API planejada:

- manter `GET /api/jobs` compatível;
- adicionar filtragem explícita de visão, preferencialmente
  `scope=active|history|all`, com `all` preservando a resposta histórica atual;
- a UI principal usa `scope=active`;
- a futura área Histórico usa `scope=history`.

Gate XM-07A:

- PES removido do filesystem não aparece na Automação atual;
- job antigo continua recuperável via visão de Histórico/all;
- jobs ativos nunca desaparecem por falta temporária de ISO/ConnectX;
- nenhuma perda automática de histórico.

##### XM-07B — Semântica forte de prontidão no Aurora

Problema observado:

- lote de 5 jogos terminou como `SUCCEEDED/AURORA_READY`;
- filesystem ConnectX estava correto;
- ContentIDs 11–15 existiam;
- metadata estava `VERIFIED`;
- capa/GC estava `VERIFIED`;
- `content.db` retornou `overall=VERIFIED`;
- apesar disso, os cinco jogos não estavam visíveis na biblioteca do Aurora.

Conclusão:

`ContentID + metadata + GC asset + content.db` provam que o backend preparou e verificou os dados, mas não provam que o jogo está efetivamente visível/utilizável na interface do Aurora.

Estados planejados:

1. `CONNECTX_READY`
   - filesystem ConnectX válido.

2. `WAITING_FOR_AURORA_SCAN`
   - ainda não existe ContentID observável;
   - UI orienta Rescan;
   - sem botão `Já fiz`;
   - backend continua verificando automaticamente.

3. `AURORA_INDEXED`
   - ContentID existe e identidade TitleID/MediaID confere.

4. `AURORA_PREPARED`
   - metadata `VERIFIED`;
   - capa/GC `VERIFIED`;
   - content.db íntegro;
   - ainda não significa visibilidade final.

5. `WAITING_FOR_AURORA_VISIBILITY`
   - backend preparado, mas falta prova independente de que o item entrou na biblioteca visível;
   - UI pode orientar refresh/restart do Aurora ou reboot do console quando necessário;
   - não pode terminar como `SUCCEEDED` somente por content.db/assets.

6. `AURORA_READY`
   - reservado exclusivamente para evidência independente de visibilidade/uso real no Aurora.

Investigação técnica obrigatória antes da implementação:

- procurar um sinal machine-readable que represente a biblioteca realmente carregada pelo Aurora;
- prioridade de fontes:
  1. WebUI/API observável do Aurora;
  2. outra API/runtime state do Aurora;
  3. somente se comprovado por teste, algum campo/estado do banco que mude depois do refresh/reload;
- não aceitar como prova final os mesmos sinais já usados para `AURORA_PREPARED`;
- se não existir probe automático confiável, o sistema deve permanecer em
  `WAITING_FOR_AURORA_VISIBILITY` em vez de produzir falso `AURORA_READY`;
- não introduzir botão obrigatório `Já fiz` apenas para mascarar ausência de probe.

Tratamento de lote:

- cada jogo é avaliado individualmente;
- um lote de 5 pode ter resultados diferentes por game;
- o job global só pode ser `SUCCEEDED` se todos os games não-erro chegarem a `AURORA_READY`;
- `AURORA_PREPARED` não conta como sucesso final;
- erros/esperas de um game não podem ser ocultados pelo sucesso dos demais.

Gate XM-07B:

- jogo individual e lote são testados;
- nenhum jogo ausente da biblioteca visível pode ser marcado `AURORA_READY`;
- `SUCCEEDED` implica todos os games válidos em `AURORA_READY`;
- reboot/refresh necessário é mostrado explicitamente;
- qualquer avanço após ação no Xbox é detectado automaticamente;
- não há escrita direta em `content.db`.

#### Implementação do replanejamento — 2026-10-04

XM-07A implementado:

- `GET /api/jobs?scope=active|history|all`;
- `all` preserva compatibilidade com a visão completa anterior;
- UI principal usa somente `scope=active`;
- jobs terminais deixam a seção `Automação atual`, mas continuam persistidos;
- `history/all` reconciliam cada game com a biblioteca atual por `game_id` e fallback `TitleID + MediaID`;
- presença transitória: `BOTH_PRESENT`, `ISO_PRESENT`, `CONNECTX_PRESENT`, `ABSENT`, `UNKNOWN`;
- `scope=active` evita a varredura pesada da biblioteca a cada polling de 2 segundos;
- nenhuma exclusão automática de histórico foi adicionada; isso continua no XM-11.

XM-07B implementado:

- novo estado `AURORA_INDEXED`;
- ContentID passa a participar da desambiguação de toda evidência posterior;
- `AURORA_PREPARED` representa ContentID + metadata + capa/GC verificados;
- `AURORA_PREPARED` não promove mais o job para `SUCCEEDED`;
- novo estado `WAITING_FOR_AURORA_VISIBILITY`;
- `AURORA_READY` exige resultado `verified` de um probe independente;
- ponto de extensão: `_probe_aurora_visibility()`;
- implementação conservadora atual retorna `unavailable`, portanto não produz falso `AURORA_READY`;
- a ação guiada informa refresh/restart do Aurora e, se necessário, reboot do console;
- não existe botão obrigatório `Já fiz`;
- lote continua mantendo evidência por game.

Investigação do NOVA:

- documentação NOVA 0.7b.2 r1622 revisada;
- endpoints documentados incluem título em execução, filebrowser, sistema, plugin, perfis etc.;
- não há endpoint documentado de listagem da biblioteca carregada do Aurora;
- por isso NOVA não foi usado como falsa prova de visibilidade.

Arquivos principais alterados:

- `backend/server/xboxmac/automation.py`;
- `backend/server/xboxmac/app.py`;
- `backend/server/tests/test_xm05_automation.py`;
- `backend/server/tests/test_xm07_aurora.py`;
- `scripts/verify-xm07.py`;
- `docs/XM-07.md`;
- `backend/server/README.md`.

Próxima etapa:

```text
git pull
.venv/bin/python scripts/verify-xm07.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

#### Validação física XM-07A — APROVADA em 2026-10-04

No Mac real, após reiniciar o backend atual:

- `GET /api/jobs?scope=active`: vazio;
- nenhum job terminal antigo permaneceu na seção operacional;
- `GET /api/jobs?scope=history`: preservou os jobs antigos;
- PES 2018: `current_presence=ABSENT`, `current_library_state=None`;
- lote de cinco jogos: `current_presence=BOTH_PRESENT`;
- os cinco jogos continuam correlacionados à biblioteca ativa como `CONNECTX_READY`;
- nenhum registro histórico foi apagado ou reescrito;
- estados históricos antigos como `AURORA_READY` permanecem como evidência do comportamento anterior e não são migrados retroativamente.

Resultado: XM-07A aceito fisicamente.

#### Validação estática do replanejamento — CONCLUÍDA em 2026-10-04

No Mac real:

- `scripts/verify-xm07.py`: `STATIC_OK`;
- 58/58 testes do backend passaram;
- `job_scope=ACTIVE_HISTORY_ALL`;
- jobs terminais: histórico preservado;
- presença do filesystem: reconciliada;
- ContentID: rastreado;
- metadata/manifesto: rastreados;
- capa/GC: verificada;
- `AURORA_PREPARED` explicitamente não equivale a `AURORA_READY`;
- probe independente de visibilidade: obrigatório;
- falso `AURORA_READY`: proibido;
- confirmação manual obrigatória: proibida;
- escrita direta em `content.db`: proibida;
- pipeline legado: inalterado.

Próxima validação física:

1. reiniciar o backend com o código atual;
2. comprovar que jobs terminais antigos não aparecem em `scope=active`;
3. comprovar que os mesmos jobs permanecem em `scope=history`;
4. validar a presença atual reconciliada, incluindo PES 2018 como `ABSENT`;
5. somente depois testar um novo fluxo até `WAITING_FOR_AURORA_VISIBILITY`.

#### Validação física XM-07B — falso AURORA_READY eliminado em 2026-10-04

Teste real usando GTA IV já ingerido:

- job novo entrou em `WAITING_FOR_AURORA_VISIBILITY`;
- game ficou em `AURORA_PREPARED`;
- resultado de ingestão: `ALREADY_INGESTED`;
- TitleID: `545407F2`;
- MediaID: `6AC07221`;
- ContentID: `13`;
- metadata: `VERIFIED`;
- capa/GC: `VERIFIED`;
- `aurora_verified=false`;
- job não foi marcado `SUCCEEDED`;
- game não foi marcado `AURORA_READY`;
- ação guiada informou refresh/restart/reboot sem botão obrigatório de confirmação;
- log registrou `AURORA_VISIBILITY UNAVAILABLE` com justificativa de que o NOVA não expõe a biblioteca carregada.

Resultado: a regressão principal do XM-07B está corrigida e validada fisicamente.

Pendência restante do XM-07:

- localizar e validar um sinal independente de visibilidade real no Aurora;
- se nenhum sinal confiável existir, formalizar `WAITING_FOR_AURORA_VISIBILITY` como limite observável automático do produto, sem falso sucesso.

#### Investigação de probe independente — Australis descartado

O cliente público Australis foi inspecionado porque oferece uma tela chamada `Game Library`.

Resultado:

- Australis baixa `/Game/Data/Databases/content.db` por FTP;
- a lista de jogos é construída com `SELECT Id, TitleName FROM ContentItems`;
- portanto usa a mesma fonte de verdade já observada pelo XboxMac;
- isso não prova que o CoverFlow/biblioteca carregada em memória pelo Aurora já incorporou o item;
- Australis não serve como probe independente para `AURORA_READY`.

Próxima investigação: procurar sinal separado em `settings.db`, cache/runtime ou outra estrutura que mude somente após reload/reboot do Aurora.

#### Robustez do estado de visibilidade + diagnóstico estrutural

Correções adicionais implementadas após a primeira validação física do XM-07B:

- `WAITING_FOR_AURORA_VISIBILITY` não é mais reencolado após restart do backend;
- o estado e a ação guiada são preservados como estavam;
- `WAITING_FOR_AURORA_VISIBILITY` não bloqueia exclusões, pois a etapa mutável já terminou;
- estados realmente em processamento continuam protegendo exclusão;
- testes adicionados para restart e delete guard.

Novo diagnóstico read-only:

- `scripts/diagnose-xm07-aurora-library.py`;
- baixa cópias temporárias de `content.db` e `settings.db` para `/tmp`;
- valida `PRAGMA integrity_check`;
- imprime campos estruturais de `ContentItems`;
- imprime `ScanPaths`, `QuickViews` e `SystemSettings`;
- não executa `UPDATE`, `DELETE`, upload ou alteração remota.

Objetivo: comparar os cinco jogos novos não visíveis contra jogos antigos visíveis e verificar diferenças em `ScanPathId`, grupos, flags, profundidade, CaseIndex ou configuração de QuickView.

#### Relação com XM-10

A permanência do PES 2018 na própria biblioteca do Aurora continua fora do XM-07.

XM-06 remove os arquivos locais.
XM-10 continua responsável, futuramente, por remover com segurança a entrada e os assets do catálogo Aurora.


### XM-08 — launcher macOS

- `XboxMac.app`;
- iniciar/find backend;
- `ensure_ready`;
- abrir browser;
- não exigir terminal.

Gate: usuário não técnico consegue iniciar e usar o painel clicando no app.

### Observação operacional para XM-09 — interface privada após desconexão prolongada

Detectado em uso real: após horas com o equipamento/ligação Ethernet indisponível, a interface configurada como `en7` deixou de existir no macOS. Os serviços launchd continuaram `running`, mas NetISO/Samba/NetBIOS ficaram sem sockets úteis em `192.168.50.1`.

XM-09 deve tratar:

- renumeração da interface privada (`en7` -> outro `enX`);
- identificação persistente do adaptador por hardware/service em vez de depender apenas do nome BSD;
- restauração de `192.168.50.1/24`;
- daemon `running` porém socket indisponível;
- recuperação automática de NetISO/Samba/NetBIOS;
- retorno a READY sem terminal.

### XM-09 — scheduler e robustez

- reconciliação periódica;
- estabilidade de arquivo;
- Xbox offline;
- Mac sem Internet;
- cache;
- retries;
- logs;
- locks;
- recuperação após reboot.

Gate: operação cotidiana sem terminal.

### XM-10 — remoção do catálogo Aurora

Gate futuro, separado e opcional:

- backup;
- remoção segura da entrada;
- remoção dos assets associados;
- integrity check;
- rollback;
- confirmação visual.

Não implementar junto com XM-06.

### XM-11 — histórico de automações

Gate futuro, separado da fila operacional.

Objetivo:

- preservar rastreabilidade dos jobs concluídos sem poluir a área principal `Automação`;
- permitir que o usuário limpe histórico antigo conscientemente;
- nunca confundir limpeza de histórico com exclusão de jogo.

Estrutura planejada:

- seção/página `Histórico` separada da Automação atual;
- listar apenas jobs terminais:
  `SUCCEEDED`, `FAILED`, `CANCELLED`;
- mostrar por job:
  - data/hora;
  - estado final;
  - jogos;
  - TitleID/MediaID/ContentID quando disponíveis;
  - resultado final;
  - presença atual reconciliada (`ISO_PRESENT`, `CONNECTX_PRESENT`, `BOTH_PRESENT`, `ABSENT`);
  - erro resumido quando houver;
- permitir abrir detalhes/log de um job sem misturá-lo com a fila atual.

Ações planejadas:

- `Limpar histórico concluído`:
  - exige confirmação;
  - remove somente jobs terminais do store de histórico;
  - nunca remove job ativo;
  - nunca remove ISO;
  - nunca remove ConnectX;
  - nunca altera catálogo/assets do Aurora;
  - persistência reescrita de forma atômica;
- opcionalmente oferecer exclusão de um único registro histórico;
- ausência física de ISO/ConnectX não apaga o histórico automaticamente;
- limpeza automática por TTL fica fora do escopo inicial.

Compatibilidade:

- `GET /api/jobs` permanece compatível;
- visão `history` usa o filtro/API planejado no XM-07A;
- endpoint destrutivo de purge deve ser específico de histórico e nunca reutilizar os endpoints de exclusão de jogos.

Gate:

- jobs concluídos não aparecem na Automação atual;
- Histórico os preserva;
- `Limpar histórico concluído` remove apenas registros terminais;
- arquivos de jogos e Aurora permanecem byte-for-byte inalterados;
- jobs ativos sobrevivem à limpeza;
- reiniciar o backend mantém corretamente o histórico restante.


## Critérios finais

O projeto estará pronto para uso cotidiano quando uma pessoa que não conhece o backend puder:

1. clicar em `XboxMac.app`;
2. ver o estado de NetISO, ConnectX, Xbox e Aurora;
3. corrigir conexões com uma ação;
4. ver a biblioteca;
5. adicionar uma ISO e acompanhar sua conversão;
6. colocar um jogo novo no ConnectX/Aurora sem terminal;
7. ver capa no CoverFlow;
8. mover a ISO para a Lixeira e manter o jogo convertido;
9. mover o convertido para a Lixeira sem apagar a ISO;
10. entender claramente quando uma entrada antiga ainda permanece no Aurora;
11. reiniciar o Mac e voltar ao mesmo estado operacional;
12. fazer tudo isso sem conhecer os detalhes internos dos serviços;
13. receber instruções claras quando Rescan ou refresh/restart do Aurora ainda forem necessários;
14. não precisar executar um segundo comando no Mac depois dessas ações manuais;
15. ver a UI continuar automaticamente assim que o backend detectar que o Aurora avançou de estado.
