# 03 — Matriz de teste físico, host e regressão de v3.x

**Estado em 12/10/2026:** MNT-01..MNT-13 **aceitos/publicados até v3.2.3**. **MNT-14 CANCELADO pelo operador** após testes físicos relatados como bem-sucedidos em cenários diversos/adversos; sem logs individuais anexados, não converter automaticamente cada caso desta matriz em PASS. A Parte 2 e a correção não ocorreram. **MNT-15: ação ZOOM IN genérica alterada para Ctrl+Equal sem Shift na PR #45 DRAFT, autorização explícita; CI host 98/98 PASS. Zoom Out/Reset preservados; há terminais que só ampliam com Shift, limitação documentada. Pico/aceite físico pendentes.**

## Preparação comum
1. Identificar tag estável instalada e a versão candidata, guardar 12 combos de shortcuts e parâmetros Movement; fazer backup quando pertinente sem flash_nuke.
2. Carregar UF2 de produção via BOOTSEL; conferir SHA256 antes de gravar, reinicialização e reconexão BLE sem perder bonds. O downgrade de firmware v3→v2 não faz parte deste plano.
3. HOME CONNECTED: testar movimento, click normal, perfil ativo, Remapping Options, Modifier Shortcuts e Saved Devices antes da tela alvo; sem telas novas a menos que expressamente aprovadas.
4. A cada gate validar função alterada + smoke de UI/Help/Lock + ausência de teclas Mouse/Keyboard/Consumer presas e persistência após reinício.

## Testes específicos por gate

| Gate | Roteiro verificável | Passa se |
|---|---|---|
| MNT-01 | HOME → SAVED DEVICES, navegar bonds, observar dicas e REMOVE DEVICE; JOY PRESS entra no Remove This; cancelar | Dicas cinza padrão, REMOVE DEVICE branco quando a única opção selecionada, paginação correta; somente nome ativo com tom atual de destaque |
| MNT-02 | HOME → SAVED DEVICES → REMOVE DEVICE → REMOVE THIS; KEY X Help, KEY B retorna/cancela, KEY Y Lock | `KEY X: HELP` visível e funcional; KEY Y nunca abre Help; sem apagar mouse por entrar/sair da ajuda |
| MNT-03 | HOME → MOVEMENT OPTIONS, configurar H/V 0.25, 1, 1.5, 3 | Linhas HORIZONTAL/ VERTICAL DPI não exibem `x`; valores continuam corretos, rotação/movimento inalterados |
| MNT-04 | Abrir todas as telas que usam `\` nas dicas, incluindo JOY LEFT/RIGHT e HOME SCREEN/PAGE | Todo separador visual do LCD é `/` e cabe em 21 colunas; armazenamento/código/USB não mudam |
| MNT-05 | Abrir todos os HELP de todas as telas, testar KEY A/B/X/Y, JOY/joy press, lock e unlock | Apenas B volta e restaura contexto; Y bloqueia; todos demais comandos não executam ação; Help persiste após unlock |
| MNT-06 | Fluxo FIRST MOUSE CONNECTED e KEY Y após MNT-05 | Dica exata `KEY Y: LOCKS ANYWHERE` legível, sem truncar; KEY Y já bloqueia em todas as telas e Helps |
| MNT-07 | Percorrer HOME, Saved Devices, Movement, Custom, Combinations, Shortcuts, Helps, comparar fotografias do LCD | Todos textos antes em ciano normal tornam-se ciano claro esbranquiçado; outros tons preservados; legível e consistente |
| MNT-08 | Em páginas com valores de estado ciano, alternar item selecionado/desselecionado; Saved Devices | Texto ciano claro selecionado vira ciano normal e volta ao ciano claro ao perder foco; cinza→branco comum preservado |
| MNT-09 | HOME CONNECTED em PASSTHROUGH e CUSTOM; JOY PRESS primeira opção | Rótulo fixo `REMAPPING OPTIONS` independentemente do perfil; destino e dados do perfil intactos |
| MNT-10 | Salvar perfil/remap/12 shortcuts/Modifier e DPI/Rotation no mouse A; remover em SAVED DEVICES; reboot; reparear mesmo mouse como novo; repetir com mouse B preservado; simular falha de armazenamento/IRK/slot reciclado | A perde completamente bond/configuração e retorna aos defaults; B mantém suas configurações; falha não informa exclusão falsa nem restaura A |
| MNT-11 | Nome BLE `BTS. 0MOUSE2`, `mouse`, `MOUSE123`, `LIFT`, vazio/UNKNOWN, truncado; HOME e SAVED DEVICES, desligar/religar | Qualquer subsequência `MOUSE` dispensa sufixo; LIFT recebe ` MOUSE`; sem duplo sufixo nem truncamento perigoso; bonds intactos |
| **MNT-12** | Em REMAPPING OPTIONS, cruzar 4 estados (CUSTOM/PASSTHROUGH × tem/sem Modifier efetivo); em COMBINATIONS 1..6 avaliar valor atribuído, NOT CUSTOMIZED e UNAVAILABLE, selecionado/não selecionado, mudança de perfil/mouse, draft, reset, reboot | Apenas CUSTOM **com Modifier aplicado** ativa ciano; na opção MODIFIER SHORTCUTS e apenas valores atribuídos da combinação = 0x07FF sem foco / 0xD7FF selecionado; rótulos, UNAVAILABLE e NOT CUSTOMIZED preservados; nenhum ciano residual em PASSTHROUGH ou CUSTOM sem Modifier |
| **MNT-13 NOVO** | Percorrer cada opção nas telas HOME, SEARCHING, RETRY, REMAPPING, EDIT CUSTOM, WILL BECOME, MOVEMENT, DPI, ROTATION, COMBINATIONS, SHORTCUTS e ação única de SAVED DEVICES; repetir navegação/paginação e BACK/Help/Lock | Em toda tela com lista elegível, **exatamente um &#124; na coluna física 1 / índice 0, na linha do item focado** (segunda linha para opção de duas linhas); zero nos demais itens/status/hints/Help; MOVEMENT terceiro item → linha 4; COMBINATIONS marcador só no valor/status 2/4, nunca no rótulo 1/3; Saved Devices único REMOVE DEVICE linha 5 quando há bond; cores/textos/comandos intactos |
| **MNT-14 / Parte 1** | A conectado e B realmente inédito: PAIR NEW por 15 s; repetir com A ausente; comparar eventos de start/scan/advertising/connect/SM/HIDS/handoff, timeout e KEY B; rejeição correta de mouse salvo | Relatório técnico demonstra causa raiz e primeiro estágio divergente **ou** classifica evidência INCONCLUSIVE/NOT REPRODUCED de modo transparente; **sem patch/UF2 release** |
| **MNT-14 / Parte 2** | Revisar relatório da Parte 1, riscos reais de coexistência BLE/BTstack/USB, viabilidade técnica, custo e regressões; deliberar GO / NO-GO / BLOCKED / NOT A BUG | Decisão justificada e aceita pelo operador. GO exige autorização **separada** para corrigir, candidato físico e aceite para release; NO-GO/BLOCKED/NOT A BUG não geram release |
| **MNT-15** | Em Debian 13 KDE Obsidian e navegador, testar Zoom In/Out/Reset do teclado físico e BLU2USB; comparar eventos por device com evtest/udevadm; reiniciar | Candidato generic Ctrl+Equal sem Shift: Obsidian e navegador ampliam; Zoom Out/Reset preservados; terminais Shift-only podem não ampliar, validar e documentar. Sem release até aceite físico |

## Testes automatizados e cross-gate

- **UI textual**: fixtures exatas para cada estado numa grade 9×21, incluindo dicas, backslash/substrings em texto visível, todas as telas de Help, selecionados, fallback de mouse e número de caracteres; não testar apenas fragmentos textuais sem navegar.
- **Renderização visual**: snapshots/cor por `BLU2USB_UI_TONE_*`, spans e precedência quando texto atual também está selecionado; validação manual de contraste no LCD, com foco no texto ciano claro esbranquiçado.
- **Input/Help**: bordas release de KEY B/KEY Y, lock/unlock em Help, supressão de KEY A/X/JOY, retorno de foco, cancelamento e remove sem side effects.
- **Nomes**: teste `strstr` case-insensitive/normalização, fragmentos dentro de letras/dígitos, capacidade do buffer, truncamento, pontuação, nome presente/ausente, sem mutação do payload BLE ou persistência.
- **HID/Zoom**: evento BLU2USB deve ser medido **no eventN próprio**, não inferido de `AT Translated Set 2 keyboard` em event0; testar keydown e keyup de Ctrl/Shift/Equal/Minus e 0, tempo e layout, navegador+Obsidian; manter 30 ações, Consumer/Media, screenshots e mouse.
- **Regressão**: todo CI host anterior, Pico 2 W produção, sem novo USB interface/CDC, preserve versão/persistência de v3, USB VID/PID, Bluetooth, perfil Custom/Passthrough, Modifier, Movement H/V+rotação, Saved Devices/Remove flow, 30 atalhos.
- **Entrega**: `.uf2` e SHA-256 em cada gate **com alteração real**, novos SHA/CI se houver correção, release notes e tag apenas **após aprovação física**. Se artefato binariamente idêntico e a mudança for apenas testes, registrar prova e justificar publicação; gate apenas documental não gera versão falsa.

## Classificação de evidências
- **PASS**: observado fisicamente no cenário, com hardware/host indicado.
- **FAIL**: observado comportamento divergente, atualizar branch do mesmo gate.
- **N/A**: host ou hardware sem suporte e limitação aprovada explicitamente; não confundir N/A com PASS.
- **PENDING**: não testado. Aceite global não autoriza inventar resultados individuais.

## Contrato de segurança adicional — novo MNT-10
Remoção de um mouse salva não equivale a `factory reset`: teste com pelo menos dois bonds e perfis diferentes é obrigatório. Dados bond-scoped incluem identidade/IRK, nomes, Movement, perfil ativo, remap, Modifier, atalhos e rascunho. Repareamento após reboot deve começar nos defaults, sem reaproveitamento de configuração antiga ou de ordinal/slot reciclado. Testar falha de flash/TLV, sequência de confirmação, cancelamento por B e idempotência. Não declarar exclusão bem-sucedida se alguma etapa persistente falhar.

## Critérios particulares de diagnóstico — MNT-14 (antigo MNT-13)

- A **Parte 1** é considerada entregue por relatório técnico rastreável (baseline SHA/versão, identificação dos dois mouses, reprodução controlada, estado de advertising e bond, timestamps/states/errors, hipótese testada e evidência pró/contra); não exige UF2 definitivo e **não publica release**. Logs e dumps devem anonimizar identidade/IRK.
- O sintoma só está **reproduzido** se mouse B não salvo, BLE HOGP, em modo de pareamento, falha com A conectado em condições comparáveis à condição A ausente. Mouse salvo ser ignorado em PAIR NEW é **PASS contratual**, não falha.
- A **Parte 2** escolhe GO/NO-GO/BLOCKED/NOT A BUG com avaliação de viabilidade/custos/risco e aprovação do operador. Não usar `gate aceito` da Parte 1 como aceite físico de correção.
- **Somente após GO e autorização específica para código**, caso exista patch: regressão host e Pico, observação de dois mouses em hardware, sem perda de input do A durante scan, troca segura somente após qualificação do B, cancel/timeout preservando A e nenhum bond/perfil de terceiros modificado. Cumprir rito de UF2/aceite SemVer 3.x.
- Desconectar A para conseguir conectar B é procedimento de **controle negativo/contorno de teste**, não solução que satisfaça a arquitetura sem formalizar mudança contratual.

## Contrato visual de regressão — MNT-12 (aceito v3.2.2)

1. Tom do texto `MODIFIER SHORTCUTS` no frame da tela `BLU2USB_SCREEN_MOUSE_OPTIONS`: conferir `BLU2USB_UI_TONE_CURRENT` / `BLU2USB_UI_TONE_SELECTED_CURRENT` **apenas** para CUSTOM aplicado + fonte Modifier existente. Outras três combinações de estado seguem ACTIONABLE / EMPHASIZED.
2. Nos seis pares de páginas `COMBINATIONS_1..6`, testar coordenadas de linhas 1/2 e 3/4: **somente células visíveis de linhas de valores 2/4 atribuídos** mudam para CURRENT (sem foco) / SELECTED_CURRENT (foco). Linhas rótulo 1/3 continuam ACTIONABLE / EMPHASIZED.
3. Com atalhos não atribuídos (`shortcut_assignments[combo] == 0`), **NOT CUSTOMIZED** não muda seu estado de foco/cor; com `blu2usb_ux_combination_unavailable(...)`, **UNAVAILABLE** continua STATIC inclusive selecionado. Conferir explicitamente a precedência final de composição no renderer.
4. Draft de Custom com Modifier criado/removido mas não confirmado não deve mudar a indicação do perfil realmente ativo. Aplicar Custom e trocar para PASSTHROUGH deve recalcular os dois grupos de tons na projeção seguinte. Após remoção/re-pareamento ou troca de mouse salvo, não herdar tons de outro bond.
5. Fazer os testes de projeção de tom por célula + CI host completa + Pico 2 W oficial + teste físico para qualquer futura implementação; na implementação MNT-12 **94/94 testes host e Pico 2 W produção passaram**, e o gate foi **fisicamente aceito/publicado v3.2.2**.

## Contrato de regressão — MNT-13 (pipe de seleção; CI PASS, físico PENDING)

1. Verificar **primeira coluna índice 0** em cada frame: exatamente um `|` na linha do foco quando há lista elegível e nenhum marcador nas outras opções. Em seleção inválida, zero marcadores. Guardar/restaurar o espaço das demais linhas sem apagar caracteres informativos.
2. Cobrir HOME(4), HOME_SEARCHING/RETRY(2), REMAPPING OPTIONS(3), EDIT CUSTOM(5), cinco WILL BECOME(6), MOVEMENT OPTIONS(3), quatro DPI SLOW/FAST(4), ROTATION(4), seis COMBINATIONS(2 pares), cinco SHORTCUTS(6) e SAVED DEVICES (única opção implícita REMOVE DEVICE com bond salvo).
3. **Exceções:** MOVEMENT seleção 2 marca ROTATION **linha 4**, não COUNTERCLOCKWISE; COMBINATIONS marcador somente na **segunda linha de cada item: valor/status 2/4**, nunca rótulos 1/3; em UNAVAILABLE, pipe branco e valor STATIC; SAVED DEVICES vazio **não** mostra `|`, com bonds marcador só REMOVE DEVICE linha 5 apesar de `ux_option_count()==0`.
4. Título, mouse salvo/ativo, PROFILE/DPI/ROTATION informativo, Help, PAIR NEW, REMOVE THIS, confirmações KEY A, dicas KEY/JOY, FIRST MOUSE e SEARCHING FIRST: zero `>` **de seleção**. `>` não aparece na tela sem menu por resíduo da tela anterior.
5. As tonalidades de foco MNT-08 e MNT-12 e estados CURRENT/UNAVAILABLE/NOT CUSTOMIZED devem continuar intactos. O pipe usa tom coerente com opção focada (branco ou ciano claro), sem recolorir rótulo/valor.
6. CI host por célula e estado/paginação, Pico 2 W produção UF2 com SHA-256 e teste físico 9×21; **CI host 96/96, produção Pico 2 W e hash UF2 foram validados em PR #43; teste físico ainda PENDING**.

**Atualização final:** operador informou testes físicos bem-sucedidos e cancelou MNT-14, sem fornecer relatório detalhado por cenário. Não houve correção de firmware nem execução da Parte 2; MNT-15 foi autorizado e implementado em candidato na PR #45, ainda sem aceite/release. Os testes anteriores não são convertidos em PASS do novo UF2.
