# HOPE-07 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@4a1451e5ce25573734fc6179c45867588b76bbb0`
- branch: `hope/hope-07-retry-pair-new`
- candidate commit: `1f7c7d7b35faffad55bb52dab0155ba95f626174`
- draft PR: `#10`
- PR remains unmerged until operator physical acceptance.

## Canonical screen

~~~text
NEW MOUSE NOT FOUND
NO NEW MOUSE OUTSIDE
THE LIST OF SAVED
DEVICES WAS FOUND

KEY A: RETRY NEW PAIR
KEY B: BACK TRY SAVED
KEY X: HELP
KEY Y: LOCK
~~~

## Behavior implemented

- accepted Pair New 15-second timeout now enters `retry-pair-new`;
- accepted `help-pair-new` now returns to `retry-pair-new`, not to the active Pair New screen;
- KEY A enters active `pair-new`; the accepted HOPE-06 app screen-transition hook requests a fresh 15-second Pair New operation;
- KEY B leaves through the HOME resolver;
- KEY X is visible but intentionally inert until HOPE-27;
- KEY Y uses normal global lock behavior;
- no active Pair New search runs merely because retry is visible.

## HOME resolution from KEY B

- current Mouse live -> inherited connected HOME placeholder until HOPE-03;
- saved Mouse offline -> accepted `home-searching`, with saved-only search started by the existing transition hook;
- no saved Mouse -> accepted `searching-first`.

## Rendering

- black body;
- dark-magenta hint field beginning at row 5;
- title magenta;
- explanatory body static/yellow;
- action hints light gray with normal held feedback.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope07_retry_pair_new.c`
- `tests/test_hope07_retry_pair_new_source.py`
- `tests/test_hope26_help_pair_new.c`
- `tests/test_hope26_help_pair_new_source.py`

No BLE Pair New runtime file changed.

## Automated verification

GitHub Actions run: `35828756931` — **SUCCESS**.

### host-architecture — SUCCESS

- inherited G02–G06 tests: PASS;
- accepted HOPE regressions: PASS;
- HOPE-26 Help regression: PASS;
- HOPE-07 focused UX/render test: PASS;
- HOPE-07 source lifecycle test: PASS;
- architecture/screen-contract tests: PASS.

Focused tests freeze:

1. exact 9-row retry literal;
2. hint start at row 5;
3. black body / dark-magenta hints;
4. X inert until HOPE-27;
5. A enters active Pair New;
6. B resolves HOME for live, saved-offline and no-saved states;
7. Y locks and unlock resolves HOME;
8. Pair New Help returns to retry;
9. Pair New timeout source targets retry;
10. retry -> Pair New is covered by the existing Pair New request transition hook.

### pico2-w-production — SUCCESS

- pinned ARM toolchain: PASS;
- pinned Pico SDK: PASS;
- Pico 2 W configure/build: PASS;
- UF2 verification: PASS;
- artifact upload: PASS.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10736321472`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **328,319 bytes**
- ZIP digest: `sha256:a4cf22775d04c814084103094a1eb4ffd715a87877978926fb3f3fa0907092d6`

Extracted firmware:

- file: `HOPE-07-retry-pair-new-new-title-pico2w.uf2`
- size: **891,392 bytes**
- SHA-256: `095eece4b490274f3ae9f697bdee2e9b80461bf32897deffdb870656cb7fdb2e`

## Gate state

HOPE-07 is **not ACCEPTED** until the operator validates this exact candidate on hardware.


## Operator-requested title improvement

Before physical acceptance, the retry title was changed from `PAIR NEW MOUSE` to `NEW MOUSE NOT FOUND`.

All other retry text and behavior remain unchanged.

The previous candidate `790ee2754c89cf151e1d85f20cad4c64c674834e` and UF2 hash `096c3878...` are superseded.
