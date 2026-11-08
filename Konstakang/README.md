# KonstaKANG — Raspberry Pi 5 / LineageOS Android 16

**Propósito:** registro técnico reproduzível da instalação já configurada e testada no Raspberry Pi 5, para restaurá-la depois de uma reinstalação/atualização ou aplicá-la em outro Pi 5.

**Estado documentado:** 08/11/2026. O objetivo é registrar o que **foi confirmado na máquina**, separado de sugestões e de testes ainda pendentes. **Nenhuma atualização para Android 17 foi executada.**

## Ambiente

- Raspberry Pi 5 Model B (rev. 1.0, identificado pelo ADB).
- LineageOS baseado em Android 16, distribuição KonstaKANG. O número exato da build **não foi coletado** nesta sessão.
- Gabinete **Argon ONE V3**, ventoinha comandada por I²C.
- Monitor **LG DualUp**, HDMI nativo 2560 × 2880, também usado fisicamente a 90°.
- Mac com Android Platform-Tools como estação de administração por ADB/SSH.
- Google Apps/serviços Google e contas já configurados pelo operador; não há registro dos passos de instalação dos GApps.

## Índice — leia na ordem para reproduzir

1. [Ambiente e pré-requisitos](01-ambiente-e-inventario.md) — hardware, estado conhecido, dependências e limites.
2. [Acesso remoto: ADB + SSH](02-acesso-adb-ssh.md) — pareamento, root, chave, diagnóstico e segurança.
3. [Vídeo, proporção, rotação, DPI e fontes](03-lg-dualup-video-acessibilidade.md) — imagem sem distorção e interface extragrande.
4. [Argon ONE V3: hardware e I²C](04-argon-v3-i2c-controle-manual.md) — detecção, protocolo e teste manual.
5. [Argon ONE V3: serviço automático sem Magisk](05-argon-v3-automacao-init.md) — script, serviço Android init, instalação e reversão.
6. [Evidências e verificação](06-testes-e-diagnostico.md) — saídas reais observadas e roteiro de aceite.
7. [Backup, recuperação e atualização](07-backup-restauracao-atualizacao.md) — cópias, riscos de OTA e reconstrução.

## Artefatos versionados

- [arquivos/argonfan.sh](arquivos/argonfan.sh): controlador térmico instalado em **/system/bin/argonfan.sh**.
- [arquivos/argonfan.rc](arquivos/argonfan.rc): definição do serviço instalado em **/system/etc/init/argonfan.rc**.

Estes dois arquivos são os artefatos da **automação permanente**, diferentes do script de teste temporário **/data/local/tmp/argon-fan.sh**.

## Estado final observado

| Elemento | Estado validado |
| --- | --- |
| ADB TCP | Conectado em 192.168.15.11:5555 durante os testes |
| Root pelo ADB e SSH | Confirmado; não precisou de Magisk |
| HDMI | 2560 × 2880 detectados e selecionados |
| Monitor | Aspect Ratio = Original no menu físico |
| Orientação em uso | Rotação Android travada em 90° |
| Densidade da interface | 640 dpi (ajuste lógico; valor físico reportado = 480) |
| Escala de fontes | 1.6 |
| Cooler Argon V3 | Controlador 0x1a em /dev/i2c-1; escrita manual funcionou |
| Serviço permanente | init.svc.argonfan = running após reboot |
| Controle térmico | Registrou 47,4 °C → 20% e 56,2 °C → 40% após reinício |

**Atenção:** este repositório é público. **Nunca suba chaves SSH privadas, senhas, tokens, backups de contas, dados de apps, dados de usuário ou arquivos com credenciais.** O endereço 192.168.15.11 foi observado na LAN naquele dia; descubra o IP real em outra instalação.

## Recuperação rápida

Consulte [07-backup-restauracao-atualizacao.md](07-backup-restauracao-atualizacao.md). O serviço está em **/system** e pode desaparecer numa atualização do Android. Os ajustes de DPI/fontes/rotação costumam persistir numa atualização que preserve dados, mas **isso não foi testado no Android 17**. Faça imagem integral do armazenamento antes de migrar.

## Fontes técnicas

- KonstaKANG Raspberry Pi 5: https://konstakang.com/devices/rpi5/
- Android Debug Bridge: https://developer.android.com/tools/adb
- Android init: https://android.googlesource.com/platform/system/core/+/master/init/README.md

Documentação de uma experiência concreta, não um instalador universal. Em outro Raspberry Pi 5, valide cada componente antes de enviar comandos I²C ou modificar /system.
