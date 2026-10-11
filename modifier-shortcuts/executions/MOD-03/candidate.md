# MOD-03 — Candidate build: 30 shortcut picker labels + v3 persistence

**Status: CI PASS + VERIFIED PICO 2 W UF2 / PHYSICAL ACCEPTANCE PENDING.** Date: 2026-10-11.

## Baseline and immutable evidence
- Operator accepted MOD-02 *corrected* (gray unselected options and visible `+` glyph) with explicit instruction to proceed, 2026-10-11.
- Source branch: [feature/modifier-shortcuts-mod01](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01), descended from immutable tag `v2.0.0`. Draft PR [#23](https://github.com/remappingbridge/remappingbridge/pull/23); no merge/tag/release.
- Exact candidate commit: [`6e5ff857185466a459c1caa8633a1847f49ed230`](https://github.com/remappingbridge/remappingbridge/commit/6e5ff857185466a459c1caa8633a1847f49ed230).
- GitHub Actions CI [run #269](https://github.com/remappingbridge/remappingbridge/actions/runs/38143309171), **completed success**.
- `host-architecture`: **SUCCESS, all 63/63 tests passed**, including two new suites for 30-item picker, all five screens, UI commit callbacks, migration v2→v3, corruption/unsupported version/reboot roundtrip, plus inherited regressions.
- `pico2-w-production`: **SUCCESS** (pinned ARM, Pico SDK and production build). Production `blu2usb_picow.uf2` test -s and debug-UF2 absence checks passed.
- [Official GitHub Actions build artifact](https://github.com/remappingbridge/remappingbridge/actions/runs/38143309171/artifacts/11703926621), ZIP id `11703926621`. SHA256 of ZIP is `84663ddf9eed69508ebc83f6bf2b0154d63865ab447f9740e47e09de1f9b6905`, **not firmware checksum**.
- **Exact production UF2:** `blu2usb_picow.uf2`, **933376 bytes**, **SHA256 `6b5e3cdfbfc27b703ddfd3d08018289ce1c4fafc3fc9c04a6e2970e1c81e3445`**. Independently downloaded, unzipped, hashed and verified against CI stdout; the user-downloadable `remappingbridge-mod03-pico2w.uf2` is byte-identical.

## Implemented
- New five SHORTCUTS pages, six actions/page, 30 IDs; all menus accessible from HOME connected. Runtime screen count 40→45.
- From Combinations, JOY PRESS opens picker on previously assigned ID or COPY; JOY Up/Down cycles 6, JOY Left/Right cycles 5 with wrap; assignment focus restored when revisiting its page.
- KEY A APPLY AND BACK commits flash transaction first then changes displayed combination value and returns to the same page/slot; KEY B cancels; JOY PRESS in picker is not Apply.
- KEY A RESET SELECTED resets precisely one persisted shortcut to NONE; second reset in NONE is idempotent and does not write.
- Values and cues: selected combination label+value white, unselected gray, "+" rendered; current saved picker item cyan when not selected. Lock preserved.
- v3 26-byte global product profile stores 12 IDs and legacy Custom/draft. The 14-byte v2 codec remains available for migration, with retired Standard/Escape fallback to PASSTHROUGH and legacy ESCAPE targets replaced by source identities rather than Modifier. Two-slot flash store CRC, bonds and per-device Movement remain separated; no `flash_nuke`.
- No HID shortcuts executed (including Consumer-labeled options), no Modifier source or UNAVAILABLE mask, no USB descriptor or BLE changes. Those are separate MOD-04..08 gates.

## Gate status
[Physical-acceptance checklist](physical-acceptance.md): **operator not yet tested/accepted**. Do not start MOD-04 before acceptance. Firmware release, merge and change to `main` are not authorized.
