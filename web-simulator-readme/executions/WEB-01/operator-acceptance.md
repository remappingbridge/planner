# WEB-01 — Operator acceptance and production-only testing policy

**Date:** October 12, 2026. **Gate decision: ACCEPTED by the operator.**

## Operator statements

The operator explicitly stated, in Portuguese, **"gate aceito"** and clarified the testing preference: **the application will be tested directly in the production browser experience rather than locally on Debian**.

This establishes:
- Acceptance of WEB-01's static page/HAT bootstrap as delivered.
- Authorization to merge [site PR #1](https://github.com/remappingbridge/remappingbridge.github.io/pull/1) and [planner evidence PR #18](https://github.com/remappingbridge/planner/pull/18), both subsequently merged.
- Production-browser verification as the required **manual acceptance route** for future interactive web gates. Do not provide Debian clone/open-file test steps as the default. An unverified GitHub Pages URL is a deployment blocker to be resolved with Pages Settings, not a reason to assert that production was tested.
- **No authorization to implement WEB-02 yet.** Before WEB-02, the operator requested an independent English-language audit of both the firmware and website repositories, including published GitHub Releases.

## Scope of acceptance

The operator's acceptance applies to WEB-01's static HTML/CSS/JavaScript shell, nine clickable virtual HAT controls, counter/reset, and the clearly labeled LCD text preview. It is **not** evidence of a successful live production-browser session, pixel-accurate renderer, BLE/HID, or v3 navigation. Those are scheduled in later gates.

## English-only requirement introduced between gates

The user directed that **all visible text** in `remappingbridge/remappingbridge` and `remappingbridge/remappingbridge.github.io` always be in English, explicitly including release pages. This rule applies to README, all documentation, labels/accessible names, visible JS messages, browser tests, screenshots/captions, `docs/releases/`, and published GitHub Release descriptions.

Approved implementation strategy:
1. Translate existing public text without altering firmware C logic, tags, production UF2 or checksums.
2. Make new documentation and user-facing strings English-only as part of **every upcoming WEB gate**; no translation to Portuguese in site pages.
3. Maintain English release-notes sources and synchronize already published GitHub Releases using an independent maintenance workflow in the **firmware** repo (not a build workflow in the static website).
4. Verify language requirements automatically where possible and ensure future release content is English before publishing.
5. Report any deployment/permission blocker honestly; do not claim a GitHub Release page is translated until its **public release body** is verified as English.

**Next gate:** WEB-02 is NOT STARTED. Wait for the operator's next explicit instruction after the language-audit report.
