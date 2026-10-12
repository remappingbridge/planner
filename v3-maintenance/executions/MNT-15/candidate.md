# MNT-15 — candidate Pico 2 W: generic Zoom In without Shift

**STATUS: IMPLEMENTED / OFFICIAL CI 98/98 HOST PASS / PRODUCTION PICO 2 W PASS / UF2 SHA-256 VERIFIED / PHYSICAL ACCEPTANCE PENDING / NO RELEASE.**

## Source and build

- Base immutable: official [v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), SHA `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.
- Branch: `maintenance/v3x-mnt-15`, **candidate HEAD `7177672d109f8f13aea77ba707c614e53d6065f1`**.
- [PR #45 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/45), targeting `main`, **not merged**. Main includes a later English-only documentation/CI change; merging after physical acceptance must preserve that.
- [Official GitHub Actions CI #38298979787](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787) on the exact HEAD: **98/98 host and architecture tests PASS**, including two new MNT-15 tests, and **Pico 2 W Release production build SUCCESS**.
- Workflow artifact: `blu2usb-picow-production-pico2w`, artifact ID **11769092575**. Its ZIP was downloaded, then `blu2usb_picow.uf2` was extracted without modification and saved for operator as **`remappingbridge-mnt15-zoom-ctrl-equal-pico2w.uf2`**.
- Candidate UF2 size: **953344 bytes**. **SHA-256: `4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`**. SHA verified locally against exact official CI `sha256sum build-pico/blu2usb_picow.uf2` job output.
- Internal source version stays **3.2.3** until operator acceptance. This UF2 is **not** the official v3.2.3 stable binary, even though it has the same internal version string. Do not replace stable release assets with candidate.

## Exact scope / tests

1. `src/modifier_shortcuts/keyboard_catalog.c`: only action **26 / ZOOM IN**, HID Equal `0x2E`, changed modifier `MOD_CTRL | MOD_SHIFT` (0x03) to **`MOD_CTRL` (0x01)**. Generic, without application detection.
2. ZOOM OUT action 27 remains Ctrl+Minus (`0x2D + 0x01`), RESET ZOOM action 28 remains Ctrl+0 (`0x27 + 0x01`). Redo keeps Ctrl+Shift+Z; screenshot area keeps Shift+Meta+PrintScreen.
3. MOD-07 and MOD-08 existing test expectations updated for new contract; added `test_mnt15_zoom_ctrl_equal.c` (USB down/up ack, USB retry, repeated zoom, no stuck Shift or keys, other Shift-based shortcuts) and `test_mnt15_zoom_source.py` (source mapping isolation), both registered in tests/CMakeLists. **98/98 all regressions PASS**.
4. No changes to UI 9×21, mouse HAT controls, BLE pairing, bond records/profiles, movement, HID descriptors, LCD, USB interfaces or global shortcut count.
5. **Explicit terminal interoperability limitation**: operator verified browser and Obsidian use Ctrl+= without Shift, whereas some terminals only zoom with Shift. Terminals whose only Zoom In binding is Ctrl+Shift+= may **no longer zoom via this RemappingBridge action**. Avoid claiming universal compatibility or emitting both chords, which can double zoom or trigger unintended commands.

## Physical acceptance

Use [physical-acceptance.md](physical-acceptance.md), starting at **HOME CONNECTED**. Check Obsidian, browser and examples of terminal types, preserve bonds (never `flash_nuke`) and test other shifted actions, modifier, lock/unlock. **Only the operator can declare actual physical PASS.** The previously accepted v3.2.3 official [UF2](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.3/remappingbridge-v3.2.3-pico2w.uf2) remains safe rollback if needed.

**PENDING:** operator feedback and explicit "gate aceito". No tag, merge or GitHub Release for MNT-15 before acceptance. Proposed patch version would be **v3.2.4** only if official v3.2.3 remains latest at that later moment.
