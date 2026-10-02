# Plano de implementação — ConnectX

## Princípios

- NetISO permanece funcionando durante todo o experimento.
- A biblioteca ISO em `/Users/Shared/xbox360` não será modificada.
- Criar uma biblioteca ConnectX separada.
- SMB1/NT1 deve ficar restrito à Ethernet privada do Xbox, não ao Wi-Fi do Mac.
- Credenciais SMB não devem ser versionadas no planner.
- Testar primeiro com **um único jogo**.
- Só expandir para a biblioteca inteira depois de validar CoverFlow, capas e estabilidade.

## CX-00 — congelar baseline e rollback

Antes de instalar ConnectX:

- registrar estado atual dos plugins do Aurora;
- manter backup do `Nova.xex` original já existente;
- registrar `launch.ini` atual;
- confirmar NetISO funcionando;
- confirmar `USB fora + reboot = retail`.

**Gate:** baseline NetISO continua funcional e há rollback documentado.

## CX-01 — backend SMB isolado no Mac

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

1. verificar se o serviço SMB disponível no macOS 27 suporta o protocolo exigido pelo ConnectX e isolamento por interface;
2. se não suportar, usar uma instância Samba dedicada (por exemplo Homebrew) com `server min protocol = NT1` e bind somente em `en7/192.168.50.1`;
3. não habilitar SMB1 na interface Wi-Fi.

**Gate:** Xbox consegue autenticar no share SMB pela rede privada, e o serviço não fica exposto pelo Wi-Fi.

## CX-02 — preparar um jogo extraído

Usar um jogo que já foi validado em NetISO para comparação direta, preferencialmente PES 2018.

Preservar:

```text
/Users/Shared/xbox360/<jogo>.iso
```

Criar separadamente:

```text
/Users/Shared/xbox360-connectx/<jogo>/
└── default.xex
```

A extração deve remover apenas o que for seguro remover, sem alterar a ISO original.

**Gate:** pasta contém `default.xex` e arquivos completos do jogo; ISO original continua intacta.

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

Validar ainda reboot do Mac, serviços automáticos, cabo removido/reconectado, NetISO, ConnectX e `USB removido + reboot = retail`.

**Gate de conclusão:** NetISO e ConnectX coexistem sem regressão.

## Depois do CX-07

Congelar a configuração ConnectX validada e seguir para [../god-local/](../god-local/).