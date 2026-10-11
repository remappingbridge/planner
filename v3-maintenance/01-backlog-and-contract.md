# 01 — Backlog de hotfixes e melhorias v3.x

**Fonte:** texto literal fornecido pelo operador em 2026-10-11; notas de escopo abaixo são critérios de aceitação e cautelas de implementação, **não são funcionalidades já implementadas**. As telas identificadas em minúsculas são nomes funcionais do pedido; o código v3.0 usa identificadores como `BLU2USB_SCREEN_SAVED_DEVICES` e `BLU2USB_SCREEN_REMOVE_THIS`.

## Hotfixes

### HF-01 — Saved Devices: dicas cinza; Remove Device cinza/branco
Na tela `saved-devices`, as palavras das dicas devem usar o **cinza padrão do sistema**. A única opção `REMOVE DEVICE` não selecionada deve ficar cinza; **como é a única opção, aparece sempre selecionada em branco** quando essa tela a apresenta/está ativa. Preservar apenas o nome do mouse conectado com a semântica de cor de destaque da etapa v3.x vigente. O nome do mouse não deve se tornar uma opção selecionável.

Aceite: HOME → SAVED DEVICES com 1 e vários bonds; `REMOVE DEVICE` branco e acessível por JOY PRESS, demais dicas cinza; paginação sem perder seleção; entrada/saída e remoção continuam corretas; não eliminar estado vazio.

### HF-02 — Remove This: legenda correta
Na tela `remove-this`, mudar a dica literal de `KEY Y: HELP` para **`KEY X: HELP`**. **Não criar release isolada neste ponto:** combinar com HF-03 para não divulgar instrução falsa.

### HF-03 — Remove This: acesso funcional ao Help
Ao pressionar **KEY X** em `remove-this`, abrir `help-remove-this`, preservando bond alvo e estado de retorno; KEY B cancela remoção quando na tela de origem; KEY Y mantém a função global de lock (nunca Help); nenhuma ação de ajuda remove mouse, limpa dados ou confirma delete. Empacotado no mesmo gate HF-02.

## Melhorias — ordem e números definitivos

### MEL-01 — Movement Options sem sufixo x
Na tela `movement-options`, exibir apenas números nas linhas `HORIZONTAL DPI` e `VERTICAL DPI`: `1`, `0.75`, `1.25`, `2`, etc. Remover **somente o sufixo `x` nessas duas linhas da tela-resumo**; não mudar multiplicadores, persistência nem labels nas telas de escolha de DPI, salvo autorização posterior. Preservar cor e posição dos valores e 9×21.

### MEL-02 — Barra normal em toda a interface
Todo texto renderizado no LCD que contenha separador visual `\` deve usar **`/`**, especialmente as dicas `JOY LEFT/RIGHT`, `JOY UP/DOWN` e `HOME SCREEN/PAGE`. Abrange templates, projeções dinâmicas, helps e strings exibidas, respeitando 9×21. **Não reescrever escapes de C, caminhos de arquivo, sequência de controle, barra necessária em código-fonte ou relatórios USB.**

### MEL-03 — First Mouse Connected: lock anywhere
Na tela `first-mouse-connected`, trocar a dica `KEY Y: LOCK` por **`KEY Y: LOCKS ANYWHERE`**. Validar comprimento máximo de 21 caracteres e que o texto comunica uma regra realmente global (incluindo Helps após MEL-04), sem inventar implementação do lock nesta etapa.

### MEL-04 — Todos os Helps: KEY B back e KEY Y lock
Em **todas** as telas do tipo Help, trocar `ANY KEY: BACK` por **`KEY B: BACK`**. **Só KEY B** retorna para a tela de origem e restaura contexto/foco; KEY Y bloqueia como nas telas normais; **todo outro input do HAT é inerte enquanto Help estiver aberto**, inclusive KEY A, KEY X, JOY direcional e JOY PRESS. Após desbloqueio, voltar ao Help, sem executar BACK/APPLY/REMOVE inadvertidamente. KEY B usa a semântica de borda/liberação do firmware, sem duplo evento. Este é o único gate com mudança funcional intencional de navegação.

### MEL-05 — Ciano normal → ciano claro esbranquiçado
Todos os textos atualmente no **tom de ciano normal do sistema** deverão passar ao **ciano claro esbranquiçado** em todas as telas. Fazer o ajuste centralizado no design system/renderer, em vez de pintar textos pontuais. Manter o papel de destaque sem transformar dicas cinza, opções brancas, valores amarelos padrão ou texto comum em ciano. Não declarar valores RGB antecipadamente: medir/confirmar no LCD real, contraste e legibilidade.

### MEL-06 — Seleção de texto ciano claro → ciano normal brilhante
Quando **um item originalmente ciano claro esbranquiçado** for selecionável e estiver selecionado, seu tom muda para **ciano normal, de maior destaque**, revertendo ao claro ao desselecionar. Itens comuns cinza→branco permanecem como antes. Não colorir linhas inteiras ou nomes não selecionáveis por engano; preservar somente o nome de mouse ativo como destaque em Saved Devices, e não converter outros dados em ciano. Depende de MEL-05.

### MEL-07 — Home Connected: nome fixo da primeira opção
Na tela `home-connected`, a **primeira opção de navegação** deve sempre conter o texto fixo **`REMAPPING OPTIONS`**, substituindo o status atual do perfil (Custom/Passthrough) nesse local. O destino da opção e as demais opções não mudam; status ativo continua no modelo/estado, mas não ocupa essa opção. Não confundir texto de item com título de tela.

### MEL-08 — ZOOM IN/OUT genéricos no Debian KDE Plasma e Obsidian
**Melhoria 8 requisitada nesta conversa**, originada do diagnóstico MOD-08/v3.0: `RESET ZOOM` (Ctrl+0) funciona no Obsidian Debian 13 KDE Plasma; `ZOOM IN` e `ZOOM OUT` pelo RemappingBridge funcionam no navegador, **não** no Obsidian; **os atalhos equivalentes pelo teclado físico do notebook funcionam no Obsidian**.

Diagnosticar primeiro **diferença genérica de HID/layout/mudança de estado/duração de tecla**, antes de propor correção. Firmware atual: ZOOM IN = Left Ctrl + Left Shift + HID Equal (0x2E); ZOOM OUT = Left Ctrl + HID Minus (0x2D); RESET = Left Ctrl + HID 0 (0x27). Nos logs `evtest /dev/input/event0` fornecidos, teclado interno mostrou Ctrl+Equal **sem Shift** e Ctrl+Minus, mas event0 representa **o teclado interno**, não prova eventos do BLU2USB. Identificar primeiro node `/dev/input/eventN` real de cada fonte via `/sys/class/input`/`udevadm`/`evtest`; comparar `EV_KEY` de ambos para as ações e teclado físico, testar sessão/layout XKB e pulsos. Alterar somente código HID geral, não adicionar perfil Obsidian, detector de app, novo menu ou atalho especial. Preservar navegador, RESET, demais shortcuts, 6KRO, USB/Android. Se não houver correção genérica comprovada, **registrar diagnóstico e NÃO publicar uma versão fictícia**.

### MEL-09 — Evitar sufixo MOUSE duplicado em nomes BLE
A atual rotina adiciona ` MOUSE` quando a sequência não é detectada como **palavra inteira**; o operador quer detecção de **subsequência `MOUSE` em qualquer posição**, incluindo sem espaços, precedida/seguida de letras, números ou caracteres especiais. Se o nome capturado contiver `MOUSE` (sem diferença entre maiúsculas/minúsculas), **não anexar** a palavra. Casos literais: `BTS. 0MOUSE2` → `BTS. 0MOUSE2` (nunca `BTS. 0MOUSE2 MOUSE`); `LIFT` → `LIFT MOUSE`. Aplicar na HOME CONNECTED e Saved Devices pelo **mesmo normalizador**, preservar nome BLE original/capitalização visível conforme regra vigente, truncamento 21 caracteres, UNKNOWN MOUSE fallback, reconexão/pareamento e bonds. **É o antigo item 8 do rascunho, renumerado 9** para não sobrescrever MEL-08 Zoom solicitado.

## Fora de escopo deste backlog
Novos shortcuts/30 IDs, mudança de protocolo ou quantidade de interfaces USB, mudanças de esquema flash, nomes BLE de origem, novos modos, compatibilidade de Obsidian por regras específicas, troca de microcontrolador, funcionalidades v4.0.
