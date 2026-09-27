# HOPE remapper-options flow — consolidated candidate

Status: **BUNDLED CANDIDATE READY / AUTOMATED PASS / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Operator-authorized bundle

The operator explicitly authorized consolidating the remaining screens of the `remapper-options` flow without stopping for physical acceptance between each screen.

This single candidate contains:

- HOPE-10 — remapper-options
- HOPE-29 — help-remapper-options
- HOPE-11 — passthrough-active
- HOPE-14 — passthrough-not-active
- HOPE-12 — standard-not-active
- HOPE-13 — standard-active
- HOPE-15 — escape-not-active
- HOPE-16 — escape-active
- HOPE-17 — custom-edit
- HOPE-18 — left
- HOPE-19 — right
- HOPE-20 — middle
- HOPE-21 — forward
- HOPE-22 — backward

None of these bundled gates is accepted yet. They share one consolidated physical candidate.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base/restored main: `main@3471e983cb7ec048c9ebb4b057633ff1b028e3aa`
- branch: `hope/hope-10-remapper-options`
- candidate commit: `d2a9256d2a5a38bb4cdb892c38ae6445f207598f`
- draft PR: `#15`
- PR title: `HOPE remapper flow: consolidate REMAPPING OPTIONS screens`
- PR remains draft/unmerged until operator physical acceptance.

The earlier PR #14 premature merge remains non-acceptance history; main was restored before this candidate was built.

## Mouse UI v1 authority check

The relevant remapper-flow sections in `mouse-ui/main` and `release/ui-layout-v1.0` were compared on 2026-09-23 and are identical for:

- remapper-options
- help-remapper-options
- passthrough-active / passthrough-not-active
- standard-active / standard-not-active
- escape-active / escape-not-active
- custom-edit
- left / right / middle / forward / backward

Therefore there is no v1 branch ambiguity for this bundle.

## Explicit remappingbridge improvements

The operator requested two deliberate improvements which override the frozen v1 presentation and will be backported to Mouse UI only after the HOPE series finishes.

### Title

The remapper menu title is:

~~~text
REMAPPING OPTIONS
~~~

instead of v1's `MOUSE OPTIONS`.

### Exclusive current-profile cyan

On `REMAPPING OPTIONS`:

- exactly one confirmed current profile may be cyan;
- all non-current, non-selected profile rows are ordinary light gray;
- the selected row is white, even when it is the current profile;
- after a confirmed profile change, the previously current profile is explicitly reset to ordinary action tone before the new current profile is made cyan.

The renderer now rebuilds rows 1–4 from authoritative `active_profile` on every projection, eliminating stale cyan accumulation.

The renderer-base stale row mapping was also corrected from the historical five-option layout to the current four-option layout.

## Consolidated visible screens

### REMAPPING OPTIONS

~~~text
REMAPPING OPTIONS
 PASSTHROUGH
 STANDARD REMAP
 ESCAPE REMAP
 CUSTOM REMAP

JOY PRESS: ACCESS
KEY B: BACK
KEY X: HELP
~~~

### REMAPPER OPTIONS HELP

~~~text
REMAPPER OPTIONS HELP
CHOOSE FROM THE
OPTIONS TO CHANGE THE
FUNCTIONS OF THE
MOUSE BUTTONS.
PASSTHROUGH IS THE
DEFAULT OPTION.

ANY KEY: BACK
~~~

### PASSTHROUGH ACTIVE

~~~text
PASSTHROUGH ACTIVE
ORIGINAL MOUSE
BUTTONS POSITION
ARE ACTIVE NOW



KEY B: BACK
KEY Y: LOCK
~~~

### APPLY PASSTHROUGH

~~~text
APPLY PASSTHROUGH
ORIGINAL MOUSE
BUTTONS POSITION
ARE NOT ACTIVE


KEY A: APPLY
KEY B: CANCEL
KEY Y: LOCK
~~~

### APPLY STANDARD REMAP

~~~text
APPLY STANDARD REMAP
FORWARD IS LEFT
LEFT IS FORWARD
BACKWARD IS RIGHT
RIGHT IS BACKWARD

KEY A: APPLY
KEY B: CANCEL
KEY Y: LOCK
~~~

### STANDARD REMAP ACTIVE

~~~text
STANDARD REMAP ACTIVE
FORWARD IS LEFT
LEFT IS FORWARD
BACKWARD IS RIGHT
RIGHT IS BACKWARD


KEY B: BACK
KEY Y: LOCK
~~~

### APPLY ESCAPE REMAP

~~~text
APPLY ESCAPE REMAP
FORWARD IS LEFT
BACKWARD IS RIGHT
LEFT IS ESCAPE
RIGHT IS BACKWARD
MIDDLE IS FORWARD

KEY A: APPLY
KEY B: CANCEL
~~~

KEY Y remains the global Lock action when a Mouse is saved even though this screen intentionally does not print the Lock hint.

### ESCAPE APPLIED ACTIVE

~~~text
ESCAPE APPLIED ACTIVE
FORWARD IS LEFT
BACKWARD IS RIGHT
LEFT IS ESCAPE
RIGHT IS BACKWARD
MIDDLE IS FORWARD

KEY B: BACK
KEY Y: LOCK
~~~

### EDIT CUSTOM REMAP

~~~text
EDIT CUSTOM REMAP
 LEFT IS LEFT
 RIGHT IS RIGHT
 MIDDLE IS MIDDLE
 FORWARD IS FORWARD
 BACKWARD IS BACKWARD

JOY PRESS: ACCESS
KEY A: APPLY CUSTOM
~~~

Successful Custom apply no longer enters the legacy `CUSTOM APPLIED` presentation. Runtime+persistence confirmation leaves the user in `EDIT CUSTOM REMAP`, with the clean confirmed mapping rows cyan and the selected row white.

### Source editors

Each source editor uses this target order:

1. LEFT
2. RIGHT
3. MIDDLE
4. ESCAPE
5. FORWARD
6. BACKWARD

The product domain/storage enum order is unchanged. Explicit UI-order ↔ domain-target mapping functions isolate presentation order from persistence/runtime semantics.

KEY A applies the selected draft target and returns to Custom Edit. Current Mouse UI v1 behavior also accepts Joy Press for the same action. KEY B returns to Custom Edit preserving the edited source row.

## Functional consolidation

Existing G06 remap/profile/storage implementation remains the underlying authority.

- preset apply still requires successful runtime activation + persistence before active feedback;
- Custom target edits still persist through the existing draft engine;
- Custom full apply still uses the existing runtime/persistence confirmation;
- Escape still uses the accepted synthetic USB Keyboard output exception;
- no Bluetooth Keyboard/Composite functionality was introduced.

When the current Mouse disconnects while one of these active screens is visible:

- Passthrough Active -> Apply Passthrough
- Standard Remap Active -> Apply Standard Remap
- Escape Applied Active -> Apply Escape Remap

This matches current Mouse UI v1 active/not-active behavior.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/renderer/profile_feedback.c`
- `src/renderer/renderer.c`
- `src/ux_model/profile_state.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g06_profile_ui.c`
- `tests/test_hope10_remapper_options.c`
- `tests/test_hope10_remapper_options_source.py`
- `tests/test_hope_remapper_flow_consolidated.c`
- `tests/test_hope_remapper_flow_consolidated_source.py`

No BLE pairing, storage format, USB HID descriptor, profile domain enum, or remap engine architecture was changed.

## Automated verification

Canonical GitHub Actions run: `35838169062` — **SUCCESS**.

### host-architecture — SUCCESS

**35/35 tests PASS**.

The focused tests cover:

1. exact visible text for every bundled screen;
2. four-option REMAPPING OPTIONS menu;
3. active/inactive routing for Passthrough, Standard and Escape;
4. contextual Help and Help-owned KEY Y;
5. exclusive current-profile cyan after sequential confirmed profile changes;
6. selected-white precedence over current cyan;
7. Custom apply success remaining in Custom Edit;
8. Custom clean-current cyan rows with selected-white precedence;
9. source editor exact target order;
10. UI-order ↔ domain-target mapping, including ESCAPE and BACKWARD;
11. source editor KEY A / Joy Press apply-and-back;
12. source-editor KEY B return preserving source row;
13. global Y lock on non-Help remapper screens;
14. active preset screen demotion on Mouse disconnect;
15. all previously accepted HOPE regressions;
16. architecture and screen-contract tests.

An intermediate run found only a missing local renderer tone helper at link time; it was corrected before the canonical final run.

### pico2-w-production — SUCCESS

- pinned ARM toolchain: PASS
- pinned Pico SDK: PASS
- Pico 2 W configure: PASS
- production firmware build/link: PASS
- UF2 verification: PASS
- artifact upload: PASS

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10740041877`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **330,637 bytes**
- ZIP digest: `sha256:0c6fbf208cc0d4d3e92c18f3e0989943441ad3ffcdbf7d2310d280887aecfd56`

Extracted firmware:

- file: `HOPE-remapper-flow-consolidated-pico2w.uf2`
- size: **897,536 bytes**
- SHA-256: `875cda790bcc86652cd4e6676d5b75ae1108b8ff91ae7f1c1003e25e982c42f4`

## Gate state

All bundled remapper-flow gates remain **PHYSICAL ACCEPTANCE PENDING**.

Do not merge PR #15 and do not mark HOPE-10/29/11/14/12/13/15/16/17/18/19/20/21/22 ACCEPTED until the operator explicitly accepts this exact consolidated candidate.
