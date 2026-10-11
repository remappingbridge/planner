# MOV-10 — Help unificado | Candidato de CI

**Status: HOST CI 59/59 PASS; PICO 2 W PRODUCTION BUILD IN PROGRESS; PHYSICAL ACCEPTANCE PENDING.**

Produto: `remappingbridge/remappingbridge`.
Branch: `feature/movement-options-v1.0`.
Source SHA: `f38c4984c2c1ebe28401dc9a3f410a62e132160a`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38136123704
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Mudanças do último gate

1. Adicionado `tests/test_mov10_all_help.c`. Parte da `home-connected` real para testar cinco percursos: Horizontal Slow/Vertical Slow (Help compartilhado), Horizontal Fast/Vertical Fast (Help compartilhado), Rotation Help e Remove Mouse Help a partir de Saved Devices.
2. Confere integralmente os **nove textos de cada Help** e a linha `ANY KEY: BACK`, sem truncamento. Confere retorno pelo release de KEY Y sem Lock, KEY A sem APPLY/REMOVE, KEY B/JOY PRESS sem mudança indevida, preservação de `return_screen`, seleção e candidatos, manutenção de H/V/rotação confirmados e do bond lógico do mouse selecionado. Enquanto exclusão pendente, KEY Y não pode abrir Help nem bloquear.
3. Teste registrado em `tests/CMakeLists.txt` como `mov10_all_help_copy_and_any_key_back`. A suíte inteira passou **59 de 59 testes host**, incluindo todos os 58 anteriores.
4. O runtime de Help já estava integrado e anteriormente exercitado em MOV-02–MOV-09, de modo que **este gate só acrescentou teste de regressão e CMake**, sem alteração de `src/`. Não presumir que o UF2 seja idêntico ao MOV-09 até comparar o SHA-256 do artefato de produção.
5. Todos os gates anteriores MOV-01 a MOV-09 têm aceite físico explícito do operador. MOV-10 ainda **NÃO** foi aceito fisicamente.

## Evidência pendente

Aguardar conclusão do job Pico de produção, baixar/extrair o UF2, verificar integridade RP2350 e registrar artifact ID/sha256, igualdade ou diferença binária com o MOV-09. Entregar o UF2 e o roteiro `physical-acceptance.md` ao operador. **Não fazer merge nem release automaticamente depois do build.**
