# MOD-09 — physical operator scenarios (HOME CONNECTED)

**Status: PHYSICALLY ACCEPTED BY OPERATOR on 2026-10-11.** This is the gate-level decision; individually unchecked rows below remain unsubstantiated and are not retroactively marked PASS. See [operator acceptance](operator-acceptance.md).

Prerequisites: start on HOME CONNECTED with the saved mouse, keep existing bonds/flash (do **not** flash_nuke). Use the MOD-09 production UF2 from the CI artifact documented in [candidate.md](candidate.md). Keep another keyboard/device connected for cross-source ownership checks if available.

| # | Action from HOME CONNECTED | Expected observable result | Actual |
|---|---|---|---|
| 01 | HOME → REMAPPING OPTIONS → MODIFIER SHORTCUTS; review 12 saved combos | No mapping loss; 30 actions unchanged; APPLY/BACK and RESET work | PENDING |
| 02 | Choose Custom Left=MODIFIER and Right=COPY; press/release | One shortcut, no Modifier click, no stuck Ctrl | PENDING |
| 03 | Start an assigned shortcut, disconnect Mouse while held | Old USB Keyboard/Consumer released, real keyboard still works | PENDING |
| 04 | Consumer Play/Pause/Volume while BLE disconnect/USB hotplug/lock | No stuck play/volume, reconnection executes new actions exactly once | PENDING |
| 05 | Modifier + Wheel detents in large burst, then lock/disconnect | Bounded actions, no backlog after recovery, HAT remains responsive | PENDING |
| 06 | Modifier + MOVE; hotplug USB mid-gesture | No ghost move/scroll after reconnect; fresh movement works | PENDING |
| 07 | SCREENSHOT AREA, second press-drag, then lock/disconnect | Synthetic LEFT released, no ghost dragging | PENDING |
| 08 | Change profile during held shortcut | Queued previous profile actions canceled; Custom/Passthrough fresh input valid | PENDING |
| 09 | Change shortcut assignment while its previous mapping is pending | After APPLY, no old queued action; KEY B cancels edit with no side effect | PENDING |
| 10 | SAVED DEVICES with two stored mice; paginate/reconnect | Only connected mouse NAME cyan; profile/DPI/rotation/page/hints always yellow | PENDING |
| 11 | Remove inactive, then active saved mouse; retry failure | No wrong active label; registry/menu states coherent; no orphaned hold | PENDING |
| 12 | Reboot/power-cycle; reconnect mouse; inspect Movement and mappings | H/V, rotation, slots and Custom survive; no unwanted default reset | PENDING |
| 13 | Logitech Lift Forward held drag, wheel/pan, HELP/LOCK | No regressions; no ghost forwarding or vendor loop | PENDING |
| 14 | USB busy during several keyboard+Consumer actions | No permanently held keys or freezing of display/HAT | PENDING |

**Gate pass rule:** all applicable rows physically verified; deviations recorded explicitly, operator decides. No MOD-10, merge or release without acceptance. [Full test detail](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod09/docs/modifier-shortcuts/mod09-recovery.md).
