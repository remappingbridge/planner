# 07 — Pacote NetISO validado no macOS

Data: 2026-10-01

## Arquivo baixado

Arquivo original:

```text
~/Downloads/Nova+NetISO-Aurora0.7b.zip
```

Cópia de trabalho:

```text
~/Documents/xbox360-tools/Nova-NetISO-Aurora0.7b.zip
```

Tamanho observado:

```text
402K
```

Tipo identificado pelo macOS:

```text
Zip archive data, at least v2.0 to extract, compression method=deflate
```

SHA-256:

```text
b029bb60e1b740d3dfcb307e9ed1f413518795da354a3f50bae2501435c2b16f
```

## Integridade

Foi executado:

```bash
unzip -t Nova-NetISO-Aurora0.7b.zip
```

Resultado:

```text
No errors detected in compressed data of Nova-NetISO-Aurora0.7b.zip.
```

## Conteúdo extraído

```text
netiso-stage/netiso/NetISO.xex
netiso-stage/netiso/NetISO.xex.txt
netiso-stage/netiso/server.exe
netiso-stage/netiso/README.txt
netiso-stage/modified-freestyleplugin.xex/FreestylePlugin.xex
netiso-stage/modified-nova.xex/Nova.xex
```

Arquivos relevantes para Aurora:

```text
Nova:   netiso-stage/modified-nova.xex/Nova.xex
NetISO: netiso-stage/netiso/NetISO.xex
Config: netiso-stage/netiso/NetISO.xex.txt
```

Nesta arquitetura:

- usar o `Nova.xex` modificado;
- usar `NetISO.xex`;
- usar `NetISO.xex.txt`;
- não usar `FreestylePlugin.xex`, pois o dashboard é Aurora;
- não usar `server.exe`, pois o servidor escolhido no Mac é `tuxuser/netiso-srv`.

## Próximo passo

Antes de substituir qualquer arquivo no Xbox:

1. fazer backup do `Hdd1:\Apps\Aurora\Plugins\Nova.xex` original;
2. configurar `NetISO.xex.txt` com `192.168.50.1`;
3. copiar o `Nova.xex` modificado para o Aurora no HDD;
4. colocar `NetISO.xex` e sua configuração no pendrive/chave;
5. definir NetISO como `plugin1` no `launch.ini`;
6. reiniciar a sessão desbloqueada e testar uma ISO real.

A alternância deve continuar preservada:

```text
USB fora + reboot -> retail
USB + exploit     -> Aurora/NetISO
```
