# MOD-01 — Candidate build and validation evidence

**Status: CI PASS / BUILD PASS / PHYSICAL ACCEPTANCE PENDING.** Date: 2026-10-11.

## References
- Source stable baseline: [tag v2.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v2.0.0), unchanged.
- Firmware branch: [feature/modifier-shortcuts-mod01](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01).
- Candidate commit (immutable): [`c1266fc8fe47c181553eb8b54a75f464c20de543`](https://github.com/remappingbridge/remappingbridge/commit/c1266fc8fe47c181553eb8b54a75f464c20de543).
- Draft PR for review: [#23](https://github.com/remappingbridge/remappingbridge/pull/23), not merged.
- CI: [GitHub Actions run 203](https://github.com/remappingbridge/remappingbridge/actions/runs/38139759253).
- [Original production build artifact (ZIP)](https://github.com/remappingbridge/remappingbridge/actions/runs/38139759253/artifacts/11702229882), includes `blu2usb_picow.uf2`; artifact id `11702229882`.

## Confirmed automated checks
- Job `host-architecture`: **SUCCESS**; `ctest` **59/59 PASS** (host C/C++, Python source contracts and architecture).
- Job `pico2-w-production`: **SUCCESS**; pinned ARM toolchain, Pico SDK, `PICO_BOARD=pico2_w`, production Release compiled, `test -s` checked UF2, debug UF2 absent, uploaded artifact.
- Firmware file `blu2usb_picow.uf2`: size **924672 bytes** (verified after artifact extraction).
- **SHA256 of UF2**: `0dca28109abff950cced3d1d8c5c570ff92dc1dc522ce861fa014d190eb6ca08`.
- CI log SHA256 and independent SHA256 verification of extracted artifact **MATCH**.
- ZIP checksum `edd14cf7829b7bed77b881bb78e83e9e3a65a93e6263f03ec706293c0ae27a76` refers to the artifact ZIP, **not** the UF2.

## Code result
- 34 screen enum entries after removing four Standard/Escape Apply/Applied screens; deleted UX commands/routing/feedback for legacy presets.
- Menu displays three items: PASSTHROUGH DEFAULT, CUSTOM REMAPPING and MODIFIER SHORTCUTS (corrected copy approved in MOD-00). Help/status updated; key-up selection/lock preserved.
- Legacy v2 active Standard/Escape maps to Passthrough only in RAM at startup; old v2 profile storage schema and BLE bonds/movement remain unchanged.
- Custom `ESCAPE` target continues as a v2-compatibility placeholder until MOD-04. Modifier Shortcuts menu row is non-navigating until MOD-02, not a hidden shortcut.
- Test versions historically asserting old Standard/Escape UI rewritten to reflect new route, safe active profile and 34 screens.

## Physical validation
Scenarios: [physical-acceptance.md](physical-acceptance.md). Requires operator flashing **this exact UF2 SHA** into Pico 2 W and testing from `home-connected`. No physical execution or human acceptance is claimed in this document. **Do not start MOD-02 before operator approves MOD-01**.

**Publication:** No release/tag and no merge. Branch, draft PR and artifacts are provided only for gate validation.
