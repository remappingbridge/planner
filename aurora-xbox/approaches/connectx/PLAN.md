# Plano de implementação — ConnectX

## Política de avanço dos gates

A partir de CX-01, a aceitação dos gates é **baseada em evidências**. O usuário não precisa declarar `gate aceito` nem pedir explicitamente o próximo gate. Quando os critérios objetivos do gate forem comprovados pelas saídas/testes, o gate será registrado como concluído e o trabalho avançará automaticamente. O fluxo só deve parar quando houver falha, ambiguidade, risco de regressão ou teste físico que ainda dependa do usuário.

## Princípios

- NetISO permanece funcionando durante todo o experimento.
- A biblioteca ISO em `/Users/Shared/xbox360` não será modificada.
- Criar uma biblioteca ConnectX separada.
- SMB1/NT1 deve ficar restrito à Ethernet privada do Xbox, não ao Wi-Fi do Mac.
- Credenciais SMB não devem ser versionadas no planner.
- Testar primeiro com **um único jogo**.
- Só expandir para a biblioteca inteira depois de validar CoverFlow, capas e estabilidade.

## CX-00 — congelar baseline e rollback — CONCLUÍDO

Baseline congelado e rollback documentado em [CX-00-baseline.md](CX-00-baseline.md).

Confirmado antes de qualquer instalação ConnectX:

- estado relevante dos plugins registrado;
- backup do `Nova.xex` original preservado com SHA-256;
- `launch.ini` atual congelado;
- NetISO validado fim a fim;
- recuperação após perda/retorno do cabo validada;
- LaunchDaemon NetISO validado após reboot do Mac;
- `USB fora + reboot = retail` novamente validado.

**Gate:** **ACEITO/CONCLUÍDO**. Próximo gate: CX-01.

## CX-01 — backend SMB isolado no Mac — FUNCIONAL VALIDADO / PERSISTÊNCIA EM VALIDAÇÃO

Criar biblioteca dedicada:

```text
/Users/Shared/xbox360-connectx
```

Modelo de rede:

```text
en0 / Wi-Fi
  -> Internet do Mac
  -> NÃO expor SMB1

en7 / 192.168.50.1
  -> rede privada Xbox
  -> SMB1/NT1 ConnectX
```

Nome lógico planejado para o servidor SMB:

```text
XBOXMAC
```

Share planejado:

```text
XBOX360
```

O backend deve usar conta dedicada/read-only quando possível.

### Decisão técnica deste gate

A implementação escolhida é **Samba dedicado via Homebrew**, separado do servidor SMB nativo da Apple. Motivos:

- ConnectX exige SMBv1/NT1;
- Samba permite `server min protocol = NT1`;
- Samba permite `interfaces` + `bind interfaces only = yes`, restringindo o serviço à rede privada do Xbox;
- o binário Homebrew usa nome próprio (`samba-dot-org-smbd`) no macOS, reduzindo conflito com o `smbd` da Apple.

A instância será configurada para escutar somente em `127.0.0.1` e `192.168.50.1/en7`, com `hosts allow` limitado a `127.0.0.1` e `192.168.50.0/24`. SMB1 não deve ser exposto pela interface Wi-Fi.

**Gate:** backend SMB1/NT1 funciona no Mac com autenticação local via `smbclient`, o nome `XBOXMAC` resolve na rede privada, TCP 445/139 não fica exposto pelo Wi-Fi e a biblioteca ConnectX fica separada. A autenticação real pelo Xbox será validada depois que o plugin ConnectX existir, em CX-03/CX-04.

Evidências consolidadas: [CX-01-samba.md](CX-01-samba.md). Funcionalidade principal já validada; falta apenas validar autostart após reboot real do Mac antes de considerar CX-01 operacionalmente encerrado.

### Evidências parciais CX-01 — 2026-10-02

- Homebrew 7.0.6 presente em `/opt/homebrew`;
- Samba 4.25.0 instalado via Homebrew;
- portas TCP 139/445 estavam livres antes de iniciar o Samba dedicado;
- existe um share configurado no SMB nativo do macOS (`Talita’s Public Folder`), mas o serviço nativo não estava escutando nas portas SMB; não removê-lo;
- `testparm` carregou `/opt/homebrew/etc/samba-xbox/smb.conf` com sucesso;
- servidor configurado como standalone, `server min protocol = NT1`, `server max protocol = NT1`, `ntlm auth = ntlmv1-permitted`, `bind interfaces only = yes`;
- share `XBOX360` aponta para `/Users/Shared/xbox360-connectx`, read-only e autenticado;
- usuário Samba `admin` foi adicionado e a senha foi redefinida com sucesso (segredo não registrado);
- arquivo de prova `CX-01-READY.txt` criado;
- autenticação SMB local validada via `smbclient` usando NT1: o share `//192.168.50.1/XBOX360` listou `CX-01-READY.txt`;
- `smbd` dedicado ficou escutando somente em `192.168.50.1:445`, `192.168.50.1:139` e loopback, sem bind wildcard;
- configuração persistente da interface `USB 10/100 LAN` continua `192.168.50.1/24`, porém o link físico `en7` estava `inactive` no momento do teste.

Enquanto `en7` estiver inativo, não considerar o gate concluído.

Diagnóstico adicional: com `en7` ativo e `smbd` funcional, `nmbd` não permaneceu em execução porque o daemon nativo do macOS `netbiosd` já ocupava UDP 137/138. `nmblookup` por broadcast e unicast falharam para `XBOXMAC`. Apple documenta a desativação reversível de `netbiosd`; CX-01 passa a usar o `nmbd` do Samba dedicado para registrar `XBOXMAC`, mantendo a pilha ConnectX sob uma única configuração.

## CX-02 — preparar jogo, identidade e metadados

Usar um jogo já validado em NetISO para comparação direta, preferencialmente PES 2018. A ISO original permanece intacta.

### CX-02A — extrair a ISO — CONCLUÍDO

Preservar:

```text
/Users/Shared/xbox360/<jogo>.iso
```

Criar separadamente:

```text
/Users/Shared/xbox360-connectx/<jogo>/
└── default.xex
```

### CX-02B — validar `default.xex` — CONCLUÍDO

Confirmar que a extração produziu o executável principal e os demais arquivos do jogo. O `.xex` sozinho não é tratado como jogo completo.

### Classificação de entradas não-Xbox

O pipeline futuro não deve assumir que toda pasta encontrada perto da biblioteca é um jogo Xbox 360. Antes de processar metadata/assets, deve exigir pelo menos:

- `default.xex` presente;
- assinatura XEX válida (`XEX2`) no executável;
- TitleID extraível da ExecutionId do XEX.

Exemplo observado em 2026-10-02: `/Users/Shared/xbox360/The Legend of Korra™/` contém `LoK.exe`, `steam_api.dll`, `_CommonRedist/DirectX` e outros artefatos de Windows/Steam, sem `default.xex`; portanto deve ser classificado como **PC / não Xbox 360** e ignorado pelo pipeline ConnectX.

### CX-02C — extrair identidade

Ler do conteúdo extraído, quando disponível:

- TitleID;
- MediaID;
- nome técnico/comercial identificável;
- região/edição relevante.

Registrar esses dados antes de importar assets.

### CX-02D — conferir edição

Relacionar TitleID/MediaID com a ISO usada no NetISO para evitar aplicar capa ou metadata de edição/região errada.

### CX-02E — buscar metadata e artwork no Mac

Preparar o pipeline para obter, quando disponível:

- título;
- capa;
- banner;
- background;
- ícone;
- descrição;
- publisher;
- developer;
- gênero;
- data de lançamento.

Não depender de busca manual capa por capa quando for possível automatizar.

### CX-02F — gerar staging de importação do Aurora

Preparar estrutura compatível com importação offline:

```text
Aurora/User/Import/<TitleID>/
├── titlename.txt
├── description.txt
├── publisher.txt
├── developer.txt
├── releasedate.txt
├── genre.txt
├── cover.jpg
├── banner.jpg
├── background.jpg
├── icon.png
└── screenshot*.jpg
```

Somente os arquivos disponíveis/validados precisam existir.

### CX-02G — validar staging antes do Xbox

Antes de enviar qualquer asset:

- confirmar TitleID correto;
- confirmar que a pasta extraída contém o jogo completo;
- confirmar que a ISO original não foi alterada;
- confirmar que a arte corresponde à edição correta;
- registrar tamanhos e hashes relevantes.

### Evidências CX-02A/B — PES 2018

- ISO original preservada em `/Users/Shared/xbox360/PES 2018 - Pro Evolution Soccer (USA) (En,Es).iso`;
- SHA-256 da ISO após extração: `12c32bf93d23e237c18fc345dc9c7984b8767de24eb866dccd930d599dd04601`;
- pasta ConnectX criada em `/Users/Shared/xbox360-connectx/PES 2018`;
- `default.xex` encontrado na raiz da pasta do jogo;
- 186 arquivos extraídos;
- tamanho extraído observado: `6.6G`;
- a extração também trouxe `$SystemUpdate`; para a biblioteca ConnectX esse diretório será removido da cópia extraída e, em extrações futuras, `extract-xiso -s` será usado para ignorá-lo;
- o comando simples `extract-xiso` não está no PATH; para o pipeline futuro o binário será instalado em caminho estável antes da automação.

**Conclusão:** CX-02A e CX-02B concluídos. A pasta está estruturalmente no formato esperado para execução por `default.xex`; a validação real de lançamento ocorrerá no CX-04 depois da instalação do ConnectX.

**Gate geral CX-02:** jogo extraído funcional + identidade confirmada + staging de metadata/assets pronto para importação offline.

## CX-03 — instalar e configurar ConnectX no Aurora

Segundo a documentação do ConnectX:

- instalar `connectx_patch.xexp` e `connectx.xex` na pasta de plugins do Aurora;
- habilitar o módulo em `Settings > Modules`;
- configurar:
  - Computer Name em maiúsculas: `XBOXMAC`;
  - Share Name: `XBOX360`;
  - usuário SMB;
  - senha SMB;
- reiniciar a sessão desbloqueada.

Não alterar:

```text
plugin1 = Usb:\NetISO\NetISO.xex
```

**Gate:** ConnectX aparece na lista de plugins/módulos e NetISO continua carregando.

## CX-04 — validar execução remota pelo File Manager

No Aurora:

```text
Back
-> File Manager
-> ConnectX:
-> <jogo>
-> default.xex
```

Executar o jogo diretamente pelo `default.xex`.

Testar abertura, carregamento, gameplay, retorno ao Aurora e desconexão/reconexão do cabo.

**Gate:** jogo extraído roda pela rede sem afetar NetISO.

## CX-05 — colocar a biblioteca no CoverFlow

No Aurora:

```text
Settings
-> Content
-> Manage Paths
-> adicionar ConnectX:
```

Configurar o caminho para conteúdo Xbox 360 e profundidade suficiente para encontrar o `default.xex`. Executar rescan.

**Resultado esperado:** o jogo remoto passa a aparecer no menu principal/CoverFlow sem precisar navegar manualmente pelo File Manager.

**Gate:** título ConnectX aparece no carrossel e inicia a partir dele.

## CX-06 — capas e metadados

Como a rede do Xbox foi deliberadamente mantida sem Internet, tratar capas em duas alternativas:

1. **preferida:** importação offline de assets para o Aurora;
2. opcional: acesso temporário/controlado à Internet apenas se houver decisão explícita posterior.

Fluxo preferido:

- identificar TitleID do jogo escaneado;
- preparar capa/assets no Mac;
- enviar por FTP;
- usar o mecanismo de importação de Assets do Aurora;
- confirmar capa correta no CoverFlow.

**Gate:** jogo ConnectX aparece com capa correta e metadados suficientes para uso normal.

## Validação pós-reboot adiada

A validação pós-reboot do Samba/NetBIOS foi adiada por decisão operacional do usuário. Ela será executada no CX-07, junto com a validação final de coexistência. Isso não bloqueia CX-02 em diante desde que `smbd`/`nmbd` estejam funcionais na sessão atual.

## CX-07 — coexistência final

Com ConnectX concluído, validar as duas bibliotecas no mesmo console:

```text
NetISO
-> ISO no Mac
-> File Browser -> NetISO -> Mount

ConnectX
-> jogo extraído no Mac
-> CoverFlow -> Launch
```

Validar ainda reboot real do Mac (incluindo autostart NetISO + `smbd` + `nmbd`), cabo removido/reconectado, NetISO, ConnectX e `USB removido + reboot = retail`.

**Gate de conclusão:** NetISO e ConnectX coexistem sem regressão.

## Depois do CX-07

Congelar a configuração ConnectX validada e seguir para [../god-local/](../god-local/).
## Pipeline incremental para jogos futuros

A solução de metadados/capas não será tratada como importação única. O objetivo é suportar novos jogos adicionados posteriormente sem reconstruir manualmente a biblioteca.

Fluxo planejado:

```text
nova ISO adicionada em /Users/Shared/xbox360
        ↓
extração para /Users/Shared/xbox360-connectx/<jogo>/
        ↓
detecção de default.xex
        ↓
leitura de TitleID / MediaID
        ↓
comparação com catálogo local de jogos já processados
        ↓
buscar somente metadata/artwork ausentes
        ↓
gerar/atualizar Aurora/User/Import/<TitleID>/
        ↓
enviar somente deltas por FTP
        ↓
Aurora rescan/import
```

Requisitos do pipeline:

- manter um manifesto local por TitleID/MediaID e hash da ISO/XEX;
- ser idempotente: rodar novamente não deve duplicar assets nem recriar jogos já processados;
- detectar jogos novos e alterações de edição/MediaID;
- preservar capas previamente escolhidas manualmente, salvo ordem explícita de substituição;
- manter cache local de metadata/artwork para não depender de novo download a cada execução;
- gerar staging separado antes de qualquer FTP;
- permitir execução manual inicialmente e posterior automação por LaunchDaemon/serviço no Mac depois que o fluxo estiver validado;
- nunca apagar a ISO original ao gerar a árvore ConnectX.

O gate CX-06 só será considerado completamente concluído quando esse fluxo incremental estiver validado com pelo menos um jogo já existente e um segundo jogo adicionado depois.