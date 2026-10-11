# MOD-10 — Full physical candidate qualification, starting HOME CONNECTED

**Status: PENDING OPERATOR TESTS AND EXPLICIT ACCEPTANCE.** CI 80/80 PASS, official Pico 2 W UF2 SHA256 `a1facaa830183b3f971d49a8b6228c20803817d207733ec42bc6fb004d3a63a0`, exact commit `2c40f1be9fd47771bf6bb51fa72fd7b9825394d2`. The MOD-10 firmware is byte-identical to accepted MOD-09; release is not authorized.

Prerequisites: saved BLE mouse connected, Pico 2 W on production UF2 from [candidate.md](candidate.md). Record host OS + desktop/application; keep external keyboard for ownership tests and a second saved mouse if available. Use BOOTSEL copy, **not flash_nuke**.

[Separate 30-action per-ID evidence sheet](action-matrix.md). Each row must record actual host/app effect, not only a correct HID code.

## Numbered scenarios
| ID | Test from HOME CONNECTED | Criteria | Operator result |
|---|---|---|---|
| Q01 | HOME → REMAPPING OPTIONS → MODIFIER SHORTCUTS → COMBINATIONS 1..6, left/right page wrap | Six pages, two combos/page, no legacy Standard/Escape screens | PENDING |
| Q02 | Open SHORTCUTS, navigate five pages and 30 labels; KEY A APPLY AND BACK | All 30 present; correct saved value/focus on return | PENDING |
| Q03 | KEY B cancel in editor; KEY A RESET SELECTED; RESET on NONE | Cancel does not write; reset only selected; NONE is no-op | PENDING |
| Q04 | Configure Custom LEFT=MODIFIER; assign MOD+LEFT; switch Modifier to MIDDLE | LEFT UNAVAILABLE only while selected as Modifier; assignment reappears intact when reassigned | PENDING |
| Q05 | With Modifier unconfigured, configure shortcuts and trigger mouse normally | Slots persist but no shortcut fires; clicks/drag/pan remain usable | PENDING |
| Q06 | MODIFIER RELEASED, then MOD+RIGHT button COPY/ESCAPE and holds | Tap once; combos suppress release action; no repeat/stuck key or Modifier click | PENDING |
| Q07 | MOD+Wheel Up/Down and multiple detents/pan | Each detent one intended action; pan not misinterpreted; no blocked HAT | PENDING |
| Q08 | MOD+MOVE LEFT/RIGHT/UP/DOWN with diagonals, jitter, quiet and 90°/270° rotation | One gesture/axis, gain independence, no accidental cursor movement | PENDING |
| Q09 | Keyboard IDs 01..18 in appropriate editor/window | Actual editing keys/chords behave as documented, modifiers release | PENDING |
| Q10 | Consumer/Media IDs 19..24 (play/next/previous/volume/mute) | Host input event and functional effect logged separately | PENDING |
| Q11 | Android HOME 25 on USB Android/Google TV | Returns to OS HOME, not start-of-document; host supported? record exact result | PENDING |
| Q12 | ZOOM IN/OUT/RESET IDs 26..28, browser and Obsidian KDE | Browser and Obsidian behavior logged separately; known mismatch not waived as PASS | PENDING |
| Q13 | BRIGHTNESS UP/DOWN 29..30 with actual controllable backlight | Log Linux HID key and real luminance change; unsupported is not PASS | PENDING |
| Q14 | SCREENSHOT FULL and SCREENSHOT AREA on KDE with physical selection drag | Full captures whole screen; Area opens rectangle and synthetic left drag selects correct region | PENDING |
| Q15 | Held shortcut/drag during BLE disconnect, USB hotplug, lock, queue overflow | All synthetic keys/Consumer/Mouse neutralized; no stale actions on reconnect | PENDING |
| Q16 | Saved Devices multiple mice, active/inactive page, remove one/both | Only active NAME cyan; values/labels yellow; safe removal, no orphan state | PENDING |
| Q17 | Movement per mouse H/V gain and rotation, Logitech Lift Forward drag | Preserved across reconnect and saved mouse switch, no double rotation/stuck Forward | PENDING |
| Q18 | Cold boot/reboot: v3 12 slots, global Modifier, profile & per-Mouse Movement | Restored, auto-connect, no UI freeze, fixed USB two HID interfaces | PENDING |
| Q19 | Non-destructive upgrade from accepted MOD-09 to MOD-10 | Profile/12 slots/bonds/names/movement unchanged; USB identity stable | PENDING |
| Q20 | **Controlled downgrade rehearsal** to v2.0.0 only after recording all 12 shortcuts and settings | v2 may reset global v3 profile; observe/report limitation and restore MOD-10; do NOT erase flash/bonds | PENDING |
| Q21 | Reinstall MOD-10 after rollback test and rebuild needed profile/slots | Reconnect and operate, identify any profile restoration loss; no hidden claim of losslessness | PENDING |
| Q22 | HAT Help/lock/unlock/navigation with full workload and USB busy | Responsive; first unlock consumed; Mouse passthrough continues as specified | PENDING |
| Q23 | Repeat source ownership with physical keyboard key held while same semantic shortcut triggers | No premature release of a key owned by other source | PENDING |
| Q24 | Confirm no diagnostic USB CDC, UART debug, reset of BLE credentials, forced enumeration | Production-only identity and safety contract unchanged | PENDING |

## Gate decision record
- Tested firmware commit: `2c40f1be9fd47771bf6bb51fa72fd7b9825394d2` (physical run still pending)
- Production UF2 SHA256: `a1facaa830183b3f971d49a8b6228c20803817d207733ec42bc6fb004d3a63a0`
- Platform and test apps: PENDING
- Actual outcomes/exceptions: PENDING
- Gate MOD-10 accepted by operator: **NO / PENDING**
- Permission to merge/tag/release: **NO**, requires an additional explicit instruction.

**If any failure occurs:** record exact action, screen, OS, firmware SHA and observation; do not silently mark PASS. KDE Obsidian zoom and Consumer brightness limitations must be explicitly resolved/accepted as known exceptions before release.
