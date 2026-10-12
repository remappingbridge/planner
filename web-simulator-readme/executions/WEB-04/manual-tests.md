# WEB-04 — Manual scenarios in the production browser

**Status:** PENDING operator testing and acceptance. No Debian clone, `file://`, npm or local install required.

Use **https://remappingbridge.github.io/** and **https://remappingbridge.github.io/tests/** after GitHub Pages has deployed the website `main` commit for WEB-04.

## Physical HAT layout and simplification

- [ ] The LCD is visibly **smaller** than before, but remains **square** and crisp, with a logical 240×240 grid.
- [ ] **Joystick is to the LEFT of the LCD**, centered alongside it.
- [ ] **A, B, X, Y are to the RIGHT of the LCD, in a SINGLE VERTICAL COLUMN from top to bottom**.
- [ ] The **LCD BACKGROUND** section does not exist. The magenta background is permanently vivid **Gentle `#300c39`**. Magenta title and text foreground colors remain unchanged.
- [ ] Check desktop and mobile portrait/narrow browser widths for clipping, usable controls and keyboard focus, especially at 100% and zoomed UI.

## Navigation and all source screens

- [ ] Select **Connected demo**. HOME shows `DEMO MOUSE` (not real Bluetooth connection), four options and a first-column `|` focus marker.
- [ ] JOY PRESS on **REMAPPING OPTIONS** reaches PASSTHROUGH, CUSTOM, MODIFIER SHORTCUTS. B goes back; X opens Help, B returns with prior selection, Y Lock blanks LCD and consumes the first release to unlock.
- [ ] Select **MODIFIER SHORTCUTS**, browse COMBINATIONS **1 OF 6** through **6 OF 6** using Left/Right. Up/Down selects one of two pairs; `|` must be on the pair's **second/value line (row 2/4)** and not the label line. JOY PRESS opens SHORTCUTS; Left/Right browses all five pages.
- [ ] Open EDIT CUSTOM and a WILL BECOME screen. Verify original source text colors and B back navigation. APPLY should **NOT** falsely claim stored profile changes.
- [ ] On HOME enter MOVEMENT OPTIONS, navigate Horizontal/Vertical slow/fast DPI and Rotation and their Help. The ROTATION marker is on row 4 of Movement Options when selected. APPLY must say preview only.
- [ ] Enter SAVED DEVICES. Its implicit `REMOVE DEVICE` shows `|` only when the explicit demo saved count is nonzero. JOY PRESS opens REMOVE THIS; X opens Help, B cancels. A must **not** pretend to delete real BLE bond.
- [ ] Enter PAIR NEW MOUSE, Help, Retry Pair New. A must not claim real pairing.
- [ ] Open the collapsed **Inspect all 45 firmware screens** section and choose several help, retry, modifier and shortcut screens, plus FIRST MOUSE CONNECTED. Confirm display text is source-aligned 9×21 and only the visual screen changes (no device flash).
- [ ] Open the [browser test page](https://remappingbridge.github.io/tests/); expect **90/90 checks passed**. If not, report browser/version and failing test names.

**WEB-04 operator decision: PENDING.** After accepted, WEB-05 may be started upon instruction. Otherwise correct WEB-04 without proceeding.
