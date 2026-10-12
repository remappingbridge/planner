# MNT-11 — candidato pronto, sem aceite físico

**STATUS: IMPLEMENTADO; CI 93/93 PASS; PICO 2 W PRODUÇÃO SUCCESS; UF2 CONFERIDO. ACEITE FÍSICO PENDING.** Não integrar PR nem criar tag v3.2.1 até confirmação do operador.

- Baseline: **tag oficial v3.2.0**, SHA verificado **`3d7c196ffa0fbda935a77ae0f386d39b2b293d2c`**; branch `maintenance/v3x-mnt-11` criada exatamente dele.
- PR draft: [#41](https://github.com/remappingbridge/remappingbridge/pull/41).
- Commit do candidato: **`3f883960b09fb71df1284dbe502cb77ee592ccdc`**.
- [CI canônica #534](https://github.com/remappingbridge/remappingbridge/actions/runs/38190966788): **93/93 testes host PASS** e **Pico 2 W production SUCCESS**, incluindo `mnt11_mouse_substring_home_and_saved`.
- GitHub Actions artifact **`11721787303`** (ZIP sha256 `ab144d825f77012b540bb2355e1c3bcac739c162dd2c934483585f4f6276a569`).
- UF2 extraído: **`remappingbridge-mnt11-pico2w.uf2`**, **951.808 bytes**.
- SHA-256 UF2: **`968243c2502d79b2baf5cc718a48ff6227553d6724771db3759df8705256e36e`**, conferido no container e **igual ao registro do log de compilação Pico 2 W do mesmo commit**.
- Versão embutida no candidato permanece **3.2.0**; próxima versão **v3.2.1 PATCH** apenas após aceite físico.

## Alteração e regressões

`home_title()` no `src/renderer/renderer.c` agora detecta `MOUSE` em **qualquer posição**, independentemente de fronteiras alfanuméricas ou variação ASCII de caixa, antes do truncamento 21 caracteres. Retirado o helper desnecessário `home_word_char`. Normalização para maiúsculas, filtragem dos caracteres suportados pelo LCD, fallback `UNKNOWN MOUSE`, política de sufixo para nomes sem MOUSE e 9×21 preservados. HOME CONNECTED e SAVED DEVICES usam o mesmo helper. Identidade BLE, bonds, IRK, persistência MNT-10, mouse/keyboard/consumer e comportamento de telas não foram alterados.

Novo teste host executa fixtures `BTS. 0MOUSE2`, `mOuSe2`, `MOUSE-123`, `MOUSEPAD`, `SuPeRmOuSePaD`, `ABC_MOUSE_2` (underscore removido na tela pela regra pré-existente), `LOGITECH LIFT`, `LIFT`, `mouse generic`, `UNKNOWN MOUSE`, nome com MOUSE após 15 caracteres, nome longo sem MOUSE e entrada vazia/inválida/null. Compara saídas HOME e SAVED DEVICES, inclusive após desconexão.

**Teste físico:** seguir `physical-acceptance.md`. Não há aceite físico informado para MNT-11.
