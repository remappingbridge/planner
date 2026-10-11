# MNT-03 — preflight técnico e contrato

**STATUS: PLANEJAMENTO ATIVO / AGUARDANDO PUBLICAÇÃO OFICIAL DA v3.0.2 PARA CRIAR BRANCH DE FIRMWARE.**

O operador aceitou o MNT-02 e autorizou o avanço. O MNT-03 deve nascer **exclusivamente da tag v3.0.2 publicada** e terá somente o escopo MEL-01: remover o `X` final dos **valores de HORIZONTAL DPI e VERTICAL DPI nas duas linhas do resumo `MOVEMENT OPTIONS`**.

## Inventário e limites verificados na fonte v3.x
- Em `src/renderer/renderer.c`, `movement_gain_name(quarter)` devolve strings de 0.25X a 3X. Essa mesma função também alimenta o resumo de Saved Devices (onde o `X` já é removido independentemente). Não mudar globalmente o contrato compartilhado sem verificar todos consumidores.
- `project_movement_options` nas linhas 1 e 2 forma ` HORIZONTAL DPI %s` e ` VERTICAL DPI %s`, e aplica `BLU2USB_UI_TONE_CURRENT` ao span dinâmico que começa nas colunas 16 e 14. A largura do span deve acompanhar os valores sem `X`.
- A grade LCD tem 9 linhas × 21 colunas. Títulos seguem magenta; itens selecionados e demais cores devem manter a versão estável.
- As listas `HORIZONTAL/VERTICAL SLOW/FAST DPI` mantêm o `x` literal nos itens, como `SLIGHTLY FAST 1.25x`; seus valores, seleção e rotinas de aplicar/cancelar NÃO devem mudar.
- Testes anteriores `tests/test_mov02_horizontal_slow.c`, `test_mov05_vertical_fast.c` e outros esperam `X` nas linhas de resumo. Atualizá-los para o novo contrato **sem desativar as regressões de navegação, cores, ganhos ou persistence**. Adicionar um novo teste MNT-03 que cubra os oito ganhos discretos possíveis em ambas direções, com matriz completa e spans.
- Preservar a versão embarcada v3.0.2 enquanto este for apenas um candidato; o próximo patch `v3.0.3` só será criado depois de aceite físico.

## Aceite futuro
Partir de HOME CONNECTED, entrar em MOVEMENT OPTIONS, ver 1 sem x em H e V, escolher 0.25/0.75/1.5/3 em eixos independentes, validar resumo sem x, listas de escolha com x e movimento igual ao da v3.0.2; voltar, reiniciar e confirmar valores. Instalação via UF2 BOOTSEL sem `flash_nuke`.

Nenhuma publicação de MNT-03/v3.0.3 deve ocorrer antes do aceite explícito.
