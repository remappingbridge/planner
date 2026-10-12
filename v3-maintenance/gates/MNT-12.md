# MNT-12 — Indicador ciano de Modifier Shortcuts e valores de Combinations

**STATUS: PLANEJADO / NÃO INICIADO.** Substitui o antigo MNT-12 de Zoom/Obsidian, que foi **preservado integralmente em [MNT-14](MNT-14.md)**. Gate adicionado por solicitação do operador em **12/10/2026**. **Este pedido é exclusivamente de planejamento:** não criar branch de firmware, não alterar código, não executar CI nem gerar UF2 ou release.

- Backlog: **MEL-12 (novo item)**. MEL-11 permanece vinculado ao MNT-13 / PAIR NEW, mesmo que o número do novo gate seja MNT-12. Não renumerar os demais itens MEL.
- Hardware e produto: Pico 2 W, LCD 9 × 21, firmware [última release v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1), perfis isolados por mouse após MNT-10.
- Futura branch de execução (somente após ordem expressa): `maintenance/v3x-mnt-12`, criada do SHA exato da **tag v3.x oficial mais recente no início da execução**, nunca de um release não aceito.
- Entrega se futuramente implementado/aceito: **PATCH da série 3.x** (somente mudança de apresentação), número derivado da tag vigente; não reservar `v3.2.2` antecipadamente.
- Relação com outros gates: [MNT-13](MNT-13.md) (PAIR NEW) segue intacto e em duas partes; [MNT-14](MNT-14.md) (Zoom) permanece suspenso. Este gate **não os inicia**.

## 1. Regra única de habilitação visual

O mesmo predicado **efetivo**, calculado sobre o **mouse/perfil ativo**, deve controlar os dois contextos solicitados:

```text
modifier_shortcuts_effectively_active =
    (perfil efetivamente aplicado == CUSTOM REMAPPING)
    E
    (existe pelo menos um botão do mouse configurado como MODIFIER
     na configuração Custom aplicada a esse mouse)
```

A existência de um **Modifier configurado em um Custom salvo**, mesmo com **PASSTHROUGH** atualmente ativo, **NÃO** satisfaz a condição. Estar em CUSTOM com **zero** botões Modifier também **NÃO** satisfaz. Não tomar como critério a existência de atalhos preenchidos, o fato de abrir a tela, o botão atualmente pressionado ou um rascunho ainda não aplicado.

Tabela de verdade:

| Perfil efetivamente ativo | Há botão Modifier efetivamente configurado | Predicado de ciano |
|---|---|---|
| PASSTHROUGH | Não | **FALSO** |
| PASSTHROUGH | Sim (guardado no Custom inativo) | **FALSO** |
| CUSTOM REMAPPING | Não | **FALSO** |
| CUSTOM REMAPPING | Sim | **VERDADEIRO** |

**Origem dos dados:** na v3.2.1 `blu2usb_ux_model_t` possui `active_profile` e `modifier_source` (-1: nenhum; 0..4: LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD). `src/app/main.c:synchronize_ux_profiles()` obtém `modifier_source` de `profiles->custom_targets` **salvos**, enquanto `ux->custom_targets` pode apresentar um **draft**. Portanto a implementação futura deve reutilizar a identidade/configuração aplicada e impedir que um draft ainda não confirmado ligue/desligue o ciano. Não criar um segundo estado persistido de “ciano habilitado”. Se o operador confirmar outra política para alterações de draft, reabrir explicitamente a especificação antes de codificar.

## 2. Tela REMAPPING OPTIONS (BLU2USB_SCREEN_MOUSE_OPTIONS)

Alvo **exclusivo:** texto da opção selecionável **`MODIFIER SHORTCUTS`** (linha do template/renderer índice 3, terceira opção).

- Se o predicado for **VERDADEIRO**, item não selecionado = **ciano normal**, `BLU2USB_UI_TONE_CURRENT` / RGB565 `0x07FF`; item selecionado = **ciano clarinho**, `BLU2USB_UI_TONE_SELECTED_CURRENT` / `0xD7FF`.
- Se **FALSO**, preservar estilo de opção normal: **cinza** não selecionado; **branco** quando selecionado. Não manter qualquer ciano residual da seleção ou do perfil anterior.
- `PASSTHROUGH DEFAULT` e `CUSTOM REMAPPING` preservam as cores atuais que representam o perfil aplicado (inclusive foco ciano clarinho nesses itens, quando cabível); **não** atribuir ciano a linhas extras.
- A opção `MODIFIER SHORTCUTS` continua navegável mesmo quando o predicado é falso. Isto é indicador de **atividade efetiva**, não uma regra de bloqueio/disabled de entrada.

## 3. Telas COMBINATIONS 1 OF 6 até 6 OF 6

Cada tela contém duas combinações e duas linhas de valor; a coloração nova atua **somente nas linhas de valor**, não no rótulo:

```text
índice 1: " MODIFIER RELEASED IS" / " MOD + ... IS"    → rótulo, sem mudança
índice 2: " ESCAPE" / " NOT CUSTOMIZED"                 → valor 1
índice 3: " MOD + MIDDLE IS" / " MOD + ... IS"            → rótulo, sem mudança
índice 4: " NOT CUSTOMIZED" / " PASTE"                  → valor 2
```

A implementação não deve assumir os textos literais da primeira página: os rótulos são os templates existentes e podem variar de page 1 a 6. **Somente `row == 2` ou `row == 4`** pode receber o novo tratamento de ciano.

Aplicar ciano ao valor **se, e somente se**, todas as condições abaixo forem verdadeiras:

1. Predicado global de Modifier efetivamente ativo = **VERDADEIRO**;
2. A combinação possui **atalho realmente atribuído** (`shortcut_assignments[combo] != 0`); e
3. A combinação **não está indisponível** pela regra existente `blu2usb_ux_combination_unavailable(ux, combo)`.

Cores dos valores **válidos atribuídos**:
- Com predicado verdadeiro, sem seleção: ciano normal `0x07FF`; com a respectiva combinação selecionada: **ciano clarinho `0xD7FF`**.
- Com predicado falso: manter cinza não selecionado e branco selecionado, como hoje.
- As linhas de **rótulo** das combinações (`row 1` e `row 3`) continuam **cinza não selecionado / branco selecionado**, inclusive quando a linha de valor imediatamente abaixo está ciano.

**Exceções rígidas (independentemente do predicado ou foco):**
- Valor literal `NOT CUSTOMIZED` (atalho não configurado, id 0): **nenhuma alteração** de tonalidade ou mecanismo de foco. Continua com as mesmas cores e seleção atuais.
- Valor literal `UNAVAILABLE` (combinação indisponível pela origem Modifier): **nenhuma alteração**: renderer hoje restaura `BLU2USB_UI_TONE_STATIC`, inclusive em seleção. Não converter para branco, ciano ou ciano clarinho.
- O ciano não deve pintar a **linha inteira do par**, o título `COMBINATIONS N OF 6`, as dicas, as telas de lista **SHORTCUTS 1-5**, a indicação de opção indisponível nem valores em outras telas.

### Exemplo A — COMBINATIONS 1 OF 6

```text
COMBINATIONS 1 OF 6
 MODIFIER RELEASED IS
 ESCAPE              <-- ciano se predicado verdadeiro; claro se selecionado
 MOD + MIDDLE IS
 NOT CUSTOMIZED      <-- sem mudança de cor

 JOY LEFT/RIGHT: PAGE
 JOY PRESS: ACCESS
 KEY A: RESET SELECTED
```

### Exemplo B — COMBINATIONS 2 OF 6

```text
COMBINATIONS 2 OF 6
 MOD + LEFT CLICK IS
 UNAVAILABLE         <-- sem mudança (regra existente)
 MOD + RIGHT CLICK IS
 PASTE               <-- ciano se predicado verdadeiro; claro se selecionado

 JOY LEFT/RIGHT: PAGE
 JOY PRESS: ACCESS
 KEY A: RESET SELECTED
```

As amostras são **fixtures de cor**, não instruções para forçar esses shortcuts na configuração real.

## 4. Localização técnica verificada no código da v3.2.1

1. `src/ux_model/ux_model.c` — template da `BLU2USB_SCREEN_MOUSE_OPTIONS`: índice 3 é `MODIFIER SHORTCUTS`; templates `BLU2USB_SCREEN_COMBINATIONS_1..6` têm as 2 linhas dinâmicas em 2/4, e `blu2usb_ux_combination_unavailable()` discrimina o botão-fonte que é Modifier.
2. `include/blu2usb/ux_model/ux_model.h` — `active_profile`, `modifier_source`, `shortcut_assignments[12]`, `custom_dirty`, `custom_targets`; a cor deve ser **derivada**, sem gravar novo campo em flash.
3. `src/app/main.c` — `synchronize_ux_profiles` já informa à UX perfil ativo e Modifier vindo de `profiles->custom_targets` aplicado (não draft); na v3.2.0+, a sincronização também carrega o perfil específico do mouse.
4. `src/renderer/profile_feedback.c` — `blu2usb_ui_enforce_applied_visual_contract()` na tela `MOUSE_OPTIONS` hoje **reconstrói as três cores dos itens a cada projeção**, marca o perfil ativo CURRENT e aplica seleção. **A nova regra do índice 3 precisa entrar nesse contrato para não ser sobrescrita pela etapa final.**
5. `src/renderer/renderer.c` — `blu2usb_ui_project()` gera valores de combinação em linhas 2/4, **redefine atualmente as quatro linhas 1-4 para ACTIONABLE**, aplica foco de rótulo/valor e, por último, preserva `UNAVAILABLE` como STATIC. A integração futura deve inserir a tonalidade CURRENT **somente nos valores válidos atribuídos**, na ordem correta antes/depois do foco para resultar em SELECTED_CURRENT e **sem sobrescrever UNAVAILABLE**.
6. `include/blu2usb/renderer/renderer.h` — paleta já implementa ciano normal `0x07FF`, ciano de seleção `0xD7FF` e helper `blu2usb_ui_tone_on_focus`; **reutilizar os papéis sem alterar RGB, nem criar nova cor**.

**Risco principal:** ordem de composição dos tons; se aplicar ciano antes da normalização de combinações a cor some, ou se aplicar depois do foco a linha selecionada fica em ciano normal em vez de pastel. Se aplicar a linha toda, o rótulo muda indevidamente. Se sobrescrever o reparo final de `UNAVAILABLE`, regredirá a UI de combinação indisponível. O pré-flight deve congelar snapshots das 4 linhas (dois pares) e estados de foco.

## 5. Matriz obrigatória de testes

| Cenário | MODIFIER SHORTCUTS (normal / selecionado) | Valor de shortcut configurado (normal / selecionado) | Valor NOT CUSTOMIZED | Valor UNAVAILABLE |
|---|---|---|---|---|
| PASSTHROUGH + sem Modifier | cinza / branco | cinza / branco | **igual ao atual** | **igual ao atual** |
| PASSTHROUGH + Custom salvo com Modifier | cinza / branco | cinza / branco | **igual ao atual** | **igual ao atual** |
| CUSTOM aplicado + sem Modifier | cinza / branco | cinza / branco | **igual ao atual** | **igual ao atual** |
| CUSTOM aplicado + Modifier | **ciano / ciano claro** | **ciano / ciano claro** | **igual ao atual** | **igual ao atual** |

Além da tabela:

- Cobrir as **6 páginas de Combinations**, cada uma com 2 pares e focos alternados: rótulos sem novo ciano, somente valores válidos, sem fuga de cor ao paginar/retornar.
- Configurar uma atribuição (como ESCAPE ou PASTE), depois resetar para NOT CUSTOMIZED, e voltar a atribuí-la; aplicar/revogar Modifier e verificar atualização imediata quando o estado aplicado é confirmado.
- Alternar CUSTOM → PASSTHROUGH → CUSTOM, com dados Custom salvos; verificar que ciano **apaga e volta** apropriadamente, preservando valores e sem efeitos no perfil funcional.
- Criar alteração de Modifier **só no rascunho**, sem APPLY: não deve ligar ciano baseado em draft. Confirmar depois e retestar. Testar `custom_dirty` sem confundir o rascunho com a configuração ativa.
- Com **dois mouses salvos** (MNT-10), usar perfis e modifiers distintos; alternar/reiniciar e comprovar que o ciano é do mouse **conectado** e não de outro bond, independentemente de Saved Devices.
- Conferir `UNAVAILABLE` por combinar MOD com o **próprio botão que é a fonte Modifier** (por exemplo: LEFT se LEFT é Modifier). Mesmo se a combinação estiver selecionada, seu valor conserva estilo existente.
- Preservar perfil ativo e cores das opções PASSTHROUGH/CUSTOM, seleção ciano clarinho em CURRENT, gray→white nos demais, 9×21, Help/Lock/Back, 12 slots/30 atalhos, Modifier HID, persistência por mouse.
- Testes C de projeção do `frame->cells[row][col].tone` com cenários de foco, além de source contract de isolamento das linhas e regressão completa; para futura entrega: CI host PASS, Pico 2 W produção PASS, UF2 do artifact oficial com SHA-256 validado e teste físico no LCD desde HOME CONNECTED.

## 6. Contrato de execução futura (não autorizado agora)

1. Receber ordem expressa para **implementar MNT-12**, confirmar tag oficial v3.x e PR em branch própria; registrar `executions/MNT-12/pre-implementation.md` com valores de baseline, fixtures e testes previstos.
2. Implementar o **menor ajuste na camada de estado/renderização**, calculando um único predicado de “Modifier efetivamente ativo”; não mudar modelo HID, persistência, número de atalhos, fluxos ou navegação. Corrigir composição em `profile_feedback.c` e `renderer.c` sem mudar outras telas.
3. Adicionar/regredir testes e CI completa, compilar produção Pico 2 W, validar UF2/SHA, registrar `executions/MNT-12/candidate.md` e `physical-acceptance.md`.
4. Aguardar **aceite físico explícito**. Se rejeitado, corrigir na mesma branch e novo UF2. Se aceito, bump PATCH 3.x sobre tag vigente, CI versionada, PR/merge, GitHub Release UF2/SHA256SUMS e documentar `operator-acceptance.md`/`release.md`.
5. **Não prosseguir automaticamente para MNT-13 ou MNT-14.** Esses gates exigem autorização independente; MNT-14 permanece suspenso.

**Estado final desta solicitação: PLANEJAMENTO APENAS. Nenhuma alteração em firmware, flash, CI, PR ou release.**
