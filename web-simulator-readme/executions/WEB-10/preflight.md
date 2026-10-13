# WEB-10 — Preflight and authorization

**Date:** 2026-10-12. **Gate:** WEB-10, explicitly authorized after the operator said **"gate aceito. prossiga"** on the final revised WEB-09. [WEB-09 operator acceptance](../WEB-09/operator-acceptance.md) is merged into planner `main` through PR #28 at `c611965224e739ce59f74819a2e92cc49411f5e1`.

## Checked authoritative state

- Website starting `main`: `dae055bc097887d5e217081fd235989406945ebd` (WEB-09 accepted); existing Pages [run #38324307357](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38324307357) successful.
- Firmware latest release on this date: [v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4), published 2026-10-12, commit `69a640d9767ec7198572eb9b5073ed71f8f3d202`. Canonical `src/ux_model/ux_model.c` Git blob `132010179de09ea81f4543e9ca83def09c0a743f`; renderer Git blob `61c4fe3d547ba05c3e24de86518d807047b50a77`. Release UF2 and SHA256SUMS exist; **WEB-10 does not modify or download/flash firmware**.
- Desktop `mouse-ui` current `main`: `e1f5e98aba8bc436729b991de9ec22294e6ca78d`. Its **vendor** `vendor/remappingbridge-v3/src/ux_model/ux_model.c` is *byte-for-byte the same Git blob* `132010179de09ea81f4543e9ca83def09c0a743f`. The older `src/projector/screens.c` still contains legacy v1 UI templates, not the v3.2.4 canonical firmware; they must never override 45 canonical screens.
- The operator removed **WEB-08 optional brightness/density controls** in accepted WEB-09. Therefore WEB-10 uses normal 100% browser brightness with KEY Y Lock; it must **not** resurrect obsolete controls despite stale historical WEB-10 gate matrix text.
- Website branch `web/web-10-parity-publication-audit`; evidence branch `web/web-10-evidence`. Single-page HTML/CSS/JS-only architecture, no build/npm/CDN/backend/analytics/custom workflow or firmware modifications.

**Boundary:** real-browser visual/manual checks and direct unauthenticated external HTTP verification remain separate from GitHub-hosted Pages deploy status. An automatic deploy `success` must not be presented as proof of live Firefox, mobile or 404-free behavior.
