# MOD-05 — Runtime buttons and clean Modifier release

Status: implementation in branch, CI and operator physical acceptance pending (2026-10-11).

Dependency: MOD-04 corrected UF2 accepted by operator, source commit 1147e79cb80d23412488cd10e92f14a9f75f26a5. Feature branch remappingbridge/remappingbridge feature/modifier-shortcuts-mod05, draft PR #25. No merge/release.

Scope from 06-gates-and-acceptance.md: clean solo Modifier release emits Escape (shortcut #7), assigned Modifier + physical button emits Copy (shortcut #1, Ctrl+C for Linux desktop). Press and release each action once; suppress extra Escape after second button (even unassigned), Modifier never leaks a mouse click. Detect physical source before Custom remapping, active only with applied Custom. Assigned button down/up consumed as a pair, including after Modifier is released. Unmapped second button forwards normally and still cancels tap.

Domain module modifier_shortcuts: bounded FIFO, separate synthetic HID ownership source, wait for successful USB keyboard report acceptance on key down and key up. On busy endpoint, retry rather than coalesce. Disconnect, removal, profile change, lock and BLE overflow cancel held state without affecting unrelated keyboard sources.

Not in this gate: wheel and directional MOVE gestures, other actions in 30-item catalog, Consumer HID or changed USB descriptor. A wheel or movement event currently forwards unchanged but suppresses clean tap conservatively; concrete gesture classification belongs in MOD-06.

Physical gate requires GitHub CI host PASS, Pico2W production UF2 with SHA256, Linux desktop Escape and Copy tests, plus operator acceptance. Prior saved data, Bluetooth bonds and Mouse Movement are unchanged.
