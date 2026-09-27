# MUI-02 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-02-interaction`;
- base: accepted MUI-01 `4daa0963e476eebd61cd7049b43cba582413144a`;
- candidate commit: `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`;
- commit message: `MUI-02: implement semantic interaction ownership`.

## Implemented semantics

Semantic controls:

~~~text
JOY_UP JOY_DOWN JOY_LEFT JOY_RIGHT JOY_PRESS
KEY_A KEY_B KEY_X KEY_Y
~~~

Semantic phases: `PRESS`, `RELEASE`.

Interaction outcomes:

- `PRESS_ACCEPTED` — first valid press owns the control;
- `RELEASE_ACTION` — matching release from current epoch; caller may execute action;
- `RELEASE_CONSUMED` — matching release was deliberately consumed;
- `DUPLICATE_PRESS` — press repeated while still held;
- `ORPHAN_RELEASE` — release without an active press;
- `STALE_RELEASE` — press belongs to an older interaction epoch;
- `INVALID` — invalid context/control/phase.

## Held-state model

The engine distinguishes:

- physical `held`: PRESS observed and physical RELEASE not yet observed;
- `visible held`: physically held **and** owned by current epoch **and** not consumed.

This permits a stale press to remain physically tracked until its eventual release while preventing it from highlighting or triggering actions in a new UI owner.

## Epoch model

The context starts at epoch 1. `mui_interaction_advance_epoch()` invalidates action ownership for currently held presses without fabricating a release. Their eventual release returns `STALE_RELEASE` and clears the physical hold.

## Consume model

`mui_interaction_consume()` marks an active press as consumed. Its matching current-epoch release returns `RELEASE_CONSUMED`, never `RELEASE_ACTION`. This is the generic primitive intended for unlock/Help ownership patterns in later gates.

## Deterministic edge behavior

- wrong-control release is orphaned and does not steal the correct press owner;
- duplicate press does not create a second owner;
- second release after a completed release is orphaned;
- multiple controls can be held independently;
- consumed state is per control;
- invalid events do not mutate interaction context;
- all nine semantic controls are tested through press → release action.

## Architecture boundary

`mouse_ui_interaction` depends only on `mouse_ui_domain`. It contains no screen ID, navigation rule, SDL mapping, GPIO mapping, hardware debounce timing, or backend operation.

`mui_input_event_t.sequence` remains metadata for adapters/debugging; ownership does not depend on timing or sequence arithmetic.

## GitHub Actions evidence

- workflow run: `35566653090`;
- head: `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`;
- `host-debug` job `106229723183`: **success**;
- `host-asan-ubsan` job `106229723073`: **success**.

Both jobs reported:

~~~text
foundation_contract                     Passed
interaction_contract                    Passed
renderer_contract                       Passed
architecture_guard                      Passed
architecture_guard_forbidden_fixture    Passed
100% tests passed, 0 tests failed out of 5
~~~

No ASan/UBSan finding was reported.

## Automated acceptance mapping

- [x] matching current-epoch release is the only action-producing outcome;
- [x] stale release after epoch transition is non-action;
- [x] duplicate/orphan/second-release cases deterministic;
- [x] consumed interaction is non-action;
- [x] held/visible-held behavior deterministic;
- [x] all semantic controls covered;
- [x] architecture guard green with no SDL/GPIO/backend dependency.

## Human semantic review — PASS

Review whether these names are clear enough to preserve as the frontend semantic vocabulary for future SDL and embedded adapters:

~~~text
JOY_UP JOY_DOWN JOY_LEFT JOY_RIGHT JOY_PRESS
KEY_A KEY_B KEY_X KEY_Y

PRESS RELEASE

PRESS_ACCEPTED
RELEASE_ACTION
RELEASE_CONSUMED
DUPLICATE_PRESS
ORPHAN_RELEASE
STALE_RELEASE
INVALID
~~~

Recommended interpretation: only `RELEASE_ACTION` authorizes a product/UI action. All other release outcomes are explicitly non-action.

## Out of scope / not claimed

- no screen navigation;
- no Lock or Help policy implementation yet (only the generic consume primitive);
- no desktop keyboard mapping;
- no GPIO mapping/debounce;
- no mock world/backend operation;
- no physical input validation.

## Rollback

If rejected, abandon `mui/mui-02-interaction` and return to accepted MUI-01 `4daa0963e476eebd61cd7049b43cba582413144a`.

Acceptance record: on 2026-09-21 the operator explicitly accepted the proposed control/phase/outcome vocabulary. MUI-02 was then promoted to `mouse-ui/main` at `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`.
