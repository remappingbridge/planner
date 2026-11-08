# 05 — Argon ONE V3: automação de temperatura no Android init (SEM Magisk)

## Objetivo e status

**Status: IMPLEMENTADO E VALIDADO no LineageOS Android 16 / KonstaKANG em 08/11/2026.**

O Android iniciou automaticamente o serviço **argonfan** após o reboot, e a ventoinha respondeu à temperatura reproduzindo um vídeo do YouTube. Não foi necessário Magisk, Termux nem aplicativos Android adicionais.

A implementação usa dois arquivos em **/system**, versionados neste repositório:

| Artefato | Destino no Raspberry Pi |
| --- | --- |
| [arquivos/argonfan.sh](arquivos/argonfan.sh) | /system/bin/argonfan.sh |
| [arquivos/argonfan.rc](arquivos/argonfan.rc) | /system/etc/init/argonfan.rc |

**Diferenciar:** o teste temporário anterior, **/data/local/tmp/argon-fan.sh**, foi executado manualmente e interrompido com Ctrl+C. Não é o serviço permanente. Não rodá-lo em paralelo com **argonfan** porque ambos poderiam alterar a velocidade do cooler ao mesmo tempo.

## 1. Pré-requisitos obrigatórios

1. Usar **Argon ONE V3** de fato e confirmar a comunicação no I²C: [04-argon-v3-i2c-controle-manual.md](04-argon-v3-i2c-controle-manual.md).
2. Confirmar ADB conectado e depuração como root: [02-acesso-adb-ssh.md](02-acesso-adb-ssh.md).
3. Fazer imagem/backup do armazenamento antes de alterar **/system**.
4. Conferir que **/vendor/bin/i2cset** e **/sys/class/thermal/thermal_zone0/temp** continuam disponíveis.
5. O procedimento abaixo é para a imagem que aceitou **adb remount**; não forçar montagem gravável em outra imagem.

## 2. Perfil térmico configurado

| Temperatura lida | Byte da ventoinha | Percentual solicitado |
| --- | --- | --- |
| Abaixo de 55 °C | 0x14 | 20% |
| 55 °C até abaixo de 60 °C | 0x28 | 40% |
| 60 °C até abaixo de 65 °C | 0x46 | 70% |
| 65 °C ou mais | 0x64 | 100% |
| Leitura inválida do sensor | 0x64 | 100% (tentativa de segurança) |

O processo lê a temperatura em **milésimos de °C**, dorme **10 segundos** a cada iteração e **só envia I²C quando a velocidade calculada muda**, evitando comandos repetidos. Se a escrita falhar, tenta novamente na iteração seguinte. O script grava a última transição em **/data/local/tmp/argonfan.status**. Esse arquivo **não é log contínuo** e pode estar desatualizado se a velocidade não mudou.

## 3. Obter os artefatos no Mac (instalação nova)

As fontes estão nesta pasta do repositório. Em um Mac com git:

~~~bash
git clone https://github.com/remappingbridge/planner.git ~/planner-kst
ls -l ~/planner-kst/Konstakang/arquivos/
~~~

O clone é apenas uma forma de baixar os arquivos. Se já tiver uma cópia atualizada, usá-la e **não recriar o script à mão**.

## 4. Preparar gravação do sistema pelo ADB

**No terminal do Mac**, usando o IP atualizado do Pi:

~~~bash
adb connect 192.168.15.11:5555
adb root
adb remount
adb shell 'test -w /system/bin && test -w /system/etc/init && echo GRAVACAO_OK || echo GRAVACAO_BLOQUEADA'
~~~

Saídas reais no teste:

~~~text
Remounted /boot as RW
Remounted / as RW
Remounted /vendor as RW
Remount succeeded
GRAVACAO_OK
~~~

**Se não mostrar GRAVACAO_OK, parar**. Não alterar partições manualmente sem investigar compatibilidade da build. Em outro Android, **adb remount** pode ser proibido.

## 5. Instalar arquivos do serviço

No **Mac**, apontando para a cópia local do repositório:

~~~bash
adb push ~/planner-kst/Konstakang/arquivos/argonfan.sh /system/bin/argonfan.sh
adb push ~/planner-kst/Konstakang/arquivos/argonfan.rc /system/etc/init/argonfan.rc
adb shell chmod 755 /system/bin/argonfan.sh
adb shell chmod 644 /system/etc/init/argonfan.rc
adb shell restorecon /system/bin/argonfan.sh
adb shell restorecon /system/etc/init/argonfan.rc
adb shell ls -l /system/bin/argonfan.sh
adb shell cat /system/etc/init/argonfan.rc
~~~

O **chmod 755** torna o script executável; o **chmod 644** torna a unidade init legível. O **restorecon** restaura rótulos SELinux conforme a imagem.

A unidade versionada declara:

~~~text
service argonfan /system/bin/sh /system/bin/argonfan.sh
    class late_start
    user root
    group root
~~~

O Android **init** lê o arquivo **.rc** e inicia o processo na classe **late_start**. Em outra imagem Android 17, isso precisa ser validado antes de considerar compatível.

## 6. Reiniciar e validar a execução sem intervenção

~~~bash
adb reboot
~~~

Após a inicialização do Android, no Mac:

~~~bash
adb connect 192.168.15.11:5555
adb root
adb shell getprop init.svc.argonfan
adb shell cat /data/local/tmp/argonfan.status
adb shell cat /sys/class/thermal/thermal_zone0/temp
~~~

Saídas verificadas após o reboot em 08/11/2026:

~~~text
running
CPU=47400 FAN=0x14
~~~

Esses dados comprovam que o serviço existe e solicitou **20% a 47,4 °C**. Acompanhe variações, não apenas o arquivo status:

~~~bash
adb shell 'while true; do cat /data/local/tmp/argonfan.status; sleep 3; done'
~~~

Reproduzir um vídeo do YouTube e aguardar elevação térmica; foi observada mudança de **54,55 °C/20%** para **56,2 °C/40%**. **Ctrl+C interrompe somente o comando de observação**, não o serviço.

## 7. Como diagnosticar falhas

~~~bash
adb shell getprop init.svc.argonfan
adb shell ls -l /system/bin/argonfan.sh /system/etc/init/argonfan.rc
adb shell cat /data/local/tmp/argonfan.status
adb shell cat /sys/class/thermal/thermal_zone0/temp
adb shell 'ps -A | grep argonfan'
~~~

- **running**, mas status antigo: o arquivo é atualizado apenas quando a velocidade muda; verificar temperatura, processo e aumento real durante carga.
- **stopped / propriedade vazia**: checar existência dos arquivos, texto do .rc, SELinux, montagem e registros do init no logcat.
- **ERRO I2C**: confirmar /dev/i2c-1, endereço **0x1a**, ferramentas da vendor e hardware. Não remapear barramentos por suposição.
- Em caso de repetidas falhas, há proteção térmica de redução de frequência do SoC, mas ela não substitui um cooler funcional.

## 8. Desabilitar/reverter a automação

Executar no Mac com ADB root; verificar gravação de /system antes. Para parar o processo corrente:

~~~bash
adb shell stop argonfan
~~~

Para impedir o serviço de ser carregado no próximo boot:

~~~bash
adb shell mv /system/etc/init/argonfan.rc /system/etc/init/argonfan.rc.disabled
adb reboot
~~~

Se desejar manter a ventoinha ativa durante diagnóstico (depois de confirmar barramento/endereço):

~~~bash
adb shell /vendor/bin/i2cset -y 1 0x1a 0x80 0x64 b
~~~

Nunca assumir que o comando manual sobreviverá a reboot.

## 9. Limitações e manutenção

- Os arquivos **/system/bin/argonfan.sh** e **/system/etc/init/argonfan.rc** **podem ser substituídos por OTA/instalação limpa**; veja [07-backup-restauracao-atualizacao.md](07-backup-restauracao-atualizacao.md).
- Não há histerese térmica; se a temperatura oscilar perto de 55/60/65 °C, a velocidade poderá alternar.
- O serviço observa CPU, não a temperatura do controlador Argon; a porcentagem de velocidade não foi medida por tacômetro.
- Foi validado **apenas no hardware e Android 16 descritos**, não no Android 17.
