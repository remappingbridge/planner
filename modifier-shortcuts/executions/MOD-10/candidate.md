# MOD-10 — Release qualification candidate

**Status:** Implementation candidate pushed, CI/UF2 and physical operator qualification pending verification.

- Accepted MOD-09 source SHA: `dcc85dfc86ef140bf8acb2be54488f0ce07b3000`.
- MOD-10 branch: [feature/modifier-shortcuts-mod10](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod10).
- First qualification commit: `2c40f1be9fd47771bf6bb51fa72fd7b9825394d2`.
- New CTest host qualification: HOME-connected editor through 30 action slots and verified v3 reread, reset/masking/CRC; all 30 keyboard/consumer down/up with busy USB ACK; production source ABI/security regression.
- Production firmware must be built by CI with pinned Pico SDK 2.2.0 and ARM toolchain. Do **not** invent artifact hashes or state CI PASS prior to workflow completion.
- [Detailed implementation contract](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod10/docs/modifier-shortcuts/mod10-release-qualification.md).
- [Physical test matrix](physical-acceptance.md); no physical PASS without explicit operator evidence.
- **No merge/release/tag**, and no claim that host-specific actions (especially KDE Obsidian zoom, brightness) are fixed without evidence.
