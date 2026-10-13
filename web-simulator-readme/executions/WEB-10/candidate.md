# WEB-10 — Static publication and firmware parity candidate

**Status:** WEB-10 candidate implemented; **operator acceptance PENDING**. **WEB-11 NOT STARTED.**

## Shipped changes and provenance

Website [PR #12](https://github.com/remappingbridge/remappingbridge.github.io/pull/12), source branch `web/web-10-parity-publication-audit`, candidate source commit `9e18b26d09f52593b5af65509c18f84f81d81349`, integrated site `main` commit `19502a2f31c43ff64df5d82b20b97b4f5ec1cebf`.

1. A brand-new independent browser fixture `tests/fixtures/firmware-screens-v3.2.4.js` is **generated from original release C screen definitions** rather than copied from the web catalog. It pins release tag, 40-character source commit, C Git blob, and **all 45 unique screen IDs, exact nine source strings and dynamic field indices**.
2. Tests now compare every one of 45 web templates against that C-source fixture, including `DYN(n)` rows, alongside pre-existing MNT-12/MNT-13, exact RGB565 bitmap/glyph, H/V DPI, rotation, 12 combinations, 30 shortcuts, lock/help, local persistent profiles and isolated Inspector checks.
3. Added a destructive-reset **cancel path** end-to-end check; confirming reset remains covered. Preserved WEB-09 accepted *Searching First Mouse / First Mouse Connected / Home Connected* demos and left-saved/right-new Virtual Mouse Lab.
4. Repaired stale English `tests/index.html` content which incorrectly described old WEB-08 0–100 brightness/density options and a historical check count; report test totals only from executed browser results.
5. Updated website README and app gate metadata to WEB-10 while preserving one-page static site, software 240×240 LCD, fixed Gentle `#300c39`, sticky HAT, responsive keyboard/touch and source KEY Y Lock.
6. Website source remains same-origin, with **18/18** relative script/style/link paths present in the audited branch tree, `.nojekyll` and AGPLv3 `LICENSE`; zero project-authored workflows, external scripts, required CDNs or downloads at runtime.

## Checks actually executed

- Direct original C source parsing and independent JS screen catalog comparison: **45/45 exact text templates and dynamic-row masks**, 0 mismatches. C-source blob also matches `mouse-ui` vendored v3 source.
- **146/146 pure V8 checks** on source-model/framebuffer and new fixture: 45 content, 45 dynamic-field parity and 45 full 240×240 RGBA frame renders, plus 11 version/demo/mouse lifecycle cases, no failures.
- JavaScript syntax checked for changed `app.js`, `tests/runner.js`, and independent fixture.
- HTML relative link/asset resolution through exact Git trees: **18/18 present**.
- Web browser test page: `https://remappingbridge.github.io/tests/`. It has runnable (not preclaimed) checks and shows the pass/fail count dynamically. Browser automation in actual Chromium/Firefox **was not executed** in this environment, and web-based direct GET verification of Pages content was unavailable.

## Publication versus acceptance

The candidate was merged into the site `main` solely for operator browser validation, using existing GitHub Pages branch/root publishing (no author-built Actions workflow). GitHub Pages run and deployment status will be tracked independently. Runtime behavior, console errors, responsive CSS, Firefox/Chromium/mobile, keyboard/touch, clipboard and downloaded file contents **remain operator tests**. Publishing the code does **not** signify operator acceptance.

**Rollback:** restore website accepted WEB-09 `main` commit `dae055bc097887d5e217081fd235989406945ebd` if the candidate is rejected, without modifying the physical v3.2.4 firmware.
