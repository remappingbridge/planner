# Plano — XboxMac UI

Data inicial: 2026-10-03

Repositório de implementação planejado:

```text
https://github.com/remappingbridge/xboxmac-ui
```

Este documento fica no `planner`. Nenhum código deve ser colocado no repositório `xboxmac-ui` antes do início explícito da implementação.

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

## Layout de implementação planejado

No futuro repositório `remappingbridge/xboxmac-ui`:

```text
xboxmac-ui/
├── pyproject.toml
├── src/
│   └── xboxmac/
│       ├── app.py
│       ├── api/
│       ├── services/
│       │   ├── netiso.py
│       │   ├── connectx.py
│       │   ├── xbox.py
│       │   ├── aurora.py
│       │   ├── library.py
│       │   ├── automation.py
│       │   ├── launchd.py
│       │   └── trash.py
│       ├── jobs/
│       ├── db/
│       ├── templates/
│       └── static/
├── helpers/
│   └── asset-engine/
├── packaging/
│   └── macos/
└── tests/
```

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

### XM-00 — contrato e baseline

- congelar paths;
- congelar portas;
- registrar serviços atuais;
- definir catálogo/schema;
- definir regras de privilégio;
- definir comportamento offline;
- nenhum código destrutivo.

Gate: documento suficiente para implementar sem decisões implícitas.

### XM-01 — backend local mínimo

- FastAPI/Uvicorn;
- bind `127.0.0.1:8742`;
- página inicial;
- health check;
- logging;
- shutdown limpo.

Gate: backend abre localmente e não fica exposto na LAN.

### XM-02 — status de conexões

- Ethernet;
- Xbox reachability;
- NetISO;
- Samba;
- NetBIOS;
- Aurora FTP.

Gate: painel reflete corretamente estados online/offline sem modificar serviços.

### XM-03 — ensure connections

- iniciar somente serviços faltantes;
- não reiniciar saudáveis;
- apresentar falha específica;
- NetISO não pode ser interrompido ao abrir o app.

Gate: abrir painel em estados variados converge para o estado saudável possível.

### XM-04 — biblioteca read-only

- inventário ISO;
- inventário ConnectX;
- correlação por TitleID/MediaID;
- tamanhos;
- estados;
- filtros.

Gate: biblioteca exibida sem permitir alterações.

### XM-05 — integração da automação

- dry-run;
- execução;
- fila;
- progresso;
- erro por jogo;
- idempotência.

Gate: um novo jogo pode ser preparado a partir da UI sem terminal.

### XM-06 — Lixeira

- mover ISO;
- mover ConnectX;
- confirmações;
- path guards;
- reconciliação de estado;
- nunca `rm -rf`.

Gate: exclusões recuperáveis pela Lixeira e nenhum path externo pode ser atingido.

### XM-07 — assets/Aurora

- estado de scan;
- ContentID;
- assets;
- uploads pendentes;
- CoverFlow;
- sem clique manual `Assets > Import`.

Gate: segundo jogo novo chega a CoverFlow com artwork pela UI.

### XM-08 — launcher macOS

- `XboxMac.app`;
- iniciar/find backend;
- `ensure_ready`;
- abrir browser;
- não exigir terminal.

Gate: usuário não técnico consegue iniciar e usar o painel clicando no app.

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
12. fazer tudo isso sem conhecer os detalhes internos dos serviços.
