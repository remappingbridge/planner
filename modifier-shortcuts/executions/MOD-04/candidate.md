# MOD-04 — Validated candidate, physical acceptance pending

**Status: CI 65/65 PASS + VERIFIED PICO 2 W UF2 / PHYSICAL ACCEPTANCE PENDING**. Date 2026-10-11.

## Dependency and immutable candidate
- MOD-03 physically accepted by operator before starting MOD-04, as recorded in [MOD-03 acceptance](../MOD-03/physical-acceptance.md).
- Firmware branch [`feature/modifier-shortcuts-mod04`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod04), created from exact accepted MOD-03 commit `6e5ff857185466a459c1caa8633a1847f49ed230`. Tag v2.0.0 unchanged.
- Draft [PR #24](https://github.com/remappingbridge/remappingbridge/pull/24) open only for review and CI; **not merged, tagged or released**.
- Exact candidate firmware commit [`b3ff70e4c632adf66580e67fc2aec94a363b0ab1`](https://github.com/remappingbridge/remappingbridge/commit/b3ff70e4c632adf66580e67fc2aec94a363b0ab1).
- GitHub Actions [CI run #297](https://github.com/remappingbridge/remappingbridge/actions/runs/38144659332): `host-architecture` SUCCESS, **65/65 tests passed**; `pico2-w-production` SUCCESS, Pico 2 W Release with pinned compiler and SDK. The MOD-02/03/04 CTest executables now compile with assertions explicitly enabled even under Release, to prevent false positive tests.
- [Official production artifact ZIP](https://github.com/remappingbridge/remappingbridge/actions/runs/38144659332/artifacts/11704048785) ID `11704048785`, name `blu2usb-picow-production-pico2w`.
- **Exact Pico UF2:** `blu2usb_picow.uf2`, **936,960 bytes**, SHA256 **`a78a9624d06587f6554e16058ccbc0219b04c2f84e01e6aff3c0c81019836b4f`**. Downloaded/unzipped original CI artifact, independently verified `sha256sum` against job logs; user-facing `remappingbridge-mod04-pico2w.uf2` is byte-for-byte identical.
- ZIP artifact digest `60469ef1ea3e44faad6e2d3a1fe316d232809db512829812577bdf5337c5a48d` is the digest of ZIP, **not** the UF2 firmware hash.

## Functional scope
- Five WILL BECOME screens with six choices, exactly `LEFT / RIGHT / MIDDLE / FORWARD / BACKWARD / MODIFIER`. New explicit target MODIFIER=6 distinct from legacy ESCAPE=5.
- Exclusive physical Modifier in saved Custom remapping, old modifier automatically reverted to physical identity during draft change. All 12 saved shortcut IDs remain intact; no editing/access/reset on masked `UNAVAILABLE` combination. Value returns when Modifier moves.
- Masks calculated from **applied Custom source** (not unsaved draft), even if active profile is Passthrough. Only the matching button combo is unavailable. `MODIFIER RELEASED`, WHEEL and four MOVE combos remain available.
- On masked pair, selected label white, `UNAVAILABLE` value disabled STATIC (not cyan or selected white); other option gray per accepted MOD-02 and `+` visibly rendered.
- Safe compatibility for legacy v2 Escape and v3 records from MOD-03 still containing Escape targets; identity fallback, never implicit Modifier. V3 validates at most one Modifier and retains shortcuts.
- Commit-first UX: only verified product flash transaction causes saved selection return; active remap/profile only switches after verified Custom Apply.
- Existing remap drops mouse button mapped to Modifier under Custom, while Passthrough retains its click. No synthetic shortcut or keyboard HID emission in MOD-04; full execution is MOD-05+. No USB descriptor, Bluetooth bond, mouse name or Movement storage change.

## Gate boundary
- [Full physical acceptance checklist](physical-acceptance.md) is **PENDING OPERATOR**, to test exact UF2 from HOME connected. Do not start MOD-05, merge or publish a release until user explicitly accepts this gate.
