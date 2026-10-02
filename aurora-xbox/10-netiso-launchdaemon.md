# 10 — Servidor NetISO como LaunchDaemon

Data: 2026-10-02

## Decisão

O LaunchAgent por usuário foi substituído por um LaunchDaemon de sistema.

Motivos:

- iniciar no boot sem depender de login gráfico;
- evitar depender do Terminal;
- manter o serviço no domínio `system` do `launchd`;
- tirar binário e biblioteca de ISOs de `~/Documents`.

## Caminhos finais

Binário instalado:

```text
/usr/local/libexec/netiso-srv
```

Biblioteca de ISOs:

```text
/Users/Shared/xbox360
```

LaunchDaemon:

```text
/Library/LaunchDaemons/io.remappingbridge.netiso-srv.plist
```

Logs:

```text
/tmp/netiso-srv.log
/tmp/netiso-srv.err.log
```

## Execução

O daemon executa:

```text
/usr/local/libexec/netiso-srv -r -v /Users/Shared/xbox360
```

como usuário:

```text
admin
```

Configuração principal:

```xml
<key>RunAtLoad</key>
<true/>
<key>KeepAlive</key>
<true/>
```

## Validação

O plist passou em:

```text
plutil: OK
```

O serviço foi carregado no domínio:

```text
system/io.remappingbridge.netiso-srv
```

Estado observado:

```text
state = running
runs = 2
pid = 1467
```

A porta foi confirmada por `lsof`:

```text
netiso-srv ... TCP *:4323 (LISTEN)
```

Isso confirma que o LaunchDaemon abriu corretamente a porta TCP usada pelo NetISO.

## Arquitetura final do servidor

```text
boot do macOS
    |
    v
launchd / system
    |
    v
io.remappingbridge.netiso-srv
    |
    v
/usr/local/libexec/netiso-srv
    |
    +--> /Users/Shared/xbox360
    |
    +--> TCP *:4323
```

O MacBook pode continuar usando Wi-Fi normalmente; o Xbox acessa o serviço pela rede Ethernet privada em `192.168.50.1:4323`.
