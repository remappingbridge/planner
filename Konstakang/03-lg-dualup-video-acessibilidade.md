# 03 — LG DualUp: vídeo, rotação e interface extragrande

## Objetivo

Usar o LG DualUp nas duas posições (normal e fisicamente girada a 90°) com imagem proporcional e ícones/textos extragrandes. Configuração observada no Raspberry Pi 5 com LineageOS Android 16 do KonstaKANG em 08/11/2026.

## Estado final aprovado

| Item | Valor |
| --- | --- |
| Resolução HDMI nativa | **2560 × 2880** |
| Conteúdo de /boot/resolution.txt | **2560x2880** |
| Aspect ratio na tela física | **Original** (menu OSD do LG) |
| Resolução lógica forçada | Nenhuma: wm size reset |
| Rotação em uso no monitor girado | **lock 1** (90°) |
| DPI físico informado pelo Android | 480 |
| DPI lógico ajustado | **640** |
| Escala de fontes | **1.6** |

O operador confirmou que a configuração final deu certo. A escolha de 640 dpi ampliou ícones/controles; a escala de fontes 1.6 já estava aplicada.

## Reproduzir — comandos em shell root do Android

~~~sh
cat /boot/resolution.txt
wm size reset
wm density reset
wm user-rotation lock 1
wm density 640
settings put system font_scale 1.6
~~~

No joystick/menu do LG, configurar a proporção de imagem para **Original**, evitando o modo que estica a imagem. Não é necessário forçar outra resolução HDMI se 2560x2880 já for detectada.

Verificar:

~~~sh
wm size
wm density
wm user-rotation
settings get system font_scale
~~~

Esperado:

~~~text
Physical size: 2560x2880
Physical density: 480
Override density: 640
lock 1
1.6
~~~

## Usar o monitor sem rotação

Ao devolver fisicamente o monitor à posição normal:

~~~sh
wm user-rotation lock 0
~~~

Para voltar à posição girada no mesmo sentido do teste:

~~~sh
wm user-rotation lock 1
~~~

Se for girado no sentido contrário, experimentar 270° com **wm user-rotation lock 3**. Não foi implementada detecção automática da orientação física; o ajuste é manual.

## EDID e saída HDMI

O monitor anunciou os modos em **/sys/class/drm/card1-HDMI-A-2/modes** no teste. Eram visíveis 2560x2880, 3840x2160, 1920x1080 e resoluções inferiores, com múltiplas entradas de frequências. O nome **card1-HDMI-A-2** pode mudar entre portas, kernels e instalações.

~~~sh
cat /boot/resolution.txt
for f in /sys/class/drm/*HDMI*/modes; do
  if [ -f "$f" ]; then
    echo "$f"
    cat "$f"
  fi
done
~~~

## Experimentos anteriores — NÃO são o estado final

Foram experimentados **wm size 1920x2160** e **wm density 270**. Houve override lógico sem modo HDMI 1920x2160 anunciado pelo EDID e nenhuma alteração visível percebida (as escalas de tamanho e densidade foram reduzidas juntas). Isso foi abandonado. Posteriormente o operador percebeu cursor mais fluido com densidade 240, mas **não foi medido nem demonstrado que o ajuste de DPI foi a causa**. A configuração final escolhida usa 640 dpi para privilegiar a leitura e os ícones.

## Como funciona

- **Resolução HDMI** define o sinal enviado ao monitor.
- **wm size** modifica as dimensões lógicas do Android, não cria modos HDMI.
- **wm user-rotation** muda a orientação do conteúdo.
- **wm density** controla a escala lógica da interface, não a quantidade física de pixels.
- **font_scale** amplia fontes de aplicativos compatíveis; aplicativos podem ignorar esse ajuste.

## Reverter

~~~sh
wm size reset
wm density reset
settings put system font_scale 1.0
wm user-rotation lock 0
~~~

Essa reversão retorna aos valores-padrão e à orientação normal, não à personalização preferida do operador.

**Não editar /boot/resolution.txt para valores fora dos modos anunciados sem plano de recuperação de vídeo.**
