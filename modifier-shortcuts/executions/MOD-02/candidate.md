# MOD-02 — Candidate build: 6 combinations screens

**Status: ORIGINAL BUILD SUPERSEDED BY MOD-02 VISUAL BUGFIX / PHYSICAL ACCEPTANCE PENDING**  
Date: 2026-10-11.

**Superseded for operator tests:** this document records the original candidate with wrong inactive-pair color and nonrendered `+`. Use [visual-bugfix.md](visual-bugfix.md) for the corrected UF2/CI run/firmware hash instead.

## Immutable candidate

- Baseline: `v2.0.0` tag, immutable. Dependency MOD-01 **physically accepted** by operator.
- Feature branch: [feature/modifier-shortcuts-mod01](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01), same branch retained, no merge/release.
- Candidate commit: [`fb568154d88d3e984a89f0c7e0b69aaaa0fefffd`](https://github.com/remappingbridge/remappingbridge/commit/fb568154d88d3e984a89f0c7e0b69aaaa0fefffd).
- CI run: [BLU2USB Canonical CI #225](https://github.com/remappingbridge/remappingbridge/actions/runs/38140599963).
- Host architecture job: **SUCCESS**. CTest **61/61 passed**, including two new tests `mod02_combinations_physical_flow` and `mod02_combinations_source_contract`. All prior tests including 40-screen inventory passed.
- Pico 2 W production job: **SUCCESS** (pinned ARM toolchain, pinned Pico SDK, Release, `PICO_BOARD=pico2_w`). Debug UF2 absent.
- GitHub Actions original [production artifact ZIP](https://github.com/remappingbridge/remappingbridge/actions/runs/38140599963/artifacts/11703161553), artifact ID `11703161553`. Contains only `blu2usb_picow.uf2`.
- **Exact UF2 bytes:** 926,720. **SHA256 UF2:** `84d2d478877c02c46dcba14d8fa83a2d3a122f1e63555d588dce19a877cb3d4a`.
- SHA256 reproduced independently after downloading/unzipping original CI artifact and matches production CI console output.
- Artifact **ZIP** digest (not the firmware hash): `462ec8a4c6a6cc4eb3d765154f0eb657811778a76170c8487fc073274986f68e`.

## What the candidate does

1. HOME → REMAPPING OPTIONS → third `MODIFIER SHORTCUTS` opens `COMBINATIONS 1 OF 6`.
2. Adds six fixed 9×21 screens; runtime inventory **34 → 40**; twelve stable IDs 0..11.
3. A combo comprises two body rows: label and `NOT CUSTOMIZED`. Selected pair is WHITE across both rows; unselected label/value yellow, title magenta.
4. JOY LEFT/RIGHT circular pages 1↔6, selection pair retained. JOY UP/DOWN circular choice 0↔1. KEY B returns with third menu option selected. KEY Y lock/unlock unchanged. KEY X no-op (no approved Help).
5. KEY A reset in NONE is no-op and JOY PRESS access is no-op until MOD-03. **No persisted assignments, no HID actions.** BLE, Movement, existing profiles/flash schema preserved.
6. Copy normalized (OF, WHEEL, NOT CUSTOMIZED), per accepted MOD-00 contract; canonical original sketch fixture remains unchanged.

## Physical acceptance required

[Test scenarios](physical-acceptance.md), starting `home-connected` and protecting flash/bonds. The gate is not completed until operator installs UF2 whose SHA matches the above and explicitly approves its physical behavior. No MOD-03 implementation started. Main, release and v2.0.0 tag untouched.
