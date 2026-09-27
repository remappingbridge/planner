# REMAPPING OPTIONS flow — consolidated physical acceptance

Status: **ACCEPTED / PHYSICAL TEST PASSED / PROMOTED TO MAIN**.

Candidate:

- branch: `hope/hope-10-remapper-options`
- commit: `d2a9256d2a5a38bb4cdb892c38ae6445f207598f`
- draft PR: `#15`
- base/restored main: `3471e983cb7ec048c9ebb4b057633ff1b028e3aa`
- UF2: `HOPE-remapper-flow-consolidated-pico2w.uf2`
- size: **897,536 bytes**
- SHA-256: `875cda790bcc86652cd4e6676d5b75ae1108b8ff91ae7f1c1003e25e982c42f4`

This one test matrix covers bundled gates HOPE-10, HOPE-29, HOPE-11, HOPE-14, HOPE-12, HOPE-13, HOPE-15, HOPE-16, HOPE-17, HOPE-18, HOPE-19, HOPE-20, HOPE-21 and HOPE-22.

## Required physical scenarios

1. Reach home-connected with a live saved Mouse and enter the remap/profile summary.
2. Confirm title is exactly **`REMAPPING OPTIONS`**.
3. Confirm exactly four profile options: PASSTHROUGH, STANDARD REMAP, ESCAPE REMAP, CUSTOM REMAP.
4. Confirm Pair New is not present in this menu.
5. Verify Up/Down wrap across exactly four rows.
6. Verify only the currently confirmed/applied profile is cyan.
7. Move selection onto the current profile: that row must become white.
8. Move selection away: it must return to cyan.
9. Apply a different profile successfully, return to REMAPPING OPTIONS, and verify the **previous profile is no longer cyan**. There must never be two cyan profile rows.
10. Repeat profile changes at least Passthrough -> Standard -> Escape and confirm exclusive cyan after each confirmed apply.
11. Press X from REMAPPING OPTIONS. Confirm exact `REMAPPER OPTIONS HELP` text.
12. Press Y inside that Help. It must act as Any Key Back, never lock, and restore the previous remapper selection.
13. Press B from REMAPPING OPTIONS. HOME resolver must work normally.
14. Confirm Joy Left from REMAPPING OPTIONS also returns through HOME resolver.

### Passthrough

15. When Passthrough is current, open it and confirm `PASSTHROUGH ACTIVE`; body rows are cyan.
16. B returns to REMAPPING OPTIONS.
17. When another profile is current, open Passthrough and confirm `APPLY PASSTHROUGH`.
18. A applies only after runtime/persistence success; resulting active screen is `PASSTHROUGH ACTIVE`.
19. B from inactive screen cancels/returns without applying.
20. Y locks on both Passthrough screens.
21. While `PASSTHROUGH ACTIVE` is visible, disconnect the current Mouse; screen must demote to `APPLY PASSTHROUGH`.

### Standard

22. When Standard is not current, open it and confirm `APPLY STANDARD REMAP` and exact four mapping description rows.
23. A apply -> runtime/persistence success -> `STANDARD REMAP ACTIVE`.
24. When Standard is already current, opening it goes directly to `STANDARD REMAP ACTIVE`.
25. B returns to REMAPPING OPTIONS.
26. Y locks.
27. Disconnect current Mouse while active; screen must demote to `APPLY STANDARD REMAP`.

### Escape

28. When Escape is not current, confirm exact `APPLY ESCAPE REMAP` copy and mappings.
29. Confirm KEY Y still locks even though this inactive page intentionally does not print a Y hint.
30. A apply -> runtime/persistence success -> `ESCAPE APPLIED ACTIVE`.
31. Confirm active Escape has only KEY B: BACK and KEY Y: LOCK hints; Joy Left must not navigate.
32. Disconnect current Mouse while active; screen must demote to `APPLY ESCAPE REMAP`.
33. Confirm Escape synthetic USB Keyboard output still works and no Bluetooth Keyboard is involved.

### Custom

34. Enter Custom and confirm exact `EDIT CUSTOM REMAP` layout with five live draft rows.
35. Up/Down selects LEFT, RIGHT, MIDDLE, FORWARD, BACKWARD source rows.
36. Joy Press opens the selected source editor.
37. In every source editor, verify visible target order is exactly:
    LEFT, RIGHT, MIDDLE, ESCAPE, FORWARD, BACKWARD.
38. Verify the currently drafted target is cyan and selected target is white.
39. Change a source to ESCAPE with KEY A; return to Custom Edit must preserve that source row and immediately show the changed draft.
40. Repeat one edit using Joy Press instead of KEY A; it must perform the same apply-and-back behavior.
41. Press B from a source editor; it must return to Custom Edit preserving the source row and without changing the draft target.
42. Press A on Custom Edit; only after runtime+persistence confirmation may Custom become current.
43. On success, remain on `EDIT CUSTOM REMAP`; there must be no separate `CUSTOM APPLIED` screen.
44. When Custom is current and draft is clean, mapping rows are cyan except the selected row, which is white.
45. Return to REMAPPING OPTIONS and confirm only CUSTOM REMAP is cyan.

### Regression

46. Confirm HOME name/profile summary still reflects the newly applied profile.
47. Confirm Mouse movement, buttons, scroll, profile persistence and remap behavior remain functional.
48. Reboot and confirm the applied profile persists and REMAPPING OPTIONS shows only that profile in cyan.
49. Confirm Pair New remains available from HOME and still works.
50. Confirm accepted Help/Home/Pair New flows remain intact.
51. Confirm no Bluetooth Keyboard/Composite pairing behavior was introduced.

## Operator result

Operator declaration: **PASSED / ACCEPTED on 2026-09-24**.

The operator confirmed that all bundled gates passed the physical test matrix. PR #15 was promoted to `main` as merge commit `5c62a98a4495570237d7b4b223a090bea1020990`.

Accepted bundled gates: HOPE-10, HOPE-29, HOPE-11, HOPE-14, HOPE-12, HOPE-13, HOPE-15, HOPE-16, HOPE-17, HOPE-18, HOPE-19, HOPE-20, HOPE-21 and HOPE-22.
