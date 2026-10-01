# 03 — Backup da NAND

## Ferramenta usada

Foi usado **Simple 360 NAND Flasher v1.5b read-only**.

Pacote:

```text
simple-360-nand-flasher-v1.5b-read-only.zip
```

Origem usada:

https://github.com/alex-free/XDK_Projects/releases/download/v1.5b/simple-360-nand-flasher-v1.5b-read-only.zip

A build read-only foi escolhida para eliminar a opção de gravar a NAND durante esta etapa.

Instalação temporária no pendrive:

```text
Usb:\Apps\SimpleNAND\Default.xex
```

Durante a etapa de dump, o `launch.ini` apontou temporariamente para:

```ini
Default = Usb:\Apps\SimpleNAND\default.xex
```

## Dumps realizados

Foram feitas duas leituras e comparadas no Debian.

Tamanho de cada dump:

```text
17301504 bytes
```

SHA-256 das duas cópias:

```text
4120f9003fdaf7e22a95f99dddb152f84d6995652b6f81f0944bf2e7fac9dd93
```

Comparação byte a byte:

```text
NAND: DUAS LEITURAS IDENTICAS
```

Isso foi validado com:

```bash
sha256sum \
"$BACKUP/flashdmp-1.bin" \
"$BACKUP/flashdmp-2.bin"

cmp -s \
"$BACKUP/flashdmp-1.bin" \
"$BACKUP/flashdmp-2.bin" \
&& echo "NAND: DUAS LEITURAS IDENTICAS" \
|| echo "NAND: LEITURAS DIFERENTES"
```

## Local exato do backup no Debian

Backup criado em:

```text
/home/tiago/xbox360-1538-backup-20261001-190729/
```

Conteúdo registrado:

```text
ConsoleInfo.txt
cpukey.txt
flashdmp-1.bin
flashdmp-2.bin
OriginalMACAddress.bin
```

Permissões aplicadas:

```text
-rw------- ConsoleInfo.txt
-rw------- cpukey.txt
-rw------- flashdmp-1.bin
-rw------- flashdmp-2.bin
-rw------- OriginalMACAddress.bin
```

### Dados sensíveis

`cpukey.txt` e `ConsoleInfo.txt` contêm informações únicas do console.

**Não copiar o conteúdo desses arquivos para este repositório, issues públicas, chats públicos ou serviços não confiáveis.**

Os dumps da NAND também não devem ser versionados no Git.

## Arquivos observados no pendrive

Após os dumps, `Apps/SimpleNAND/` continha:

```text
cpukey.txt
Default.xex
flashdmp_403175141900.bin
flashdmp.bin
readme-orig.txt
readme.txt
Simple 360 NAND Flasher.log
```

Não depender desses arquivos no USB como backup permanente. A cópia de referência é a pasta em `/home/tiago/`.

## Como copiar para armazenamento externo no futuro

### 1. Conectar o armazenamento e identificar o mount point

```bash
lsblk -f
```

Exemplo hipotético:

```text
/dev/sdf1 -> /media/tiago/Backup
```

**Não usar `/dev/sdf1` sem confirmar o dispositivo real da sessão.**

### 2. Definir origem e destino

```bash
SRC="$HOME/xbox360-1538-backup-20261001-190729"
DEST="/media/tiago/Backup/xbox360-1538-backup-20261001-190729"
```

Substituir `/media/tiago/Backup` pelo mount point real.

### 3. Copiar com rsync

```bash
mkdir -p "$DEST"

rsync -aH --info=progress2 \
"$SRC/" \
"$DEST/"
```

### 4. Forçar flush

```bash
sync
```

### 5. Verificar os dumps no destino

```bash
sha256sum \
"$SRC/flashdmp-1.bin" \
"$SRC/flashdmp-2.bin" \
"$DEST/flashdmp-1.bin" \
"$DEST/flashdmp-2.bin"
```

Os quatro hashes dos dumps devem ser:

```text
4120f9003fdaf7e22a95f99dddb152f84d6995652b6f81f0944bf2e7fac9dd93
```

Também é possível confirmar byte a byte:

```bash
cmp "$SRC/flashdmp-1.bin" "$DEST/flashdmp-1.bin"
cmp "$SRC/flashdmp-2.bin" "$DEST/flashdmp-2.bin"
```

Sem saída de `cmp` = arquivos idênticos.

### 6. Desmontar corretamente

Descobrir o device associado ao mount point e desmontar:

```bash
findmnt "$DEST"
```

ou desmontar pelo mount point:

```bash
udisksctl unmount -b /dev/sdX1
```

Substituir `/dev/sdX1` pelo dispositivo real.

## Recomendação para FAT32/exFAT/NTFS

Em FAT32/exFAT/NTFS, permissões Unix como `chmod 600` podem não ser preservadas.

Para uma cópia externa portátil, é melhor também criar um **arquivo criptografado** contendo todo o backup.

Exemplo com GnuPG:

```bash
ARCHIVE="/tmp/xbox360-1538-backup-20261001-190729.tar.gz"

tar -C "$HOME" -czf "$ARCHIVE" \
xbox360-1538-backup-20261001-190729

gpg --symmetric --cipher-algo AES256 \
-o "$DEST/xbox360-1538-backup-20261001-190729.tar.gz.gpg" \
"$ARCHIVE"

rm -f "$ARCHIVE"
sync
```

Guardar a senha do arquivo criptografado fora do próprio armazenamento.

Para restaurar no futuro:

```bash
gpg -o /tmp/xbox360-backup.tar.gz \
-d xbox360-1538-backup-20261001-190729.tar.gz.gpg

tar -C "$HOME" -xzf /tmp/xbox360-backup.tar.gz
rm -f /tmp/xbox360-backup.tar.gz
```

Depois validar novamente o SHA-256 dos dumps.

## Regra operacional

Antes de qualquer futura mudança de baixo nível:

1. confirmar que esta pasta local ainda existe;
2. confirmar o SHA-256 dos dois dumps;
3. manter pelo menos uma segunda cópia offline/externa;
4. nunca compartilhar CPUKey/DVDKey publicamente.
