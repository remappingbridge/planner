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


### XM-07 — assets/Aurora e ações manuais guiadas — CONCLUÍDO

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

##### XM-07A.1 — filtro de candidatos da Automação

Objetivo:

- facilitar a seleção de jogos para automação sem misturar estado do filesystem com histórico de jobs;
- tornar imediatamente visíveis jogos nunca processados, jogos com somente ISO, somente ConnectX ou ambos;
- manter a fila `Automação atual` separada: o filtro atua na lista de candidatos/seleção, não nos jobs já em execução.

Modelo de filtros planejado:

1. **Histórico de automação**
   - `Nunca rodaram job` — **default**;
   - `Já rodaram job`;
   - `Todos`.

2. **Presença**
   - `Todos` — default;
   - `Somente ISO`;
   - `Somente ConnectX`;
   - `ISO + ConnectX`;
   - `Nenhum` — útil apenas para reconciliação/histórico, não selecionável para nova automação.

3. **Busca por texto**
   - mesma ergonomia da seção `Biblioteca e exclusão`;
   - filtra por título, nome do arquivo e, quando disponíveis, TitleID/MediaID.

Semântica de `Nunca rodaram job`:

- significa que não existe registro histórico de automação associado ao jogo;
- correlação preferencial por `game_id`;
- fallback por `TitleID + MediaID` quando disponíveis;
- para ISO ainda não identificada/ingerida, fallback por caminho ISO canônico + fingerprint já usado pela biblioteca (`size + mtime_ns`);
- simples renome de arquivo não deve criar falso histórico quando uma identidade forte já existir;
- arquivo diferente colocado no mesmo caminho não deve herdar histórico antigo se o fingerprint divergir.

Enriquecimento planejado da biblioteca/candidatos:

- `automation_history`:
  - `NEVER_RUN`;
  - `HAS_HISTORY`;
- `automation_last_job_id`;
- `automation_last_state`;
- `automation_last_run_at`;
- `presence`:
  - `ISO_ONLY`;
  - `CONNECTX_ONLY`;
  - `ISO_AND_CONNECTX`;
  - `ABSENT`.

Regras de seleção:

- jogo com ISO presente pode ser selecionado para Dry-run/Preparar;
- jogo somente ConnectX aparece para diagnóstico, mas checkbox/botão de preparação fica desabilitado com explicação `ISO ausente`;
- jogo sem ISO nem ConnectX não deve aparecer na lista operacional normal; só em visões de histórico/reconciliação;
- filtros nunca alteram arquivos, jobs ou estado do Aurora;
- trocar filtro não dispara automação.

Comportamento inicial da UI:

- ao abrir a página, `Histórico de automação = Nunca rodaram job`;
- `Presença = Todos`;
- resultado esperado: destacar prioritariamente jogos que ainda nunca passaram pelo XboxMac;
- contador deve indicar quantidade visível e quantidade total, por exemplo:
  `7 de 14 jogos · Nunca rodaram job`.

Arquitetura/API planejada:

- não reutilizar `scope=active|history|all` para candidatos; `scope` continua significando visão de jobs;
- criar parâmetros próprios na fonte de candidatos, por exemplo:
  - `automation_history=never|has_history|all`;
  - `presence=iso|connectx|both|all`;
- preferir enriquecer a resposta da biblioteca/candidatos em uma única chamada em vez de a UI baixar todos os jobs e fazer correlação no navegador;
- evitar varredura pesada do filesystem a cada polling; reutilizar `library_revision`/reconciliação já existente e recalcular somente quando biblioteca ou histórico de jobs mudar;
- manter `GET /api/jobs` compatível.

Relação com Histórico futuro (XM-11):

- este filtro responde `o que posso/preciso automatizar agora?`;
- XM-11 responde `o que aconteceu em jobs anteriores?`;
- `Já rodaram job` pode usar a mesma correlação histórica, mas não substitui a tela Histórico;
- **decisão de produto aceita em 2026-10-04:** limpar o histórico no XM-11 faz o jogo voltar a `NEVER_RUN`; `Nunca rodou job` significa literalmente “não existe mais nenhum registro de job associado no store de histórico”; o purge deve deixar essa consequência explícita na confirmação.

Decisão vinculante para XM-11:

- a classificação de histórico é derivada somente dos registros de jobs existentes;
- se todos os registros associados a um jogo forem removidos pelo usuário em `Limpar histórico concluído`, esse jogo volta imediatamente a `NEVER_RUN`;
- nenhum marcador/tombstone separado será mantido apenas para lembrar que o jogo já rodou;
- limpar histórico não altera ISO, ConnectX nem Aurora.

Gate XM-07A.1:

- default mostra somente jogos `NEVER_RUN`;
- filtros de presença distinguem ISO, ConnectX e ambos;
- combinação dos filtros funciona de forma composável;
- jogo ConnectX-only é visível mas não selecionável para preparar;
- jobs ativos continuam aparecendo separadamente em `Automação atual`;
- nenhum job ou arquivo é criado/modificado ao apenas filtrar;
- resultado permanece correto após excluir/restaurar ISO/ConnectX pelo Finder;
- histórico antigo do PES não reaparece na fila operacional.


#### Implementação XM-07A.1 — 2026-10-04

Implementado:

- nova rota `GET /api/automation/candidates`;
- filtros `automation_history=never|has_history|all`;
- filtros `presence=iso|connectx|both|all`;
- busca por título, arquivo, TitleID, MediaID e diretório ConnectX;
- default da UI: `Nunca rodaram job` + `Todos`;
- contador `N de T jogos`;
- classificação por candidato:
  - `NEVER_RUN`;
  - `HAS_HISTORY`;
- último job exposto por:
  - `automation_last_job_id`;
  - `automation_last_state`;
  - `automation_last_run_at`;
- presença:
  - `ISO_ONLY`;
  - `CONNECTX_ONLY`;
  - `ISO_AND_CONNECTX`;
- ConnectX-only aparece, mas fica não selecionável com `ISO ausente`;
- jobs novos persistem `source_iso`, `source_size` e `source_mtime_ns`;
- ISO sem identidade só herda histórico quando caminho canônico + tamanho + mtime coincidem;
- arquivo diferente no mesmo caminho não herda histórico antigo;
- classificação é derivada exclusivamente do store atual de jobs;
- remover todos os registros de um jogo no XM-11 faz o jogo voltar a `NEVER_RUN`;
- nenhum tombstone ou marcador paralelo de histórico será mantido;
- filtros são read-only e não criam job;
- `GET /api/jobs?scope=...` continua separado e compatível.

Testes adicionados:

- classificação antes/depois de criar job;
- purge do store voltando a `NEVER_RUN`;
- filtros ISO, ConnectX e ambos;
- ConnectX-only não selecionável;
- busca combinada;
- substituição de ISO no mesmo caminho sem herdar histórico;
- validação de parâmetros;
- contrato da rota;
- contrato visual dos filtros.

Revalidação necessária:

```text
git pull
.venv/bin/python scripts/verify-xm07.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

#### Revalidação estática XM-07A.1 — CONCLUÍDA em 2026-10-04

No Mac real:

- `scripts/verify-xm07.py`: `STATIC_OK`;
- 65/65 testes do backend passaram;
- `candidate_default=NEVER_RUN`;
- `candidate_history=NEVER_RUN_HAS_HISTORY_ALL`;
- `candidate_presence=ISO_CONNECTX_BOTH_ALL`;
- `history_purge=RESETS_TO_NEVER_RUN`;
- `raw_iso_history=PATH_SIZE_MTIME`;
- histórico terminal preservado;
- filesystem reconciliado;
- falso `AURORA_READY` continua proibido;
- pipeline legado continua inalterado;
- estado `WAITING_FOR_AURORA_VISIBILITY` continua preservado após restart e não bloqueia exclusão.

Próxima validação física do XM-07A.1:

- validar default `Nunca rodaram job`;
- validar `Já rodaram job`;
- validar `Todos`;
- validar presença `Somente ISO`, `Somente ConnectX`, `ISO + ConnectX`;
- validar combinação com busca;
- confirmar ConnectX-only visível e não selecionável;
- não criar job durante essa validação.

#### Validação física XM-07A.1 — APROVADA em 2026-10-04

Validação real da UI concluída:

- default `Nunca rodaram job`: OK;
- `Já rodaram job`: OK;
- `Todos`: OK;
- `Somente ISO`: OK;
- `Somente ConnectX`: OK;
- `ISO + ConnectX`: OK;
- combinações entre filtros: OK;
- busca por texto/identidade: OK;
- jogos ConnectX-only aparecem e permanecem não selecionáveis sem ISO: OK;
- nenhum job foi criado apenas por filtrar.

Resultado: XM-07A.1 aceito fisicamente.

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

#### Diagnóstico estrutural XM-07B — campos e QuickView descartados

Com `content.db` e `settings.db` reais:

- ContentIDs 1–15 usam os mesmos valores estruturais relevantes:
  - `ScanPathId=1`;
  - `FoundAtDepth=1`;
  - `ContentGroup=1`;
  - `DefaultGroup=1`;
  - `ContentType=28672`;
  - `FileType=1`;
  - `ContentFlags=20`;
  - `CaseIndex=0`;
- portanto os ContentIDs novos 11–15 não diferem estruturalmente dos jogos antigos visíveis;
- `DefaultQuickView=6`;
- QuickView 6 = `XboxMac Probe`, filtro `User.XboxMac Probe`;
- o filtro Lua congelado `XboxMacProbe.lua` retorna `true` para todo item após executar `processManifest()`;
- portanto não há regra no filtro XboxMac Probe que exclua seletivamente os cinco novos jogos.

Hipóteses descartadas:

- ScanPathId incorreto;
- ContentGroup/DefaultGroup divergente;
- ContentFlags/ContentType/FileType divergentes;
- profundidade/CaseIndex divergentes;
- QuickView XboxMac Probe retornando false para os novos jogos.

Próximo teste físico:

- com os ContentIDs 11–15 já persistidos, reiniciar completamente o console;
- após o boot e carregamento do Aurora, verificar se os cinco jogos passam a aparecer;
- não executar novo Rescan nem nova automação antes dessa observação.

Objetivo: determinar se a divergência restante está no estado/cache/runtime carregado do Aurora/ConnectX e é resolvida apenas por reboot completo.

#### Validação física adicional XM-07B — reboot global do Aurora em 2026-10-04

Observação real:

- após reboot completo do console, os cinco jogos novos ficaram visíveis no Aurora;
- GTA IV, GH Warriors of Rock, Guitar Hero 5, Guitar Hero II e Guitar Hero III aparecem corretamente;
- o usuário observou que os cinco provavelmente já haviam aparecido quando executou o fluxo posterior selecionando somente GTA IV;
- o job atual do painel contém somente GTA IV, pois foi o único jogo selecionado naquele job;
- isso é coerente com o pipeline atual: `xbox-connectx-sync-metadata --apply` e `xbox-connectx-sync-covers` percorrem o catálogo global, embora o job operacional acompanhe apenas os jogos selecionados;
- a visibilidade/reload do Aurora é, portanto, uma ação global do console, não necessariamente limitada aos games do job que a desencadeou.

Conclusão operacional:

- `AURORA_PREPARED` continua sendo evidência por jogo;
- refresh/reboot do Aurora é um evento global que pode tornar visíveis vários jogos preparados de uma vez;
- a UI não deve adicionar automaticamente jogos não selecionados ao job atual apenas porque a sincronização global os tocou;
- a UI deve deixar claro que a ação de visibilidade pode afetar outros jogos preparados;
- o job GTA IV permanecer em `WAITING_FOR_AURORA_VISIBILITY` após o reboot evidencia apenas a ausência de detecção automática do evento de reload, não falha de preparação.

Direção de implementação:

- detectar automaticamente um ciclo completo de indisponibilidade/retorno do console/Aurora após entrar em `WAITING_FOR_AURORA_VISIBILITY`;
- distinguir restart simples do Aurora de reboot completo quando tecnicamente possível;
- após um reboot completo detectado e com evidência `AURORA_PREPARED` íntegra, avaliar promoção automática para `AURORA_READY`;
- a promoção deve permanecer restrita aos jogos acompanhados pelo job;
- não importar jogos não selecionados para o job atual;
- registrar que um único reboot pode satisfazer a etapa de visibilidade de múltiplos jobs preparados simultaneamente.

#### Descoberta para probe runtime — Content.FindContent()

A API Lua pública do Aurora expõe:

```lua
table Content.FindContent( DWORD titleId, [string searchText] );
```

Scripts públicos do Aurora usam também `Content.FindContent()` sem argumentos para construir uma lista de jogos a partir da coleção conhecida pelo runtime.

Isso é tecnicamente superior a usar `content.db` como prova final:

- `content.db` comprova persistência/indexação;
- `Content.FindContent()` consulta a coleção exposta pelo runtime Lua do Aurora;
- portanto pode servir como sinal independente para `AURORA_READY`, desde que um probe auxiliar consiga executar essa chamada e publicar o resultado para o Mac.

Restrição de implementação:

- não modificar `XboxMacProbe.lua` congelado sem uma decisão explícita;
- preferir um probe Lua auxiliar, isolado e removível;
- não alterar a associação de jogos ao job: o job continua contendo somente os jogos selecionados;
- sincronização global pode preparar outros jogos, mas isso deve aparecer apenas como efeito global informativo.

Próxima implementação experimental:

1. criar probe Lua auxiliar que enumere `Content.FindContent()`;
2. gravar snapshot somente-leitura de identidade (`ContentID/TitleID/MediaID`) em arquivo de estado;
3. backend lê o snapshot via FTP;
4. jogo do job só chega a `AURORA_READY` se sua identidade aparecer no snapshot runtime;
5. validar primeiro sem alterar o filtro Lua congelado.

#### Implementação do probe runtime Content.FindContent — 2026-10-04

Implementado sem modificar o `XboxMacProbe.lua` congelado:

Novos arquivos auxiliares:

- `aurora/User/Scripts/Content/Filters/XboxMacVisibilityProbe.lua`;
- `aurora/User/Scripts/Content/Filters/XboxMacVisibilityProbe.ini`;
- `backend/server/xboxmac/aurora_visibility.py`;
- `backend/server/tests/test_xm07_visibility_probe.py`.

Comportamento:

- o probe Lua é somente-leitura em relação ao catálogo;
- aguarda a enumeração runtime estabilizar;
- usa `Content.FindContent()`;
- grava `ContentID/TitleID/MediaID` em:
  `game:\User\Scripts\xboxmac-visibility.snapshot`;
- o backend instala/atualiza o probe via FTP;
- o snapshot anterior é removido antes de armar a validação;
- isso impede snapshot antigo de validar job novo;
- jobs antigos já parados em `WAITING_FOR_AURORA_VISIBILITY` são armados automaticamente após restart do backend;
- o worker verifica snapshots em background;
- correspondência exige `ContentID + TitleID + MediaID`;
- todos os games não-erro do job precisam estar presentes;
- se presentes: `AURORA_READY` e `SUCCEEDED`;
- se ausentes: permanece `WAITING_FOR_AURORA_VISIBILITY`;
- a UI mostra `Probe runtime: <status>`;
- um reboot/reload global pode satisfazer vários jobs preparados;
- jogos não selecionados nunca são adicionados retroativamente ao job.

Estados do probe:

- `NEEDS_ARM`;
- `ARMED`;
- `WAITING_SNAPSHOT`;
- `MISSING`;
- `VERIFIED`;
- `ARM_FAILED`.

Freshness:

- qualquer snapshot anterior é apagado ao armar;
- somente snapshot recriado depois de reload/reboot pode ser utilizado.

Testes adicionados/alterados:

- parser do snapshot;
- schema/status obrigatório;
- correspondência exata dos três IDs;
- snapshot correto promove para `AURORA_READY`;
- snapshot sem o jogo mantém espera;
- probe auxiliar não usa setters de metadata.

Revalidação estática necessária antes do teste físico.

#### Revalidação estática do probe runtime — CONCLUÍDA em 2026-10-04

No Mac real:

- `scripts/verify-xm07.py`: `STATIC_OK`;
- 69/69 testes do backend passaram;
- `visibility_probe=CONTENT_FIND_CONTENT`;
- `visibility_snapshot=FRESH_AFTER_ARM`;
- `visibility_probe_mutation=FORBIDDEN`;
- `false_aurora_ready=FORBIDDEN`;
- `legacy_pipeline=UNCHANGED`;
- `runtime_visibility_probe=IMPLEMENTED_PHYSICAL_PENDING`.

Próximo teste físico:

1. reiniciar somente o backend XboxMac;
2. confirmar que o job GTA IV existente continua em `WAITING_FOR_AURORA_VISIBILITY`;
3. aguardar o backend instalar/armar o probe e apagar snapshot anterior;
4. confirmar `Probe runtime: ARMED` ou estado equivalente de espera por snapshot;
5. executar reboot completo do console;
6. após o Aurora carregar, aguardar reconciliação automática;
7. esperado:
   - snapshot novo gerado por `Content.FindContent()`;
   - GTA IV reconhecido por ContentID 13 + TitleID 545407F2 + MediaID 6AC07221;
   - job -> `SUCCEEDED`;
   - game -> `AURORA_READY`;
   - `aurora_verified=true`;
   - probe -> `VERIFIED`;
8. nenhum novo job/ingest/rescan deve ser necessário.

#### Falha física do probe v1 e correção para v2 — 2026-10-04

Primeiro teste físico do probe runtime:

- instalação/armação via FTP: OK;
- snapshot antigo removido: OK;
- reboot completo do console: executado;
- snapshot novo gerado: OK;
- snapshot retornou:
  - `schema=xboxmac-visibility-snapshot-v1`;
  - `count=0`;
  - `status=READY`;
- GTA IV permaneceu em `WAITING_FOR_AURORA_VISIBILITY`;
- probe ficou em `MISSING`;
- visualmente o GTA IV estava presente no Aurora.

Causa:

- o probe v1 exigia `item.Id`;
- `Content.FindContent()` expõe de forma comprovada `TitleId`, `MediaId`, `Name` e `BaseVersion`;
- no teste físico, exigir `item.Id` descartou toda a coleção runtime.

Correção implementada:

- novo schema `xboxmac-visibility-snapshot-v2`;
- protocolo `title-media-v2`;
- snapshot contém somente `TitleID + MediaID`;
- `ContentID` continua obrigatório em `AURORA_PREPARED`, mas não participa da identidade runtime;
- correspondência final usa `TitleID + MediaID`;
- jobs aguardando com protocolo antigo/ausente são automaticamente rearmados;
- rearm instala o probe v2 e remove o snapshot v1 anterior;
- snapshot v1 nunca pode validar o protocolo v2;
- teste de migração de protocolo adicionado.

Próxima etapa:

- revalidar testes estáticos;
- reiniciar backend;
- confirmar que o job GTA IV é rearmado como `protocol=title-media-v2`;
- reboot completo do console;
- esperado: snapshot v2 com coleção não vazia e GTA IV promovido a `AURORA_READY/SUCCEEDED`.

#### Falha física do probe v2 e correção para QuickView callback v3 — 2026-10-04

Segundo teste físico:

- protocolo v2 foi armado corretamente;
- reboot completo executado;
- snapshot novo foi gerado com:
  - `schema=xboxmac-visibility-snapshot-v2`;
  - `status=READY`;
  - `count=0`;
- GTA IV permaneceu corretamente em `WAITING_FOR_AURORA_VISIBILITY`;
- o job registrou `protocol=title-media-v2`;
- visualmente o jogo continua presente no Aurora.

Conclusão:

- o problema não era mais identidade;
- `Content.FindContent()` executado no top-level do carregamento do script ocorre cedo demais;
- nesse estágio a biblioteca runtime ainda não está disponível;
- esperar dentro desse mesmo carregamento não é um sinal confiável.

Probe v3 implementado:

- protocolo `quickview-callback-v3`;
- schema `xboxmac-visibility-snapshot-v3`;
- auxiliar renomeado para:
  - `ZZXboxMacVisibilityProbe.lua`;
  - `ZZXboxMacVisibilityProbe.ini`;
- prefixo `ZZ` prioriza carregamento depois do `XboxMacProbe.lua`;
- o auxiliar captura a função existente:
  `GameListFilterCategories.User["XboxMac Probe"]`;
- registra um wrapper que chama primeiro o filtro original;
- quando o filtro original aceita um item, observa `TitleID + MediaID`;
- snapshot é atualizado incrementalmente conforme o QuickView real avalia jogos;
- isso transforma o probe em evidência do caminho real de exibição, e não de uma consulta prematura no startup;
- arquivos auxiliares antigos são removidos automaticamente do Xbox ao instalar o v3;
- `WRAP_UNAVAILABLE` é tratado como falha do probe, nunca como jogo ausente;
- protocolos antigos são rearmados automaticamente;
- snapshot antigo nunca valida protocolo novo.

Também corrigido:

- `verify-xm07.py` deixou de procurar a string do protocolo dentro de `automation.py`;
- agora valida `PROBE_PROTOCOL` e `SNAPSHOT_SCHEMA` no módulo `aurora_visibility`.

Próxima etapa:

- revalidar estaticamente;
- reiniciar backend;
- confirmar `protocol=quickview-callback-v3`;
- reboot completo do console;
- esperado: snapshot v3 com `count>0`;
- GTA IV deve ser observado pelo callback do QuickView e promovido a `AURORA_READY/SUCCEEDED`.

#### Validação física final do probe v3 — APROVADA em 2026-10-04

Teste real com o job já existente do GTA IV:

- `verify-xm07.py`: `STATIC_OK`;
- 73/73 testes do backend passaram;
- probe armado com:
  - `protocol=quickview-callback-v3`;
  - `status=ARMED`;
- reboot completo do console executado;
- snapshot criado pelo QuickView ativo:
  - `schema=xboxmac-visibility-snapshot-v3`;
  - `status=READY`;
  - `count=16`;
- GTA IV observado pelo callback do `XboxMac Probe`;
- job removido de `scope=active`;
- job final:
  - `state=SUCCEEDED`;
  - `probe.status=VERIFIED`;
  - `probe.protocol=quickview-callback-v3`;
- GTA IV final:
  - `state=AURORA_READY`;
  - `aurora_verified=true`.

Conclusão:

- a prova final de visibilidade não depende de `content.db`;
- a prova é produzida pelo próprio caminho de avaliação do QuickView/CoverFlow;
- `TitleID + MediaID` identificam o item observado no runtime;
- `ContentID` continua sendo evidência da etapa `AURORA_PREPARED`;
- nenhum botão manual de confirmação é necessário;
- um reload/reboot global pode tornar visíveis outros jogos preparados sem adicioná-los ao job atual;
- o pipeline congelado `connectx-v1.0.0` permanece inalterado.

Resultado: XM-07 aceito e concluído.

#### Relação com XM-10

A permanência do PES 2018 na própria biblioteca do Aurora continua fora do XM-07.

XM-06 remove os arquivos locais.
XM-10 continua responsável, futuramente, por remover com segurança a entrada e os assets do catálogo Aurora.


### XM-07C — adoção automática de jogos XEX manuais — CONCLUÍDO

Motivação real:

- jogo colocado manualmente em `/Users/Shared/xbox360-connectx` com `default.xex` válido pode rodar no Xbox e ser descoberto pela biblioteca;
- porém hoje ele não necessariamente passa pelo mesmo fluxo de metadata/capa dos jogos ingeridos por ISO;
- caso de validação: `Avatar: The Last Airbender` em XEX manual, jogável no Xbox, mas sem capa ilustrada automática.

Objetivo:

- transformar qualquer árvore XEX válida colocada manualmente no ConnectX em um candidato adotável pelo XboxMac;
- não exigir ISO de origem;
- reutilizar o pipeline já validado de metadata, capa, Aurora scan e probe runtime.

Regras de descoberta:

- detectar recursivamente `default.xex`;
- recusar symlink;
- validar magic `XEX1/XEX2`;
- exigir Execution Info;
- extrair `TitleID + MediaID`;
- calcular fingerprint da árvore/arquivo suficiente para reconciliação;
- distinguir:
  - XEX gerado pelo XboxMac;
  - XEX manual ainda não adotado;
  - XEX manual já adotado.

Novo estado conceitual:

- `MANUAL_CONNECTX_UNADOPTED` — filesystem válido, mas ainda não passou por metadata/capa;
- após adoção, segue os mesmos estados:
  `CONNECTX_READY -> WAITING_FOR_AURORA_SCAN -> AURORA_PREPARED -> AURORA_READY`.

Automação:

- a seção Automação passa a permitir selecionar XEX manual sem ISO;
- nesses casos o botão deve ser `Adotar / Preparar`, não `Ingerir ISO`;
- o job não chama `xbox-connectx-ingest`;
- chama scanner/catalogação, staging, metadata, cover e verificação Aurora;
- idempotente: repetir adoção não duplica catálogo, assets ou jobs;
- não mover, renomear ou reempacotar a pasta manual sem autorização explícita.

Metadata/capa:

- usar `TitleID + MediaID` obtidos do próprio XEX;
- buscar x360db;
- buscar/normalizar capa via XboxUnity quando necessário;
- gerar GC asset;
- verificar CoverFlow pelo probe runtime v3;
- metadata/capa ausentes ou incompletas não devem impedir o jogo de continuar jogável;
- erros de metadata/capa devem ser mostrados separadamente da validade do XEX.

Gate XM-07C:

- copiar um XEX manual válido para o ConnectX;
- biblioteca o detecta automaticamente;
- Automação o mostra como XEX manual não adotado;
- sem ISO presente, ainda pode ser selecionado para adoção;
- `Avatar: The Last Airbender` recebe metadata e capa automaticamente;
- jogo continua jogável no Xbox;
- chega a `AURORA_READY`;
- nenhuma duplicação no catálogo/Aurora.

#### Implementação XM-07C — 2026-10-04

Implementado no `remappingbridge/xboxmac-ui` sem modificar o pipeline
congelado `backend/connectx/*`.

Biblioteca:

- XEX vivo sem `ingest-state` passa a ser classificado como
  `MANUAL_CONNECTX_UNADOPTED`;
- novos campos:
  - `manual_connectx`;
  - `manual_adoption_state=UNADOPTED|ADOPTED`;
  - `manual_adoption_job_id`;
- adoção é invalidada automaticamente se o SHA-256 do `default.xex`
  mudar.

Store persistente:

- `/usr/local/var/xbox-connectx/manual-adoptions.json`;
- schema `xboxmac-manual-adoptions-v1`;
- chave por `TitleID + MediaID`;
- fingerprint pelo SHA-256 do XEX;
- registro só é gravado após prova final `AURORA_READY`;
- Histórico de jobs e store de adoção são independentes.

Automação:

- novo planejamento `xboxmac-automation-plan-v2`;
- mantém compatibilidade com `iso_filenames`;
- adiciona `game_ids` para alvos XEX manuais;
- ações:
  - `adopt_manual_connectx`;
  - `already_adopted`;
- XEX manual é revalidado por identidade/fingerprint antes de processar;
- resultado inicial `MANUAL_CONNECTX_VALID`;
- XEX alterado/ausente:
  `MANUAL_XEX_CHANGED_OR_MISSING / VALIDATE_MANUAL_XEX`;
- branch manual nunca chama `xbox-connectx-ingest`;
- segue diretamente para metadata, capa e Aurora;
- probe runtime v3 continua sendo a condição para `AURORA_READY`.

UI/API:

- `AutomationRequest` aceita `iso_filenames` e `game_ids`;
- XEX manual ConnectX-only fica selecionável mesmo sem ISO;
- ação exibida: `Adotar / Preparar`;
- botão principal:
  `Adotar / Preparar selecionadas`;
- ConnectX-only que não é XEX manual adotável continua não selecionável.

Arquivos principais:

- `backend/server/xboxmac/manual_adoptions.py`;
- `backend/server/xboxmac/library.py`;
- `backend/server/xboxmac/automation.py`;
- `backend/server/xboxmac/app.py`;
- `backend/server/tests/test_xm04_library.py`;
- `backend/server/tests/test_xm07c_manual_xex.py`;
- `scripts/verify-xm07c.py`;
- `docs/XM-07C.md`.

Validação estática necessária:

```text
git pull
.venv/bin/python scripts/verify-xm07.py
.venv/bin/python scripts/verify-xm07c.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Validação física planejada com `Avatar: The Last Airbender`:

1. aparecer como `MANUAL_CONNECTX_UNADOPTED`;
2. filtro `Somente ConnectX` permite seleção;
3. Dry-run retorna `adopt_manual_connectx`;
4. job não executa ingest;
5. metadata/capa são processadas;
6. capa ilustrada é gerada/instalada;
7. Aurora chega a `AURORA_READY`;
8. store de adoção é persistido;
9. biblioteca passa a `CONNECTX_READY / ADOPTED`;
10. jogo continua jogável no Xbox.

#### Validação estática XM-07C — CONCLUÍDA em 2026-10-04

No Mac real:

- `scripts/verify-xm07.py`: `STATIC_OK`;
- `scripts/verify-xm07c.py`: `STATIC_OK`;
- 80/80 testes do backend passaram;
- `manual_xex=DISCOVERED`;
- `manual_state=MANUAL_CONNECTX_UNADOPTED`;
- `manual_without_iso=SELECTABLE`;
- `manual_ingest=SKIPPED`;
- `manual_identity=TITLE_ID_MEDIA_ID`;
- `manual_fingerprint=XEX_SHA256`;
- `manual_adoption_store=PERSISTENT`;
- `manual_adoption_final=AURORA_READY_ONLY`;
- `legacy_pipeline=UNCHANGED`.

Próxima validação física com `Avatar: The Last Airbender`:

1. reiniciar backend XboxMac;
2. confirmar na Biblioteca:
   - `state=MANUAL_CONNECTX_UNADOPTED`;
   - `manual_connectx=true`;
   - `manual_adoption_state=UNADOPTED`;
3. na Automação:
   - Histórico `Nunca rodaram job`;
   - Presença `Somente ConnectX`;
   - Avatar deve estar selecionável sem ISO;
   - UI deve mostrar `Adotar / Preparar`;
4. executar Dry-run;
5. confirmar:
   - `action=adopt_manual_connectx`;
   - `source_kind=manual_connectx`;
   - `ingest=0`;
6. executar `Adotar / Preparar selecionadas`;
7. confirmar no log que não há `xbox-connectx-ingest`;
8. acompanhar metadata/capa/Aurora;
9. executar Rescan/reload/reboot somente se a UI pedir;
10. esperado final:
    - job `SUCCEEDED`;
    - game `AURORA_READY`;
    - `aurora_verified=true`;
    - capa ilustrada no CoverFlow;
    - biblioteca `CONNECTX_READY`;
    - `manual_adoption_state=ADOPTED`.

#### Validação física XM-07C — etapa Dry-run APROVADA em 2026-10-04

Caso real:

- jogo: `AVATAR THE LAST AIRBENDER`;
- origem:
  `/Users/Shared/xbox360-connectx/AVATAR THE LAST AIRBENDER/AVATAR THE LAST AIRBENDER`;
- `game_id=xbox360-545107E1-117FE50B`;
- `TitleID=545107E1`;
- `MediaID=117FE50B`;
- SHA-256 do `default.xex`:
  `fc3b177a4f8d00dc0ee8ffee4203925d43bdc42ff12b232f7d16e1fd556233ae`;
- tamanho da árvore: `5457685906` bytes.

Dry-run real:

- `schema=xboxmac-automation-plan-v2`;
- `source_kind=manual_connectx`;
- `action=adopt_manual_connectx`;
- `ingest=0`;
- `adopt_manual_connectx=1`;
- `already_ingested=0`;
- `already_adopted=0`.

Conclusão parcial:

- XEX manual foi descoberto e identificado corretamente;
- XEX manual é planejável sem ISO;
- o planejamento não tenta ingest de ISO;
- próximo passo é executar o job real e validar metadata/capa/Aurora/probe/store de adoção.

#### Validação física XM-07C — execução real entrou no pipeline sem ingest

Job real do Avatar:

- `job_id=e7eba4ee5d644351bba95172bb1916cd`;
- `source_kind=manual_connectx`;
- `result=MANUAL_CONNECTX_VALID`;
- `game_id=xbox360-545107E1-117FE50B`;
- `TitleID=545107E1`;
- `MediaID=117FE50B`;
- `state=APPLYING_METADATA`;
- `iso_filenames=[]`;
- `target_game_ids` contém somente o Avatar;
- log observado:
  - `MANUAL_CONNECTX_VALID ...`;
  - `$ /usr/local/libexec/xbox-connectx-sync-metadata --apply`;
- nenhuma chamada a `xbox-connectx-ingest`.

Conclusão parcial:

- branch manual foi executado corretamente;
- XEX foi revalidado pelo fingerprint;
- ingest ISO foi efetivamente pulado no teste físico;
- próximo ponto de validação é o resultado do sync de metadata/capa/Aurora.

#### Validação física XM-07C — metadata e capa do Avatar preparadas

Job real `e7eba4ee5d644351bba95172bb1916cd`:

- estado atual: `WAITING_FOR_AURORA_REFRESH`;
- Avatar:
  - `ContentID=16`;
  - `TitleID=545107E1`;
  - `MediaID=117FE50B`;
  - `metadata_state=MANIFEST_PENDING`;
  - `cover_state=VERIFIED`;
  - `aurora_verified=false`;
- metadata:
  - catálogo local reconheceu 15 games;
  - Aurora content.db íntegro com 16 items;
  - Avatar detectado como pendente nos campos:
    `TitleName, Description, Publisher, Developer, ReleaseDate`;
  - manifesto enviado:
    `manifest_uploaded=YES`;
- capa:
  - placeholder remoto anterior: `2048` bytes;
  - GC novo enviado: `566272` bytes;
  - `covers_uploaded=1`;
  - `status=UPDATED`;
- nenhum erro de metadata/capa;
- nenhuma chamada a ingest ISO.

Próxima ação física:

- executar refresh/restart do Aurora conforme orientação do job;
- aguardar o backend verificar o manifesto;
- esperado:
  - metadata -> `VERIFIED`;
  - estado -> `WAITING_FOR_AURORA_VISIBILITY`;
  - probe v3 armado;
- após prova de visibilidade:
  - job `SUCCEEDED`;
  - game `AURORA_READY`;
  - adoção persistida;
  - biblioteca `CONNECTX_READY / ADOPTED`;
  - validar visualmente a nova capa do Avatar no CoverFlow.

#### Validação física XM-07C — restart do Aurora foi suficiente para metadata/capa

Correção de interpretação baseada na sequência física real:

- após o restart do Aurora, sem reboot completo do console:
  - Avatar já apareceu visualmente com capa ilustrada;
  - o manifesto terminou de ser processado;
  - `metadata_state=VERIFIED`;
  - `cover_state=VERIFIED`;
  - `ContentID=16`;
  - job avançou para `WAITING_FOR_AURORA_VISIBILITY`;
  - probe runtime v3 ficou `ARMED`.

Evidência do processamento:

- `aurora_processing=COMPLETED`;
- `manifest=ABSENT`;
- `result=PRESENT`;
- setters de TitleName, Description, Publisher, Developer e ReleaseDate retornaram sucesso;
- `game_status=VERIFIED`;
- banco:
  `ContentID=16 TitleID=545107E1 VERIFIED Avatar TLA TBE`;
- `overall=VERIFIED`.

Conclusão:

- restart do Aurora foi suficiente para metadata e capa;
- reboot completo não foi necessário para a capa aparecer;
- reboot completo executado posteriormente serviu para concluir a prova de visibilidade runtime do QuickView e finalizar a adoção.

#### Validação física final XM-07C — APROVADA em 2026-10-04

Após reboot completo do Xbox, usando o mesmo job do Avatar:

- `job_id=e7eba4ee5d644351bba95172bb1916cd`;
- job final: `SUCCEEDED`;
- game final: `AURORA_READY`;
- `metadata_state=VERIFIED`;
- `cover_state=VERIFIED`;
- `aurora_verified=true`;
- probe:
  - `status=VERIFIED`;
  - `protocol=quickview-callback-v3`;
- log:
  - `MANUAL_CONNECTX_ADOPTED 545107E1 117FE50B`;
  - `AURORA_VISIBILITY VERIFIED source=QuickViewCallback`.

Biblioteca final:

- Avatar:
  - `state=CONNECTX_READY`;
  - `manual_connectx=true`;
  - `manual_adoption_state=ADOPTED`;
  - `manual_adoption_job_id=e7eba4ee5d644351bba95172bb1916cd`.

Store:

- `manual-adoptions.json` criado;
- chave:
  `545107E1:117FE50B`;
- fingerprint do XEX preservado;
- job de adoção persistido.

Validação visual:

- a capa ilustrada do Avatar apareceu já após restart do Aurora;
- reboot completo posterior concluiu a prova runtime e a adoção persistente.

Resultado: XM-07C aceito fisicamente e concluído.

### XM-07D — importação e normalização de pacotes Xbox 360 não-ISO/não-XEX — IMPLEMENTADO / VALIDAÇÃO ESTÁTICA PENDENTE

Motivação real:

- alguns jogos rodam no Xenia a partir de um único arquivo/container, mas não aparecem no Aurora/ConnectX porque não possuem `default.xex` exposto;
- caso de validação: `The Legend of Korra`, formato não-XEX, jogável no Xenia Edge no Mac, mas invisível ao scan/restart do Aurora.

Objetivo:

- detectar o formato real do arquivo;
- quando suportado, normalizá-lo para uma árvore executável pelo fluxo ConnectX;
- nunca assumir formato pela extensão;
- preservar sempre o arquivo original.

Detecção inicial planejada:

- ISO Xbox 360;
- XEX/tree;
- pacote STFS:
  - `LIVE`;
  - `PIRS`;
  - `CON`;
- `UNKNOWN/UNSUPPORTED` para formatos ainda não reconhecidos.

Regras:

- identificação por magic/estrutura interna, não por nome/extensão;
- extração sempre em staging temporário;
- validar o resultado antes de publicar no ConnectX;
- publicação final atômica;
- origem nunca é alterada;
- se a extração não produzir `default.xex` válido, não publicar;
- não copiar automaticamente pacote desconhecido para o HDD interno do Xbox;
- não declarar compatibilidade com ConnectX apenas porque Xenia consegue abrir o arquivo.

Pipeline esperado para pacote suportado:

```text
arquivo/container
    -> detectar formato
    -> extrair em staging
    -> localizar default.xex
    -> validar XEX
    -> obter TitleID + MediaID
    -> publicar no ConnectX
    -> XM-07C adoção
    -> Aurora scan
    -> metadata/capa
    -> probe runtime
    -> AURORA_READY
```

Dependências:

- antes da implementação, escolher uma biblioteca/ferramenta de extração STFS adequada ao macOS arm64;
- ferramenta deve ser auditável, automatizável e utilizável sem GUI;
- se não houver dependência aceitável, manter o formato como detectado porém não suportado em vez de usar conversão insegura.

#### Implementação XM-07D — 2026-10-04

Dependência escolhida:

- `xverter==1.5.0`;
- projeto MIT;
- Python 3.9+;
- CLI;
- distribuição macOS Apple Silicon disponível;
- suporte STFS LIVE/PIRS/CON;
- leitor segue cadeias de blocos e valida hash tree;
- versão diferente de 1.5.0 encontrada no ambiente é recusada.

Nova raiz dedicada:

- `/Users/Shared/xbox360-packages`.

Compatibilidade com arquivos existentes:

- filhos diretos não-.iso da raiz de ISOs também são inspecionados;
- arquivos diretos no ConnectX legado também são inspecionados;
- pastas ConnectX que não pertencem a um XEX válido são inspecionadas
  com profundidade limitada;
- pastas de jogos XEX já válidos são protegidas da varredura de pacote.

Detecção:

- por magic/estrutura, nunca por extensão;
- STFS:
  - `LIVE`;
  - `PIRS`;
  - `CON `;
- XDVDFS/ISO é reconhecido e encaminhado conceitualmente ao pipeline de
  ISO já existente, sem conversão pelo XM-07D;
- XEX isolado é reconhecido, mas não publicado como árvore;
- formato desconhecido fica `UNKNOWN / normalizable=false`.

Normalização STFS:

1. UI envia apenas `package_id`;
2. backend reconcilia esse ID com descoberta/fingerprint atuais;
3. origem é revalidada por device/inode/size/mtime_ns;
4. extração ocorre em
   `/Users/Shared/.xbox360-connectx-staging/packages`;
5. `xverter convert <source> -o <staging>/extracted/`;
6. resultado deve conter exatamente um `default.xex` válido;
7. XEX fornece TitleID + MediaID;
8. identidade do header STFS é conferida quando presente;
9. identidade já existente retorna `ALREADY_PRESENT`;
10. árvore é copiada para
    `.xboxmac-package-<uuid>` dentro do ConnectX;
11. XEX da cópia é revalidado;
12. publicação final usa rename atômico no mesmo filesystem;
13. árvore publicada é redescoberta pelo scanner live;
14. origem é revalidada e nunca movida, renomeada ou apagada;
15. staging é removido.

Integração com XM-07C:

- após publicação, a Biblioteca classifica o XEX como
  `MANUAL_CONNECTX_UNADOPTED`;
- `POST /api/packages/prepare` cria automaticamente o job XM-07C;
- usuário não precisa selecionar novamente o jogo na Automação;
- metadata, capa, Aurora e probe runtime reutilizam o fluxo já aceito.

API/UI:

- `GET /api/packages`;
- `POST /api/packages/prepare`;
- painel `Pacotes Xbox 360`;
- ação `Normalizar / Preparar selecionado`;
- nenhuma entrada de path arbitrário pelo navegador.

Arquivos principais:

- `backend/server/xboxmac/package_import.py`;
- `backend/server/xboxmac/app.py`;
- `backend/contracts/defaults.json`;
- `backend/server/requirements.txt`;
- `backend/server/tests/test_xm07d_packages.py`;
- `scripts/verify-xm07d.py`;
- `docs/XM-07D.md`.

O pipeline congelado `connectx-v1.0.0` não foi alterado.

Validação estática necessária:

```text
git pull
.venv/bin/python -m pip install -r backend/server/requirements.txt
.venv/bin/python scripts/verify-xm07.py
.venv/bin/python scripts/verify-xm07c.py
.venv/bin/python scripts/verify-xm07d.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Validação estática concluída no Mac físico em 2026-10-04:

- `scripts/verify-xm07d.py` retornou `XM-07D: STATIC_OK`;
- suíte completa do backend: 91/91 testes aprovados;
- correção aplicada no teste para a canonização macOS `/var` -> `/private/var`;
- `korra_physical` permanece `PENDING`;
- correção adicional validada para localizar `xverter` dentro da virtualenv no macOS;
- suíte após essa correção: 92/92 testes aprovados;
- inventário físico atual mostra apenas `.DS_Store` e `CX-01-READY.txt` como candidatos `UNKNOWN`; o arquivo real do Korra ainda não está dentro da profundidade/caminho atualmente alcançado pelo detector.

#### Validação física XM-07D — normalização real do Korra

Evidência obtida em 2026-10-04:

- detecção física:
  - `format=STFS`;
  - `subtype=LIVE`;
  - `TitleID=58411447`;
  - `MediaID=41E4449D`;
  - `normalizable=true`;
- suíte após correção de profundidade/filtro de housekeeping:
  `94/94` testes aprovados;
- origem:
  `/Users/Shared/xbox360-connectx/The Legend of Korra/58411447/000D0000/6681F6A8D4443C7A1DB9AA844200B3DB644BC4DF58`;
- baseline e pós-normalização idênticos:
  - SHA-256:
    `000039444e7c3049aed3fcdf6b6e650f166c0a71c7ce2d685ebc9838939588c9`;
  - tamanho: `1928855552` bytes;
  - inode: `4066957`;
  - mtime: `1414103522`;
- preparação real:
  - HTTP `202`;
  - `action=NORMALIZED`;
  - `source_preserved=true`;
- árvore publicada:
  `/Users/Shared/xbox360-connectx/The Legend of Korra [58411447-41E4449D]`;
- tamanho publicado: `1916401362` bytes;
- SHA-256 do `default.xex`:
  `79dfa5a66a93154b8139946336c55983e3ca6dc5ebf56a45bf46a48336ae3230`;
- Biblioteca:
  - `MANUAL_CONNECTX_UNADOPTED`;
  - `manual_connectx=true`;
  - `manual_adoption_state=UNADOPTED`;
- job XM-07C criado automaticamente:
  `4dbd2ed03850447b996f17964ffedf7f`;
- a consulta imediatamente posterior a `scope=active` não listou jobs;
  antes de avançar é necessário consultar esse job específico e registrar
  seu estado terminal/erro.

#### XM-07D — falha de metadata do Korra e correção

O primeiro job automático após a normalização real falhou em
`METADATA`:

- job:
  `4dbd2ed03850447b996f17964ffedf7f`;
- XEX:
  `58411447 / 41E4449D`;
- erro:
  `MediaID 41E4449D não encontrado no metadata`.

Interpretação:

- identidade binária do jogo estava válida;
- o x360db possuía o registro por TitleID, mas não essa variante de MediaID;
- o helper legado tratava ausência do MediaID como erro fatal embora os
  campos usados de título/descrição/publisher/developer/data/artwork fossem
  de nível de TitleID.

Correção:

- TitleID divergente continua sendo erro;
- MediaID ausente passa a `metadata_scope=TITLE_ONLY`;
- metadata/artwork de nível de título podem ser preparados;
- edição/região ficam nulas;
- nenhum MediaID alternativo é adotado;
- teste de regressão adicionado ao XM-07D.

#### XM-07D — fallback validado e aguardando scan do Aurora

Job após a correção de metadata:

- `job_id=0bb08d0df50d41a3833d740eb418b839`;
- `MANUAL_CONNECTX_VALID 58411447 41E4449D`;
- nenhum novo erro de MediaID;
- estado:
  `WAITING_FOR_AURORA_SCAN`;
- erro:
  `null`;
- ação física requerida:
  Rescan do caminho ConnectX no Aurora;
- o mesmo job deve retomar automaticamente quando o jogo aparecer no
  catálogo do Aurora.

#### XM-07D — Korra indexado no Aurora e assets preparados

Após o Rescan do caminho ConnectX:

- job:
  `0bb08d0df50d41a3833d740eb418b839`;
- Aurora content.db passou de 16 para 17 itens;
- Korra:
  - `ContentID=17`;
  - `TitleID=58411447`;
  - `MediaID=41E4449D`;
- metadata:
  - estado `MANIFEST_PENDING`;
  - manifesto enviado;
  - campos pendentes:
    `Description, Publisher, Developer, ReleaseDate`;
- capa:
  - placeholder remoto anterior de 2048 bytes;
  - nova capa de 566272 bytes enviada;
  - `cover_state=VERIFIED`;
- job:
  `WAITING_FOR_AURORA_REFRESH`;
- próximo passo:
  restart/reload do Aurora; reboot completo do console ainda não é
  necessário nesta etapa.

#### XM-07D — Korra preparado após reboot; aguardando prova runtime

Após reboot completo do Xbox:

- job:
  `0bb08d0df50d41a3833d740eb418b839`;
- estado:
  `WAITING_FOR_AURORA_VISIBILITY`;
- `ContentID=17`;
- metadata:
  `VERIFIED`;
- capa:
  `VERIFIED`;
- resultado de metadata v3:
  `overall=VERIFIED`;
- QuickView probe:
  - `ARMED`;
  - `quickview-callback-v3`;
- não houve teste isolado de restart/reload simples do Aurora nesta etapa;
- não registrar restart simples como suficiente;
- próximo passo: selecionar o Korra no Aurora para o QuickView observar a identidade e testar a execução do jogo.

Depois da validação estática, o teste físico usa o arquivo real de
`The Legend of Korra` já existente:

1. confirmar local onde o detector o encontrou;
2. confirmar formato/magic real;
3. sendo STFS, confirmar subtipo LIVE/PIRS/CON;
4. normalizar pelo painel;
5. confirmar arquivo original preservado;
6. confirmar XEX válido publicado;
7. confirmar job XM-07C criado automaticamente;
8. completar Aurora/probe;
9. testar o jogo no Xbox;
10. aceitar XM-07D somente após `AURORA_READY / ADOPTED`.

#### Validação física final XM-07D — APROVADA em 2026-10-04

The Legend of Korra concluiu o fluxo completo:

- container STFS/LIVE detectado sem depender de extensão;
- origem preservada byte-for-byte;
- árvore XEX publicada e validada;
- TitleID `58411447`;
- MediaID `41E4449D`;
- `ContentID=17`;
- metadata e capa verificadas;
- QuickView callback v3 verificou a presença runtime;
- job final:
  `0bb08d0df50d41a3833d740eb418b839 = SUCCEEDED`;
- game final:
  `AURORA_READY`;
- Biblioteca:
  `CONNECTX_READY / ADOPTED`;
- confirmação física do usuário:
  jogo visível, capa correta, informações corretas e execução do jogo bem-sucedida;
- não houve teste isolado de restart simples do Aurora nessa etapa:
  o avanço final foi observado após reboot completo do Xbox.

Resultado: **XM-07D aceito e encerrado.**

### XM-07D.1 — identificação assistida e metadata manual — ACEITO / CONCLUÍDO

Objetivo de UX:

- quando o arquivo/container não fornecer identificação suficiente, permitir ao usuário complementar os dados no próprio painel;
- ajudar a busca de metadata/capa;
- nunca usar entrada manual para mascarar formato incompatível.

Implementação:

- novo store persistente:
  `/usr/local/var/xbox-connectx/package-overrides.json`;
- schema:
  `xboxmac-package-overrides-v1`;
- gravação atômica;
- chave primária por path + fingerprint;
- após identidade forte, correlação adicional por
  `TitleID + MediaID`;
- para jogos já normalizados, salvar um override pode vincular a entrada
  a uma árvore ConnectX XEX já validada com a mesma identidade
  (`source=XEX_EXISTING`);
- após nova normalização, `POST /api/packages/prepare` vincula
  automaticamente a entrada à identidade XEX antes de criar o job XM-07C.

Proveniência por campo:

- `DETECTED`;
- `CATALOG`;
- `MANUAL`.

Regras de prioridade:

- TitleID/MediaID detectados pelo binário vencem sempre;
- conflito manual/catálogo é mostrado como
  `DETECTED_WINS`;
- IDs manuais só são efetivos quando não existe identidade técnica;
- valores manuais descritivos vencem catálogo;
- nenhuma edição de metadata altera `supported` ou `normalizable`.

Formulário:

- item não normalizável também pode ser selecionado;
- ação:
  `Identificar / editar metadata`;
- campos:
  - origem somente leitura;
  - Nome;
  - TitleID;
  - MediaID;
  - tipo/content type detectado;
  - Região;
  - Edição;
  - Ano;
  - Publisher;
  - Developer;
  - Observações;
  - Título para busca de capa;
- proveniência é exibida na UI;
- conflitos ficam visíveis;
- botão `Normalizar / Preparar` continua bloqueado logicamente quando
  `normalizable=false`.

Busca assistida:

- x360db `games.json` como índice;
- `titles/{TitleID}/info.json` para detalhe;
- busca por:
  - TitleID exato;
  - título exato;
  - prefixo;
  - substring;
- sem fuzzy match silencioso;
- `selection_required=true` sempre;
- candidatos mostram TitleID, MediaIDs e capa;
- usuário precisa acionar `Usar este candidato`;
- MediaID não é escolhido automaticamente entre variantes.

API:

- `GET /api/packages/{package_id}/metadata`;
- `PUT /api/packages/{package_id}/metadata`;
- `GET /api/packages/{package_id}/metadata/search`;
- `POST /api/packages/{package_id}/metadata/catalog`.

Integração Aurora:

- helper estendido:
  `backend/connectx/xboxmac-stage-assets`;
- lê apenas overrides vinculados à mesma identidade forte
  `TitleID + MediaID`;
- pode aplicar nome/publisher/developer manuais e registrar
  região/edição/ano/notas/título de busca no staging;
- a identidade técnica nunca vem do store.

Preservação do baseline:

- `backend/connectx/xbox-connectx-stage-assets` foi restaurado exatamente
  ao blob congelado `7d01cff377581add9a9d30f33fd48e5f5080b86d`;
- as extensões XM-07D/D.1 vivem em
  `backend/connectx/xboxmac-stage-assets`;
- na validação física, o helper estendido é instalado como
  `/usr/local/libexec/xbox-connectx-stage-assets`, preservando o contrato
  do helper legado sem alterar o baseline versionado.

Testes adicionados:

- UNKNOWN com metadata manual continua não normalizável;
- store persiste entre leituras;
- conflito de identidade mantém DETECTED;
- busca por nome não auto-seleciona;
- catálogo não sobrescreve valores manuais;
- catálogo conflitante é recusado;
- bind de identidade XEX persiste;
- override pode ser vinculado a XEX ConnectX já existente;
- staging aplica somente override vinculado;
- rotas/formulário existem.

Validação estática:

```text
.venv/bin/python scripts/verify-xm07d.py
.venv/bin/python scripts/verify-xm07d1.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Suíte esperada:

- 104 testes.

Validação estática aprovada em 2026-10-04:

- `XM-07D: STATIC_OK`;
- `korra_physical=PASSED`;
- `XM-07D.1: STATIC_OK`;
- suíte backend: `104/104` testes aprovados;
- próximo passo: validação física com arquivo UNKNOWN inofensivo.

Evidência física parcial em 2026-10-04:

- fixture UNKNOWN abriu no formulário;
- overrides manuais foram salvos;
- API confirmou `UNKNOWN / supported=false / normalizable=false`;
- proveniência dos campos preenchidos: `MANUAL`;
- store persistente criado corretamente;
- feedback de acessibilidade: o formulário diagnóstico original estava
  visualmente difícil para baixa visão;
- UI diagnóstica ajustada com fonte 22 px, controles 56 px, foco/bordas
  reforçados, radios maiores, capa maior e proveniência em linhas;
- restante da validação passa a ter caminho equivalente por Terminal
  através de `scripts/physical-xm07d1.py`, sem exigir inspeção visual.

Gate físico XM-07D.1:

- item desconhecido pode ser aberto no formulário;
- usuário complementa nome/IDs/dados;
- dados sobrevivem a restart do backend;
- busca de capa usa os dados complementares;
- múltiplos resultados exigem escolha explícita;
- conflito de identidade não é aplicado silenciosamente;
- nenhuma edição manual transforma arquivo tecnicamente incompatível em
  `AURORA_READY`;
- override vinculado a um XEX existente pode alimentar o staging sem
  alterar TitleID/MediaID.

Validação física final aprovada em 2026-10-04:

- busca de catálogo retornou Korra com capa;
- nenhuma seleção automática ocorreu;
- escolha do TitleID foi explícita;
- UNKNOWN permaneceu não normalizável;
- normalização de UNKNOWN foi recusada;
- conflito de identidade resultou em `DETECTED_WINS`;
- overrides sobreviveram ao restart do backend;
- compatibilidade técnica permaneceu inalterada.

Resultado: **XM-07D.1 aceito e encerrado.**

### XM-08 — launcher macOS e atalhos de operação no Finder — ACEITO / CONCLUÍDO

Objetivo:

- `XboxMac.app`;
- iniciar/encontrar backend;
- `ensure_ready`;
- abrir navegador;
- não exigir Terminal no uso cotidiano.

Implementação do launcher:

- instalador:
  `scripts/install-xboxmac-app.sh`;
- destino:
  `~/Applications/XboxMac.app`;
- bundle:
  - `Contents/Info.plist`;
  - `Contents/MacOS/XboxMac`;
  - `Contents/Resources/runtime-root.txt`;
- runtime operacional:
  `~/Library/XboxMac/runtime`;
- health check:
  `GET http://127.0.0.1:8742/healthz`;
- backend saudável é reutilizado sem restart;
- backend ausente é iniciado por:
  `.venv/bin/python -m backend.server.xboxmac.cli`;
- readiness é delegada a:
  `POST /api/connections/ensure`;
- painel aberto em:
  `http://127.0.0.1:8742`;
- log do backend iniciado pelo app:
  `~/Library/Logs/XboxMac/xboxmacd.log`;
- launcher não usa `sudo`, `kill`, `pkill` ou `killall`.

#### Atalhos no painel web

Área:

- `Arquivos`, próxima ao topo e separada das ações destrutivas.

Botões:

- `Abrir pasta de ISOs`;
- `Abrir pasta de jogos XEX / ConnectX`;
- `Abrir Lixeira`.

Endpoints explícitos:

- `POST /api/files/open-isos`;
- `POST /api/files/open-connectx`;
- `POST /api/files/open-trash`.

Não existe rota genérica com path arbitrário.

Destinos:

- ISO:
  `/Users/Shared/xbox360`;
- ConnectX:
  `/Users/Shared/xbox360-connectx`;
- Lixeira:
  `~/.Trash`.

Serviço:

- `backend/server/xboxmac/finder.py`;
- usa somente `/usr/bin/open <destino-fixo>`;
- não cria destino ausente;
- não move/exclui arquivo;
- não esvazia a Lixeira;
- não altera jobs ou Aurora;
- resposta inclui `destructive=false`.

Acessibilidade:

- reutiliza padrão ampliado do XM-07D.1:
  fonte-base 22 px, controles 56 px e foco forte;
- botões usam texto completo e não dependem de ícones.

Validação estática planejada:

```text
.venv/bin/python scripts/verify-xm08.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Primeira tentativa física do launcher:

- falha ao iniciar backend;
- `/healthz` indisponível;
- nenhum processo xboxmacd;
- log:
  `PermissionError: Operation not permitted` ao ler
  `~/Documents/.../.venv/pyvenv.cfg`;
- causa: runtime de desenvolvimento em Documents bloqueado para o
  processo gráfico iniciado pelo Finder.

Correção aplicada:

- runtime operacional instalado em
  `~/Library/XboxMac/runtime`;
- `backend/` + `.venv/` copiados na instalação;
- shebangs dos console scripts da virtualenv copiada são reescritos;
- launcher não acessa Documents depois de instalado;
- segundo health check antes de abrir o navegador.

Segunda tentativa física do launcher:

- runtime fora de Documents iniciou corretamente;
- health check respondeu 200;
- ensure respondeu 200;
- frontend respondeu 200;
- backend encerrou aproximadamente um segundo depois junto com o processo
  do app;
- comportamento reproduzido duas vezes.

Correção:

- substituir `nohup &` por LaunchAgent de usuário;
- plist:
  `~/Library/LaunchAgents/io.remappingbridge.xboxmacd.plist`;
- `RunAtLoad=false`;
- instalador faz `launchctl bootstrap`;
- app faz `launchctl kickstart` apenas quando necessário;
- ciclo de vida do backend passa a ser independente do launcher gráfico.

Terceira tentativa física do launcher:

- backend previamente parado;
- app aberto pelo Finder;
- frontend abriu no navegador;
- health check permaneceu `ok` após o launcher terminar;
- LaunchAgent `io.remappingbridge.xboxmacd` permaneceu
  `state=running`;
- PID observado: `5607`;
- ciclo de vida independente do app: aprovado;
- pendente: atalhos Finder + validação estática final.

Gate físico XM-08:

- instalar o app;
- desligar backend manual;
- abrir `XboxMac.app` pelo Finder;
- backend iniciar sem Terminal;
- navegador abrir automaticamente;
- abrir o app novamente com backend saudável sem duplicar processo;
- abrir ISO, ConnectX e Lixeira pelos botões;
- confirmar que nenhuma ação de abertura modifica arquivos;
- após a instalação, operação cotidiana sem Terminal.

Validação final aprovada em 2026-10-04:

- `XM-08: STATIC_OK`;
- suíte backend `111/111 OK`;
- app iniciou backend desligado sem Terminal;
- frontend abriu automaticamente;
- backend persistiu via LaunchAgent após o launcher encerrar;
- segunda abertura reutilizou o mesmo PID `5607`;
- atalhos ISO/ConnectX/Lixeira retornaram `opened`;
- todos retornaram `destructive=false`.

Resultado: **XM-08 aceito e encerrado.**

Robustez pós-gate:

- reinstalação do app não executa mais `bootout + bootstrap` quando
  o LaunchAgent já está registrado;
- isso elimina o falso `Bootstrap failed: 5` observado durante XM-09;
- bootstrap só ocorre quando o job está ausente e o resultado é
  verificado explicitamente.

Validação da autocorreção em 2026-10-04:

- `XM-08: STATIC_OK`;
- suíte backend `117/117 OK`;
- `/healthz = ok`;
- `io.remappingbridge.xboxmacd` voltou a `state=running`;
- PID observado: `6389`;
- auto-bootstrap do LaunchAgent: validado fisicamente.


- durante o início do XM-09 foi observado plist presente com LaunchAgent
  ausente do domínio `gui/<uid>`;
- launcher passa a fazer auto-`bootstrap` do
  `io.remappingbridge.xboxmacd` quando necessário;
- em seguida valida o job e executa `kickstart`;
- perda transitória do registro não exige reinstalação manual.

### Observação operacional para XM-09 — interface privada após desconexão prolongada

Detectado em uso real: após horas com o equipamento/ligação Ethernet
indisponível, a interface configurada como `en7` deixou de existir no
macOS. Os serviços launchd continuaram `running`, mas
NetISO/Samba/NetBIOS ficaram sem sockets úteis em `192.168.50.1`.

### XM-09 — scheduler e robustez — ACEITO / CONCLUÍDO

Escopo completo continua:

- reconciliação periódica;
- estabilidade de arquivo;
- Xbox offline;
- Mac sem Internet;
- cache;
- retries;
- logs;
- locks;
- recuperação após reboot.

A primeira etapa implementada trata o incidente real de rede antes de
avançar para os demais itens.

#### Identidade persistente da interface

O contrato deixa de considerar `en7` como identidade primária.

Nova identidade:

- network service macOS:
  `USB 10/100 LAN`;
- `en7` permanece apenas como fallback histórico.

O backend resolve dinamicamente o Device através de:

```text
networksetup -listnetworkserviceorder
```

Exemplos aceitos:

```text
USB 10/100 LAN -> en7
USB 10/100 LAN -> en9
USB 10/100 LAN -> en12
```

Fallback adicional:

- se o lookup do serviço falhar, localizar a interface que já contém
  `192.168.50.1`.

O status passa a expor:

- `configured_interface`;
- `network_service`;
- `service_device`;
- `ip_device`;
- `resolved_interface`;
- `resolution_source`;
- `renumbered`.

#### Reconciliador root periódico

Helper:

```text
/usr/local/libexec/xboxmac-network-reconcile
```

Fonte:

```text
backend/system/xboxmac-network-reconcile
```

LaunchDaemon:

```text
io.remappingbridge.xboxmac-network-reconcile
```

Periodicidade:

```text
30 segundos
```

O helper tem escopo fixo e não aceita argumentos vindos da UI.

Contrato congelado:

- service:
  `USB 10/100 LAN`;
- Mac:
  `192.168.50.1/24`;
- gateway configurado:
  `0.0.0.0`;
- DNS:
  vazio.

Se o IP desaparecer:

1. reaplicar configuração manual no service;
2. resolver novamente o Device atual;
3. aguardar `192.168.50.1`;
4. recuperar serviços vinculados à rede.

Se o adaptador/link estiver ausente:

- registrar estado;
- não reiniciar serviços continuamente;
- nova tentativa acontece no próximo intervalo.

#### Daemon running mas socket ausente

A reconciliação não confia somente em `launchctl state=running`.

Também valida:

- NetISO TCP 4323;
- Samba TCP 139;
- Samba TCP 445;
- nmbd UDP 137/138.

Se somente um serviço perdeu seu socket:

- aplicar `launchctl kickstart -k` somente naquele job.

Serviços saudáveis não sofrem restart forçado.

#### Wrapper ConnectX sem en7

Novo wrapper versionado:

```text
backend/system/xbox-connectx-samba
```

Ele espera:

```text
qualquer interface com 192.168.50.1
```

e não um BSD name específico.

Preservado:

- `samba-dot-org-smbd -F --no-process-group`;
- `nmbd -F --no-process-group`;
- config dedicada Samba.

O instalador preserva uma cópia única do wrapper anterior em:

```text
/usr/local/libexec/xbox-connectx-samba.pre-xm09
```

#### Instalação privilegiada separada

Script:

```text
scripts/install-xm09-network-reconciler.sh
```

Somente esse instalador usa sudo.

`XboxMac.app` e `xboxmacd` continuam sem root.

Instalados:

- `/usr/local/libexec/xboxmac-network-reconcile`;
- `/usr/local/libexec/xbox-connectx-samba`;
- `/Library/LaunchDaemons/io.remappingbridge.xboxmac-network-reconcile.plist`;
- log:
  `/Library/Logs/XboxMac/network-reconcile.log`.

#### Validação

Estática:

```text
.venv/bin/python scripts/verify-xm09.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Teste físico:

```text
.venv/bin/python scripts/physical-xm09-network.py before
```

Depois desconectar a ligação Ethernet/docking, aguardar mais de 30 s,
reconectar, aguardar até 45 s e executar:

```text
.venv/bin/python scripts/physical-xm09-network.py after
```

Critério desta etapa:

- interface resolvida dinamicamente;
- `192.168.50.1` presente;
- link ativo;
- NetISO UP;
- Samba UP;
- NetBIOS UP;
- `XM-09 NETWORK_RECOVERY_OK`;
- nenhuma intervenção manual para restaurar IP/serviços.

Depois da aceitação desta etapa, prosseguir automaticamente com os
demais itens do XM-09: estabilidade de arquivos, offline/cache,
retries/locks e recuperação final pós-reboot.

Evidência física parcial da etapa de rede — 2026-10-04:

- estado antes: Ethernet/NetISO/Samba/Xbox/Aurora FTP `up`;
- após remover a docking, reconciliador registrou
  `SET_MANUAL / WAITING_FOR_IP`;
- após reconectar, sem reparo manual, voltou a:
  `READY ... en7 ... 192.168.50.1`;
- recuperação IPv4 automática: **aprovada**;
- NetBIOS ficou inconclusivo por probe do backend não localizar
  `nmblookup` Homebrew no PATH mínimo do LaunchAgent;
- correção aplicada:
  lookup Homebrew absoluto + fallback UDP 137/138 separado + check root
  exigindo ambos os sockets;
- gate de rede permanece pendente somente até repetir a confirmação com
  o probe corrigido.

Etapa de rede aceita em 2026-10-04:

- ciclo real docking off/on executado;
- reconciliador registrou
  `SET_MANUAL -> WAITING_FOR_IP -> READY`;
- retorno sem comando manual;
- Ethernet/NetISO/Samba/NetBIOS/Xbox/Aurora FTP todos `up`;
- `XM-09 NETWORK_RECOVERY_OK`;
- próxima etapa: estabilidade de arquivo, offline/cache, retries e locks.


#### Etapa 2 — robustez do scheduler — IMPLEMENTADA / VALIDAÇÃO PENDENTE

Estabilidade de ISO:

- novo estado:
  `WAITING_FOR_FILE_STABILITY`;
- tamanho + mtime precisam permanecer iguais por duas observações;
- intervalo de produção: 5 s;
- se o arquivo muda, observação reinicia;
- fingerprint estável substitui o snapshot feito na submissão;
- ingest não começa sobre arquivo ainda em cópia.

Duplicidade:

- job não-terminal passa a bloquear nova submissão para o mesmo alvo;
- chave ISO:
  path canônico;
- XEX:
  `game_id` ou SHA-256;
- jobs terminais não bloqueiam nova execução.

Offline:

- comportamento existente `WAITING_FOR_XBOX` permanece recuperável;
- ingest local não exige Xbox online;
- metadata/capa aguardam Aurora FTP;
- cache de `xboxmac-stage-assets` é reutilizado quando metadata/artwork
  já existem localmente;
- conteúdo externo não cacheado pode continuar exigindo Internet.

Retries:

- metadata/capa/status remoto:
  até 3 tentativas;
- backoff exponencial;
- códigos semânticos Aurora 3/4 não são tratados como falha;
- cada retry é registrado no log do job.

Lock:

- `WorkerLease` baseado em `flock`;
- path:
  `<state_root>/xboxmac-worker.lock`;
- somente um worker pode executar pipeline por vez mesmo se dois backends
  forem iniciados acidentalmente.

Restart:

- `WAITING_FOR_FILE_STABILITY` é retomável;
- após restart:
  `QUEUED + RECOVERED_AFTER_BACKEND_RESTART`;
- contrato XM-07 preservado:
  `WAITING_FOR_AURORA_VISIBILITY` não é re-enfileirado;
- o waiter de visibilidade permanece no próprio estado e continua pelo
  reconciliador específico, sem repetir ingest/metadata/capa.

Teste seguro:

```text
.venv/bin/python scripts/physical-xm09-scheduler.py
```

Ele usa somente diretório temporário e valida:

- arquivo mudando antes de estabilizar;
- rejeição de job duplicado;
- retry com sucesso na terceira tentativa;
- exclusão mútua do worker;
- recuperação de `WAITING_FOR_FILE_STABILITY` após restart;
- preservação do waiter XM-07 de visibilidade;
- contrato offline do Xbox;
- cache-first de assets.


Etapa 2 aceita em 2026-10-04:

- `XM-09: STATIC_OK`;
- suíte backend `128/128 OK`;
- `XM-09 SCHEDULER_ROBUSTNESS_OK`;
- ISO em cópia esperou estabilidade;
- job ativo duplicado recusado;
- retry transitório recuperou na terceira tentativa;
- worker lock exclusivo;
- `WAITING_FOR_FILE_STABILITY` recuperado após restart;
- Xbox offline permanece wait-state recuperável;
- cache de assets confirmado cache-first;
- contrato XM-07 de `WAITING_FOR_AURORA_VISIBILITY` preservado;
- runtime do app reinstalado após a validação.

Próximo e último gate do XM-09:

- reboot real do Mac;
- login normal;
- abrir `XboxMac.app`;
- nenhum comando de reparo;
- backend e serviços voltam ao estado operacional;
- jobs persistidos permanecem coerentes.

#### Etapa 3 — gate final de reboot — IMPLEMENTADA / TESTE REAL PENDENTE

Verificador:

```text
scripts/physical-xm09-reboot.py
```

Fase `before` registra:

- `kern.boottime`;
- componentes `up/down`;
- IDs dos jobs persistidos;
- presença do LaunchAgent xboxmacd;
- presença do LaunchDaemon do reconciliador.

Marker:

```text
~/Library/XboxMac/xm09-reboot-marker.json
```

Procedimento:

1. executar `before`;
2. reboot real do Mac;
3. login normal;
4. nenhum comando de reparo;
5. abrir `XboxMac.app`;
6. executar `after` apenas como diagnóstico.

O `after` exige:

- novo boot detectado;
- backend saudável;
- LaunchAgent xboxmacd carregado;
- reconciliador root carregado;
- Ethernet/NetISO/Samba/NetBIOS `up`;
- continuidade de Xbox/Aurora FTP se estavam `up` antes;
- nenhum job persistido desaparecido;
- `manual_repair_commands=NONE`.

Resultado esperado:

```text
XM-09 REBOOT_RECOVERY_OK
```


Validação final XM-09 aprovada em 2026-10-04:

- reboot real concluído;
- `XM-09 REBOOT_RECOVERY_OK`;
- backend saudável após abrir o app;
- reconciliador root carregado;
- Ethernet/NetISO/Samba/NetBIOS/Xbox/Aurora FTP todos `up`;
- 7 jobs persistidos preservados;
- nenhum comando manual de reparo.

Resultado: **XM-09 aceito e encerrado.**

Gate final XM-09: **APROVADO — operação cotidiana sem terminal.**

### XM-10 — remoção do catálogo Aurora — IMPLEMENTADO / VALIDAÇÃO ESTÁTICA E FÍSICA PENDENTES

Gate separado e opcional.

Objetivo:

- remover somente entradas antigas do catálogo Aurora;
- nunca reutilizar a exclusão local de ISO/ConnectX;
- backup obrigatório;
- transação;
- integrity check;
- rollback;
- confirmação explícita;
- confirmação visual no Aurora.

#### Escopo restrito

Uma entrada só é candidata quando:

- TitleID + MediaID pertencem ao histórico gerenciado pelo XboxMac:
  `ingest-state.json` ou `catalog.json`;
- a identidade não existe mais no ConnectX real;
- a linha ainda existe em `ContentItems`.

Entradas do Aurora nunca gerenciadas pelo XboxMac não são oferecidas.

ConnectX ainda presente torna a entrada inelegível.

#### Serviço backend

Arquivo:

```text
backend/server/xboxmac/aurora_catalog_delete.py
```

Descoberta:

```text
GET /api/aurora/catalog/stale
```

Plano:

```text
POST /api/aurora/catalog/remove/plan
```

O plan_id vincula:

- candidate_id;
- ContentID;
- TitleID;
- MediaID;
- título;
- diretório GameData;
- SHA-256 do content.db;
- SHA-256 do SQL interno de rollback.

Execução:

```text
POST /api/aurora/catalog/remove/execute
```

Status:

```text
GET /api/aurora/catalog/remove/status/{plan_id}
```

Rollback:

```text
POST /api/aurora/catalog/remove/rollback
```

A API do navegador não aceita:

- path;
- SQL;
- ContentID arbitrário;
- nome de tabela.

#### Backup

Mac:

```text
/usr/local/var/xbox-connectx/aurora-delete-backups/<plan_id>/
```

Inclui:

- content.db;
- plan.json;
- manifesto usado;
- SQL de rollback somente no backup interno.

Xbox:

```text
game:\User\Scripts\XboxMacDeleteBackup\<plan_id>
```

Inclui:

- cópia de content.db;
- cópia do GameData associado quando ele existe.

Se assets existem e o backup dos assets falha, a exclusão é recusada.

#### Processamento dentro do Aurora

Processador XM-10 isolado:

```text
aurora/User/Scripts/Content/Filters/ZZXboxMacCatalogDelete.lua
```

Baseline preservado:

```text
aurora/User/Scripts/Content/Filters/XboxMacProbe.lua
```

permanece byte-for-byte igual ao `connectx-v1.0.0`.

Manifesto:

```text
/Hdd1/Apps/Aurora/User/Scripts/xboxmac-delete.manifest
```

Fluxo:

1. validar ContentID/TitleID/MediaID;
2. backup;
3. `BEGIN IMMEDIATE`;
4. DELETE exato em ContentItems;
5. SELECT confirma ausência;
6. remover GameData associado;
7. `COMMIT`;
8. em falha: `ROLLBACK` + restauração de assets quando necessário.

O desenho acompanha o mecanismo usado pelo Database Cleaner oficial do
Aurora, acrescentando as garantias do XboxMac.

#### Verificação

Só considerar removido quando:

- resultado Lua contém `status=VERIFIED`;
- plan_id coincide;
- content.db recém-baixado passa:
  `PRAGMA integrity_check = ok`;
- ContentID está ausente;
- diretório GameData associado está ausente.

#### Rollback

O navegador fornece somente plan_id.

O backend recupera o SQL original exclusivamente do backup local.

O Lua:

- inicia transação;
- reinsere a linha original;
- verifica a identidade;
- faz commit;
- restaura assets do backup Xbox.

#### UI

Nova seção separada:

```text
Catálogo Aurora
```

Ações:

- `Procurar entradas antigas`;
- `Remover entrada antiga do Aurora`;
- `Consultar status`;
- `Rollback`.

A confirmação mostra TitleID, MediaID e ContentID e deixa explícito que
ISO/ConnectX locais não serão removidos.

#### Instalação do filtro

Script:

```text
scripts/install-xm10-aurora-probe.py
```

Ele:

- baixa a versão instalada;
- cria backup local com SHA-256;
- envia a nova versão;
- relê por FTP;
- exige igualdade byte-for-byte.

Após instalação:

```text
next=XBOX_POWER_CYCLE_REQUIRED
```

#### Validação

Estática:

```text
.venv/bin/python scripts/verify-xm10.py
.venv/bin/python -m unittest discover -s backend/server/tests -v
```

Helper físico:

```text
scripts/physical-xm10.py
```

Primeiro passo é estritamente não destrutivo:

```text
.venv/bin/python scripts/physical-xm10.py discover
```

Planejamento também não exclui nada.

`execute` e `rollback` exigem flag explícita `--confirm`.

Primeira validação física não destrutiva:

- `verify-xm10.py` detectou corretamente uma mutação indevida no
  `XboxMacProbe.lua`;
- baseline não foi atualizado;
- probe congelado foi restaurado no repositório;
- lógica XM-10 foi movida para filtro separado
  `ZZXboxMacCatalogDelete.lua/.ini`;
- instalador passa a restaurar o probe baseline no Xbox e instalar o
  filtro separado;
- descoberta já executada:
  - managed=17;
  - live=16;
  - stale=1;
  - candidato `PRO EVOLUTION SOCCER 2018`;
  - TitleID `4A3007D3`;
  - MediaID `1CB7BE36`;
  - ContentID `1`;
- nenhuma ação destrutiva foi executada.

Pré-condição adicional antes de qualquer DELETE real:

- instalador limpa marker de carregamento antes de instalar o filtro;
- `ZZXboxMacCatalogDelete.lua` recria o marker ao ser carregado pelo
  Aurora;
- marker:
  `/Hdd1/Apps/Aurora/User/Scripts/xboxmac-delete-filter-loaded.txt`;
- conteúdo:
  `schema=xboxmac-delete-filter-loaded-v1` +
  `version=xm10-isolated-v2`;
- comando de validação:
  `.venv/bin/python scripts/physical-xm10.py loaded`;
- exclusão real proibida no gate enquanto
  `XM-10 FILTER_LOADED_OK` não aparecer.

Evidência física já obtida:

- `146/146 OK`;
- baseline restaurado;
- filtro separado instalado byte-for-byte;
- stale real:
  PES 2018 / `4A3007D3` / `1CB7BE36` / ContentID 1;
- plano:
  `ba3e9753357e048b84602742ee311d754984605542cc751ec9129f4fcf610740`;
- nenhuma ação destrutiva executada.

Restart apenas do Aurora foi insuficiente na primeira prova de
carregamento:

- `FILTER_LOADED_FAILED / marker=ABSENT`;
- nenhuma ação destrutiva executada;
- filtro estava instalado byte-for-byte;
- gate passa a exigir power cycle completo do Xbox 360;
- após o boot:
  `physical-xm10.py loaded` precisa retornar
  `XM-10 FILTER_LOADED_OK`.

Preflight somente leitura adicional:

- script:
  `scripts/physical-xm10-loaded.py`;
- normaliza CRLF antes de validar marker;
- reconhece o build V2 já instalado e o V3 atual;
- baixa o filtro remoto e exige SHA-256 de build conhecido;
- V2 esperado:
  `7b5fa378178fb04e998e49a6bd8eed13bf9064d912ccd3c2217ee4149813fa2e`;
- nenhuma escrita, manifesto ou alteração de content.db;
- DELETE continua bloqueado até:
  `XM-10 FILTER_PREFLIGHT_OK`.

Preflight físico aprovado em 2026-10-04:

- `146/146 OK`;
- `XM-10 FILTER_PREFLIGHT_OK`;
- filtro remoto V2 conhecido byte-for-byte;
- SHA-256:
  `7b5fa378178fb04e998e49a6bd8eed13bf9064d912ccd3c2217ee4149813fa2e`;
- candidato:
  PES 2018 / `4A3007D3` / `1CB7BE36` / ContentID 1;
- plan_id atual:
  `dfc73a352853be51e66abfc1602c7f0eee5a0b9130d0c3fd6611ab16348e6b92`;
- db_sha256:
  `92b97f64332beb05b1d957f62290512c2b87d6738ba0d60bc7e8b5593eb1d706`;
- nenhuma ação destrutiva executada até este ponto.

Primeiro manifesto físico chegou ao Lua, mas foi recusado antes
de qualquer DELETE:

- result:
  `status=INVALID_MANIFEST`;
- content.db íntegro;
- ContentID 1 ainda presente;
- GameData ainda presente;
- backups locais íntegros;
- rollback não necessário.

Causa:

- parser Lua `raw:gmatch("([^\\r\\n]+)")` incorreto;
- em Lua isso fragmentava linhas também em caracteres literais r/n.

Correção:

- parser substituído por:
  `for line in (raw .. "\\n"):gmatch("(.-)\\n") do`;
- regressão coberta por testes/verifier;
- manifesto pendente será reutilizado;
- proibido repetir `execute` para esse plan_id.

Falha controlada seguinte: `DATABASE_BACKUP_FAILED`.

Evidência:

- Lua processou o manifesto;
- `database_backup=false`;
- ContentID 1 permaneceu presente;
- GameData permaneceu presente;
- content.db íntegro;
- nenhuma transação começou;
- rollback não necessário.

Correção:

- não copiar mais o content.db ativo com `FileSystem.CopyFile`;
- backend envia o backup completo pelo Mac via FTP antes do manifesto;
- releitura remota e comparação byte-for-byte obrigatórias;
- local:
  `aurora-delete-backups/<plan_id>/content.db`;
- Xbox:
  `User/Scripts/XboxMacDeleteBackup/<plan_id>/content.db`;
- Lua exige backup presente e tamanho esperado;
- log:
  `database_backup_source=MAC_FTP`;
- reparo do plan_id já pendente:
  `scripts/repair-xm10-remote-db-backup.py`;
- reparo não altera manifesto e não executa SQL.

Falha seguinte identificada no reparo remoto: limite FATX.

- plan_id completo possui 64 caracteres;
- FATX aceita no máximo 42 caracteres por nome;
- diretório remoto com plan_id completo não pôde ser criado;
- nenhuma escrita de banco/SQL ocorreu.

Correção:

- plan_id lógico continua SHA-256 completo;
- chave física remota:
  `p-<primeiros-32-hex>`;
- exemplo:
  `p-dfc73a352853be51e66abfc1602c7f0e`;
- comprimento:
  34 caracteres;
- backend e Lua usam a mesma derivação;
- backend recusa qualquer componente FATX >42;
- FTP MKD cria o componente final dentro do diretório pai.

Plano físico antigo deve ser aposentado antes de continuar:

- hash do banco mudou desde a criação do plano;
- não reutilizar manifesto `dfc73a...`;
- script:
  `scripts/retire-xm10-failed-plan.py`;
- só retira manifesto/resultado após provar:
  FAILED, não VERIFIED, linha ainda presente e identidade igual;
- arquiva manifesto/resultado localmente;
- depois gerar plano novo contra o content.db atual.

Novo plano físico pós-FATX aprovado:

- suite `149/149 OK`;
- plano antigo aposentado com
  `FAILED_PLAN_RETIRED`;
- filtro carregado:
  `FILTER_PREFLIGHT_OK`;
- SHA do filtro:
  `88314b30a9fefd4b6032b455728ea1fd22a3a1c889f880260377b959700316ee`;
- novo plan_id:
  `da57feb71f49316e591778707f766f124440b97c1264ceb90df952205c8f1e8f`;
- db_sha256:
  `d82f91401d1a1a6381d9db32dffa33ddd86adb88fc65819ef8e09d501791759c`;
- candidato:
  PES 2018 / `4A3007D3` / `1CB7BE36` / ContentID 1;
- nenhuma ação destrutiva executada ainda.

Backup remoto FATX-safe validado fisicamente:

- plan_id:
  `da57feb71f49316e591778707f766f124440b97c1264ceb90df952205c8f1e8f`;
- key:
  `p-da57feb71f49316e591778707f766f12`;
- bytes:
  39936;
- SHA:
  `d82f91401d1a1a6381d9db32dffa33ddd86adb88fc65819ef8e09d501791759c`;
- `BYTE_FOR_BYTE_VERIFIED`;
- estado atual:
  `WAITING_FOR_AURORA`;
- não repetir execute enquanto não houver diagnóstico do resultado remoto.

Manifesto pós-startup permaneceu pendente:

- manifesto presente;
- result ausente;
- snapshot de visibilidade READY;
- banco ainda exatamente no hash do plano;
- ContentID/assets intactos.

Correção:

- delete filter expõe
  `XboxMacProcessDeleteManifest`;
- visibility wrapper ativo chama essa função em runtime;
- instalador XM-10 passa a instalar também
  `ZZXboxMacVisibilityProbe.lua`;
- preflight exige wrapper remoto byte-for-byte;
- plano `da57...` pode ser reutilizado porque o banco permanece no
  mesmo SHA-256 e nenhuma operação ocorreu.

Remoção física XM-10 aprovada:

- plan_id:
  `da57feb71f49316e591778707f766f124440b97c1264ceb90df952205c8f1e8f`;
- `AURORA_REMOVED`;
- integrity ok;
- linha ausente;
- assets ausentes;
- verified=true.

Antes do rollback:

- assets serão restaurados antes do COMMIT;
- falha de restauração => ROLLBACK da linha;
- backend exige assets presentes quando havia backup;
- helper mostra `asset_backup_present`.

Escopo stale ampliado sob investigação:

- PES 2018 desapareceu visualmente como esperado;
- existem outros jogos visualmente órfãos que não foram candidatos;
- causa provável:
  regra inicial `managed identities only`;
- não ampliar DELETE ainda;
- auditoria somente leitura:
  `scripts/physical-xm10-stale-audit.py`;
- classifica:
  managed_live / managed_stale / unmanaged_live / unmanaged_stale;
- inclui Directory, ScanPathId e ScanPath quando possível;
- gate destrutivo fica congelado até analisar essa auditoria.

Confirmação visual:

- `visual_removal=PES2018_CONFIRMED`;
- PES 2018 desapareceu da biblioteca Aurora;
- rollback pausado até concluir auditoria global dos demais órfãos.

Auditoria global física concluída:

- aurora_rows=16;
- managed_live=13;
- managed_stale=3;
- unmanaged_stale=0;
- unknown_identity=0.

Stale restantes:

- aurora-5 — Fuzion Frenzy 2 — 485507D4 / 7D9E713E;
- aurora-4 — SEGA Rally — 534507E6 / 70E7E7E3;
- aurora-6 — Teenage Mutant Ninja Turtles Mutants in Manhattan —
  4156091E / 4EF57F51.

Conclusão:

- regra managed_stale_only está correta;
- após rollback obrigatório do PES, limpar os quatro stale entries;
- verifier corrigido;
- helper físico passa a recuperar xboxmacd automaticamente quando necessário.

Rollback físico do PES 2018 aprovado:

- `ROLLED_BACK`;
- integrity ok;
- row presente;
- assets presentes;
- backup de assets presente;
- verified=true;
- capa reapareceu visualmente somente após reboot completo do Xbox;
- rescan + restart do Aurora não foram suficientes para atualizar a apresentação.

Validação final do XM-10 usa inventário dinâmico:

- não existe lista fixa de jogos a remover;
- não existe stale_entries esperado;
- o usuário pode remover/restaurar jogos entre verificações;
- toda iteração começa com descoberta fresca;
- cada snapshot recebe state_fingerprint;
- plan usa o estado corrente;
- execute recalcula e recusa qualquer plano invalidado por mudança de
  estado;
- listas anteriores de jogos são somente evidência histórica.

Contrato de inventário dinâmico:

- `inventory_assumption=NONE`;
- nenhuma contagem, ordem, nome, TitleID, MediaID ou ContentID físico
  pode ser hardcoded/esperado;
- usuário pode excluir/restaurar jogos após cada verificação;
- `GET /api/aurora/catalog/stale` é sempre uma leitura fresca;
- resposta expõe `state_fingerprint`;
- `next-stale` apenas seleciona a partir do snapshot corrente;
- plan vincula candidato + content.db corrente;
- execute recalcula o plano e deve recusar se o cenário mudou;
- inventários registrados anteriormente são evidência histórica apenas.

Fingerprint ausente detectou backend runtime antigo:

- helper novo recebeu `state_fingerprint=` vazio;
- snapshot é inválido para qualquer decisão operacional;
- candidate/count desse snapshot não podem ser reutilizados;
- helper passa a falhar fechado se fingerprint não for SHA-256 válido;
- atualizar XboxMac runtime e fazer nova descoberta do zero.

Falha local de retomada do backend:

- após reinstalação, porta 8742 recusou conexão;
- inventário anterior não pode ser reutilizado;
- helper/launcher passam a usar `launchctl kickstart -k`;
- falha futura inclui estado do LaunchAgent + tail de xboxmacd.log;
- nenhuma ação Aurora foi executada durante essa falha.

Teste adversarial de plano obsoleto:

- backend self-recovery validado;
- descoberta válida exige fingerprint SHA-256;
- `plan-next-stale` faz descoberta + plano e compara fingerprints;
- se mudar durante essas chamadas, retorna RETRY sem ação destrutiva;
- state_fingerprint entra no plan_id;
- depois do plano, usuário deve mudar inventário de propósito;
- execute deve recusar plano obsoleto antes de backup/manifesto.

Plano adversarial salvo:

- `plan-next-stale` salva metadados públicos em
  `~/Library/XboxMac/xm10-adversarial-plan.json`;
- após mudança deliberada do inventário,
  `execute-saved-plan --confirm` compara fingerprint novo com o salvo;
- se cenário não mudou, não chama endpoint destrutivo;
- se mudou, envia o plano antigo e exige rejeição do backend;
- sucesso do teste:
  `XM-10 STALE_PLAN_REJECTED`.

Primeiro plan-next-stale falhou fechado:

- regressão 1:
  require_state_fingerprint recursivo;
- regressão 2:
  db_bytes de teste reutilizava SQLite e recriava tabela;
- ambas corrigidas;
- teste de regressão adicionado;
- nenhum plano adversarial válido foi salvo;
- execute-saved-plan posterior recusou por ausência de plano salvo;
- nenhuma escrita/manifesto/DELETE ocorreu.

Fingerprint estava ausente do payload do plano:

- discovery fingerprint válido;
- plan fingerprint vazio;
- plan-next-stale retornou RETRY e não salvou plano;
- execute-saved-plan posterior recusou ausência do plano;
- nenhuma escrita ocorreu;
- corrigido: state_fingerprint entra no payload público e no hash do
  plan_id;
- testes exigem fingerprint público de 64 hex.

Ramo arbitrário UNCHANGED validado:

- plano adversarial salvo corretamente;
- cenário permaneceu com mesmo fingerprint;
- isso é um resultado válido, não falha de pré-condição;
- nenhuma escrita ocorreu.

Comportamento do operador é arbitrário:

- operador pode alterar ou não alterar qualquer jogo;
- nenhum ramo físico é exigido;
- fingerprint igual => ramo `UNCHANGED`, válido;
- fingerprint diferente => ramo `CHANGED`, plano antigo deve ser
  recusado;
- ambos são sucesso;
- suíte automatizada cobre deterministicamente os dois ramos;
- teste físico apenas observa o ramo produzido pela arbitrariedade real.

Gate físico:

- filtro instalado e verificado byte-for-byte;
- candidato stale real;
- plano confirmado;
- remoção verificada no banco e no GameData;
- entrada desaparece visualmente no Aurora;
- rollback restaura banco/assets;
- entrada reaparece visualmente;
- nenhuma ISO/ConnectX local é alterada.

Não implementar junto com XM-06.



XM-10 = ACCEPTED / COMPLETE

Evidência final:

- 165/165 testes OK;
- inventário sem expectativa fixa;
- operator_behavior=ARBITRARY;
- branch física UNCHANGED validada;
- remoção real + rollback real já validados;
- desaparecimento/reaparecimento visual confirmados;
- fingerprint/state binding e fail-closed aprovados.

### XM-11 — histórico de automações

Status:

    ACCEPTED / COMPLETE

Implementado:

- seção `Histórico` separada da Automação atual;
- `GET /api/jobs?scope=history` exibe somente
  `SUCCEEDED`, `FAILED`, `CANCELLED`;
- presença atual reconciliada continua disponível;
- detalhe/log usa `GET /api/jobs/{job_id}`;
- `POST /api/jobs/history/purge`;
- confirmação explícita obrigatória;
- purge remove somente jobs terminais do mesmo store;
- jobs ativos preservados;
- persistência continua atômica via tmp + replace;
- nenhum helper de ISO/ConnectX/Aurora é chamado pelo purge;
- UI informa explicitamente que arquivos de jogos e Aurora não serão
  alterados;
- testes:
  `backend/server/tests/test_xm11_history.py`;
- verificador:
  `scripts/verify-xm11.py`;
- helper físico:
  `scripts/physical-xm11.py`;
- documentação:
  `docs/XM-11.md`.

Physical validation evidence: history_before=7, purged=7,
active_before=0, active_after=0; restart confirmou history_jobs=0.
UI Histórico confirmada visualmente pelo usuário.
Único failure restante era assertion de formatação do teste da URL active;
corrigido sem alteração de produção.

Não há TTL automático no XM-11.
Exclusão individual de um registro histórico permanece opcional e fora
do gate inicial.


XM-11 = ACCEPTED / COMPLETE

Evidência final:

- STATIC_OK;
- 171/171 testes OK;
- UI Histórico validada;
- purge real 7/7;
- restart persistente;
- arquivos de jogos/Aurora fora do purge.


### XM-12 — exclusão ConnectX reconciliada com Aurora

Status:

    ACCEPTED / COMPLETE

Objetivo:

- excluir ConnectX pela aplicação => limpar automaticamente catálogo Aurora;
- ISO presente ou ausente não interfere;
- ISO-only não toca Aurora;
- Finder/manual ConnectX removal será detectado posteriormente pela reconciliação global Aurora × ConnectX e oferecido como stale/órfão para limpeza consciente;
- Histórico XM-11 permanece preservado.

Implementado:

- identidade de exclusão inclui TitleID/MediaID;
- store persistente `connectx-aurora-reconcile.json`;
- estados PENDING_DISCOVERY / WAITING_FOR_XBOX /
  WAITING_FOR_AURORA / COMPLETE / ERROR;
- reconciliação usa o pipeline seguro XM-10;
- múltiplas linhas da mesma identidade são tratadas sequencialmente com
  redescoberta entre operações;
- feedback na Biblioteca em `delete-status`;
- ação WAITING_FOR_AURORA recomenda reboot completo do Xbox;
- browser poll automático a cada 4s;
- reconciliação fica deferida enquanto houver job ativo;
- `POST /api/delete/aurora/reconcile`;
- `GET /api/delete/aurora/status` somente leitura;
- testes: `test_xm12_connectx_aurora_cleanup.py`;
- verificador: `scripts/verify-xm12.py`;
- helper físico: `scripts/physical-xm12.py`;
- docs: `docs/XM-12.md`.

Decisão arquitetural adotada — reconciliação global Aurora × ConnectX:

- a aplicação não perde definitivamente o controle quando um ConnectX é
  removido manualmente pelo Finder ou por outro meio externo;
- ela perde somente o evento causal da exclusão, portanto não deve assumir
  automaticamente que a entrada correspondente no Aurora pode ser apagada;
- em reconciliação periódica e também sob ação explícita do usuário, o
  XboxMac deve comparar o inventário atual do ConnectX com o catálogo atual
  do Aurora (`content.db`), usando TitleID + MediaID e o histórico de
  identidades conhecidas pelo XboxMac;
- uma entrada presente no Aurora cuja identidade gerenciada não possui mais
  ConnectX correspondente deve ser classificada como stale/órfã;
- esse estado deve aparecer diretamente na Biblioteca, por exemplo:
  `ConnectX ausente · ainda presente no Aurora`;
- a Biblioteca deve oferecer uma ação explícita equivalente a
  `Limpar do Aurora` para esse resíduo;
- essa ação deve reutilizar o mesmo pipeline seguro já validado no XM-10/XM-12:
  descoberta fresca, identidade exata, plano, backup, execução, verificação,
  polling e instrução de refresh/restart quando necessária;
- resíduos descobertos por reconciliação não serão apagados automaticamente,
  pois a ausência do ConnectX pode ser temporária (volume indisponível,
  diretório movido ou outra condição externa);
- regra final de UX:
  - ConnectX excluído pelo próprio XboxMac => cleanup Aurora automático;
  - ConnectX ausente detectado posteriormente => oferecer cleanup com uma
    confirmação explícita;
- a seção atual `Catálogo Aurora` permanece como mecanismo técnico compatível,
  mas a experiência alvo é integrar essa detecção e ação à Biblioteca para
  que o usuário não precise distinguir manualmente XM-10 de XM-12;
- PES 2018, removido manualmente e ainda visível no CoverFlow, passa a ser a
  evidência física de referência para este caso de reconciliação global.
Implementação da decisão arquitetural:

- `discover_catalog_inventory()` passou a inventariar as entradas gerenciadas
  do `content.db` e classificá-las por presença atual do ConnectX;
- `discover_stale_entries()` continua compatível e deriva desse inventário;
- `merge_aurora_inventory()` integra o resultado à Biblioteca;
- um resíduo sem ISO e sem ConnectX recebe linha sintética `AURORA_STALE`,
  portanto não desaparece da UI apenas porque os arquivos locais sumiram;
- `GET /api/library/aurora-reconcile` executa a comparação com timeout curto
  e falha aberta: Aurora/Xbox offline não bloqueia a Biblioteca local;
- a UI mostra uma coluna Aurora com o estado
  `ConnectX ausente · ainda presente no Aurora`;
- filtro `AURORA_STALE` adicionado;
- resíduos elegíveis recebem botão `Limpar do Aurora` diretamente na
  Biblioteca;
- o botão reutiliza o pipeline XM-10 de plano, backup, execute e status;
- polling do inventário Aurora a cada 15s;
- polling de uma remoção manual ativa a cada 4s;
- `physical-xm12.py` passa a listar também resíduos globais detectados;
- testes de regressão adicionados para:
  - resíduo sem qualquer arquivo local ainda aparecer como `AURORA_STALE`;
  - Aurora offline preservar a Biblioteca local.

Evidência física final:

- após a correção do JavaScript, a UI voltou a popular as listas;
- exclusão ConnectX feita pela aplicação funcionou;
- Rescan + restart do Aurora foram suficientes nesse teste para o jogo
  excluído desaparecer do CoverFlow;
- PES 2018 removido manualmente foi detectado como resíduo elegível;
- ação `Limpar do Aurora` foi executada com sucesso;
- após atualização/restart do Aurora, o PES 2018 desapareceu do CoverFlow;
- `verify-xm12.py`: `STATIC_OK`;
- helper físico final:
  - `pending=0`;
  - `complete=2`;
  - `errors=0`;
  - `library_aurora_available=true`;
  - `library_stale_games=0`;
  - `library_stale_entries=0`;
- suíte local executou 183 testes; a única falha era uma asserção textual
  legada do XM-06 que esperava `Ações de exclusão` depois da coluna ter sido
  generalizada para `Ações`; o teste foi corrigido sem alteração funcional;
- Histórico XM-11 permanece preservado por contrato e testes;
- XM-12 aceito.

Regressão observada no primeiro reteste físico:

- HTML carregava, mas a UI permanecia em `Preparando conexões...` e não
  populava as listas;
- causa confirmada: escapes `\n` insuficientes dentro do JavaScript embutido
  na string Python da página, produzindo JavaScript inválido no navegador;
- corrigidos 20 escapes no `app.py`;
- JavaScript renderizado validado sintaticamente;
- teste de regressão adicionado ao XM-12;
- reteste físico após reinstalação do runtime concluído com sucesso.

Gate aceito:

- XM-12 `ACCEPTED / COMPLETE`.



### Melhorias de experiência pós-XM-12 — navegação por abas e Biblioteca em cards

Status:

    ACCEPTED / COMPLETE

Escopo:

- substituir a tela única longa por abas, mantendo o conteúdo funcional de
  cada seção;
- ordem e rótulos curtos das abas:
  1. Conexões;
  2. Arquivos;
  3. Biblioteca;
  4. Catálogo;
  5. Pacotes;
  6. Automação;
  7. Histórico;
- os títulos completos dentro das páginas permanecem, inclusive
  `Biblioteca e exclusão`, `Catálogo Aurora` e `Pacotes Xbox 360`;
- barra de abas permanece visível durante a rolagem por `position: sticky`;
- em telas estreitas, a barra aceita rolagem horizontal.

Biblioteca:

- a tabela extensa foi removida;
- os jogos são apresentados em um seletor/dropdown;
- ao selecionar um jogo, são mostrados cinco cards:
  - linha superior: Estado, TitleID e MediaID;
  - linha inferior: ISO e ConnectX;
- cards ISO/ConnectX mostram tamanho em GB;
- `Excluir ISO` usa botão com texto e borda amarelos;
- `Excluir ConnectX` permanece uma ação separada;
- a ação combinada `Excluir ISO + ConnectX` foi removida por segurança;
- resíduos `AURORA_STALE` continuam tratáveis sem criar um sexto card:
  o aviso e `Limpar do Aurora` aparecem dentro do card ConnectX;
- seleção atual é preservada quando possível após refresh/reconciliação.

Contratos adicionados:

- `backend/server/tests/test_post_xm12_ux.py`;
- teste legado XM-06 atualizado para a Biblioteca em cards e para a remoção
  da ação combinada;
- `scripts/verify-post-xm12-ux.py`.

Validação física concluída em 2026-10-05:

- usuário confirmou que a experiência reorganizada por abas funciona;
- Biblioteca em dropdown/cards aprovada no uso real;
- controles visuais e fluxo geral aprovados.



### Melhorias de experiência pós-XM-12 — controles de servidor e fila de jobs

Status:

    ACCEPTED / COMPLETE

Conexões — ciclo do servidor:

- a aba Conexões recebe:
  - `Parar servidor`;
  - `Reiniciar servidor`;
  - `Iniciar servidor`;
- como o próprio `xboxmacd` não pode receber um comando para iniciar depois
  de estar parado, foi criado um plano de controle separado:
  `io.remappingbridge.xboxmac-supervisor`;
- o supervisor:
  - roda somente em `127.0.0.1:8741`;
  - usa um LaunchAgent separado e persistente;
  - aceita comandos somente da origem local da UI e exige
    `X-XboxMac-Supervisor: 1`;
  - não serve conteúdo da aplicação;
  - controla somente o LaunchAgent `io.remappingbridge.xboxmacd`;
- `Parar servidor` envia SIGTERM ao backend principal;
- `Reiniciar servidor` executa SIGTERM, aguarda a porta 8742 encerrar e
  somente então faz `kickstart`;
- `Iniciar servidor` faz `kickstart` do serviço registrado;
- stop/restart preservam o mecanismo já existente que devolve o job ativo
  para `QUEUED` em shutdown/recovery;
- o instalador passa a registrar e manter o supervisor ativo com
  `RunAtLoad=true` e `KeepAlive=true`.

Automação — controles por job:

- novos estados/controles do scheduler:
  - `Pausar job`;
  - `Retomar job`;
  - `Cancelar job`;
- `PAUSED` não é terminal e não volta automaticamente para a fila;
- pausar:
  - remove o job da fila;
  - interrompe cooperativamente o helper filho atual quando houver;
  - libera o worker para o próximo job `QUEUED`;
  - registra `PAUSED_BY_USER`;
- retomar:
  - é permitido somente quando o worker já liberou completamente o job;
  - muda o estado para `QUEUED`;
  - coloca o job no final da fila;
  - registra `RESUMED_TO_QUEUE`;
- cancelar:
  - remove o job da fila;
  - interrompe o helper ativo quando necessário;
  - muda para o estado terminal `CANCELLED`;
  - registra `CANCELLED_BY_USER`;
- o scheduler expõe `is_current`, `queue_position` e capacidades
  `can_pause`, `can_resume`, `can_cancel`;
- a submissão feita pela UI passa a criar um job separado por jogo, mesmo
  quando vários jogos são selecionados de uma vez;
- a API mantém compatibilidade com requests multi-alvo existentes.

Automação — acordeões:

- a antiga tabela de jobs ativos foi removida;
- cada job aparece em um `details/summary` cujo título é o nome do jogo;
- jobs antigos com múltiplos jogos usam o primeiro nome seguido da quantidade
  adicional;
- o job que possui o worker atual abre automaticamente;
- jobs `QUEUED`, `PAUSED` ou aguardando fora do worker ficam recolhidos;
- o usuário pode abrir um job não atual e essa preferência permanece durante
  os refreshes;
- um job atual não pode permanecer recolhido enquanto estiver executando;
- dentro do acordeão ficam:
  - Estado;
  - Etapa;
  - Ação necessária;
  - posição na Fila;
  - Progresso;
  - identidade e evidências Aurora do jogo;
  - botões Pausar / Retomar / Cancelar.

APIs adicionadas:

- `POST /api/jobs/{job_id}/pause`;
- `POST /api/jobs/{job_id}/resume`;
- `POST /api/jobs/{job_id}/cancel`.

Contratos adicionados:

- testes de scheduler em `test_xm09_scheduler.py`;
- `backend/server/tests/test_post_xm12_controls.py`;
- extensão dos testes de UX em `test_post_xm12_ux.py`;
- `scripts/verify-post-xm12-controls.py`.

Validação local observada em 2026-10-05:

- `verify-post-xm12-controls.py` => `STATIC_OK`;
- primeira suíte pós-implementação: 201 testes, com 1 falha e 2 erros;
- os dois erros eram testes XM-10 de serialização do plano chamando o endpoint
  diretamente enquanto o `job_manager` global carregava jobs reais ativos;
  esses testes foram isolados de `_delete_jobs_idle()`, pois não testam
  concorrência;
- a falha XM-07 ainda exigia o cabeçalho removido `Jogos / Aurora`; o
  contrato foi atualizado para os novos acordeões (`job-accordion` e
  `Fluxo do jogo`);
- CSS residual da tabela antiga removido e corrigido typo
  `solidvar(--border)` -> `solid var(--border)`;
- novo reteste da suíte completa ainda pendente.

Validação física concluída em 2026-10-05:

- usuário confirmou que os botões de servidor funcionam;
- usuário confirmou que a experiência de Automação/Jobs funciona como um todo;
- controles e acordeões aprovados para uso cotidiano.



### Correção pós-XM-12 — reconciliação determinística de capas

Status:

    IMPLEMENTED / PHYSICAL_VALIDATION_PENDING

Caso físico de referência:

- jogo: Gears of War: Judgment;
- TitleID confirmado: `4D530A26`;
- ConnectX funcional e jogo executando no Xbox;
- capa ausente no CoverFlow mesmo após reboot do console.

Diagnóstico:

- o x360db possui metadata e artwork para `4D530A26`;
- existe `boxart.jpg` versionado no repositório x360db para esse TitleID;
- o helper `xbox-connectx-sync-covers` considerava qualquer
  `GC<TitleID>.asset` remoto com mais de 2048 bytes como já sincronizado;
- portanto um asset placeholder/antigo do Aurora podia produzir falso
  `SYNCED` sem comparação com o asset gerado pelo XboxMac;
- o scheduler aceitava `SYNCED`/ `UPLOADED` como capa verificada sem
  evidência criptográfica.

Correções:

- `xbox-connectx-sync-covers` agora:
  - gera o asset desejado para títulos gerenciados pelo XboxMac;
  - compara bytes/SHA-256 do asset local e remoto;
  - só retorna `SYNCED` quando o conteúdo é idêntico;
  - substitui o remoto mesmo quando o tamanho é igual, se o conteúdo divergir;
  - verifica o upload por igualdade exata de conteúdo;
  - aceita `--title-id` para sincronização direcionada;
  - ignora ContentItems sem staging XboxMac;
- jobs com apenas um TitleID conhecido chamam o sincronizador de capa com
  `--title-id <TitleID>`, evitando tocar jogos não relacionados;
- o scheduler só marca `cover_state=VERIFIED` quando a saída contém
  evidência SHA-256;
- o JobManager passa a usar os helpers `backend/connectx` empacotados no
  próprio runtime do XboxMac, eliminando dependência de cópias antigas em
  `/usr/local/libexec`;
- `xbox-connectx-ingest` e `xbox-connectx-sync-metadata` resolvem seus
  helpers irmãos no mesmo diretório;
- `scripts/physical-cover-repair.py --title-id <TITLEID>` executa reparo
  físico direcionado usando exatamente o runtime instalado;
- `xbox-connectx-stage-assets` passa a preferir o artwork versionado atual
  do x360db antes do URL legado do Xbox Marketplace;
- se a fonte primária não trouxer cover, permanece fallback para XboxUnity
  900x600;
- testes adicionados cobrem:
  - asset remoto do mesmo tamanho mas conteúdo diferente;
  - asset remoto realmente idêntico;
  - título Aurora não gerenciado ignorado;
  - prioridade do artwork x360db;
  - fallback XboxUnity;
  - rejeição de evidência de capa sem hash.

Validação observada em 2026-10-05:

- verificador estático => `POST-XM12-COVER-REPAIR: STATIC_OK`;
- primeira suíte após endurecimento por hash executou 210 testes e revelou
  4 fixtures legados que ainda simulavam sucesso de capa apenas por tamanho;
- fixtures XM-05 e XM-07C foram atualizados para incluir evidência SHA-256,
  sem afrouxar o novo contrato;
- primeira tentativa do helper físico foi recusada corretamente com
  `worker da Automação está ocupado`;
- causa: a sequência de teste abriu o XboxMac antes do reparo, o que iniciou
  o backend e retomou um job persistido;
- a saída `UPLOADED ... new_sha256=...` vista antes de `INSTALLED=` veio
  dos testes unitários e não representa alteração física no Xbox;
- sequência física corrigida: instalar runtime, parar xboxmacd, executar
  `physical-cover-repair.py`, somente depois reabrir XboxMac.

Validação pendente:

1. suíte completa sem falhas;
2. reinstalar runtime atualizado;
3. parar o backend XboxMac;
4. executar `scripts/physical-cover-repair.py --title-id 4D530A26`;
5. confirmar no log `UPLOADED ... TitleID=4D530A26 ... new_sha256=...`
   ou `SYNCED ... TitleID=4D530A26 ... sha256=...`;
6. reabrir XboxMac;
7. executar refresh/restart do Aurora quando solicitado;
8. confirmar visualmente a capa no CoverFlow.


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
