# WEB-06 — Preflight, scope and source verification

**Date:** October 12, 2026. **Candidate; operator acceptance pending.**

- Explicit operator acceptance: WEB-05 was accepted ("gate corrente aceito"), authorization to proceed to WEB-06 granted. Accepted planner evidence PR #24 merged as `db24f12400a252805659bf84590388e602cd6769`.
- Site baseline before changes: accepted WEB-05 main `0ee2238faeb6942f9edc99b8320f65b785feec0d`. Website branch: `web/web-06-profiles-movement-sticky-hat`, planner branch `web/web-06-evidence`.
- Firmware latest verified: **v3.2.4**, tag SHA `69a640d9767ec7198572eb9b5073ed71f8f3d202`. Canonical UI C blob `132010179de09ea81f4543e9ca83def09c0a743f` and LCD renderer `61c4fe3d547ba05c3e24de86518d807047b50a77`; no newer release detected during WEB-06 preflight. No firmware/UF2 changes.
- WEB-06 gate scope (from [gate definition](../../gates/WEB-06.md)): virtual saved-mouse PASSTHROUGH/CUSTOM profile activation, single Modifier, source identity, draft/apply/cancel, horizontal and vertical speed 0.25×..3×, 0/90/180/270 rotation and Reset Movement; distinct per-mouse persisted profiles; never emit physical USB/HID.
- Operator-requested **WEB-06 layout enhancement**: sticky virtual HAT always visible during scrolling below, reduce LCD housing top/bottom, reduce right A/B/X/Y rounding and align all four within LCD vertical extent; move in-device top branding and bottom Pico/LCD/HAT info to **right-side metadata** aligned with LCD vertical limits. Existing English key guide stays below sticky device, web-only Gentle `#300c39`, 45 LCD screens and 240×240 logical geometry unchanged.
- Test only in **production browser**. English-only public firmware/site UI/docs/release copy. No Node/npm, backend, CDN, custom site workflow, real BLE or HID.
- WEB-07 Modifier Shortcuts assignments and interactive 12 combinations/30 shortcuts are not part of WEB-06; do not claim those are complete.

Rollback to accepted WEB-05 website main `0ee2238faeb6942f9edc99b8320f65b785feec0d` if operator rejects candidate.
