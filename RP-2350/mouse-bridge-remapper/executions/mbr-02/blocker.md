# MBR-02 contract blocker — Pair New connected entry path

Gate: `mbr-02 — Interaction engine, UI projector and golden screen model`  
Status: **RESOLVED — superseded by 2026-09-20 connected HOME amendment**

## Finding

During executable transition modeling, the then-current MBR-00 product contract exposed a reachability contradiction. This record is retained as historical evidence; it was subsequently resolved by an explicit product amendment before MBR-02 acceptance.

The product contract requires a supported case in which `PAIR NEW` begins while one Mouse is already authoritative/connected and remains usable during discovery. However, the canonical screen/control inventory exposes `PAIR NEW MOUSE` only on:

- `home-searching`, whose precondition is saved records + **no authoritative Mouse**; and
- `home-retry`, which follows saved-search expiry/cancel in the same no-live HOME family.

The canonical `home-connected` screen contains only:

1. the current Mouse profile/remap summary;
2. `SAVED DEVICES`;
3. `LEARN THE KEYS`;
4. `KEY X: HELP TO REMOVE`.

It contains no visible Pair New action. The same contract explicitly forbids inheriting hidden controls.

Therefore the historical control map had no documented user-reachable transition from a valid `saved + live Mouse -> home-connected` state into `pair-new` while preserving that live Mouse.

## Resolution

The 2026-09-20 product amendment adds `PAIR NEW MOUSE` as the first visible option on `home-connected`, makes the connected Mouse name the dynamic title, maps the current remap summary to `remapper-options`, and retains Saved Devices/Learn the Keys as the third/fourth options. Selecting Pair New starts the existing 15-second new-only transaction without disconnecting the current Mouse.

The amended canonical screen and transition model are now authoritative.

## Why implementation did not guess

Any of these would be an unauthorized product change:

- add `PAIR NEW MOUSE` to `home-connected`;
- replace one existing `home-connected` row/option with Pair New;
- assign Pair New to a hidden Key/control;
- allow SEARCH_SAVED to keep running concurrently after entering Pair New so that a Mouse later becomes live;
- reinterpret the profile-summary row as Pair New.

The execution rules require stopping dependent work when the frozen documentation is materially contradictory rather than choosing an interpretation silently.

## Work completed despite blocker

Implementation branch:

`tiagooliveirajs/mouse-bridge-remapper:mbr/mbr-02-host-ux-model`

Current exact implementation head at blocker discovery:

`13cad3fec43eeed0353b0271a018012d115f2845`

PR:

`#2 — MBR-02: host UX model and golden screen contract`

Implemented and host-tested:

- all 30 canonical screen IDs/literals;
- 21-character name projection/fallback;
- release-triggered interaction;
- Help ownership/consumption;
- ordinary and instructional Lock semantics;
- HOME resolver;
- FIRST_MOUSE 8s repeated transaction model;
- SEARCH_SAVED 8s transaction model;
- PAIR_NEW 15s semantic transaction model;
- transaction/session stale-event filtering;
- one authoritative Mouse + one non-authoritative Pair New candidate representation;
- saved-candidate rejection for PAIR_NEW;
- Pair New timeout/cancel/handoff semantics at the state-machine API level;
- STANDARD vocabulary;
- Saved Devices connected/disconnected projection and cyan priority;
- Custom draft immediate projection;
- confirmation-only profile/removal success;
- exact Pair New Help literals and didactic columns;
- Escape active HOME shortcut;
- no Keyboard/Composite/multi-connected screen state.

The host CI at exact SHA `13cad3fec43eeed0353b0271a018012d115f2845` passed `bootstrap_contract`, `ux_golden_contract`, `ux_behavior_contract`, and `architecture_contract`.

The behavior test can exercise the required Pair New-with-live semantics by constructing that semantic state directly. This proves the state model supports it, but **does not prove the user can reach it through the frozen control map**. That distinction is the blocker.

## Additional implementation finding

When MBR-02 replaced MBR-01 stubs with real dependent static libraries, the MBR-01 CMake facade exposed a latent static-library link-order problem. The module graph itself was preserved, but declaration/wiring had to be separated so each implementation library precedes its dependencies on the final link line. Host build/tests pass after this correction.

## Acceptance impact

The blocker is closed. MBR-02 may proceed to exact-head CI, integration and completion reporting. No physical acceptance is required for MBR-02.

The next gate after MBR-02 acceptance is mbr-03.
