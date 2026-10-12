# MNT-11 — release v3.2.1

**STATUS: ACEITO E PUBLICADO.** Em 11/10/2026 o operador aceitou MNT-11 e determinou **não avançar ao próximo gate** enquanto investiga PAIR NEW.

- PR [#41](https://github.com/remappingbridge/remappingbridge/pull/41) integrado por squash à `main`; commit oficial **`3846e8f4ee5fba40421c0db1f51387de6c51e953`**.
- Tag [v3.2.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.1) **verificada**; aponta ao commit oficial `3846e8f4ee5fba40421c0db1f51387de6c51e953`, e `tests/test_bootstrap.c` da tag contém **3.2.1**.
- CI do firmware aceito [#534](https://github.com/remappingbridge/remappingbridge/actions/runs/38190966788): **93/93 host PASS**, Pico 2 W production SUCCESS; UF2 candidato SHA256 `968243c2502d79b2baf5cc718a48ff6227553d6724771db3759df8705256e36e`.
- CI do código versionado [#539](https://github.com/remappingbridge/remappingbridge/actions/runs/38192205507): **host e Pico 2 W production SUCCESS**, antes da integração.
- Artefatos e hash da release final são recompilados pelo workflow `.github/workflows/release-v3.2.1.yml`; **não** confundir hash do UF2 candidato com hash do binário da release.
- Correção: normalizador compartilhado HOME/Saved detecta `MOUSE` em qualquer posição, ignorando caixa, e não anexa outro sufixo. Nenhum ajuste BLE, pairing, HID, perfis ou bonds foi parte do MNT-11.
- **HOLD:** **MNT-12 não iniciado**, por instrução expressa do operador. Investigação de PAIR NEW separada em [investigations/pair-new-with-connected-mouse-2026-10-11.md](../../investigations/pair-new-with-connected-mouse-2026-10-11.md).

O título HTML/herdado no workflow usa `--title "RemappingBridge 3.0"`, apesar de tag, versão embutida, notas e artefato **v3.2.1**. Esse detalhe de metadados não altera o commit/tag versionados, mas deve ser corrigido no workflow em uma manutenção futura; não alterar nesta investigação.
