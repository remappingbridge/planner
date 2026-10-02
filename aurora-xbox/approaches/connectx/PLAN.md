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

A implementação escolhida é **Samba dedicado via Homebrew**, separado do servidor SMB nativo da Apple. Motivos:

- ConnectX exige SMBv1/NT1;
- Samba permite `server min protocol = NT1`;
- Samba permite `interfaces` + `bind interfaces only = yes`, restringindo o serviço à rede privada do Xbox;
- o binário Homebrew usa nome próprio (`samba-dot-org-smbd`) no macOS, reduzindo conflito com o `smbd` da Apple.

A instância será configurada para escutar somente em `127.0.0.1` e `192.168.50.1/en7`, com `hosts allow` limitado a `127.0.0.1` e `192.168.50.0/24`. SMB1 não deve ser exposto pela interface Wi-Fi.

**Gate:** Xbox consegue autenticar no share SMB pela rede privada, e o serviço não fica exposto pelo Wi-Fi.

## CX-02 — preparar jogo, identidade e metadados

Usar um jogo já validado em NetISO para comparação direta, preferencialmente PES 2018. A ISO original permanece intacta.

### CX-02A — extrair a ISO

Preservar:

```text
/Users/Shared/xbox360/<jogo>.iso
```

Criar separadamente:

```text
/Users/Shared/xbox360-connectx/<jogo>/
└── default.xex
```

### CX-02B — validar `default.xex`

Confirmar que a extração produziu o executável principal e os demais arquivos do jogo. O `.xex` sozinho não é tratado como jogo completo.

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

**Gate:** jogo extraído funcional + identidade confirmada + staging de metadata/assets pronto para importação offline.

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