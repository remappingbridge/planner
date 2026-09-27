# HOPE-04 — saved-devices physical acceptance

Status: **ACCEPTED BY OPERATOR / READY FOR PROMOTION**.

Candidate:

- branch: `hope/hope-04-saved-devices`
- commit: `14001e06da8be2fce05fd842dec5c868f33b475a`
- draft PR: `#16`
- accepted base: `5c62a98a4495570237d7b4b223a090bea1020990`
- UF2: `HOPE-04-saved-devices-stable-identity-14001e0-pico2w.uf2`
- size: **906,752 bytes**
- SHA-256: `ae1ea834c6d559af37f4a51d031c850bed97cff5371f9436bce83275fda05368`
- CI run: `35991066967` — host/architecture PASS; Pico 2 W production PASS.

## Required scenarios

1. From each HOME state where `SAVED DEVICES` is available, enter it and confirm the canonical layout.
2. Confirm exactly one saved Mouse is represented per page.
3. Confirm title format `N OF COUNT`.
4. Connect a Mouse whose raw saved/bond order is not first and confirm that it is nevertheless displayed on page `1 OF N`.
5. Confirm the connected Mouse real name is shown in cyan on page 1 and row 2 is `STATUS: CONNECTED`.
6. Move to another saved page with Joy Right/Left and confirm its saved name and `STATUS: DISCONNECTED`.
7. Disconnect the page-1 Mouse and confirm its name remains visible on its saved page with `STATUS: DISCONNECTED`; it must not revert to `UNKNOWN MOUSE`.
8. Connect a different saved Mouse and confirm that this newly connected Mouse immediately becomes page 1 while the previous Mouse moves to another page and keeps its name.
9. Reboot after at least two Mouse names have been learned and confirm those names are restored from persistent storage before manual removal.
10. Confirm `PROFILE: PASSTHROUGH/STANDARD/ESCAPE/CUSTOM` matches the active runtime profile.
11. Confirm Joy Left/Right wrap through all saved pages.
12. Confirm Joy Up/Down do not select legacy list rows.
13. Confirm `REMOVE DEVICE` is visually present as the next action but Joy Press does not leave `saved-devices` in HOPE-04.
14. Confirm Key B returns through the correct HOME resolver: connected -> home-connected, saved offline -> home-searching.
15. Confirm Key Y locks and any key unlocks through the existing HOME resolver.
16. Disconnect/reconnect the current Mouse while on `saved-devices`; the screen stays usable and connection status reflects runtime state.
17. Confirm Pair New, Mouse movement, buttons, scroll and all already accepted remapping profiles still work.
18. Confirm no Keyboard/Composite pairing option or legacy saved-device detail screen is reachable.
19. With two previously saved Mice, connect each Mouse once so its Device Name is learned by this corrected firmware; then disconnect both and confirm both names remain instead of `UNKNOWN MOUSE`.
20. Turn either saved Mouse back on from home-searching and confirm the saved-device count does not increase; the Mouse must reuse its existing logical page/identity instead of creating a third Mouse.
21. If the previous buggy firmware already left a duplicate bond, reconnect that Mouse and confirm the logical page count is deduplicated and remains stable after another disconnect/reconnect cycle.


Superseded candidates: `143c00b...`, `3b85bac...`, `8980f397...`, `4e738622...` — do not use/accept.

## Operator result

**ACCEPTED** by the operator on 2026-09-24.

Accepted exact candidate:
- commit: `14001e06da8be2fce05fd842dec5c868f33b475a`
- UF2 SHA-256: `ae1ea834c6d559af37f4a51d031c850bed97cff5371f9436bce83275fda05368`

Operator declaration: gate accepted after physical testing.

Promotion:
- merged PR: `#16`
- main commit: `a459316fd2c9eefb9fc85e6656cd96134f22d0a0`
