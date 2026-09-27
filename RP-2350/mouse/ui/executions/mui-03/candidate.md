# MUI-03 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-03-mock-world`;
- base: accepted MUI-02 `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`;
- candidate commit: `fe7acaa5059dcc8e489e031082c57f938dff59ec`;
- commit message: `MUI-03: implement deterministic semantic mock world`.

## Product View

`mui_product_view_t` is a frontend-private semantic model, deliberately separate from navigation and from the future public UI↔Core contract. It contains:

- up to 16 saved Mouse records;
- current connection truth;
- per-Mouse profile;
- search purpose/status/token/deadline;
- operation kind/status/token;
- global Custom applied template;
- persistent Custom draft/dirty state;
- stale-result diagnostic count.

## Mock behavior

- virtual time only; no wall-clock sleeps;
- FIRST and SAVED search deadlines: 8000 ms;
- PAIR_NEW deadline: 15000 ms;
- tokenized search/operation results;
- success/failure/timeout/stale/late result control;
- Pair New can produce semantic handoff to a replacement Mouse;
- profile apply, Custom apply, and remove use PENDING → SUCCEEDED/FAILED;
- saved Mouse/profile/Custom draft+applied state persists across mock reboot;
- connection/search/operation state does not persist as product storage;
- factory reset returns to defaults.

## Initial scenarios

~~~text
empty
one-connected
one-saved-offline
custom-dirty
full-registry
~~~

These are intentionally small foundations; MUI-07 will own the richer scenario/fault laboratory.

## Architecture boundary

~~~text
mouse_ui_mock
      ↓
mouse_ui_domain/product_view
~~~

The mock does not depend on renderer, interaction, app/navigation, SDL, or backend transports. Architecture guard scans mock source and rejects backend/platform tokens.

## GitHub Actions evidence

- workflow run: `35567092031`;
- head: `fe7acaa5059dcc8e489e031082c57f938dff59ec`;
- `host-debug` job `106230988717`: **success**;
- `host-asan-ubsan` job `106230988984`: **success**.

Both jobs reported:

~~~text
foundation_contract                     Passed
interaction_contract                    Passed
mock_world_contract                     Passed
renderer_contract                       Passed
architecture_guard                      Passed
architecture_guard_forbidden_fixture    Passed
100% tests passed, 0 tests failed out of 6
~~~

No ASan/UBSan finding was reported.

## Automated coverage highlights

- 7999 ms remains SEARCH_RUNNING; +1 ms becomes TIMED_OUT;
- Pair New result at exactly scheduled virtual time;
- search failure independently injected;
- profile failure leaves confirmed profile unchanged;
- profile success changes/persists profile;
- stale older operation token increments stale diagnostic and cannot overwrite newer pending operation;
- dirty Custom draft survives reboot without changing applied template;
- successful Custom apply copies draft to applied and confirms Custom profile;
- failed remove preserves Mouse/current connection;
- successful remove removes/disconnects;
- persisted Mouse survives reboot;
- factory reset clears persisted state;
- identical scenario + event sequence yields identical Product View hash;
- named scenarios initialize expected states.

## Human trace review — PASS

Run on Debian:

~~~bash
git fetch origin
git switch mui/mui-03-mock-world
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui-mock-probe
~~~

Review whether the textual trace is immediately understandable for UX debugging. In particular, the sequence should make it obvious when search/operation is RUNNING/PENDING versus FAILED/SUCCEEDED, which Mouse is current, whether Custom is dirty, what virtual clock value is active, and whether reboot/factory reset produced the expected semantic state.

## Out of scope / not claimed

- no screen IDs or navigation;
- no renderer integration;
- no SDL shell;
- no Bluetooth/GATT/HIDS/HID++;
- no TinyUSB;
- no flash-sector or credential implementation;
- no released UI↔Core contract.

## Rollback

If rejected, abandon `mui/mui-03-mock-world` and return to accepted MUI-02 `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`.

Acceptance record: the operator's Debian trace showed the expected deterministic states and hashes: one connected Mouse at t=0; Pair New RUNNING through t=2999ms; handoff/FOUND at t=3000ms; profile FAILED then SUCCEEDED; dirty Custom draft preserved across reboot with current connection cleared; factory reset returning to empty/default state. MUI-03 was explicitly accepted and promoted to `mouse-ui/main` at `fe7acaa5059dcc8e489e031082c57f938dff59ec`.
