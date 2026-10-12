# WEB-07 — Operator acceptance and WEB-08 authorization

**Date:** October 12, 2026. **Decision: ACCEPTED**.

The operator explicitly instructed **"gate aceito. prossiga"** following the published WEB-07 candidate. This authorizes the planned WEB-08, **HAT/LCD visual, responsive and web brightness 0–100%**. Operator acceptance does not independently certify a 194/194 real-browser execution; those were isolated V8 DOM/Canvas2D results. The 15 manual scenarios remain archived as the acceptance plan.

Published website source: PR #8 merged to `main` commit `5f2597946c1af04ceb08c9eec301dc867675c248`; GitHub Pages build/deploy run #38316811734 **success**. Verified v3.2.4 firmware tag `69a640d9767ec7198572eb9b5073ed71f8f3d202`.

**WEB-08 boundaries:** modern single-page in-app polished HAT/LCD visual styling, adjustable UI density, accessible focus/touch/contrast/motion, responsive zoom/HiDPI, browser-only brightness strictly **0–100%**; **Lock effective 0%** without destroying remembered non-lock brightness, preference restored on unlock. Scale presentation separately from brightness. Preserve 240×240 underlying Canvas, 45 screens, MNT-12/13 semantics, fixed Gentle `#300c39`, left-corner brand and yellow-dot Virtual Device, sticky panel, English UI, local mock mouse persistence, and no real HID/BLE. No navbar, hero, footer, CDN, npm, build, firmware/UF2 writes.

**WEB-09 NOT STARTED.** This is a gate approval only, not permission to proceed beyond WEB-08.
