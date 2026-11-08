# 04 — Argon ONE V3: I²C e controle manual da ventoinha

## O que foi comprovado

Em 08/11/2026, no Raspberry Pi 5 com LineageOS Android 16 KonstaKANG, o microcontrolador do gabinete **Argon ONE V3** respondeu no **barramento I²C 1, endereço 0x1a**. Os comandos de ventilação máxima e 30% foram executados com sucesso; o operador confirmou alteração audível da velocidade.

Não confundir com modelos Argon de outras gerações. **Antes de enviar comandos, confirmar o hardware e o endereço.**

## Pré-requisitos

Acesso root via SSH ou ADB (documento 02). A configuração observada do sistema tinha:

~~~text
/dev/i2c-1
/dev/i2c-13
/dev/i2c-14
/vendor/bin/i2cdetect
/vendor/bin/i2cset
/boot/config.txt: dtparam=i2c_arm=on
/boot/config.txt: #dtoverlay=i2c-fan
~~~

**Não foi necessário descomentar o overlay i2c-fan.**

## Diagnóstico sem modificar o cooler

Executar no **shell Android root**:

~~~sh
cat /sys/class/thermal/thermal_zone0/temp
ls -l /dev/i2c-* 2>&1
command -v i2cdetect
command -v i2cset
grep -i i2c /boot/config.txt /boot/config_user.txt 2>/dev/null
i2cdetect -y 1 0x1a 0x1a
~~~

A temperatura vem em **milésimos de grau** (exemplo **48500 = 48,5 °C**). O scan restrito ao endereço observado mostrou:

~~~text
10:                             1a
~~~

Se não aparecer **1a**, **parar**; não tentar escritas em endereço desconhecido.

## Controle manual (Toybox do Android)

O **i2cset** desta imagem é fornecido pelo **Toybox**, que exige um modo final (**b**, byte). A primeira tentativa **sem b** retornou **i2cset: mode too long** e não moveu a ventoinha.

Usar:

~~~sh
# Solicitar 100%
i2cset -y 1 0x1a 0x80 0x64 b

# Solicitar 30%
i2cset -y 1 0x1a 0x80 0x1e b
~~~

Ambos foram validados pelo operador. O byte **0x80** seleciona o comando de velocidade usado neste controlador; valores finais usados pelo perfil automático:

| Percentual solicitado | Hexadecimal |
| --- | --- |
| 20% | 0x14 |
| 30% (teste manual) | 0x1e |
| 40% | 0x28 |
| 70% | 0x46 |
| 100% | 0x64 |

O percentual é o valor **solicitado ao controlador**; não há medição independente de RPM registrada.

## Temperaturas observadas em testes

- Diagnóstico inicial: **48,5 °C**.
- Script temporário: **44,65 °C → 20%**, **56,2 °C → 40%**, **52,35 °C → 20%**.
- Após ativar serviço de boot, a mudança de velocidade também foi observada.

## Segurança e limites

- Evitar comandos I²C em outros endereços/registradores; não copiar para outras versões de gabinete sem validar o protocolo.
- Testar com boa alimentação e sem obstruir a ventilação.
- O controle manual não é automático e não persiste como rotina após reboot.
- Não desligar a ventoinha indefinidamente sem estratégia térmica.
- Controle automático: [05-argon-v3-automacao-init.md](05-argon-v3-automacao-init.md).
