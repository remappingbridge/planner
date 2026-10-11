# MOD-09 — Candidate CI PASS and Pico 2 W production UF2

**Status: CANDIDATE VALIDATED IN CI, PHYSICAL OPERATOR ACCEPTANCE PENDING (2026-10-11).**

## Lineage
- Accepted MOD-08 SHA: `5bfde2c4dc21aef3505ea9884a4878ae8ee8ec6f`.
- Final MOD-09 candidate SHA: [`dcc85dfc86ef140bf8acb2be54488f0ce07b3000`](https://github.com/remappingbridge/remappingbridge/commit/dcc85dfc86ef140bf8acb2be54488f0ce07b3000).
- Branch: [`feature/modifier-shortcuts-mod09`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod09); [draft PR #29](https://github.com/remappingbridge/remappingbridge/pull/29). No merge/release or tag modifications.

## Validated build and artifact
- [GitHub Actions run #38172603206](https://github.com/remappingbridge/remappingbridge/actions/runs/38172603206), push trigger for **exact candidate SHA**: completed **SUCCESS**, both `host-architecture` and `pico2-w-production`.
- Host tests: **77/77 PASS** (including two new MOD-09 CTests and all inherited MOV/MOD regressions).
- Production UF2: `blu2usb_picow.uf2`, **944640 bytes**, SHA256 **`a1facaa830183b3f971d49a8b6228c20803817d207733ec42bc6fb004d3a63a0`**. Extracted independently from the uploaded ZIP, SHA compared to exactly the same SHA printed by CI production job. Do not confuse with ZIP checksum.
- [Official CI artifact #11714307781](https://github.com/remappingbridge/remappingbridge/actions/runs/38172603206/artifacts/11714307781): ZIP size 348703 bytes, SHA256 **`4e8906d298711f0df8477fb0a776b50904af77e75c8b52d5e16d37482a8ca0df`**. ZIP contains exactly the `blu2usb_picow.uf2` binary above. Production SDK and ARM toolchain are pinned by CI.
- No debug CDC/UART or debug UF2 artifact was introduced.

## What is implemented
- Fresh USB session, BLE disconnect, BLE pair-new handoff or BLE runtime queue overflow: flush stale unsent pointer/wheel/pan and Movement state; release stale HID source owners via the existing per-source cancellation path. Fresh input remains valid.
- Successfully committing new shortcut assignment cancels pending/running actions from old assignment, preserving physical keyboard/mouse ownership; already accepted Consumer input is neutralized by existing shared-USB-endpoint barrier.
- Preserves accepted MOD-06 rule that nonzero future/unsupported MOVE slots capture a gesture but cannot produce an unsupported HID action; preserves MOV-07 explicit Movement clear on disconnect.
- No added generic shortcut codes, Obsidian-specific mappings, HID ABI changes, flash changes, or Saved Devices highlight changes; existing identity-only cyan highlighting remains covered by regression.

## Gate conditions
The first draft commit `7d93c0e...` failed two old source/gesture regressions and was **not** selected as candidate. These regressions were fixed in final `dcc85df...` and the full 77-test suite passed. Neither CTests nor UF2 compilation validates real BLE, USB interruption or physical app behavior. Follow [14 numbered scenarios starting from HOME CONNECTED](physical-acceptance.md). **MOD-09 PENDING PHYSICAL ACCEPTANCE; MOD-10 BLOCKED until operator approval.** No merge, tag or release.

**Prior caveat:** The Obsidian KDE zoom in/out discrepancy documented in MOD-08 was not silently changed or claimed resolved.
