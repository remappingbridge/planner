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

### MEL-10 — Exclusão de mouse sem recuperação de dados antigos (novo MNT-10)
**Novo pedido do operador em 11/10/2026.** Após remover um mouse por Saved Devices, a nova conexão por Pair New recuperou o perfil antigo. Remover deve apagar **todos os registros funcionais vinculados ao mouse** e seus ajustes (bond LE, nome salvo, IRK/identidade e resolving list, Movement DPI/Rotation, perfil ativo, remapeamento, rascunho, Modifier, combinações e shortcuts), sem interferir nas configurações de outros mouses salvos. Ao reconectar o mesmo dispositivo como novo, devem valer os **defaults completos**, inclusive após reboot.

**Achado preliminar do código atual:** há limpeza de bonds, nomes e Movement por identidade BLE, mas `blu2usb_profiles_t` (perfil/remap/shortcuts) é persistido de forma **global** em `src/app/main.c`, e portanto pode ser reaproveitado no novo pareamento. Investigar causa efetiva com regressões; qualquer solução deve isolar estado por mouse e preservar os demais, sem apagar indiscriminadamente o perfil global. Priorizar identidade estável e migração de registros v3, remoção idempotente e falhas recuperáveis de TLV/flash. Não prometer secure erase físico forense do flash sem requisito técnico adicional.

**Critérios de aceite:** remover A e reparear A reinicia perfil PASSTHROUGH, botões, atalhos, modifier e Movement; B continua com suas configurações; reboot antes/depois não restaura dados de A; remoção falha não pode ser mostrada como concluída; testes de RPA/IRK e ordinais reciclados. Planejamento e histórico de implementação em [MNT-10](gates/MNT-10.md). **Aceito e publicado como v3.2.0.**

**Ordem de gates atualizada:** MEL-10 integra MNT-10; MEL-09 permanece MNT-11; **MEL-08 Zoom**, antes associado ao gate MNT-10, foi adiado para **MNT-12**. A numeração MEL histórica dos itens originais não é modificada; MEL-11 agora adiciona MNT-13 sem alterar MNT-12.

### MEL-11 — PAIR NEW com mouse conectado: investigação e decisão, não correção automática (MNT-13)

**Novo pedido, 11/10/2026.** O operador observou que PAIR NEW só consegue parear um novo dispositivo quando não há mouse conectado. Os requisitos originais de 20/09/2026 exigem exatamente o contrário: o mouse atual deve continuar operacional enquanto um **segundo mouse BLE HOGP não salvo** é descoberto e qualificado; somente depois ocorre handoff e desconexão do antigo. A tentativa cancelada ou expirada em 15 segundos não pode desconectar o mouse atual. Mouse já cadastrado não é vencedor de PAIR NEW por contrato.

**Resultados prévios verificados:** HOPE-06 falhou inicialmente com pools BTstack de apenas 1 conexão/GATT/HIDS, corrigidos para 2 e fisicamente aceitos. A v3.2.0 mantém os três limites em **2**; o renderer/UI permite PAIR NEW mesmo com mouse conectado, e `start_pair_new` aceita o estado READY. Existem sessão candidata separada, security/HIDS e handoff seguro. **Essas evidências estáticas não provam a causa raiz atual** nem se o defeito foi reproduzido em testes controlados. Ver [investigação anterior](investigations/pair-new-with-connected-mouse-2026-10-11.md).

**MNT-13 será dividido obrigatoriamente em duas partes:**

1. **Parte 1 (somente investigação):** reproduzir controladamente com A conectado × A ausente e B realmente não salvo em modo pairing, capturar estados/erros de scan, advertising, connection, SM, GATT HIDS, filtros de bonds/IRK, timeout 15 s e handoff. Identificar a primeira divergência, separar hipótese de causa comprovada, gerar relatório com evidências. **Não corrigir, não versionar.**
2. **Parte 2 (decisão técnica):** com a causa raiz conhecida, avaliar se corrigir é viável, seguro e proporcional, preservando o contrato de um mouse autoritativo e candidato temporário. Resultado **GO / NO-GO (DEFERRED) / BLOCKED (INCONCLUSIVE) / NOT A BUG**. Somente um GO aprovado e uma **nova autorização expressa de implementação** permitem alterar firmware; release apenas após CI, UF2 e aceite físico. Nenhum release por diagnóstico.

**Escopo e detalhes do gate:** [MNT-13](gates/MNT-13.md). **Status: PLANEJADO; duas partes PENDING, não iniciado.** MNT-12 Zoom segue separado e suspenso.

## Registro da implementação de cores aceita
As solicitações MEL-05/MEL-06 acima registram o desejo original. Após iterações e aceite final conjunto do operador, a regra efetivamente publicada na **v3.1.3** é o inverso do texto original: **CURRENT sem seleção = ciano normal 0x07FF** e **CURRENT selecionado = ciano clarinho pastel 0xD7FF**; os demais itens permanecem cinza→branco. O nome conectado em Saved Devices é informativo e permanece ciano normal.

## Fora de escopo deste backlog
Novos shortcuts/30 IDs, mudança de protocolo ou quantidade de interfaces USB, mudanças de esquema flash, nomes BLE de origem, novos modos, compatibilidade de Obsidian por regras específicas, troca de microcontrolador, funcionalidades v4.0.
