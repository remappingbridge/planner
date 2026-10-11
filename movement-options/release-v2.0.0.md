# RemappingBridge 2.0.0 — Publication audit

**Operator authorization:** 2026-10-11, “gate aceito. publique como a versão v2.0 do remappingbridge”.
**Gate status:** MOV-01 to MOV-10 physically **ACCEPTED** (see `executions/MOV-XX/physical-acceptance.md`).
**Publication status: IN PROGRESS** — verify GitHub Release before marking complete.

## Product and merge
- Repo: https://github.com/remappingbridge/remappingbridge
- Branch: `feature/movement-options-v1.0`
- PR: https://github.com/remappingbridge/remappingbridge/pull/22 — merged into `main`.
- Merge SHA: `35dec22ef8ce60275dd2b812bca2e225b7d0edc3`.
- Version: CMake `2.0.0`, `BLU2USB_VERSION_STRING="2.0.0"`; planned release tag `v2.0.0`.
- Release notes: `docs/releases/v2.0.0.md`; user README updated.
- GitHub Actions release publication: https://github.com/remappingbridge/remappingbridge/actions/runs/38137256052 (retest and Pico build on merged `main`, then publish with GitHub token).
- Existing `v1.0.0` release preserved; separate v1 workflow detects existing release and skips publication.

## Last pre-merge release-prepared candidate
- Source commit `9be62271f2265966797df98e44108ec36bc573e3`.
- CI https://github.com/remappingbridge/remappingbridge/actions/runs/38137078875.
- Host **59/59 PASS**, Pico 2 W production **PASS**.
- CI artifact ID `11701246601`, UF2 RP2350 **925.696 bytes, 1.808 valid 512-byte blocks**, SHA-256 `66fbcadb5530d50e05cf9bcdffec44509895aa8e0f6afe4f5d0df0c84f7b6a0f`.
- Firmware is functionally the MOV-10 accepted candidate with version metadata bumped to 2.0.0; final official asset checksum will be read from the actual GitHub Release.

## Publication exit checks
1. GitHub Action `Publish RemappingBridge v2.0.0` completed successfully on merge SHA.
2. Tag `v2.0.0` points to merged `main` source.
3. GitHub Release `v2.0.0` is published, not draft or prerelease.
4. `remappingbridge-v2.0.0-pico2w.uf2` exists as public Release asset and is a valid RP2350 UF2.
5. `SHA256SUMS.txt` is present and matches the asset digest.
6. Existing `v1.0.0` remains available.
7. Record published URL, tag SHA, official artifact SHA-256 and CI release workflow result here.

Do not report a completed publication until these checks are satisfied.
