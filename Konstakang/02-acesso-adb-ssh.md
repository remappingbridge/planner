# 02 — Acesso remoto: ADB, root e SSH (macOS)

**Testado em 08/11/2026:** Pi 5 em 192.168.15.11, servidor ADB TCP porta 5555; conexão ADB e SSH como root concluídas. Magisk **não** foi instalado.

## Instalar Android Platform-Tools no Mac

No terminal do **Mac**:

~~~bash
brew --version
brew install --cask android-platform-tools
adb version
~~~

Também existe distribuição oficial em https://developer.android.com/tools/releases/platform-tools . Não precisa instalar Android Studio completo.

## Habilitar serviços no LineageOS

1. Configurações > Sobre o tablet > tocar 7 vezes em **Número da versão** para liberar as Opções do desenvolvedor.
2. Configurações > Sistema > Opções do desenvolvedor: ativar **Depuração USB** (se disponível) e **Rooted debugging / Depuração com root**.
3. Configurações > Sistema > **Raspberry Pi settings**: habilitar **ADB** e **SSH**. Reiniciar o Pi se a configuração pedir.
4. Descobrir o IP real do Pi 5 nas configurações de rede. Mac e Pi devem estar na mesma rede ou em redes roteadas que permitam conexão.

O cabo USB foi conectado em um momento do diagnóstico, mas **o acesso ADB que funcionou foi por TCP/IP**, sem depender do cabo.

## ADB em rede

No Mac (substituir IP caso mude):

~~~bash
adb connect 192.168.15.11:5555
adb devices -l
adb root
adb shell id
~~~

Saídas observadas:

~~~text
192.168.15.11:5555 device product:lineage_rpi5 model:Pi_5_Model_B_Rev_1_0 device:rpi5
restarting adbd as root
uid=0(root) ... context=u:r:su:s0
~~~

Se o daemon ADB reiniciar com **adb root**, reconectar. Antes da conexão pela rede, **adb devices -l** não listava dispositivos; isso não significou falha do Android. Também foi tentado por engano 192.168.15.8; o Pi 5 usado no teste era 192.168.15.11. Não presumir que o IP seja fixo.

## SSH integrado do KonstaKANG

O SSH integrado foi habilitado nas configurações específicas do Raspberry Pi. A autenticação exigiu uma **identidade privada local, armazenada com permissões restritas no Mac**, no arquivo de exemplo:

~~~text
~/.ssh/rpi5_konstakang_ed25519
~~~

Esse material foi provisionado na máquina de administração durante os testes pelo procedimento específico descrito na documentação do KonstaKANG. A chave privada **não faz parte deste repositório**: nunca publicá-la, copiá-la entre dispositivos nem colocá-la em scripts de bootstrap. Em uma instalação nova, seguir a documentação da versão correspondente para provisionar o acesso SSH e preferir autenticação por chave de cliente dedicada se suportada.

Depois de provisionar uma identidade **válida para aquele Pi**, conectar no Mac:

~~~bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/rpi5_konstakang_ed25519
ssh -i ~/.ssh/rpi5_konstakang_ed25519 root@192.168.15.11
~~~

Conexão validada: prompt do Android **:/ #**. Confirmar permissões:

~~~sh
id
~~~

**Não executar ssh dentro do próprio Pi.** O prompt **:/ #** indica que já está no shell Android; **admin@Mac %** indica terminal do Mac. Na tentativa de se reconectar a partir do Android, o arquivo no diretório ~/.ssh do Mac não existia no Pi, e houve erro de autenticação.

## Diagnóstico e segurança

~~~bash
adb kill-server
adb start-server
adb connect IP_DO_PI:5555
adb devices -l
~~~

Se USB for necessário no Mac, verificar reconhecimento físico com:

~~~bash
system_profiler SPUSBDataType
~~~

- Se a conexão falhar, conferir IP e acesso à porta TCP, autorização ADB e rede antes de assumir problema de root.
- Revisar a fingerprint SSH na primeira conexão.
- **ADB com root é sensível**: restringir à rede confiável/VPN e desabilitar quando não for necessário.
- Guardar credenciais privadas fora do Git. Não documentar contas/senhas dos GApps.
- Referência oficial: https://konstakang.com/devices/rpi5/

## Relação com os demais arquivos

Depois de entrar como root, o shell do Android pode executar **wm**, **settings**, **cat**, **i2cdetect**, **i2cset** e diagnosticar o serviço **argonfan**. Para gravar arquivos em /system, consulte [05-argon-v3-automacao-init.md](05-argon-v3-automacao-init.md) e faça backup antes.
