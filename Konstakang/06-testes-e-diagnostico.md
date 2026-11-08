# 06 — Evidências de testes e roteiro de verificação

**Data:** 08/11/2026. Apenas observações fornecidas no terminal/conversa; não são testes automatizados executados pelo repositório.

## 1. ADB e SSH — aprovados

~~~text
adb connect 192.168.15.11:5555
already connected to 192.168.15.11:5555

adb devices -l
192.168.15.11:5555 device product:lineage_rpi5 model:Pi_5_Model_B_Rev_1_0 device:rpi5 transport_id:1

adb root
restarting adbd as root

adb shell id
uid=0(root) ... context=u:r:su:s0
~~~

A conexão SSH com identidade local no Mac resultou em prompt root **:/ #**. Não foi necessário Magisk.

## 2. Monitor — aprovado visualmente pelo operador

~~~text
wm size
Physical size: 2560x2880

wm density
Physical density: 480
~~~

Após **wm density 640**, fonte **1.6**, rotação **lock 1** e Aspect Ratio **Original** no monitor, o operador confirmou **“deu certo”**. A exibição com a rotação de 90° ficou adequada à finalidade e ícones/textos maiores. A posição normal exige voltar a orientação lógica para **lock 0**; a troca entre as duas orientações não foi automatizada.

A configuração de 1920 × 2160 foi **testada e abandonada**. Não estava disponível como modo HDMI anunciado pelo EDID; o override lógico do Android não criou um modo HDMI real.

## 3. I²C e cooler — aprovado

~~~text
cat /sys/class/thermal/thermal_zone0/temp
48500

ls -l /dev/i2c-*
/dev/i2c-1
/dev/i2c-13
/dev/i2c-14

command -v i2cset
/vendor/bin/i2cset

i2cdetect -y 1 0x1a 0x1a
... 1a ...
~~~

A primeira tentativa sem modo de byte:

~~~text
i2cset -y 1 0x1a 0x80 0x64
i2cset: mode too long (see "i2cset --help")
~~~

Com modo byte **b**, funcionou e a velocidade mudou audivelmente:

~~~sh
i2cset -y 1 0x1a 0x80 0x64 b
i2cset -y 1 0x1a 0x80 0x1e b
~~~

## 4. Script manual temporário — aprovado

Executado com **sh /data/local/tmp/argon-fan.sh** em sessão root antes de instalar a automação. Saídas observadas ao usar e pausar YouTube:

~~~text
Sun Nov  8 16:41:00 -03 2026 CPU=44650 velocidade=0x14
Sun Nov  8 16:44:21 -03 2026 CPU=56200 velocidade=0x28
Sun Nov  8 16:45:01 -03 2026 CPU=52350 velocidade=0x14
~~~

Interpretar: **44,65 °C → 20%**, **56,2 °C → 40%**, **52,35 °C → 20%**. A sessão de teste foi interrompida com Ctrl+C; não deve permanecer executando junto do serviço de boot.

## 5. Instalação do serviço de boot — aprovada

~~~text
adb remount
Remounted /boot as RW
Remounted / as RW
Remounted /vendor as RW
Remount succeeded

test -w /system/bin && test -w /system/etc/init
GRAVACAO_OK

ls -l /system/bin/argonfan.sh
-rwxr-xr-x 1 root shell 916 ... /system/bin/argonfan.sh

cat /system/etc/init/argonfan.rc
service argonfan /system/bin/sh /system/bin/argonfan.sh
    class late_start
    user root
    group root
~~~

Após **adb reboot**, sem executar manualmente o controlador:

~~~text
adb shell getprop init.svc.argonfan
running

adb shell cat /data/local/tmp/argonfan.status
CPU=47400 FAN=0x14
~~~

**Teste funcional após reboot:**

~~~text
CPU=54550 FAN=0x14
CPU=56200 FAN=0x28
~~~

Ao reproduzir vídeo do YouTube, o valor passou de **20% a 54,55 °C** para **40% a 56,2 °C**, confirmando a reação do serviço. O comando de observação foi encerrado com Ctrl+C, não o serviço.

## 6. Roteiro de aceite numa recuperação

- [ ] ADB mostra estado **device** e **adb shell id** indica root.
- [ ] SSH acessa o dispositivo correto sem expor chave privada.
- [ ] Resolução HDMI física nativa do DualUp **2560x2880**.
- [ ] Com o monitor girado, conteúdo mantém proporção correta; OSD **Original**.
- [ ] Fonte **1.6** e DPI **640** deixam ícones/textos suficientemente grandes.
- [ ] Controlador Argon V3 detectado em barramento e endereço confirmados no hardware.
- [ ] Comando manual 100%/30% modifica a ventoinha.
- [ ] Depois de reiniciar, **init.svc.argonfan = running** sem iniciar script manual.
- [ ] Durante carga, comando de velocidade muda ao ultrapassar 55 °C; ao esfriar, diminui.
- [ ] Após um segundo reboot, a mesma automação continua operante.
- [ ] Backup do armazenamento e dos arquivos de /system existe em local seguro.

## 7. Diagnóstico rápido via ADB

~~~bash
adb connect 192.168.15.11:5555
adb root
adb shell getprop init.svc.argonfan
adb shell cat /data/local/tmp/argonfan.status
adb shell cat /sys/class/thermal/thermal_zone0/temp
adb shell wm size
adb shell wm density
adb shell wm user-rotation
adb shell settings get system font_scale
~~~

Use sempre o IP atual do Pi. O arquivo **argonfan.status** registra só a última **transição de velocidade** e não é uma telemetria contínua. Não há relatório de benchmark nem medição independente de RPM.
