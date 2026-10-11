# MOV-10 — Help unificado | Contrato de implementação do último gate

Data: **2026-10-11** (America/Sao_Paulo). Produto: `remappingbridge/remappingbridge`; branch `feature/movement-options-v1.0` sem merge. Baseline: `release/v1.0.0`.

## Estado inicial
MOV-01 até MOV-09: **ACCEPTED** individualmente pelo operador (último aceite MOV-09 em 2026-10-11). MOV-10: **PENDING** até validação física. É o último gate e abrange exatamente **todas** as telas de Help novas/atualizadas, conforme [01-screen-contracts-and-navigation.md](../../01-screen-contracts-and-navigation.md), seção “All Help screens [MOV-10: ONE combined gate]”. Nenhuma aprovação de PR/merge/release é implícita.

## Quatro páginas reais, cinco percursos de entrada
- **SLOW DPI HELP** compartilhado entre Horizontal Slow e Vertical Slow, via `KEY X`: as sete linhas de título e instrução seguem as palavras exatas do planejamento (slower, sensitivity, precision). `ANY KEY: BACK` na última linha.
- **FAST DPI HELP** compartilhado entre Horizontal Fast e Vertical Fast, via `KEY X`: textos faster, high-resolution, widescreen environments. `ANY KEY: BACK`.
- **ROTATION HELP**, via `KEY X` na tela Rotation: explica 90 degrees, anticlockwise. `ANY KEY: BACK`.
- **REMOVE MOUSE HELP**, aberto por `KEY Y` na confirmação `REMOVE THIS MOUSE`: explica remoção de conexão automática, button remapping e **custom movements** (corrige apenas grafia, sem inventar novas promessas). `ANY KEY: BACK`.

Cada retorno por **qualquer tecla** (inclusive KEY Y e KEY A) é consumido exclusivamente no Help; não aplica ganho, não remove mouse, não ativa Lock e não navega à tela errada. A tela chamadora e a opção/candidato exatos são preservados, inclusive alternância H/V Slow/Fast. No Help de remoção, preservar o **bond lógico selecionado**; KEY A dentro do Help jamais confirma exclusão. Após pedido de remoção pendente, KEY Y continua sem abrir Help e sem Lock.

## Limites e evidência
- Grid 9 linhas × 21 colunas, legendas sem corte, sem outras telas ou menus de debug.
- Todas as telas Help já haviam sido integradas antecipadamente na branch; MOV-10 adiciona teste dedicado, não modifica rotinas estáveis salvo se regressões exigirem correção.
- Teste host `tests/test_mov10_all_help.c`: percorre as cinco rotas **a partir de HOME conectada** (dois eixos para cada Slow/Fast, Rotation e Remove This), confere cópia completa 9×21, repetições e teclas distintas de retorno, restauração de seleção, preservação H/V/Rotation, lock, bonding e candidato. Registrado em `tests/CMakeLists.txt`.
- Exigir suíte CI host e firmware Pico 2 W de produção para o SHA exato. Se o UF2 produzido for idêntico ao MOV-09 fisicamente aceito, teste físico MOV-10 pode usar aquele firmware, mas só afirmar isso após comparar SHA-256.
- O PR #22 permanece **Draft** e `main`/`release/v1.0.0` intactos até decisão separada do operador.

## Aceite
Somente o operador pode declarar MOV-10 ACEITO após teste manual de Help; não marcar conclusão da iniciativa nem mesclar automaticamente.
