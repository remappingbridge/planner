# WEB-06 — Operator acceptance and WEB-07 handoff

**Date:** 2026-10-12. **Status: ACCEPTED** by the operator, who stated **"gate corrente aceito. prossiga para o proximo"**.

Website WEB-06 candidate [site PR #7](https://github.com/remappingbridge/remappingbridge.github.io/pull/7) was merged at `7b8449dd233016698d089015b28a811ddd643478` and GitHub Pages build/deploy #38314559207 completed successfully. Isolated automated suite reported 165/165; the operator did not separately report an independently measured browser test count.

**WEB-07 additional layout instruction:** move **REMAPPINGBRIDGE** from the right-side device metadata column to the **top-left corner inside the sticky physical HAT panel**; move **VIRTUAL DEVICE and its small yellow dot** to the **bottom-left corner inside the same panel**. Keep the Pico/LCD/HAT specifications on the right, LCD + joystick + A/B/X/Y centered vertically, sticky scrolling and source LCD colors intact. Do this **in WEB-07 alongside its originally planned 12-combination, 30-shortcut work**, not as a separate hotfix. Make placement fit without overlap and provide numbered production-browser tests.

This acceptance authorizes **WEB-07 only**; WEB-08 must not be started without acceptance.
