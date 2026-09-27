# MUI-05 — Navigation & Baseline UX Flows

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-05-navigation`, commit `acdce2b26d661b9855a3220d5c95858eab1fb3ad`.

Evidence: `../executions/mui-05/candidate.md`.

## Objective

Implement the complete platform-independent MBR-08 frontend flow over the projector, interaction engine, and deterministic mock world.

## Dependencies

MUI-04 **ACCEPTED** at `8aed51e00eaadff351e77778f92646ec155bae9d`.

## Deliverables

- pure `mouse_ui_navigation` reducer/coordinator;
- semantic HAT input → interaction ownership → navigation → semantic mock intent/result → projector/render flow;
- `navigation_contract` end-to-end regression suite;
- `mouse-ui-nav-probe` deterministic headless trace;
- `docs/development/navigation.md`.

## Automated acceptance

- [x] all 30 baseline screens reachable through intended navigation
- [x] release-triggered actions and stale epoch behavior hold end-to-end
- [x] 8 s/15 s mock deadlines behave deterministically
- [x] Help/Lock behavior matches active specs and consumes return/unlock interactions
- [x] profile/Custom/removal UI distinguishes request from confirmed result
- [x] background disconnect/reconnect does not steal Saved Devices page
- [x] stale async result cannot promote/overwrite a newer operation

Final verification run `35568861841`, head `acdce2b26d661b9855a3220d5c95858eab1fb3ad`, passed all 8 CTest contracts in both `host-debug` and `host-asan-ubsan`. Navigation trace also completed successfully in both jobs.

## Human acceptance

- [x] run and review `mouse-ui-nav-probe` on Debian
- [x] confirm the scripted flow remains understandable before SDL desktop shell work

Run:

~~~bash
git fetch origin
git switch mui/mui-05-navigation
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui-nav-probe
~~~

Review the trace from `boot empty` through first-search cycling, first connection, instructional Lock, HOME Help, Standard failure/success, Pair New lock/handoff, disconnect, saved-search Help timeout, retry, and Saved Devices.

## Forbidden scope

- SDL desktop shell
- new UX redesign
- Core contract release
- real hardware behavior

Candidate review confirms these scopes remain outside MUI-05.

## Rollback / rebuild point

Scenario tests define accepted behavior. If future UX corrections require many reducer exceptions, rebuild navigation from accepted MUI-04 while retaining the scenario suite.

Acceptance record: on 2026-09-21 the operator reported `100% tests passed, 0 tests failed out of 8`, supplied the complete `mouse-ui-nav-probe` trace ending in `MUI-05 trace PASS`, and explicitly stated `gate aceito`. The candidate was promoted to `mouse-ui/main` at `acdce2b26d661b9855a3220d5c95858eab1fb3ad` before MUI-06 began.
