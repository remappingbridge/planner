# CX-01 — backend SMB/NetBIOS isolado no Mac

> **Status funcional: VALIDADO em 2026-10-02. LaunchDaemons configurados; validação pós-reboot foi adiada para o gate final de coexistência.**

## Implementação

- Homebrew: `/opt/homebrew`;
- Samba: 4.25.0;
- configuração dedicada: `/opt/homebrew/etc/samba-xbox/smb.conf`;
- biblioteca ConnectX: `/Users/Shared/xbox360-connectx`;
- NetBIOS name: `XBOXMAC`;
- share: `XBOX360`;
- protocolo: SMB1/NT1;
- autenticação: usuário Samba `admin` (senha não versionada);
- share read-only;
- rede privada: `192.168.50.0/24`;
- Mac: `192.168.50.1` em `en7`.

## Evidências

`testparm` carregou a configuração sem erro e confirmou:

```text
bind interfaces only = Yes
interfaces = 127.0.0.1 192.168.50.1/24
netbios name = XBOXMAC
ntlm auth = ntlmv1-permitted
server min protocol = NT1
server max protocol = NT1
hosts allow = 127.0.0.1 192.168.50.0/24
hosts deny = ALL
```

A conta Samba existe:

```text
admin:501:Talita
```

Autenticação SMB local validada:

```text
//192.168.50.1/XBOX360
-> CX-01-READY.txt
```

`smbd` escuta somente na rede privada e loopback:

```text
192.168.50.1:445
192.168.50.1:139
127.0.0.1:445
127.0.0.1:139
```

Teste pelo Wi-Fi do Mac:

```text
192.168.15.11:445
-> Connection refused
```

Logo, SMB/TCP não está exposto pelo Wi-Fi.

## NetBIOS

O `netbiosd` nativo do macOS ocupava UDP 137/138 e impedia `nmbd` de permanecer ativo. Foi desabilitado de forma persistente via `launchctl unload -w` para esta implementação.

Depois disso, `nmbd` iniciou e `XBOXMAC` passou a resolver corretamente:

```text
broadcast 192.168.50.255:
192.168.50.1 XBOXMAC<00>

unicast 192.168.50.1:
192.168.50.1 XBOXMAC<00>
```

## Rollback do NetBIOS nativo

Se a abordagem ConnectX for removida, o serviço Apple pode ser reativado com:

```bash
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist
```

## Persistência / reboot

Foram criados LaunchDaemons próprios para `smbd` e `nmbd`, usando um wrapper que aguarda `en7` adquirir `192.168.50.1` antes de iniciar os processos.

Na primeira tentativa os dois jobs ficaram em `spawn scheduled` com `last exit code = 1`. O reboot real não será executado agora por decisão operacional do usuário.

A validação pós-reboot foi transferida para o gate final de coexistência (CX-07), junto com a validação completa de NetISO + ConnectX. Antes disso, os LaunchDaemons serão corrigidos e validados na sessão atual.

### Evidência pré-reboot — 2026-10-03

Antes do reboot real foi auditado o estado dos serviços:

- os plists `io.remappingbridge.connectx-smbd.plist` e `io.remappingbridge.connectx-nmbd.plist` existem em `/Library/LaunchDaemons`;
- ambos chamam `/usr/local/libexec/xbox-connectx-samba` com argumento `smbd` ou `nmbd`, usam `RunAtLoad=true`, `KeepAlive=true` e `ThrottleInterval=5`;
- `launchctl print system` mostrou somente `io.remappingbridge.netiso-srv` carregado; os dois jobs ConnectX não estavam carregados no launchd;
- apesar disso, `samba-dot-org-smbd` e `nmbd` estavam em execução manual como root;
- `smbd` escutava em `192.168.50.1:445/139` e `127.0.0.1:445/139`;
- `nmbd` escutava UDP 137/138;
- `en7` estava ativo em `192.168.50.1/24`, 100baseTX full-duplex;
- `testparm` validou novamente a configuração dedicada;
- NetISO estava carregado pelo launchd e ouvindo em TCP 4323, com conexões estabelecidas ao Xbox.

Conclusão: **não reiniciar ainda**. O estado atual prova que a sessão funciona, mas não prova autostart ConnectX; como os processos Samba/NetBIOS estão ativos fora do launchd, o reboot agora provavelmente os perderia. O próximo passo é corrigir/carregar os jobs ConnectX e validar o wrapper/logs antes do reboot.


### Diagnóstico do wrapper/LaunchDaemons — 2026-10-03

A inspeção do wrapper e dos plists descartou a hipótese de daemonização incorreta:

- `/usr/local/libexec/xbox-connectx-samba` espera `en7` adquirir `192.168.50.1`;
- para `smbd`, usa `exec ... samba-dot-org-smbd -F -s <conf>`;
- para `nmbd`, usa `exec ... nmbd -F -s <conf>`;
- portanto ambos permanecem em foreground e são apropriados para supervisão por `launchd`;
- os dois plists passam em `plutil -lint`;
- ownership/permissões: plists `root:wheel 0644`, wrapper `root:wheel 0755`;
- logs dedicados estavam vazios;
- os jobs ConnectX não apareciam em `launchctl print system`, enquanto processos Samba/NetBIOS manuais estavam ativos.

Conclusão: o problema atual não está no wrapper nem na sintaxe dos plists. O foco passa a ser registrar/carregar os dois LaunchDaemons no domínio `system` e substituir de forma controlada os processos manuais pelos processos supervisionados pelo `launchd`, antes do reboot real.


### Bootstrap controlado falhou — 2026-10-03

Após encerrar as instâncias manuais de `smbd` e `nmbd`, os dois LaunchDaemons foram registrados com `launchctl bootstrap system`, porém ambos falharam imediatamente:

- `io.remappingbridge.connectx-smbd`: `state = spawn scheduled`, `active count = 0`, `runs = 1`, `last exit code = 1`;
- `io.remappingbridge.connectx-nmbd`: mesmo estado e `last exit code = 1`;
- nenhum processo Samba/NetBIOS permaneceu ativo;
- nenhuma porta SMB/NetBIOS ficou aberta;
- `nmblookup XBOXMAC` falhou;
- portanto o problema é reproduzível mesmo com wrapper em foreground e plists válidos.

Conclusão: **CX-07 continua bloqueado e o Mac não deve ser reiniciado ainda**. Próximo diagnóstico: capturar stderr/logs gerados por essa tentativa, verificar pid/state files remanescentes e executar cada wrapper fora do launchd em ambiente limpo para separar falha do Samba de falha específica do launchd.


### Causa raiz provável confirmada — setsid / no-process-group

O diagnóstico manual reproduziu a mesma falha fora do launchd:

- `smbd -F` via wrapper terminou com exit 1;
- `nmbd -F` via wrapper terminou com exit 1;
- os logs nativos de ambos registraram repetidamente `Failed to create session, error code 1`;
- ao restaurar com `-D`, ambos iniciaram normalmente e voltaram a escutar nas portas esperadas.

A implementação Samba 4.25 chama `setsid()` no caminho de foreground quando `no_session` não está habilitado. Em um processo que já é líder de grupo, `setsid()` retorna EPERM (errno 1), exatamente o erro observado. A correção candidata é iniciar em foreground com `--no-process-group`, preservando a supervisão pelo launchd sem tentar criar nova sessão.

Próximo gate técnico: alterar somente o wrapper para acrescentar `--no-process-group` a `smbd -F` e `nmbd -F`, testar manualmente e então via `launchctl bootstrap`. Reboot continua bloqueado até os dois jobs ficarem em `state = running`.


### Correção confirmada — --no-process-group

A hipótese de falha em `setsid()` foi confirmada operacionalmente.

O wrapper `/usr/local/libexec/xbox-connectx-samba` foi alterado para usar:

- `samba-dot-org-smbd -F --no-process-group -s <conf>`;
- `nmbd -F --no-process-group -s <conf>`.

Validação manual em foreground:

- `smbd_foreground=ALIVE`;
- `nmbd_foreground=ALIVE`;
- stderr vazio para ambos.

Isso elimina a falha anterior `Failed to create session, error code 1` sem voltar ao modo daemonizado `-D`, preservando compatibilidade com supervisão por `launchd`.

Próximo passo: carregar os dois LaunchDaemons no domínio `system`, confirmar `state = running`, validar portas/NetBIOS/ConnectX e somente então executar reboot real.
