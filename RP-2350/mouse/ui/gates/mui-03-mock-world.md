# MUI-03 — Deterministic Mock World

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-03-mock-world`, commit `fe7acaa5059dcc8e489e031082c57f938dff59ec`.

Evidence: `../executions/mui-03/candidate.md`.

## Objective

Create the frontend-only product-view source and deterministic async result model so the UX can be developed without implementing a second backend.

## Dependencies

MUI-00, MUI-01, and MUI-02 are **ACCEPTED**. Candidate is based on accepted MUI-02.

## Tasks

1. Define private frontend Product View state separate from UI navigation state.
2. Define private semantic intents and observable result/events; do not publish them as the stable UI↔Core contract.
3. Model request/pending/success/failure for user-visible product operations.
4. Implement deterministic virtual clock and scheduled events without real sleeping.
5. Implement in-memory simulated persistence sufficient for REBOOT/FACTORY RESET UX.
6. Support saved Mouse records, current connection truth, profile state, Custom draft/applied state, search purpose/outcome, and removal/handoff results needed by baseline screens.
7. Add scenario primitives and stale/late event generation hooks.
8. Explicitly avoid HCI/GATT/HIDS/TinyUSB/flash-sector simulation.

## Deliverables

- `mui_product_view_t` private frontend semantic model;
- pure `mouse_ui_mock` library;
- virtual clock/scheduler;
- in-memory mock persistence;
- named initial scenarios;
- `mouse-ui-mock-probe` textual trace utility;
- `mock_world_contract` deterministic unit tests;
- `docs/development/mock-world.md`.

## Automated acceptance

- [x] identical input/event sequence yields identical state
- [x] clock advancement is deterministic and no test sleeps
- [x] success/failure/timeout/stale result paths are independently controllable
- [x] reboot restores simulated persisted view state; factory reset clears it
- [x] mock source has no BTstack/TinyUSB/flash implementation dependencies

GitHub Actions run `35567092031` passed 6/6 CTest contracts in both Debug and ASan/UBSan, including `mock_world_contract` and architecture guards.

## Human acceptance

- [x] inspect example state traces for clarity and usefulness to UX work

Run:

~~~bash
git fetch origin
git switch mui/mui-03-mock-world
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui-mock-probe
~~~

The trace should clearly show: one-connected baseline, Pair New pending at t+2999 ms, Pair New result/handoff at t+3000 ms, profile failure, profile success, dirty Custom draft, reboot preserving the draft but not connection, and factory reset returning to empty/default state.

## Forbidden scope

- real backend algorithms
- transport packet simulation
- public contract release
- screen rendering/navigation

Candidate review confirms none of these scopes were introduced.

## Rollback / rebuild point

If the mock starts reproducing backend internals, delete/rebuild it around semantic observable results while preserving `mock_world_contract` and Product View tests. Baseline for rebuild: accepted MUI-02 `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`.

Human acceptance record: on 2026-09-21 the operator ran the Debian flow, reported `100% tests passed, 0 tests failed out of 6`, and supplied the complete semantic trace from `one-connected` through Pair New, profile failure/success, dirty Custom draft, reboot, and factory reset. The trace matched the intended MUI-03 state model and was accepted. The candidate was promoted to `mouse-ui/main` before MUI-04 began.
