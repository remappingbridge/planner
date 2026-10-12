# MNT-15 — official release v3.2.4 (12 October 2026)

**FINAL STATE: OPERATOR ACCEPTED / MERGED / RELEASED.**

## Operator acceptance and exact candidate

- Explicit operator decision: **“gate aceito”**, 12 October 2026, after receiving and testing the MNT-15 Pico 2 W candidate UF2. [Acceptance](operator-acceptance.md) and [physical checklist](physical-acceptance.md).
- Base official [v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3), commit `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.
- Physically accepted candidate: `7177672d109f8f13aea77ba707c614e53d6065f1`, [candidate CI #38298979787](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787), **98/98 host and Pico 2 W PASS**, UF2 953344 bytes, SHA-256 `4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`.
- Branch `maintenance/v3x-mnt-15`, [PR #45](https://github.com/remappingbridge/remappingbridge/pull/45), approved candidate followed by version and English documentation-only release commits; final versioned PR CI [#38300604410](https://github.com/remappingbridge/remappingbridge/actions/runs/38300604410): **98/98 host PASS, Pico 2 W production PASS, English public documentation PASS**.
- PR #45 ready and **squash-merged** into main at immutable commit **`69a640d9767ec7198572eb9b5073ed71f8f3d202`**. This incorporates the English-only docs/CI changes already on main before MNT-15.

## Published artifact

- **Official release:** [RemappingBridge v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4), release ID **410954279**.
- **Tag `v3.2.4`:** points directly to commit **`69a640d9767ec7198572eb9b5073ed71f8f3d202`** (the exact squash-merge source commit; not the original v3.2.3-versioned candidate).
- **Release pipeline:** [GitHub Actions #38300896801](https://github.com/remappingbridge/remappingbridge/actions/runs/38300896801), **SUCCESS**, 98/98 host tests PASS, pinned toolchain/SDK Pico 2 W Release build PASS, `sha256sum --check` PASS.
- **Production firmware:** [remappingbridge-v3.2.4-pico2w.uf2](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.4/remappingbridge-v3.2.4-pico2w.uf2), **953344 bytes**.
- **Official SHA-256:** `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`. Confirmed in the successful release job log and `SHA256SUMS.txt` validation.
- **Checksum file:** [SHA256SUMS.txt](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.4/SHA256SUMS.txt).
- English-only [v3.2.4 release notes](https://github.com/remappingbridge/remappingbridge/blob/v3.2.4/docs/releases/v3.2.4.md), public `README.md` subsequently updated on main to identify v3.2.4 as current stable. The latter documentation-only commit does not change the immutable release tag or UF2.

## Exact change and trade-off

- Only firmware behavior change: action **26 ZOOM IN** from `Ctrl+Shift+HID Equal` (modifier mask 0x03) to **`Ctrl+HID Equal` (0x01)**.
- Actions **27 ZOOM OUT** and **28 RESET ZOOM** untouched; Mouse, USB HID descriptors, Consumer, Bluetooth Pair New, per-mouse profiles, settings, navigation, LCD and all other shortcuts untouched.
- In Mabox/Obsidian, physical Ctrl+= works without Shift and fails with Shift; browsers accept Ctrl+= without Shift. Some terminals require Shift for zoom and may therefore not respond to the new generic action. This is a **known application binding limitation**, explicitly documented before approval. There is no app detection, duplicated key chord, terminal-specific feature or additional menu.
- MNT-14 is **canceled**, with no firmware modifications or release.

## Gate outcome

**MNT-15 CLOSED — ACCEPTED/PUBLISHED v3.2.4.** No new gate has been authorized. A subsequent version must start from the latest officially released tag in effect at that time.

**Evidence boundary:** the operator's short overall acceptance is not a timestamped PASS report for every row of the physical test matrix; do not invent individual results.
