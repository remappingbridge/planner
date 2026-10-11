# MOD-10 — acceptance and authorization to publish v3 (2026-10-11)

**Gate-level decision: ACCEPTED BY THE OPERATOR.** Literal user instruction: “gate aceito. publique como v3 do remappingbridge”.

## Frozen qualification artifact
- Previously qualified firmware branch: `feature/modifier-shortcuts-mod10`, commit `2c40f1be9fd47771bf6bb51fa72fd7b9825394d2`.
- Green CI: [run 38174579749](https://github.com/remappingbridge/remappingbridge/actions/runs/38174579749), **80/80** host tests and successful Pico 2 W production build.
- Candidate UF2 SHA-256: `a1facaa830183b3f971d49a8b6228c20803817d207733ec42bc6fb004d3a63a0`.
- Operator accepted the gate and separately ordered publication of major **v3**; product SemVer standard from previous releases is **`v3.0.0`**.

## Evidence boundary
- The operator's gate acceptance authorizes creating final release commit, merging and publishing tag/release v3.0.0. It **does not** report a per-scenario PASS for Q01–Q24 or the 30 individual actions, which remain individually unverified in the records.
- Known caveats (Obsidian KDE zoom, platform-specific Consumer brightness/media, Android Home) must remain documented.
- Release build must re-run host regressions and pinned Pico SDK/ARM GCC at its final commit before publishing, upload UF2 + SHA256SUMS.txt and verify the tag.
- Upgrading normally from v2 must preserve bonds via UF2; downgrade to v2 may reset v3 global profile/shortcuts; no flash_nuke.
- Publication outcome (release URL, tag SHA, asset SHA, final CI) must be documented **only after verification**.

[Candidate evidence](candidate.md) · [Physical acceptance scenarios](physical-acceptance.md) · [30-action checklist](action-matrix.md).
