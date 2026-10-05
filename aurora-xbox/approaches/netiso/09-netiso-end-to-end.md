# 09 — Validação fim a fim do NetISO

Data: 2026-10-01

## Resultado

A cadeia completa foi validada com sucesso até a abertura de um jogo real:

```text
MacBook
/Users/Shared/xbox360/PES 2018 - Pro Evolution Soccer (USA) (En,Es).iso
        |
        | netiso-srv TCP 4323
        v
Ethernet direta 192.168.50.1/24 <-> 192.168.50.2/24
        |
        v
Xbox 360
ABadAvatar
 -> XeUnshackle
 -> Aurora 0.7b.2
 -> Xbox Guide
 -> File Browser
 -> NetISO
 -> PES 2018
 -> jogo abriu
```

## Itens confirmados

- Aurora abriu normalmente após instalar o Nova.xex modificado.
- NetISO apareceu no File Browser.
- As ISOs servidas pelo Mac ficaram acessíveis no Xbox.
- PES 2018 foi selecionado e montado via NetISO.
- PES 2018 abriu no Xbox 360 a partir da ISO mantida no Mac.
- Não foi necessário copiar a ISO integralmente para o HDD interno do Xbox.

## Estado atual da arquitetura

```text
USB Aurora-XBOX
├── ABadAvatar
├── XeUnshackle
├── launch.ini
└── NetISO
    ├── NetISO.xex
    └── NetISO.xex.txt

HDD Xbox
└── Apps\Aurora
    ├── Aurora.xex
    └── Plugins\Nova.xex   <- versão modificada para NetISO

MacBook
├── /Users/Shared/xbox360/*.iso
└── netiso-srv -r -v /Users/Shared/xbox360
```

## Rede

```text
MacBook: 192.168.50.1/24
Xbox:    192.168.50.2/24
NetISO:  TCP 4323
Aurora:  FTP TCP 21
```

## Requisito permanente

Preservar:

```text
USB fora + reboot -> dashboard retail/original
USB + exploit     -> Aurora + NetISO
```

## Validação de estabilidade e retorno ao modo retail

Em 2026-10-02 o usuário confirmou:

- gameplay via NetISO sem travamentos;
- reinicialização do Xbox sem o pendrive retorna normalmente ao dashboard retail/original;
- portanto a instalação do Nova modificado no HDD não alterou o comportamento retail sem o exploit.

Requisito permanente novamente validado:

```text
USB fora + reboot -> dashboard retail/original
USB + exploit     -> Aurora + NetISO
```

## Validação dinâmica do enlace

Em 2026-10-02 também foi validado o comportamento durante perda e retorno do cabo Ethernet:

```text
cabo conectado    -> ISO remota disponível
cabo desconectado -> ISO remota desaparece
cabo reconectado  -> ISO remota reaparece
```

Não houve travamento no teste. Isso confirma recuperação normal do NetISO quando o enlace físico volta.

O servidor foi posteriormente migrado para um LaunchDaemon de sistema e a biblioteca para `/Users/Shared/xbox360`; consulte [10-netiso-launchdaemon.md](10-netiso-launchdaemon.md).


## Revalidação após integração XboxMac — 2026-10-05

O usuário relatou que não consegue mais carregar um jogo via NetISO.

O baseline continua sendo a validação física de 2026-10-02, quando PES 2018
foi montado e executado com sucesso. Portanto, a investigação deve detectar
qual camada divergiu desse estado conhecido em vez de reinstalar componentes
às cegas.

Foi identificado que o indicador `NetISO=UP` do XboxMac verificava apenas:

- LaunchDaemon `io.remappingbridge.netiso-srv` running;
- TCP `192.168.50.1:4323` aberto.

Isso não comprova o protocolo NetISO nem o lado Xbox.

Correção de diagnóstico:

- o status do XboxMac passa a exigir resposta de protocolo:
  `ISVR -> ISVRokOK`;
- novo diagnóstico somente leitura:
  `scripts/physical-netiso-diagnose.py`;
- o diagnóstico compara o estado atual ao baseline:
  - ProgramArguments do LaunchDaemon;
  - biblioteca `/Users/Shared/xbox360`;
  - enumeração real das ISOs pelo protocolo NetISO;
  - mount/read probe local pelo protocolo;
  - `NetISO.xex` no USB;
  - `NetISO.xex.txt = 192.168.50.1`;
  - `plugin1 = Usb:\\NetISO\\NetISO.xex`;
  - hash do `Hdd1:\\Apps\\Aurora\\Plugins\\Nova.xex` modificado;
  - logs de conexões originadas do Xbox `192.168.50.2`;
  - tentativas `Mounting:` ou `MountIso: Failed`.

Critério para considerar NetISO novamente validado:

    protocolo Mac OK
    + biblioteca enumerada e mount probe OK
    + artefatos Xbox iguais ao baseline
    + conexão real do Xbox observada
    + ISO montada e jogo aberto fisicamente

Status:

    IMPLEMENTED / PHYSICAL_REVALIDATION_PENDING

### Evidência física de revalidação — diagnóstico inicial

Em 2026-10-05 o diagnóstico físico retornou:

- LaunchDaemon NetISO running;
- ProgramArguments iguais ao baseline:
  `/usr/local/libexec/netiso-srv -r -v /Users/Shared/xbox360`;
- protocolo respondeu `ISVRokOK`;
- 8 ISOs locais e exatamente as mesmas 8 enumeradas pelo protocolo;
- mount probe local de `Chavo Kart` retornou mounted=true,
  sector_count=3827488 e sector_size=2048;
- `Nova.xex` remoto possui exatamente o hash congelado do baseline:
  `7be2e01f60065ac642e4393228fa845d4e7b7fa02e8c1183636ee20907e05eee`;
- `Usb0:\\NetISO\\NetISO.xex` presente com 28672 bytes;
- `NetISO.xex.txt = 192.168.50.1`;
- `launch.ini plugin1 = Usb:\\NetISO\\NetISO.xex`;
- logs registraram 2 conexões vindas do Xbox `192.168.50.2`;
- houve comando `Mounting:` para Guitar Hero Live.

O único failure do diagnóstico foi timeout tardio de FTP depois que os
artefatos relevantes já haviam sido confirmados; isso foi corrigido para
warning.

Também foi corrigida a leitura dos logs: stdout e stderr não devem ser
concatenados como se preservassem ordem temporal entre arquivos diferentes.

Próxima validação:

- mount/read probe de todas as ISOs atuais;
- leitura real de bytes via comando NetISO ReadData;
- tentativa física de boot de um título atual;
- correlação com conexão originada de `192.168.50.2`.



### Hipótese QuickView XboxMac Probe

Após revalidar servidor, protocolo, biblioteca e artefatos do Xbox, o usuário
relatou falha ao tentar montar Guitar Hero Live enquanto a QuickView ativa era
`XboxMac Probe`.

Análise do filtro instalado:

- `GameListFilterCategories.User["XboxMac Probe"]` executa manutenção de
  metadata e retorna `true` para todos os itens;
- portanto o filtro isolado não deve bloquear um item;
- porém a composição da QuickView em `settings.db.QuickViews` ainda precisa
  ser inspecionada, pois filtros adicionais podem afetar a visibilidade do
  disco depois do mount.

A documentação do NetISO separa as etapas:

1. Guide -> File Browser -> NetISO;
2. selecionar/montar ISO;
3. voltar ao dashboard Aurora;
4. lançar o jogo montado.

Logo, QuickView pode afetar 3/4, mas não deveria impedir a requisição de mount
1/2.

Novas ferramentas somente leitura:

- `scripts/netiso-attempt-trace.py arm|read`: captura apenas o delta dos logs
  gerado por uma tentativa física, sem probes locais;
- `scripts/inspect-netiso-aurora-view.py`: inspeciona QuickViews,
  SystemSettings, ScanPaths e logs Aurora relacionados a NetISO/Nova/disc.

Próxima validação deve comparar a mesma ISO em:

- QuickView `XboxMac Probe`;
- QuickView padrão sem esse filtro.

Não rodar `physical-netiso-diagnose.py` entre `arm` e `read`, porque seus
mount probes locais contaminam o log.


## Status congelado por decisão do usuário — 2026-10-05

O usuário decidiu congelar temporariamente a investigação do NetISO para
priorizar problemas de exclusão de resíduos Aurora/ConnectX.

Estado preservado para retomada:

- servidor `netiso-srv` responde `ISVRokOK`;
- 8 ISOs locais são enumeradas pelo protocolo;
- as 8 passam no mount probe local;
- `Nova.xex` corresponde ao hash do baseline;
- `NetISO.xex`, `NetISO.xex.txt` e `plugin1` correspondem ao baseline;
- houve conexões históricas vindas de `192.168.50.2`;
- hipótese ainda aberta: runtime do plugin/integração pós-mount e influência
  da QuickView;
- ferramentas preparadas:
  `scripts/netiso-attempt-trace.py` e
  `scripts/inspect-netiso-aurora-view.py`.

Status:

    FROZEN_BY_USER / RESUME_ONLY_ON_REQUEST
