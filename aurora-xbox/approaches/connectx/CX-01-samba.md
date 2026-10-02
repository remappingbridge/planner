# CX-01 — backend SMB/NetBIOS isolado no Mac

> **Status funcional: VALIDADO em 2026-10-02. Persistência no boot em validação.**

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

## Pendência para fechamento operacional

Transformar `smbd` e `nmbd` em LaunchDaemons próprios e validar após reboot real do Mac. Como `en7` pode estar sem link durante o boot, os serviços devem aguardar `192.168.50.1` aparecer antes de iniciar.