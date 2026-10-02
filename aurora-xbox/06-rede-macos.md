# 06 — Rede privada MacBook ↔ Xbox 360

> **Status (2026-10-01): VALIDADO.** A rede Ethernet ponto a ponto funciona sem modem, roteador, DHCP ou Internet. O Aurora responde por FTP e o servidor NetISO no Mac escuta em TCP 4323.

## Objetivo

Criar uma rede portátil e independente de qualquer infraestrutura externa:

```text
MacBook
192.168.50.1/24
      |
      | Ethernet via docking station
      |
Xbox 360
192.168.50.2/24
```

O MacBook pode continuar usando Wi-Fi para sua própria Internet, mas **não há Internet Sharing/NAT para o Xbox**.

## MacBook

Plataforma observada:

```text
Architecture: arm64
macOS: 27.0
```

A interface Ethernet real da docking station foi identificada como:

```text
Network service: USB 10/100 LAN
Device:          en7
```

Os dispositivos `en4`, `en5` e `en6` estavam inativos e não correspondem à porta usada.

### Configuração aplicada

```text
IP:       192.168.50.1
Mask:     255.255.255.0 (/24)
Router:   0.0.0.0
DNS:      vazio
IPv6:     Automatic (sem endereço ativo observado)
```

Comandos usados:

```bash
sudo networksetup -setmanual \
  "USB 10/100 LAN" \
  192.168.50.1 \
  255.255.255.0 \
  0.0.0.0

sudo networksetup -setdnsservers \
  "USB 10/100 LAN" \
  empty
```

Validação:

```text
IP address: 192.168.50.1
Subnet mask: 255.255.255.0
Router: 0.0.0.0

en7:
inet 192.168.50.1 netmask 0xffffff00
status: active
media: 100baseTX full-duplex
```

A rota padrão do Mac continuou no Wi-Fi:

```text
interface: en0
```

Assim, alterar `en7` não interrompeu a sessão SSH via Wi-Fi.

## Xbox 360

Configuração manual aplicada na interface **Wired Network** do dashboard retail:

```text
IP Address:  192.168.50.2
Subnet Mask: 255.255.255.0
Gateway:     192.168.50.1
```

O gateway é apenas um valor aceito pela configuração do Xbox; o Mac não está configurado para compartilhar Internet/NAT nesta rede.

## Testes

### Rota no Mac

```bash
route -n get 192.168.50.2
```

Resultado relevante:

```text
destination: 192.168.50.0
interface: en7
```

### ICMP

```bash
ping -c 4 192.168.50.2
```

Resultado observado: 100% packet loss.

Isso **não foi tratado como falha da rede**, porque os testes de camada 2 e TCP passaram.

### ARP

```bash
arp -an | grep '192.168.50.2'
```

O Mac resolveu corretamente o endereço Ethernet do Xbox em `en7`. Isso confirmou vizinhança L2 direta.

### FTP do Aurora

Com o Xbox desbloqueado e Aurora aberto:

```bash
nc -vz 192.168.50.2 21
```

Resultado:

```text
Connection to 192.168.50.2 port 21 [tcp/ftp] succeeded!
```

Isso validou tráfego TCP Mac → Xbox/Aurora.

## Servidor NetISO no Mac

Repositório:

```text
https://github.com/tuxuser/netiso-srv.git
```

Checkout local:

```text
/Users/admin/Documents/xbox360-tools/netiso-srv
```

Biblioteca de ISOs:

```text
/Users/admin/Documents/xbox360
```

O binário foi compilado para o Mac ARM64 e está executando.

Testes:

```bash
lsof -nP -iTCP:4323 -sTCP:LISTEN
nc -vz 127.0.0.1 4323
nc -vz 192.168.50.1 4323
```

Resultados validados:

```text
netiso-srv ... TCP *:4323 (LISTEN)
Connection to 127.0.0.1 port 4323 succeeded
Connection to 192.168.50.1 port 4323 succeeded
```

## Topologia final validada desta etapa

```text
Internet opcional
      |
Wi-Fi / en0
      |
   MacBook
      |
      | en7 / USB 10/100 LAN
      | 192.168.50.1/24
      | TCP 4323 netiso-srv
      |
      +---------------- Ethernet ----------------+
                                                |
                                         Xbox 360
                                         192.168.50.2/24
                                         Aurora FTP :21
```

Não depende de modem, DHCP ou configuração da rede do local.

## Próximo passo

Instalar o lado Xbox do NetISO:

- `Nova.xex` modificado no Aurora;
- `NetISO.xex`;
- `NetISO.xex.txt` apontando para `192.168.50.1`;
- NetISO como `plugin1` no `launch.ini` do pendrive;
- validar montagem de uma ISO real.
