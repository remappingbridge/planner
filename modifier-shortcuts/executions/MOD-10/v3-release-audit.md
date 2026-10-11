# RemappingBridge v3.0.0 — publication audit (completed 2026-10-11)

**Status: PUBLISHED / VERIFIED.** Operator authorized it by accepting MOD-10 and explicitly requesting “publique como v3 do remappingbridge”.

## Source and immutable tag
- [PR #30](https://github.com/remappingbridge/remappingbridge/pull/30): **MERGED**.
- Final `main` commit SHA: **`d7c7950fe595bd0e14a970cf60a29d085f065db4`**.
- [Tag `v3.0.0`](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0) references **that exact commit SHA** (lightweight tag). No divergence from `main` at publication verification.
- [Release page](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0): **published 2026-10-11T21:18:49Z**, not draft and not prerelease; title `RemappingBridge 3.0`.

## Final release workflow and source verification
- [Release GitHub Actions run 38175676759](https://github.com/remappingbridge/remappingbridge/actions/runs/38175676759): completed **SUCCESS**, exact merge SHA.
- Rebuilt from exact release commit, executed **80/80 CTests PASS** (workflow log 2026-10-11T21:16:49Z) and Pico 2 W production build with pinned tools.
- Final release workflow `sha256sum --check SHA256SUMS.txt`: **OK**; release publication step completed SUCCESS.
- [Canonical CI run 38175676768](https://github.com/remappingbridge/remappingbridge/actions/runs/38175676768) on exact merged commit: **SUCCESS**.

## Official downloadable assets
- [`remappingbridge-v3.0.0-pico2w.uf2`](https://github.com/remappingbridge/remappingbridge/releases/download/v3.0.0/remappingbridge-v3.0.0-pico2w.uf2): **944640 bytes**, SHA-256 **`77c772cb987196fb04248c147fa0d1ae6fc303085d5e962215e33a66f19a46a9`**.
  - Digest is consistent in GitHub release asset metadata (`sha256:`), release job checksum printout, and release job checksum verification.
  - This release firmware SHA is different from the MOD-10 pre-release candidate because the build source now carries `3.0.0` version identifiers.
- [`SHA256SUMS.txt`](https://github.com/remappingbridge/remappingbridge/releases/download/v3.0.0/SHA256SUMS.txt): **100 bytes**, file digest `635a248536d29dde6da580c50c1b6741b048b2d0ba582f539480ea39758c6c7d`.

## Evidence limits / upgrade safety
- Gate-level MOD-10 accepted, but [24 physical scenario rows](physical-acceptance.md) and [30 action per-host rows](action-matrix.md) were **not individually marked PASS** and remain pending detailed evidence. Acceptance alone must not be presented as observed compatibility on all hosts.
- Obsidian KDE zoom, OS-specific HOME/Consumer behavior and actual brightness changes may vary; previous discrepancy not hidden.
- Upgrade by copying UF2 in BOOTSEL. **Do not flash_nuke**; normal update preserves saved BLE bonds and Movement per mouse. Downgrading v3→v2 can reset global profile/shortcuts because v2 does not decode v3 schema. Release notes document this explicitly.

**Operator acceptance record:** [MOD-10/operator-acceptance.md](operator-acceptance.md). Publication is finished; no further release actions are implied.
