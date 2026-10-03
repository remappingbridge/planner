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
