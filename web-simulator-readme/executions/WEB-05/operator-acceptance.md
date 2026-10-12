# WEB-05 — Operator acceptance and WEB-06 handoff

**Date:** 2026-10-12. **Decision:** ACCEPTED by operator.

The operator said **"gate corrente aceito"** and explicitly requested the next gate. WEB-05 site PR #6 merged as `0ee2238faeb6942f9edc99b8320f65b785feec0d`; GitHub Pages run #38311281605 succeeded.

Additional **WEB-06** requirements: keep the **virtual HAT continuously visible while the rest of the simulator's options scroll**; tighten the top/bottom LCD housing and the right-side A/B/X/Y key geometry (smaller roundness and height) so keys fit strictly within the LCD square; relocate the current brand/virtual device and bottom Pico/LCD/HAT informational text to a **right-hand metadata strip vertically constrained to the LCD square**. Allow the joystick+LCD+right button group to shift left, preserving physical HAT arrangement. Avoid hiding simulator options behind a sticky panel; support responsive screens, zoom and keyboard. After implementing, deliver **numbered, explicit manual tests with actions and expected outcomes**.

This user statement is an acceptance decision, **not** a claim of independently observed 134/134 production-browser checks. WEB-06 explicitly authorized; WEB-07 remains blocked.
