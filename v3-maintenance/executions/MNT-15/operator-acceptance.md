# MNT-15 — operator acceptance (12 October 2026)

**Decision: ACCEPTED.** The operator responded **“gate aceito”** after receiving the exact MNT-15 production UF2 and physical test plan.

## Scope accepted

- [RemappingBridge PR #45](https://github.com/remappingbridge/remappingbridge/pull/45), original candidate commit `7177672d109f8f13aea77ba707c614e53d6065f1`.
- [Canonical CI #38298979787](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787): **98/98 host tests PASS**, production Pico 2 W build PASS.
- Operator-delivered candidate `remappingbridge-mnt15-zoom-ctrl-equal-pico2w.uf2`, 953344 bytes, SHA-256 `4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`.
- Firmware action **26 / ZOOM IN** changed from Left Ctrl + Left Shift + HID Equal to **Left Ctrl + HID Equal**, no application detection. ZOOM OUT and RESET unchanged.
- Terminals can differ on Zoom In chords: some accept Ctrl+= and some Ctrl+Shift+=; the chosen single generic action may not zoom in on every terminal. The operator was informed of this trade-off before requesting implementation.

## Evidence boundaries

The final message was a **gate-level approval**, not a nine-row test report. Do not retroactively mark each scenario of [physical-acceptance.md](physical-acceptance.md) individually PASS without its own evidence. The explicit acceptance **authorizes the normal v3.x PATCH release process**, including version bump, CI, PR merge and official GitHub Release, with immutable provenance.

## Release discipline

- Last official tag prior to this gate: [v3.2.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3).
- Next compatible PATCH: **v3.2.4**, on the same firmware logic as the accepted candidate. Only source version, bootstrap version, changelog/release workflow and public README metadata may be updated.
- Preserve the English-only public documents that were independently merged into `main` after v3.2.3.
- Official release UF2 hash is **not** necessarily the accepted candidate's hash, because version metadata and the final exact source commit are different. Validate final artifact against its own `SHA256SUMS.txt` and build log.
- MNT-14 remains canceled; no pairing changes.

**Do not introduce any next gate without new authorization.**
