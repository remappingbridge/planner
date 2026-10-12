# MNT-11 — preflight (sem mudança BLE/HID)

**Base:** o operador aceitou MNT-10 em 11/10/2026 e o PR #40 foi integrado à `main` como commit `3d7c196ffa0fbda935a77ae0f386d39b2b293d2c`, com versão fonte **3.2.0**. A branch `maintenance/v3x-mnt-11` nasceu exatamente desse SHA; a tag oficial `v3.2.0` deve ser verificada antes de encerrar o gate. PR draft [#41](https://github.com/remappingbridge/remappingbridge/pull/41).

**Escopo MEL-09:** impedir acrescentar ` MOUSE` ao nome BLE se a subsequência `MOUSE` já ocorrer em qualquer posição, ignorando caixa e sem exigir fronteiras de palavra. HOME CONNECTED, Saved Devices e demais páginas que exibem mouse já usam o helper compartilhado `home_title` de `src/renderer/renderer.c`; não deve duplicar lógica nem alterar o nome bruto persistido na BLE.

**Diagnóstico:** `home_title` já converte ASCII para maiúsculas e verifica a ocorrência antes de cortar a saída em 21 colunas. A regra antiga de detecção exige que caractere anterior e posterior não sejam alfanuméricos; por isso `0MOUSE2`, `MOUSEPAD` e `mOuSe2` recebem sufixo incorreto. Remover apenas o predicado de fronteira e a função `home_word_char`, preservando normalização, filtro de caracteres suportados, fallback `UNKNOWN MOUSE` e limite 9×21.

**Testes:** adicionar regressão host para `BTS. 0MOUSE2`, `mOuSe2`, `MOUSE-123`, `MOUSEPAD`, `SUPERMOUSEPAD`, `ABC_MOUSE_2`, `LIFT`, `LOGITECH LIFT`, vazio, inválido, NULL, nome com `MOUSE` após posição 15 e outro sem a subsequência. Conferir saída idêntica entre HOME e Saved Devices e após desconexão, preservando cores, navegação e perfis individuais MNT-10. A CI canônica deve passar e gerar UF2 Pico 2 W e SHA256 válido.

**Publicação:** MNT-11 ainda não foi aceito fisicamente. A versão futura prevista após aceite é **v3.2.1 PATCH**, não v4.0.0. Nenhuma mudança de versão/release no candidato.
