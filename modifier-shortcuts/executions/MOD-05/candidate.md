# MOD-05 — Candidate: Modifier buttons, Escape / Ctrl+C, USB ACK

**Status: CI 68/68 PASS + production Pico 2 W UF2 VERIFIED / PHYSICAL ACCEPTANCE PENDING.** Data: 2026-10-11.

## Dependency and exact build
- Based on the user-approved corrected MOD-04 source commit `1147e79cb80d23412488cd10e92f14a9f75f26a5` (operator: "gate aceito. prossiga"). [MOD-04 acceptance](../MOD-04/physical-acceptance.md).
- Source branch: [`feature/modifier-shortcuts-mod05`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod05), [draft PR #25](https://github.com/remappingbridge/remappingbridge/pull/25). Source tag v2.0.0 and main are unchanged. No merge/release authorized.
- Exact Pico firmware commit: [`ee11c4dedad7e1699912982d6469f3675cae2e88`](https://github.com/remappingbridge/remappingbridge/commit/ee11c4dedad7e1699912982d6469f3675cae2e88).
- GitHub Actions [run #338](https://github.com/remappingbridge/remappingbridge/actions/runs/38147899079): `host-architecture` SUCCESS, **68/68 CTests PASS**, includes all MOD-02..04 inherited contracts and new MOD-05 button/USB source regressions; `pico2-w-production` SUCCESS.
- [GitHub Actions artifact 11704924925](https://github.com/remappingbridge/remappingbridge/actions/runs/38147899079/artifacts/11704924925), ZIP digest `6a1d661fba74e92c214819a4d36c7316d02317a9eafd6bc72750856d5a6db2fb` (ZIP, **not** firmware SHA).
- Firmware inside archive `blu2usb_picow.uf2`, **939008 bytes**, SHA256 **`8f1015d2081c83707ee33f524478cbef98780dee32e4a0fd46e43af6ebbaa3ad`**. Downloaded original artifact, extracted, independently hashed and compared against Pico CI job's `sha256sum`; delivered `remappingbridge-mod05-pico2w.uf2` is byte-for-byte identical.

## Implemented and tested
1. `src/modifier_shortcuts/modifier_shortcuts.c` detects physical modifier source before remapping; Custom active only. Press/release Modifier never leaks its physical Mouse click. Duplicate down and buttons physically held before Modifier cannot start false chords.
2. Valid configured IDs **1 COPY** and **7 ESCAPE** only. Clean solo Modifier down/up queues one Escape (USB Keyboard usage 0x29). Other configured modifier + button on a fresh down edge queues one Ctrl+C (left Ctrl modifier + HID C key usage 0x06); secondary down/up always suppressed if consumed, even if Modifier is released first. Both actions one-shot.
3. Any other physical button used while Modifier held suppresses solo Escape while allowing the usual Custom remap if no supported action. Unsupported saved IDs never impersonate another shortcut; global v3 assignments intact.
4. USB keyboard module has bounded 8-item FIFO, separate synthetic HID source to avoid releasing unrelated keys, and phased **press ack → release ack** with retries on USB busy. Keydown and keyup cannot be collapsed into one service tick. Cancellation on BLE disconnect, Mouse removal, profile switch, pair promotion, BLE overflow, lock, USB unmount/remount. USB mount status change invalidates cached last keyboard report.
5. Sensor jitter tolerance: under 8 relative raw counts, a clean solo tap may still fire; motion accumulated to 8 or more cancels clean tap. This provisional tap-only budget is **not** a 4-direction gesture classifier (MOD-06 owns gesture tuning). Wheel/MOVE are otherwise passed through unchanged.
6. No new screens, no change to USB VID/PID, interface count (still Mouse + Keyboard), descriptor, flash schema, BLE bond storage, Saved Devices color or per-Mouse H/V DPI/rotation. Other 28 semantic actions are not yet executed.
7. New Release assert-enabled tests `mod05_button_chords_usb_backpressure` and `mod05_runtime_source_contract` cover keyup acceptance, Ctrl+C ownership, Copy without extra Escape, no auto-repeat, preheld secondary, jitter vs motion, lock/profile cancel, Passthrough inactivity, and wheel/move forwarding.

## Acceptance
[Physical scenarios](physical-acceptance.md): operator must verify **actual Escape and clipboard Copy in Linux desktop**, plus ordinary mouse behavior, reboot persistence, and release of keys after reconnect. No hardware test result is inferred from the CI. **Gate MOD-05 pending user acceptance.** MOD-06 remains blocked.
