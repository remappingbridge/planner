# English-only audit — firmware and web simulator

**Date:** October 12, 2026. **Status:** COMPLETED. **WEB-02 remains NOT STARTED.**

This maintenance work was explicitly requested **after accepting WEB-01 and before authorizing WEB-02**. It is not a new firmware feature, firmware release, or web feature gate.

## Repositories changed

| Repository | PR and result | What changed |
|---|---|---|
| [remappingbridge.github.io](https://github.com/remappingbridge/remappingbridge.github.io) | [PR #2](https://github.com/remappingbridge/remappingbridge.github.io/pull/2), merged to `main` at `9b95bc964928b5912f0d46ae82434bdd9c3130a6` | English UI labels, page headings, aria attributes, messages, tests, README and `html lang="en"`; bootstrap enforces English locale |
| [remappingbridge](https://github.com/remappingbridge/remappingbridge) | [PR #44](https://github.com/remappingbridge/remappingbridge/pull/44), merged to `main` at `87bb8e4e1f04cb9395b9b5b43b8e971b2aca2c7d` | Translated README, MOD-01 historical notes, all **16** release Markdown pages; introduced English-check CI and release-description synchronization |
| [planner](https://github.com/remappingbridge/planner) | [PR #19](https://github.com/remappingbridge/planner/pull/19), merged to `main` at `8dcde49ef6373f9565a6c0aa106a5f81f03a69dc` | Explicit WEB-01 acceptance, English-only contract and production-browser test policy |

## Verifications performed

- **43 Markdown pages** in the firmware repository scanned after translation: none matched the documented set of distinctive Portuguese words.
- **16/16 release-notes files** now in English, including v1.0.0, v2.0.0 and every v3.0.0–v3.2.3 published tag.
- [Firmware CI branch run #38296113378](https://github.com/remappingbridge/remappingbridge/actions/runs/38296113378): **host-architecture SUCCESS**, including the new English check, and **pico2-w-production SUCCESS**. No functional firmware C changes in PR #44.
- [Release description sync run #38296362367](https://github.com/remappingbridge/remappingbridge/actions/runs/38296362367): **SUCCESS**. The GitHub Releases API was queried *after* the run; **16/16 published release descriptions** were in English, and version-specific titles were standardized (e.g., `RemappingBridge v3.2.3`).
- The sync workflow changes only GitHub Release **title and description** using `gh release edit --title --notes-file`. It does **not** upload/delete binaries, move tags or modify `SHA256SUMS`. The v3.2.3 UF2 remained 953344 bytes with digest `sha256:29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4` (release asset created October 12, 2026, unchanged).
- The web repository's two HTML pages declare `lang="en"`; the app and test runner JavaScript parse and expose the English 9-control prototype. Browser-only tests have **17 test assertions** after this maintenance.
- **No live production-browser validation was performed here**: the Pages URL could not be independently confirmed. The operator will perform web tests in production, not on Debian.

## Future safeguards

1. Firmware CI runs `python3 scripts/check_public_english.py` against public Markdown on PRs and pushes; no external translation service or Node.js is required.
2. `.github/workflows/release-notes-english.yml` synchronizes the GitHub Release descriptions on changes to `docs/releases/` and supports `workflow_dispatch` for manual re-synchronization. Future release source Markdown must be written in English.
3. The site's bootstrap requires `lang=en`; its browser harness checks English locale and message strings. No project-owned site build workflow was created.
4. All later WEB gates must add **English** UI strings, labels, accessibility descriptions, release notes and README documentation.
5. The operator requires manual UI tests through the **production browser**, without local Debian testing.
6. A regex/wordlist guard is a safety net, not proof of grammatical accuracy in every future sentence; release/editorial review remains required.

**Next action: await the operator's explicit instruction to start WEB-02 (Canvas LCD renderer).**
