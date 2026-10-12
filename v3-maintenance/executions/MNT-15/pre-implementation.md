# MNT-15 — pre-implementation gate, zoom-in HID compatibility

**Status: AUTHORIZED FOR IMPLEMENTATION, candidate NOT YET VALIDATED.** Explicit instruction on 12 October 2026: "sem shift tambem aumenta e diminui zoom no navegador, mas no terminal depende do termial. tem terminal que funciona com e terminal que funciona sem shift. implemente o gate agora".

## Immutable reference and authorization

- Last official release [v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), immutable tag `f38c5fd15c68ea9a36d3b05912727788d7b98e81`, production UF2 SHA-256 `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`; **no version bump until operator accepts physical firmware**.
- Main is **one documentation/CI commit ahead of the tag** at start of gate; it contains an English-only documentation normalization and release-notes workflow. The MNT-15 branch must start from the verified tag, and the PR must merge these changes without reverting main's English-only public content.
- MNT-14 was canceled after operator-reported broad pairing success. Do not reopen BLE.
- User A/B results: Mabox, session perhaps X11 (not confirmed); in Obsidian, physical Ctrl+= **without Shift** zooms in, with Shift it does not; Ctrl+- zooms out, Ctrl+0 resets. In browser, Ctrl+= and Ctrl+- **without Shift** work. In terminals, some require Shift for Zoom In, others do not. User expressly approved implementation with this trade-off in mind.

## Minimal source diff

- `src/modifier_shortcuts/keyboard_catalog.c`: for action **26 (ZOOM IN)** only, retain HID Keyboard Equal `0x2E`, change modifier mask **`MOD_CTRL | MOD_SHIFT` -> `MOD_CTRL`**. Do NOT change 27 (Ctrl+Minus), 28 (Ctrl+0), any other action, 6KRO, USB descriptors, BLE, UX or display.
- `tests/test_mod07_keyboard_catalog.c` and `tests/test_mod08_reported_fixes.c`: change the obsolete expected Zoom In mask 0x03 to **0x01**; preserve assertion that all other actions and consumer usages are unchanged.
- Add focused MNT-15 host test for Ctrl+Equal down/up/USB backpressure and non-sticky modifiers, Zoom Out/Reset preservation, other shifted chords such as Redo and Screenshot Area, plus source contract if needed. Register in CMake for canonical CI.

## Accepted trade-off / no app-specific handling

A fixed, generic USB HID shortcut **cannot guarantee universal Zoom In behavior across terminal applications** when their bindings disagree about Shift. The operator explicitly reported that some terminals require Shift and others do not. Choosing Ctrl+= prioritizes verified Obsidian and browser compatibility; terminals that only accept Ctrl+Shift+= may lose Zoom In through this single predefined RemappingBridge action, **even though the terminal's own keyboard shortcut remains available**. Do not emit both chords indiscriminately: that would risk double zoom, unintended commands and inconsistent state. Do not detect application, add a new UI option or synthesize Shift based on target. Explicitly ask operator to test at least one of each terminal class and mark the limitation in candidate notes.

## Gates and evidence

1. Create `maintenance/v3x-mnt-15` from v3.2.3, draft PR into main. No release version bump.
2. Run host CI and production Pico 2 W build on exact candidate commit, download CI UF2 and verify SHA from build log.
3. Prepare physical tests from **HOME CONNECTED**: Obsidian Zoom In/Out/Reset, browser Zoom In/Out/Reset, terminals with/without Shift bindings, keyboard/consumer actions, passthrough/Custom, lock/unlock, no stuck keys, bonds/profiles persisted. Record PASS only after operator's observation.
4. Await explicit physical acceptance. After acceptance, version PATCH 3.x, merge, tag, release with UF2 and SHA256SUMS, preserving main's English-only content. No release for diagnostics only.
