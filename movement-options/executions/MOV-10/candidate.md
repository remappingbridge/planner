# MOV-10 — Help unificado | Candidato de CI

**Status: HOST CI 59/59 PASS; PICO 2 W UF2 PASS; PHYSICAL ACCEPTANCE PENDING.**

Produto: `remappingbridge/remappingbridge`.
Branch: `feature/movement-options-v1.0`.
Source SHA: `f38c4984c2c1ebe28401dc9a3f410a62e132160a`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38136123704
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Mudanças do último gate

1. Adicionado `tests/test_mov10_all_help.c`. Parte da `home-connected` real para testar cinco percursos: Horizontal Slow/Vertical Slow (Help compartilhado), Horizontal Fast/Vertical Fast (Help compartilhado), Rotation Help e Remove Mouse Help a partir de Saved Devices.
2. Confere integralmente os **nove textos de cada Help** e a linha `ANY KEY: BACK`, sem truncamento. Confere retorno pelo release de KEY Y sem Lock, KEY A sem APPLY/REMOVE, KEY B/JOY PRESS sem mudança indevida, preservação de `return_screen`, seleção e candidatos, manutenção de H/V/rotação confirmados e do bond lógico do mouse selecionado. Enquanto exclusão pendente, KEY Y não pode abrir Help nem bloquear.
3. Teste registrado em `tests/CMakeLists.txt` como `mov10_all_help_copy_and_any_key_back`. A suíte inteira passou **59 de 59 testes host**, incluindo todos os 58 anteriores.
4. O runtime de Help já estava integrado e anteriormente exercitado em MOV-02–MOV-09, de modo que **este gate só acrescentou teste de regressão e CMake**, sem alteração de `src/`. Confirmado após extração/verificação: UF2 MOV-10 é binariamente idêntico ao MOV-09 fisicamente aceito, sem necessidade de regravar Pico.
5. Todos os gates anteriores MOV-01 a MOV-09 têm aceite físico explícito do operador. MOV-10 ainda **NÃO** foi aceito fisicamente.

## Evidência pendente

CI concluído: host 59/59 PASS e Pico 2 W production build/UF2 verification/upload PASS, no SHA `f38c4984c2c1ebe28401dc9a3f410a62e132160a`. Artifact GitHub Actions `11701285206`, nome `blu2usb-picow-production-pico2w`. UF2 extraído diretamente do ZIP, **925.696 bytes**, **1.808 blocos UF2** (primeiro bloco metadata família `0xe48bff57`, outros firmware `0xe48bff59`), SHA-256 **`dbbeb26fd013facccacb226d8b9e3bdba487871a146560f18c8ed28130721bdc`**. Conteúdo comparado integralmente com o MOV-09 aceito: **idêntico byte a byte**; portanto **não precisa reflashear se o MOV-09 permanece instalado**.

A validação física do MOV-10 ainda é exigida. **Não fazer merge nem release automaticamente depois do build.**
