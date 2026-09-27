# Mouse Bridge Remapper planning

Status: **MBR-05 IMPLEMENTED / PHYSICAL ACCEPTANCE PENDING. MBR-00 through MBR-04 are physically accepted on the clean rebuild baseline.**

This directory is the planning source of truth for `tiagooliveirajs/mouse-bridge-remapper`.

## Goal

Rebuild the Mouse portion of physically accepted BLU2USB through G06 as a cleaner Mouse-only Bluetooth product with:

- BLE HOGP Mouse transport only;
- multiple saved Mouse records;
- zero or one authoritative live Mouse;
- Pair New new-only replacement handoff;
- frozen Mouse remap profiles including synthetic Escape;
- HOME-driven saved reconnect;
- documentation as product, code as consequence.

Accepted historical migration reference:

- repo `tiagooliveirajs/blu2usb`;
- branch `gate/g06-profiles-remap-logitech-hidpp`;
- accepted SHA `7eee024ad4ee726c5a85ffa2f32b9f47187878af`;
- accepted UF2 SHA-256 `d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88`.

G07+ Keyboard work is research evidence only.

## Current frozen product highlights

- one authoritative connected Mouse maximum;
- current Mouse stays live while Pair New searches;
- first valid unsaved replacement candidate triggers a safe handoff;
- Pair New timeout/cancel before handoff leaves current Mouse live;
- connected HOME presents the current Mouse name as title and exposes `PAIR NEW MOUSE` as its first visible option;
- connected HOME remap summary is the second option and opens `remapper-options`;
- connected HOME Saved Devices and Learn the Keys remain the third and fourth options;
- saved candidates are ignored as Pair New winners;
- to reconnect saved instead, unplug current Mouse and Back until HOME reaches SEARCHING;
- HOME with saved mice + no live Mouse starts 8-second saved search automatically;
- first-Mouse search repeats 8-second cycles until success;
- Pair New window is 15 seconds;
- canonical profile word is STANDARD;
- disconnected Saved Devices word is DISCONNECTED;
- names render first 21 supported characters, fallback `UNKNOWN MOUSE`;
- BLE HOGP only;
- Escape retained through minimal fixed USB Keyboard output;
- no Bluetooth Keyboard/Composite product support.

## Accepted clean rebuild baseline

Accepted product `main` now includes MBR-02:

`tiagooliveirajs/mouse-bridge-remapper@34f5806763503c79aa98e54923a3ec854b11d270`

MBR-01 established the compileable host/Pico 2 W scaffold, frozen module/dependency graph, single-authoritative-Mouse slot, separate non-authoritative Pair New candidate scaffold, architecture ownership guards and pinned G06-derived CI/toolchain baseline. The exact accepted implementation branch head was `826c50dab3b105c6bcecef6a6dbba401506aefc9`; exact-head CI run `35477941473` passed host/architecture and Pico 2 W production jobs.

## Current UX amendment

The 2026-09-20 connected-HOME amendment is recorded in `requirements/2026-09-20-connected-home-pair-new.md`. A later 2026-09-20 amendment for `home-searching-help` is recorded in `requirements/2026-09-20-home-searching-help.md` and changes only that screen's literal wording.

## Historical MBR-02 implementation state

MBR-02 implementation was integrated from product branch `mbr/mbr-02-host-ux-model`, PR #2. Amended implementation head: `ec21f11685e3e80cbb119560a4e8d5cd4e8a6ff0`. Integrated main: `34f5806763503c79aa98e54923a3ec854b11d270`.

Host CI on that exact SHA passed all four contracts:

- `bootstrap_contract`;
- `ux_golden_contract`;
- `ux_behavior_contract`;
- `architecture_contract`.

The implementation covers the 30 canonical screens, release interaction, Help/Lock, HOME/search transactions, stale IDs, Pair New candidate/handoff semantics, name/status/profile projection, Custom draft, confirmation-only success and semantic colors.

Historical pre-reset MBR-02 evidence is retained below. The active clean rebuild baseline is `mbr/rebuild-00-through-04` at `8bebe26ff7554ffa811a58ea024cae5fe80a4a84`; the operator accepted MBR-00 through MBR-04 physically on 2026-09-20. MBR-05 is implemented on `mbr/mbr-05-ble-mouse` at `7f294a7fac9eebe226ad66c6b572582c5e483421` with green host/Pico CI; physical acceptance is pending.

## Documents

1. [`00-authority-scope-and-precedence.md`](00-authority-scope-and-precedence.md) — authority and hard scope.
2. [`01-g06-migration-ledger.md`](01-g06-migration-ledger.md) — inherited G06 no-regression behavior.
3. [`02-ambiguity-register.md`](02-ambiguity-register.md) — closed MBR-00 decisions.
4. [`03-target-architecture.md`](03-target-architecture.md) — frozen architecture.
5. [`04-ux-state-model.md`](04-ux-state-model.md) — frozen UX state/transition semantics.
6. [`05-gates.md`](05-gates.md) — gates mbr-00 through mbr-10 and current status.
7. [`06-execution-rules.md`](06-execution-rules.md) — execution/evidence discipline.
8. [`07-mbr-00-frozen-contract.md`](07-mbr-00-frozen-contract.md) — gate-level frozen contract.
9. [`08-mbr-00-migration-manifest.md`](08-mbr-00-migration-manifest.md) — G06 reuse/adapt/exclude manifest.
10. [`executions/mbr-00/completion.md`](executions/mbr-00/completion.md) — durable MBR-00 completion report.
11. [`executions/mbr-01/pre-implementation.md`](executions/mbr-01/pre-implementation.md) — exact MBR-01 execution subject before implementation.
12. [`executions/mbr-01/completion.md`](executions/mbr-01/completion.md) — durable MBR-01 implementation/build/CI/integration record.
13. [`executions/mbr-02/pre-implementation.md`](executions/mbr-02/pre-implementation.md) — exact MBR-02 execution subject before implementation.
14. [`executions/mbr-02/blocker.md`](executions/mbr-02/blocker.md) — historical Pair New connected-entry contradiction, now resolved by the 2026-09-20 amendment.
15. [`requirements/2026-09-19-user-rules.md`](requirements/2026-09-19-user-rules.md) — original verbatim UX source.
16. [`requirements/2026-09-20-single-connected-mouse.md`](requirements/2026-09-20-single-connected-mouse.md) — single-live-Mouse simplification.
17. [`requirements/2026-09-20-connected-home-pair-new.md`](requirements/2026-09-20-connected-home-pair-new.md) — connected HOME Pair New entry amendment.
18. [`requirements/2026-09-20-pair-new-help-and-handoff.md`](requirements/2026-09-20-pair-new-help-and-handoff.md) — newest Pair New Help/handoff clarification.
19. [`requirements/2026-09-20-home-searching-help.md`](requirements/2026-09-20-home-searching-help.md) — current `home-searching-help` literal amendment.
20. [`executions/mbr-03/pre-implementation.md`](executions/mbr-03/pre-implementation.md) — exact renderer/HAT gate subject before implementation.
21. [`executions/mbr-03/candidate.md`](executions/mbr-03/candidate.md) — implementation/CI/UF2 evidence and physical acceptance matrix.

## Gate summary

| Gate | Status | Purpose |
|---|---|---|
| mbr-00 | **COMPLETE / ACCEPTED** | provenance + contract freeze |
| mbr-01 | **COMPLETE / ACCEPTED** | clean bootstrap and architecture guards |
| mbr-02 | **COMPLETE / ACCEPTED** | host interaction/state/projector/golden UX; connected HOME Pair New amended |
| mbr-03 | **COMPLETE / ACCEPTED** | Waveshare renderer/HAT candidate |
| mbr-04 | **COMPLETE / ACCEPTED** | fixed USB identity |
| mbr-05 | **IMPLEMENTED / PHYSICAL ACCEPTANCE PENDING** | BLE HOGP passthrough core |
| mbr-06 | **BLOCKED BY MBR-05 PHYSICAL ACCEPTANCE** | G06 profile/persistence/reconnect/HID++ parity |
| mbr-07 | **BACKLOG** | lifecycle/Pair New handoff/registry/removal |
| mbr-08 | **BACKLOG** | complete real UX integration |
| mbr-09 | **BACKLOG** | resilience/regression |
| mbr-10 | PLANNED | final release qualification |

## Evidence boundary

Active execution has advanced through the clean rebuild. MBR-00 through MBR-04 are physically accepted. MBR-05 automated evidence is complete on exact head `7f294a7fac9eebe226ad66c6b572582c5e483421`; only operator physical acceptance remains open. MBR-06 must not start until MBR-05 is physically accepted.


## MBR-03 historical implementation evidence

The renderer/HAT candidate is built and green in CI, with exact production and qualification UF2 hashes recorded in `executions/mbr-03/candidate.md`. Physical acceptance remains the only open condition for mbr-03.


## MBR-05 active candidate evidence

- branch: `mbr/mbr-05-ble-mouse`
- exact head: `7f294a7fac9eebe226ad66c6b572582c5e483421`
- CI run: `35533201112` — host and pico2-w SUCCESS
- host tests: 10/10 PASS
- Actions artifact ID: `10612321695`
- artifact archive SHA-256: `ead4a3b57b29e9579b23d491b44eecfc24e09e3f003eb62146dee4cf564cbfa7`
- production UF2: 861696 bytes, SHA-256 `be40b08c473c06f558b9769a661a8f197f10d3cea403e5a8b82ff21dd297b3d8`
- qualification UF2: 95744 bytes, SHA-256 `fd8bb312bd13549ef28c60803e0ee9b483e21329cb9d81b1450510b760960df6`
- physical acceptance: pending operator execution of the numbered MBR-05 scenarios

Durable evidence: `executions/rebuild-mbr-05/candidate-evidence.md`.
