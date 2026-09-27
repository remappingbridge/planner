# MUI-07 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-07-scenario-bug-lab`;
- provisional base: MUI-06 candidate `c621fd538c515fa9591eb80afaf6130dfe6a7add`;
- scenario/evidence core: `ddd1d48f41408c8faa12acf12f43116943afe70e`;
- SDL integration: `92e07a0c1566780e807e2be7b7b573a14335f32a`;
- shell spacing refinement: `bd26cbc2b525b630265ac0b44cf005d53752b624`;
- real evidence bundle test: `8930a32462a6f7d39776c8c338a0b33c7eb75e2b`;
- final documented candidate: `8694ae242e81fe2f74b00efede90962d8701161b`.

## Promotion record

MUI-06 and MUI-07 received explicit operator acceptance on 2026-09-21. The accepted chain was promoted to `mouse-ui/main` at MUI-07 commit `8694ae242e81fe2f74b00efede90962d8701161b`.

## Pure lab architecture

~~~text
navigation + deterministic mock
             ↓
        mouse_ui_lab
   scenarios / faults / steps
   event log / evidence v1
             ↓
      desktop shell adapter
~~~

`mouse_ui_lab` is SDL-free. Architecture guard rejects SDL, BTstack, and TinyUSB tokens from the lab layer.

## Scenario catalog

Fifteen named scenarios are implemented and parseable by stable string name. Each loads from clean deterministic state and performs the minimum semantic setup necessary.

Representative states:

- `first-use` -> continuous FIRST/RUNNING on `searching-first`;
- `first-connected` -> `first-mouse-connected`;
- `search-help` -> SAVED search while `home-searching-help` owns presentation;
- `pair-new-current-live` -> Pair New RUNNING while current Mouse remains connected;
- `profile-pending` -> Standard confirmation with PROFILE_APPLY/PENDING;
- `custom-dirty` -> Custom editor with draft != applied;
- `saved-devices` -> two saved records;
- `remove-failed` -> remove confirmation remains after semantic failure;
- `full-registry` -> 16 saved records;
- `search-timeout` -> deterministic HOME retry;
- `stale-result` -> newer profile operation remains PENDING and stale count increments;
- `late-result` -> SAVED timeout wins; delayed result increments stale count.

## Fault injection

Supported semantic controls: success, failure, timeout, disconnect, stale-result, late-result, and pending. These operate only on frontend-visible semantic requests/results and do not emulate protocol packets or physical hardware.

## Deterministic step runner

Supported step primitives are TAP, ADVANCE_MS, FAULT, HOME, REBOOT, and FACTORY_RESET. The test suite runs identical scenario+step sequences twice and compares screen, time, Product View state, framebuffer hash, and event logs.

## Evidence v1

Compact, text, and JSON evidence formats contain scenario, screen, virtual clock, presentation settings, Lock, saved/current summary, search/operation states and tokens, stale-result count, framebuffer hash, Inspector element metadata, and recent events.

`mui_lab_write_evidence_bundle()` writes three files from one state:

~~~text
<prefix>.txt
<prefix>.json
<prefix>.ppm
~~~

The PPM is the raw 240×240 product framebuffer. Desktop scale, backlight gain, Inspector outline, and shell chrome are deliberately excluded.

`lab_contract` now performs a real bundle export, opens all three files, removes them, and verifies that framebuffer hash, Product View hash, clock, and screen remain unchanged.

## Desktop integration

The SDL shell adds:

- `--list-scenarios`;
- `--scenario NAME` startup;
- SCN PREV / SCN NEXT;
- current scenario in STATE panel;
- FAIL / TIMEOUT / STALE / LATE controls;
- F10 stale-result and F11 late-result shortcuts;
- F9 / EVIDENCE bundle export;
- scenario-aware Ctrl+C / COPY REF compact reference;
- 20-event semantic lab log with the latest 12 displayed.

Existing MUI-06 scale/backlight/HAT/Mouse/time/Inspector controls remain available.

## CI evidence

Final workflow: `35571682117`; head `8694ae242e81fe2f74b00efede90962d8701161b`.

Both `host-debug` and `host-asan-ubsan` reported:

~~~text
lab_contract                              Passed
100% tests passed, 0 tests failed out of 10
MUI-07 deterministic scenario catalog PASS
mouse-ui MUI-06 SDL smoke PASS: 300%=720x720
~~~

No ASan/UBSan finding was reported.

## Human review — accepted

Recommended quick validation:

~~~bash
./build/mouse-ui-lab-probe --all
./build/mouse-ui --scenario profile-pending
./build/mouse-ui --scenario stale-result
./build/mouse-ui --scenario late-result
./build/mouse-ui --scenario remove-failed
~~~

In the window, confirm direct scenario loading, scenario cycling, fault controls, Inspector metadata, Ctrl+C reference, and F9/EVIDENCE export. Inspect the generated `.txt` and `.json`; open the `.ppm` if useful.

## Out of scope / not claimed

- no backend diagnosis;
- no network/cloud telemetry;
- no real Bluetooth/USB fault injection;
- no Core implementation;
- no MUI-08 baseline parity claim.

## Rollback

If MUI-06 is rejected or replaced, retain the scenario catalog, lab tests, evidence v1 format, and documentation, then rebase/revalidate them over the replacement accepted desktop shell.

## Acceptance record

On 2026-09-21 the operator explicitly accepted MUI-06 and MUI-07 (`gates 6 e 7 aceitos`). MUI-07 is therefore no longer provisional and is the accepted base for MUI-08.
