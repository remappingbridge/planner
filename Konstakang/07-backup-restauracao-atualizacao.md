# 07 — Backup, restauração e possível atualização de Android

## Decisão registrada

Em **08/11/2026**, o operador **decidiu não atualizar ainda** do LineageOS Android 16 (KonstaKANG) para Android 17. Esta pasta documenta o estado funcional anterior à migração.

**Nenhuma atualização Android 17 foi executada ou validada.** Portanto, qualquer previsão de preservação de dados é condicional ao procedimento de atualização escolhido.

## 1. O que precisa ser preservado

| Elemento | Onde está | Observação |
| --- | --- | --- |
| Serviço da ventoinha | /system/etc/init/argonfan.rc | Pode sumir se /system for substituído |
| Script do cooler | /system/bin/argonfan.sh | Pode sumir se /system for substituído |
| Perfil térmico | Dentro do script | 20/40/70/100% por limiares 55/60/65 °C |
| Resolução HDMI | /boot/resolution.txt | Era 2560x2880; confirmar após update |
| Configuração de vídeo Android | Preferências/serviços Android | DPI 640, fonte 1.6, rotação 90° |
| SSH integrado | Configurações do KonstaKANG e identidade privada local | Revalidar endereço IP/fingerprint em reinstalação |
| Apps e contas Google | Dados do Android, vários diretórios internos | **Não** são cobertos pelo backup de arquivos aqui |
| Dados de aplicativos | Dados do usuário Android | Fazer backup integral antes de migrar |

A cópia dos scripts já está versionada neste repositório. **Não adicionar dados de /data nem credenciais Google ao repositório Git.**

## 2. Backup técnico no Mac (não inclui apps e contas)

~~~bash
mkdir -p ~/rpi5-android16-backup

adb connect 192.168.15.11:5555
adb root

adb pull /system/bin/argonfan.sh ~/rpi5-android16-backup/
adb pull /system/etc/init/argonfan.rc ~/rpi5-android16-backup/
adb pull /boot/resolution.txt ~/rpi5-android16-backup/

adb shell 'getprop ro.build.display.id; getprop ro.build.version.release; getprop ro.build.date; wm size; wm density; wm user-rotation; settings get system font_scale; getprop init.svc.argonfan' \
  > ~/rpi5-android16-backup/estado.txt
~~~

O IP é somente o que funcionou em 08/11/2026, substituir se o DHCP mudar.

Verificar arquivos e conteúdo do backup, não presumir que os comandos foram concluídos caso o ADB tenha caído.

### Para um backup realmente completo

Fazer **imagem integral do cartão/SSD** em outro computador ou usar mecanismo de backup/recovery suportado pela build, armazenando a cópia **fora do próprio Pi**. Confirmar a integridade da imagem e como restaurar **antes** de atualizar. Desligar corretamente o dispositivo antes de remover mídia. Não executar **dd** em um disco sem ter identificado com certeza origem e destino; ele pode sobrescrever a mídia errada. Um backup de apenas três arquivos **não protege logins Google, aplicativos, fotos ou dados locais**.

## 3. O que pode acontecer numa atualização

### OTA preservando /data

- Aplicativos, contas e preferências **podem** ser mantidos, mas a passagem de Android 16 para 17 requer confirmação do procedimento **específico do KonstaKANG**.
- A substituição de **/system** tende a remover arquivos personalizados **argonfan.sh / argonfan.rc**. Planejar sua reinstalação, não presumir que continuará funcionando.
- **/boot/resolution.txt** e configurações do Raspberry Pi podem ser tratados especificamente pelos pacotes OTA do autor; **verificar o changelog e os passos oficiais da versão exata**.
- GApps/serviços Google: garantir que o pacote e procedimento sejam compatíveis com **Android 17**. Preservar /data não é garantia universal de que Play Services seguirá funcionando sem ajustes.

### Instalação limpa / formatação de /data

Tratar como perda das contas conectadas, aplicativos, preferências, configurações de acessibilidade, sessões e dados locais até que um backup recuperável comprove o contrário. A conta Google da nuvem não é apagada por formatar o Pi, mas será preciso fazer login novamente.

**Nunca fazer factory reset apenas para tentar recuperar a ventoinha.**

## 4. Sequência recomendada para outra instalação ou após upgrade

1. Criar/validar **imagem de backup** do Android funcional.
2. Anotar build exata, método de update e pacote de GApps antes de fazer qualquer alteração.
3. Seguir apenas as instruções oficiais da versão alvo: https://konstakang.com/devices/rpi5/
4. Após iniciar, validar HDMI, proporção, orientação, DPI e fonte: [03](03-lg-dualup-video-acessibilidade.md).
5. Confirmar ADB/SSH root e IP atual: [02](02-acesso-adb-ssh.md).
6. Inspecionar sensor térmico, I²C e endereço do Argon V3: [04](04-argon-v3-i2c-controle-manual.md).
7. Verificar se os arquivos do serviço sobreviveram. Se não, reinstalar usando as **fontes versionadas** e passos do [05](05-argon-v3-automacao-init.md), somente após confirmar compatibilidade do Android alvo.
8. Reiniciar e cumprir o checklist de aceite do [06](06-testes-e-diagnostico.md).
9. Verificar logins, GApps, Play Services, aplicativos, mídia, notificações e dados importantes.
10. Em falha séria, restaurar a **imagem integral anterior**, em vez de tentar adivinhar as configurações.

## 5. Recuperação rápida do cooler após reinstalação

Se o Pi voltou com Android 16 e I²C validado: baixar esta pasta do repositório; usar **arquivos/argonfan.sh** e **arquivos/argonfan.rc**; seguir procedimento de **adb remount + adb push + chmod + restorecon + reboot** no [documento 05](05-argon-v3-automacao-init.md). Não habilitar dois controladores simultâneos.

Se o Pi voltou com Android 17: **NÃO assumir compatibilidade**. Primeiro comprovar caminho do sensor, driver I²C, protocolo, permissões de escrita de /system e política de init/SELinux. Testar manualmente antes de reinstalar automação.

## 6. Segurança

- Este repositório público deve conter **apenas documentação e scripts sem credenciais**.
- Nunca publicar chaves privadas SSH, arquivos de contas Google, tokens ADB, backups íntegros ou dumps de dados Android.
- Considerar o endereço 192.168.15.11 e nomes de dispositivos de vídeo/USB como observações **históricas**, não valores portáteis.
- Os documentos não substituem backup integral nem as notas oficiais da build.

Referências: https://konstakang.com/devices/rpi5/ e https://developer.android.com/tools/adb
