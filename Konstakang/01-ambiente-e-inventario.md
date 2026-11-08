# 01 — Ambiente, inventário e pontos de partida

## Escopo

Reconstruir **um Raspberry Pi 5 com LineageOS Android 16 do KonstaKANG**, gabinete Argon ONE V3, LG DualUp e administração via Mac. Este documento não substitui o procedimento oficial de instalar/flashear o Android: registra a configuração **depois da instalação**.

## Inventário verificado em 08/11/2026

| Item | Evidência |
| --- | --- |
| Placa | ADB: **Pi_5_Model_B_Rev_1_0** |
| Distribuição | LineageOS do KonstaKANG com Android 16 (build exata não coletada) |
| Monitor | LG DualUp, resolução anunciada 2560x2880 |
| Saída de vídeo conectada | /sys/class/drm/card1-HDMI-A-2/modes (na sessão observada) |
| Gabinete / ventilação | Argon ONE V3, microcontrolador de ventoinha no I²C |
| Host de administração | macOS, Android SDK Platform-Tools e SSH |
| IP do Android durante o teste | 192.168.15.11 (não é endereço fixo garantido) |
| Root | ADB: uid=0(root); SSH como root confirmado |
| Apps | GApps e contas Google já presentes; método de instalação original não registrado |
| Atualização futura | Android 17 considerado e **adiado** |

## Dependências confirmadas

- Na distribuição: servidor ADB em rede, SSH integrado e **Rooted debugging** habilitados nas configurações.
- ADB detectou o dispositivo com estado **device**, produto **lineage_rpi5**.
- /dev/i2c-1, /dev/i2c-13, /dev/i2c-14 existiam; /vendor/bin/i2cset e /vendor/bin/i2cdetect estavam presentes.
- /boot/config.txt continha **dtparam=i2c_arm=on**.
- A linha **#dtoverlay=i2c-fan** estava comentada. Não foi necessário habilitá-la para o controlador Argon.
- Temperatura lida em **/sys/class/thermal/thermal_zone0/temp** em milésimos de °C: por exemplo **48500 = 48,5 °C**.
- O host recuperou acesso de escrita a /system usando **adb root** e **adb remount**; resposta de teste: **GRAVACAO_OK**.

## Limites da evidência

- Não há inventário de armazenamento, fonte de alimentação, versão exata do kernel/build, método original de instalação Android, partições de backup, data/versão dos GApps ou MAC address.
- A presença das ferramentas Android não significa que o mesmo método funcione em qualquer imagem. Em particular, o serviço de boot sem Magisk depende da build aceitar remount e arquivos init adicionais.
- O modo HDMI disponível não é sinônimo de resolução lógica configurada pelo Android.
- Uma alteração de DPI **não reduz necessariamente a resolução de renderização HDMI**; não há benchmark comprovando melhora do cursor.
- Os IPs e nomes dos dispositivos DRM podem mudar. Não pressupor /dev/i2c-1 ou card1-HDMI-A-2 em outro Pi sem testar.

## Checklist antes de reconstruir

1. Gravar a imagem do KonstaKANG compatível com **Pi 5**, seguindo o site oficial; validar versão Android.
2. Confirmar alimentação/cabo HDMI e que o LG DualUp anuncia a resolução nativa.
3. Confirmar gabinete **exatamente Argon ONE V3**, não confundir com Argon ONE V2/V5.
4. Configurar ADB e SSH conforme o documento 02.
5. Ajustar vídeo e acessibilidade conforme documento 03.
6. **Testar** manualmente I²C antes de instalar automação (documento 04).
7. Instalar serviço, reiniciar, verificar comportamento e manter cópia de restauração (documentos 05–07).

Referências: https://konstakang.com/devices/rpi5/ e https://developer.android.com/tools/adb
