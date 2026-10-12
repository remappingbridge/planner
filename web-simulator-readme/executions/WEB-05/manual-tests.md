# WEB-05 — Production-browser manual acceptance scenarios

**Operator status:** PENDING, no local Debian test.

After the WEB-05 GitHub Pages candidate is live, open https://remappingbridge.github.io/ and https://remappingbridge.github.io/tests/ in the production browser.

## General HAT legend

- [ ] Immediately below the HAT, find the English guide: **"KEY B — Go back or cancel on most screens (except Connected Home)."**
- [ ] Second line: **"KEY Y — Lock the display; press and release any HAT control to unlock and return Home."**
- [ ] The small tutorial/Retry caveat is visible and grammatically correct. Neither the LCD source text nor the fixed Gentle color/physical-HAT arrangement has changed. The guide is readable at increased browser zoom.

## Pairing, reconnect and storage

- [ ] Start Pair New as **Office Mouse**, then Complete Successfully. Exactly one virtual mouse is saved/connected; the simulated first-connected LCD appears. It does not require any actual Bluetooth permission.
- [ ] Disconnect Office Mouse: bond/profile remains saved and virtual HOME SEARCHING appears. Search Saved and Complete Successfully: **same ID** reconnects, no second bond.
- [ ] Pair a second mouse, **Travel Mouse**, then choose Office Mouse from Saved virtual mouse. Search and reconnect it. In Saved Devices, names and front selection correspond to the virtual model; only the active mouse identity is cyan.
- [ ] Reload the production webpage: both names and distinct bonds persist when local storage is enabled; **no pending connection attempt resumes**. Reboot Virtual Device preserves both names but disconnects.
- [ ] Start Pair New with a previously saved name (case-insensitive): no duplicated device.
- [ ] Start Pair New for 6 additional unique virtual mice (total **8**). A ninth attempt must be rejected with clear feedback, without losing any saved profiles.
- [ ] Disconnect; Search Saved; choose **Advance to Timeout (+5 ticks)**. Retry screen appears; no spontaneous connection. Simulate Failure, Cancel Pending, or supersede an attempt: old results must not connect or create a bond.
- [ ] Remove the active virtual mouse. Connection clears and its entire saved record/profile disappears, while other devices remain. Remove an offline mouse without disconnecting an unrelated active device.
- [ ] Clear All Virtual Data: the saved list, front selection, connection and history reset; reload has no ghost records.
- [ ] With browser storage disabled (or restricted), check for a clear **Memory only — storage unavailable** warning. The simulator remains usable without claiming the records will persist.
- [ ] Confirm Lock blocks virtual lab operations; first HAT press/release unlocks and is consumed. No physical BLE mouse, USB HID or Pico flash is accessed.
- [ ] Open the browser-only regression page: expect **134/134 checks passed**; if not, report English test names and browser details.

**WEB-05 acceptance: PENDING.** WEB-06 remains blocked until the operator explicitly accepts this gate.
