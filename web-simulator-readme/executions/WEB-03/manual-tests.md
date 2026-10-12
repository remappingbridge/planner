# WEB-03 — Production-browser test cases (not yet accepted)

Open **https://remappingbridge.github.io/** in Firefox or another supported browser. Open **https://remappingbridge.github.io/tests/** for the live test harness. The operator explicitly requested **no Debian local testing**.

## Visual and HAT tests

- [ ] Confirm badge `WEB-03`, English interface, default **Gentle** more vivid and less gray (`#300c39`), with Original/Soft still selectable. The magenta **title** and all foreground colors must remain unchanged.
- [ ] Initial SEARCHING FIRST MOUSE tutorial remains visible; hold and release each physical-layout HAT button. The corresponding text turns white while held, then returns gray.
- [ ] Press Y in SEARCHING FIRST MOUSE: it must **not** lock that didactic screen (source firmware exception).
- [ ] Choose **Connected demo** (explicit fake mouse state). The title is `DEMO MOUSE`. JOY UP/DOWN must wrap/select one of four HOME options. A white `|` marks the first column of the selected row.
- [ ] In Connected demo, use X to open `REMOVE CONNECTED HELP`, try joystick/A/X (inert), then B to return to HOME with the previous selection.
- [ ] Open Connected demo Help again, press Y: the LCD becomes completely black. The demo-state buttons are unavailable while locked. Press/release one HAT control: the LCD unlocks to connected HOME **without executing** that control's normal action.
- [ ] Choose **Saved mouse search**. B changes to DEVICE NOT FOUND; A restarts virtual search. X opens searching Help; B goes to retry. Y locks except on initial FIRST.
- [ ] Use keyboard **Up/Down/Left/Right, Enter/Space and A/B/X/Y** to duplicate HAT input. Selection changes on **keyup/release**, not on keydown, with no auto-repeat action. When an input/text entry/control button has focus, global HAT hotkeys do not hijack it.
- [ ] Test slow/long key holds, browser focus loss, pointer/touch cancellation and switching tabs: never activate a stale key when input is canceled.
- [ ] Tap/click the nine rounded controls on desktop/mobile. None requires pairing, firmware flashing, a downloaded test harness or Linux terminal.
- [ ] JOY PRESS on unimplemented HOME options must visibly report `This menu route is planned for WEB-04.` and must **not** claim full 45-screen navigation or real BLE/HID.
- [ ] Open the browser-only test page: expect **80/80 checks passed**. If not, report the failing English check name and browser.

**Production acceptance:** pending operator testing and explicit `gate aceito`. This checklist is not treated as automatically completed when the Pages deployment succeeds. WEB-04 must remain blocked.
