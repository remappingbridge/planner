# WEB-05 — Virtual mouse lab and accurate key guide

**State:** IMPLEMENTED CANDIDATE; **134/134** isolated JavaScript/DOM/Canvas regressions PASS; actual production-browser tests and operator acceptance **PENDING**.

## Delivered

- `assets/js/virtual-mice.js` (new): browser-only, pure virtual mouse manager with schema `remappingbridge-virtual-mice-v1`; up to eight uniquely named stable virtual bonds, independent default profile fields, selected front mouse, connected mouse, bounded logical-time event log, deterministic attempt tokens and five-tick timeout. Pair/reconnect success only after an explicit simulated completion; failure/cancel/stale/timeout never fabricates a bond. Storage is validated at every reload, pending attempts are intentionally ephemeral, memory-only fallback clearly reports loss of durability when browser storage is unavailable. No real BLE/HID access.
- `assets/js/hat-interaction.js`: synchronized bond count, front index and selected/saved/connected mouse identity with the same 45 screen routes. Saved Devices paging and removal reflect actual virtual model; pairing and saved searching use canonical Pair/Retry/Help screens, with source-like release/Lock rules preserved. WEB-04 demonstration-only states remain available.
- `assets/js/ui-projector.js`: Saved Devices and Remove This display the correct virtual per-mouse name; connected mouse identity uses cyan, offline saved identity does not. Dynamic names are uppercased to render with the physical firmware bitmap font.
- `index.html` and `assets/css/app.css`: always-visible **two-line English general HAT guide immediately below physical HAT**, outside LCD, with accurate caveat about first-mouse tutorial and Retry; responsive Virtual Mouse Lab with Pair/Search/Complete/Fail, and expandable Timeout/Cancel/Disconnect/Remove/Reboot/Reset and history. The accepted smaller centered LCD, left joystick, vertical right A/B/X/Y and fixed vivid Gentle `#300c39` remain intact.
- `assets/js/app.js`: model-to-Canvas wiring, local controls, disabled Lock state, browser persistence and reload; unsupported per-mouse Movement/Custom/Shortcuts effects are not claimed.
- `README.md`, `tests/index.html`, `tests/runner.js`: all English; expands WEB-04 canonical smoke tests to **134 assertions**, including reload, 8/8 limit, duplicate prevention, deterministic timeout, lost/stale connection, front bond, connected/offline removal, storage corruption/failure and actual DOM controls.

## Isolated verification and limits

- Executed the **actual unmodified browser test runner** in a V8 JavaScript environment with simulated native DOM/Canvas objects; initial execution returned **134/134 PASS**, including 45/45 source screen rasterizations and the accepted RGB font/Gentle hashes. Any changes after that pass need a repeat run before the candidate is published.
- This does **not** assert production Firefox or browser availability. Pages deployment and visual verification must be checked separately; the operator alone accepts the gate after their test.
- The general legend deliberately uses **"on most screens"**, not unqualified `always`, because firmware's first-mouse tutorial and certain Retry screens are exceptions. The unlock action is a press-and-release of any HAT control, returns to the appropriate resolved Home and is consumed. No claim that KEY Y itself toggles unlock.
- Persisted profiles hold separate default values but **full editing/apply transactions are WEB-06/07, not WEB-05**. Physical pairing and bonds are never modified.

## Actual publication for production browser

The website's [PR #6](https://github.com/remappingbridge/remappingbridge.github.io/pull/6) was merged **only to publish WEB-05 for operator testing**, site `main` commit `0ee2238faeb6942f9edc99b8320f65b785feec0d`. [Pages run #38311281605](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38311281605): build SUCCESS at the time of recording, deploy still IN PROGRESS. Recheck for success before telling the operator to rely on the live version. The gate remains unaccepted even after Pages deployment.

## Publication and rollback

Site [WEB-05 candidate branch](https://github.com/remappingbridge/remappingbridge.github.io/tree/web/web-05-virtual-mice-key-legend). When deployed to `main`, this is only for operator's production testing, not final gate acceptance. If rejected, revert to accepted WEB-04 site SHA `19a5b7dd24c917ecc2810ad8230963f13e33d00e`. **WEB-06 NOT STARTED**.
