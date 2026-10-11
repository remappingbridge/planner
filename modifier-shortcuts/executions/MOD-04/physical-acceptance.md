# MOD-04 — Physical operator acceptance (Raspberry Pi Pico 2 W)

**Status: CORRECTIVE CI 66/66 PASS + VERIFIED UF2 / MOD-04 PHYSICAL ACCEPTANCE PENDING.** Use [visual-correction.md](visual-correction.md) for the corrected firmware evidence. Do **not** use the original 65-test UF2 for bugfix acceptance. Start every scenario from HOME connected with previously bonded Mouse. Do not use flash_nuke.

- [ ] **01 — Upgrade:** Flash candidate MOD-04 UF2 in BOOTSEL without flash erase; saved Mouse reconnects, its bonds, name, H/V DPI and rotation remain.
- [ ] **02 — New WILL BECOME order:** HOME → REMAPPING OPTIONS → CUSTOM REMAPPING → LEFT WILL BECOME. Six options: LEFT, RIGHT, MIDDLE, FORWARD, BACKWARD, MODIFIER (last row). No ESCAPE here. Repeat other four source screens.
- [ ] **03 — Draft vs Applied:** Select LEFT → MODIFIER by KEY A. Back at EDIT CUSTOM the LEFT value shows MODIFIER. Before KEY A APPLY CUSTOM, combinations still do **not** mask LEFT. Apply Custom and revisit COMBINATIONS 2 OF 6, LEFT slot now shows UNAVAILABLE.
- [ ] **04 — Mask blocking:** On `MOD + LEFT CLICK IS` UNAVAILABLE, both JOY PRESS and KEY A RESET stay on the page; previously saved shortcut not erased. Other combos remain editable.
- [ ] **05 — Shift Modifier to MIDDLE:** HOME → CUSTOM REMAPPING → MIDDLE WILL BECOME → MODIFIER → KEY A, then KEY A APPLY CUSTOM. The old LEFT returns to LEFT identity, and COMBINATIONS 2 left slot restores its prior shortcut (e.g. COPY); COMBINATIONS 1 MIDDLE now shows UNAVAILABLE. Confirm MIDDLE slot's previously saved shortcut remains latent.
- [ ] **06 — Other physical sources:** Repeat for RIGHT, FORWARD and BACKWARD. Each masks only its matching button combo; RELEASED, WHEEL UP/DOWN and all MOVE options remain available.
- [ ] **07 — Reversible persisted assignment:** Configure a shortcut for a future Modifier source *before* assigning it Modifier. Mask, change Modifier, observe saved shortcut return without duplication or reset.
- [ ] **08 — PASSTHROUGH:** Apply Passthrough. Configured masks continue to identify Custom's saved Modifier source, but normal mouse clicks work in Passthrough; no shortcut execution.
- [ ] **09 — Reboot:** Power cycle Pico; Custom source and 12 shortcuts restore. No second Modifier arises; UNAVAILABLE computed from same stored Custom source. Existing saved Mouse data unchanged.
- [ ] **10 — UI regressions:** JOY UP/DOWN wraps through six WILL BECOME options; Back cancels without changing draft; selected white, current cyan, disabled UNAVAILABLE never cyan/white; '+' is visible in MOD + labels; KEY Y lock/unlock, Saved Devices connected-name-only cyan.
- [ ] **11 — Runtime boundary:** With Modifier active in Custom, its source click is not sent as ordinary mouse click, but no shortcut/keyboard command is emitted yet (MOD-05). Other buttons and scrolling behave per existing remap settings.

## Evidence
- **Current corrective commit:** [`1147e79cb80d23412488cd10e92f14a9f75f26a5`](https://github.com/remappingbridge/remappingbridge/commit/1147e79cb80d23412488cd10e92f14a9f75f26a5); production UF2 **936960 bytes**, **SHA256 `a93cb3ec8b1289ad87e48b2f03ce4e1830589cc538fe3122a6fa24f98daf41f0`**, [CI artifact 11704518123](https://github.com/remappingbridge/remappingbridge/actions/runs/38146526719/artifacts/11704518123). The old checksum `a78a9624d06587f6554e16058ccbc0219b04c2f84e01e6aff3c0c81019836b4f` was **superseded**, not for acceptance.
- Corrective host CI **66/66 PASS**, Pico 2 W production PASS: [Actions run #312](https://github.com/remappingbridge/remappingbridge/actions/runs/38146526719).
- Operator verdict: **PENDING**.
- Gate MOD-04 accepted: **NO**. MOD-05 remains blocked.

## 12–15 — Correções exigidas pelo operador
- [ ] **12 — Texto MODIFIER nas cinco fontes:** selecionar MODIFIER em cada WILL BECOME, aplicar com KEY A, confirmar `LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD IS MODIFIER` completo na EDIT CUSTOM REMAP.
- [ ] **13 — Botões WILL BECOME:** JOY PRESS não grava nem volta (todas as cinco telas); KEY B cancela e volta; apenas KEY A aplica e volta após sucesso. KEY X e JOY LEFT/RIGHT não aplicam. KEY Y faz Lock e o desbloqueio retorna à HOME conectada.
- [ ] **14 — Dicas depois de APPLY CUSTOM:** EDIT CUSTOM REMAP mostra simultaneamente `JOY PRESS: ACCESS` e `KEY B: BACK`. Antes de aplicar o rascunho, mantém `KEY A: APPLY CUSTOM`.
- [ ] **15 — Um único ciano:** MIDDLE WILL BECOME, aplicar FORWARD, reabrir e aplicar BACKWARD; voltar à WILL BECOME, FORWARD não pode estar ciano, somente BACKWARD. Selecionado continua branco. Repetir com MODIFIER como última opção.

**Veredicto dos bugs:** PENDING operador no UF2 corrigido. O aceite anterior de MOD-03 não é alterado.
