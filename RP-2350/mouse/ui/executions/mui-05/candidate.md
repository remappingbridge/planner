# MUI-05 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-05-navigation`;
- base: accepted MUI-04 `8aed51e00eaadff351e77778f92646ec155bae9d`;
- initial implementation: `fbd12d59388bfd7daf3cc09f89c9fd839c409194`;
- strict-build fix: `535c98a40ff3909e2f5d1078ec531051f9852164`;
- final candidate with stale-result scenario: `acdce2b26d661b9855a3220d5c95858eab1fb3ad`.

## Architecture

~~~text
semantic HAT input
       ↓
MUI-02 interaction ownership
       ↓
mouse_ui_navigation
       ├────────────→ semantic mock intents
       │                    ↓
       │             MUI-03 mock world
       │                    ↓
       └──────────── Product View/results
                            ↓
                    MUI-04 projector
                            ↓
                    MUI-01 renderer
~~~

Navigation owns screen, selection, page, Help owner, Lock state, pending semantic operation identity, and reconciliation. It contains no screen literals, renderer glyph logic, SDL mapping, BLE/USB protocol, or real persistence.

## Flow coverage

Automated scenarios cover:

- repeated FIRST 8-second cycles and first connection;
- action-on-release and stale release after screen epoch change;
- SAVED search Help with original deadline preserved;
- retry/cancel flows;
- ordinary Lock + consumed unlock;
- instructional B-lock / X-only-unlock;
- connected HOME four options;
- contextual Help and return ownership;
- Passthrough/Standard/Escape active/not-active routing;
- profile apply failure followed by confirmed success;
- Escape active JOY LEFT direct HOME shortcut;
- Custom source editor, dirty draft, reboot persistence, full confirmed Custom apply;
- Saved Devices paging, disconnected/connected status without page theft;
- remove failure/success and last-saved return to FIRST search;
- Pair New timeout/help/retry/cancel and successful replacement handoff;
- stale older async operation result ignored while newer operation remains pending;
- intended navigation reachability for all 30 canonical screens.

## CI evidence

An initial strict build detected one unused test helper; it was removed before acceptance.

Green run `35568755184` proved the complete implementation/test suite with 8/8 contracts in Debug and ASan/UBSan. A final scenario was then added for stale async replacement.

Final run: `35568861841`; head `acdce2b26d661b9855a3220d5c95858eab1fb3ad`. Both host jobs completed successfully, including `navigation_contract`, all prior contracts, screen hashes, architecture guards, and `mouse-ui-nav-probe`.

## Representative trace observations

The CI trace confirms:

- `boot empty` → `searching-first`, FIRST/RUNNING;
- after +16 s the screen remains `searching-first` with a renewed FIRST transaction;
- first result → `first-mouse-connected`; B locks, Y while locked is ignored, X unlocks;
- Y → `home-connected`; Help round-trip returns HOME;
- Standard request remains `standard-not-active` while PENDING;
- failed Standard remains not-active; confirmed success → `standard-active`;
- Pair New keeps current Mouse and transaction alive through Lock/unlock;
- at +2999 ms Pair New is still RUNNING; result at +3000 ms → handoff + HOME connected;
- disconnect on HOME → `home-searching` SAVED/RUNNING;
- timeout while Help remains on Help but changes return owner to `home-retry`;
- Saved Devices remains reachable after retry.

## Human trace review — PASS

Run on Debian:

~~~bash
git fetch origin
git switch mui/mui-05-navigation
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui-nav-probe
~~~

The review is semantic rather than graphical: confirm the ordered state lines are understandable and that Lock/Help/failure/pending/handoff/search-timeout behavior reads naturally before the SDL shell exposes the same reducer interactively.

## Out of scope / not claimed

- no SDL window or keyboard adapter;
- no scale/backlight implementation;
- no interactive inspector UI yet;
- no public UI↔Core contract release;
- no physical/hardware claim.

## Rollback

If rejected, abandon `mui/mui-05-navigation` and return to accepted MUI-04 `8aed51e00eaadff351e77778f92646ec155bae9d`. Preserve scenario tests as the behavioral specification if the reducer itself is replaced.

Acceptance record: the operator's Debian execution passed all 8 contracts and reproduced the expected deterministic trace for FIRST cycling, first connection, instructional Lock/unlock, HOME Help, Standard failure/success, Pair New handoff, disconnect, saved-search Help timeout, retry, and Saved Devices. The trace ended in `MUI-05 trace PASS`, after which the operator explicitly accepted the gate. MUI-05 was promoted to `mouse-ui/main` at `acdce2b26d661b9855a3220d5c95858eab1fb3ad`.
