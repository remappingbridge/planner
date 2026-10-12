# WEB-05 — Preflight and source freeze

**Date:** October 12, 2026. **State:** implementation candidate for production-browser operator testing.

## Authorization

The operator explicitly accepted WEB-04: **"gate aceito. prossiga para o proximo"**. WEB-04 site PR #5 was published as `19a5b7dd24c917ecc2810ad8230963f13e33d00e`, and planner evidence PR #23 was merged on acceptance (`2507dda8593206acc9138535d0bf141ec50a43cc`).

Additional WEB-05 requirement: show a **general English key legend** in an appropriate location, fixing two user-supplied draft sentences about KEY B Back/Cancel and KEY Y Lock/Unlock in Home.

Verified latest official firmware **v3.2.4**, tag commit `69a640d9767ec7198572eb9b5073ed71f8f3d202`. Its C UI `src/ux_model/ux_model.c` Git blob is `132010179de09ea81f4543e9ca83def09c0a743f`; renderer blob `61c4fe3d547ba05c3e24de86518d807047b50a77`. Display semantics remain identical to the v3.2.3 baseline.

## Input semantics and legend

The literal requested English is not wholly true on every screen: `SEARCHING FIRST MOUSE` is a tutorial that ignores KEY Y Lock and KEY B, and HOME RETRY also treats KEY B specially. The physically correct legend therefore uses:

- **KEY B — Go back or cancel on most screens (except Connected Home).**
- **KEY Y — Lock the display; press and release any HAT control to unlock and return Home.**

A small additional sentence clarifies that the first-mouse tutorial only demonstrates keys and some Retry screens have special behavior. The guide belongs **outside the 240×240 LCD**, directly below the virtual HAT panel; it does not change firmware source strings or LCD colors.

## WEB-05 boundaries

- Browser-local 0–8 saved virtual mice, distinct names and stable IDs, profile containers isolated per bond, localStorage with schema validation and safe memory-only fallback.
- Deterministic logical clock and timeout, pair first/new, saved search/reconnect, cancel/failure/retry, stale result invalidation, remove connected/offline, front saved mouse selection, reboot and reset, bounded virtual event history.
- No real BLE HOGP, Web Bluetooth, USB/HID, physical pairing, UF2 or firmware changes. No Node/npm/framework/CDN or website-owned Actions.
- State editing and applying Custom/Movement belongs to WEB-06; Modifier Shortcuts assignments and semantic coloring to WEB-07. WEB-05 may store default per-mouse profile placeholders without claiming those editors are functional.
- **All public site UI/docs/release copy remains English.** Manual testing only via production `https://remappingbridge.github.io/` and `https://remappingbridge.github.io/tests/`, not Debian/local.

## Rollback

Site candidate branch: `web/web-05-virtual-mice-key-legend`, based on accepted WEB-04 `main` `19a5b7dd24c917ecc2810ad8230963f13e33d00e`. A production merge is a candidate only, not operator acceptance.
