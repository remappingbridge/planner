# MOD-10 — Release qualification candidate

**Status: CI SUCCESS 80/80 CTests + production UF2 verified; MOD-10 gate accepted by operator (2026-10-11). Publishing RemappingBridge v3.0.0 separately authorized; check GitHub release state before marking published.**

## Provenance / frozen source
- Gate MOD-09 accepted by the operator on 2026-10-11; exact approved dependency SHA `dcc85dfc86ef140bf8acb2be54488f0ce07b3000`.
- MOD-10 branch [`feature/modifier-shortcuts-mod10`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod10), [draft PR #30](https://github.com/remappingbridge/remappingbridge/pull/30).
- Exact candidate commit [`2c40f1be9fd47771bf6bb51fa72fd7b9825394d2`](https://github.com/remappingbridge/remappingbridge/commit/2c40f1be9fd47771bf6bb51fa72fd7b9825394d2).
- No changes to firmware runtime, USB/HID descriptors or persistent schema from MOD-09; this qualification gate adds only 3 tests and documentation. The compiled **UF2 is byte-identical** to the operator-approved MOD-09 binary, confirmed by `cmp` and SHA-256. This is intended: a release-candidate qualification, not an unrequested firmware behavior change.

## Verified CI / artifact (exact candidate)
- [GitHub Actions production run #38174579749](https://github.com/remappingbridge/remappingbridge/actions/runs/38174579749) **SUCCESS**; both `host-architecture` and `pico2-w-production` successful with pinned SDK/toolchain.
- Host CTest **80/80 PASS**, including all previous 77 and `mod10_home_editor_persistence_mask_and_reboot`, `mod10_full_30_action_keyboard_consumer_matrix`, `mod10_production_security_abi_source`.
- Official [artifact #11715590905](https://github.com/remappingbridge/remappingbridge/actions/runs/38174579749/artifacts/11715590905), ZIP size **348703 bytes**, digest of ZIP **`859c9eb86bc4cc4f0e71ac06fb8a4c677c642ed18e818977387a37af939b24a0`** (ZIP hash is not firmware hash).
- Archive contains exactly one file `blu2usb_picow.uf2`: **944640 bytes**, SHA256 **`a1facaa830183b3f971d49a8b6228c20803817d207733ec42bc6fb004d3a63a0`**. Extracted independently from ZIP, hashed using `sha256sum`, compared to GitHub CI log and MOD-09 accepted binary. All match.
- Production artifact excludes debug UF2 and debug CDC/UART endpoints; stable two-HID-interface USB ABI source regression passes.

## Qualification scope proven vs not proven
- Host flow: HOME CONNECTED → 5 picker pages → all 30 action IDs → persistence v3 reread → UI apply; KEY B and Reset; Modifier mask/unmask preserving latent assignments; v3 CRC rejection without overwriting in-memory profile; no Modifier = no shortcut.
- Host action executor: 30/30 typed Keyboard/Consumer usages with down/up ACK, stalled endpoint and nonblocking minimum dwell; **NOT 30 observed effects in external software**.
- Source safety: legacy v2 migration guarded; USB Report/Boot and no CDC descriptors, BLE removal identity-scope, motion flushing, cancel paths and name-only cyan Saved Devices.

**Operator gate-level acceptance:** [recorded in operator-acceptance.md](operator-acceptance.md). The [24 scenarios Q01–Q24](physical-acceptance.md) and [30 individual actions](action-matrix.md) remain individually unverified; do not invent checkmarks. Upgrade/downgrade and host-specific Obsidian/brightness behavior cannot be proven in CI. The operator has now separately authorized release v3.

[Technical contract on product branch](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod10/docs/modifier-shortcuts/mod10-release-qualification.md).
