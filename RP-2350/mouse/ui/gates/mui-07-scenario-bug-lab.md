# MUI-07 — Scenario, Fault & Bug Evidence Lab

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-07-scenario-bug-lab`, commit `8694ae242e81fe2f74b00efede90962d8701161b`.

Evidence: `../executions/mui-07/candidate.md`.

## Objective

Make difficult UX states instantly reproducible and make bug reports self-identifying, deterministic, and useful for rebuilds.

## Dependency status

MUI-06 is ACCEPTED at `c621fd538c515fa9591eb80afaf6130dfe6a7add`. MUI-07 was originally developed provisionally from that exact candidate; the dependency chain became valid when the operator explicitly accepted gates 6 and 7 on 2026-09-21.

## Implemented tasks

1. Defined a 15-scenario deterministic catalog covering first use, first connection, connected/offline HOME states, Help during search, Pair New with live current Mouse, profile pending, dirty Custom, Saved Devices, removal, full registry, timeout, stale result, and late result.
2. Added SDL-free CLI scenario probe plus desktop `--list-scenarios` / `--scenario NAME` and SCN PREV/NEXT controls.
3. Added semantic fault/result injection: success, failure, timeout, disconnect, stale result, late result, and hold-pending.
4. Added deterministic step runner for TAP, ADVANCE_MS, FAULT, HOME, REBOOT, and FACTORY_RESET.
5. Added evidence v1 with scenario, screen, element metadata, clock, scale, selected/effective backlight, state/tone/bounds/text, search/operation tokens, stale count, framebuffer hash, and recent semantic events.
6. Added compact reference plus TXT and JSON formats.
7. Added raw logical framebuffer PPM to evidence bundles.
8. Added regression fixtures for stale-result, late-result, and remove-failed.
9. Added technical/user documentation for scenario startup, faults, evidence generation, and bug reproduction.

## Named scenario catalog

~~~text
first-use
first-connected
one-connected
saved-offline
search-help
pair-new-current-live
profile-pending
custom-dirty
saved-devices
remove-current
remove-failed
full-registry
search-timeout
stale-result
late-result
~~~

## Automated acceptance

- [x] named scenarios initialize deterministically
- [x] fault injections reach expected frontend states without backend code
- [x] same scenario/steps produce same semantic trace/framebuffer hash
- [x] evidence export contains stable screen/element references and relevant presentation settings
- [x] bug evidence generation does not mutate product state except explicit scenario actions
- [x] actual TXT/JSON/PPM bundle files are created and verified by `lab_contract`

Final CI run `35571682117`, head `8694ae242e81fe2f74b00efede90962d8701161b`, completed successfully in both `host-debug` and `host-asan-ubsan`. Both jobs reported `100% tests passed, 0 tests failed out of 10`, `MUI-07 deterministic scenario catalog PASS`, and SDL smoke PASS. No sanitizer finding was reported.

## Human acceptance

- [x] representative difficult states can be selected directly by scenario or SCN PREV/NEXT
- [x] semantic fault controls produce understandable frontend states
- [x] inspected elements yield useful scenario-aware compact references
- [x] TXT/JSON/PPM evidence flow is accepted as the bug-reporting workflow
- [x] saved regression fixtures are accepted as reproducible frontend evidence
- [x] MUI-06 dependency is accepted

Explicit operator acceptance was recorded on 2026-09-21: "gates 6 e 7 aceitos".

Run on Debian:

~~~bash
git fetch origin
git switch mui/mui-07-scenario-bug-lab
git pull
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure

./build/mouse-ui-lab-probe --list
./build/mouse-ui-lab-probe --all
./build/mouse-ui --list-scenarios
./build/mouse-ui --scenario stale-result
~~~

Inside the SDL application, test SCN PREV/NEXT, FAIL/TIMEOUT/STALE/LATE, Inspector selection, Ctrl+C/COPY REF, and F9/EVIDENCE.

Expected evidence files:

~~~text
mouse-ui-evidence.txt
mouse-ui-evidence.json
mouse-ui-evidence.ppm
~~~

## Forbidden scope

- automatic backend diagnosis
- network/cloud telemetry
- real Bluetooth/USB fault injection
- turning developer evidence metadata into product UI

Candidate review confirms none of these scopes were introduced.

## Rollback / rebuild point

Scenario definitions, evidence format, and regression tests are the durable assets. The SDL shell implementation may be replaced freely. If MUI-06 is rejected, MUI-07 must be rebased/revalidated on the replacement accepted desktop baseline before promotion.
