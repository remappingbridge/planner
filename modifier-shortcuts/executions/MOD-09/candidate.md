# MOD-09 — Candidate CI and production UF2

**Status:** Implementation pushed to [MOD-09 firmware branch](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod09); CI/UF2 qualification and physical operator acceptance pending verification.

- Base accepted MOD-08 SHA `5bfde2c4dc21aef3505ea9884a4878ae8ee8ec6f`.
- First recovery commit `7d93c0e56e333d020fc0c977350104756db33630`.
- Documentation commit `ce82a7de40ee5f17ce0887168f79e7d6010a214a`.
- CTest additions: `mod09_recovery_cancel_overflow_and_ownership`, `mod09_app_saved_devices_safety_source` (expected suite total: 77 if both pass; do not report PASS before CI).
- Recovery: discard stale relative deltas on USB state transitions, BLE disconnect/pair handoff/overflow; cancel old queued actions after persisted edit; reject invalid MOVE action ID as a reason to suppress movement; keep name-only cyan Saved Devices contract.
- USB VID/PID, interface count, 30 actions, pairing, flash v3 and production identity unchanged.
- No local claim of downloadable UF2 or SHA until the GitHub CI artifact exists and its binary digest is verified.

**Physical acceptance:** [PENDING](physical-acceptance.md). No merge, tag or release. Known Obsidian KDE zoom discrepancy remains a previously accepted MOD-08 caveat, not silently fixed.
