# WEB-03 — Preflight and source baseline

**Date:** October 12, 2026. **State:** candidate implemented; acceptance pending.

## Dependency accepted

The operator stated in this conversation: **"prefiro gentle, porem um pouco mais vivo, menos acinzentado. faça essa melhoria no proximo gate. gate atual aceito. implemente o proximo"**.

- WEB-02 was explicitly accepted. [Operator acceptance](../WEB-02/operator-acceptance.md) recorded and planner [PR #21](https://github.com/remappingbridge/planner/pull/21) merged (SHA `e1a268697ead055b92722819c29725acb848fb86`).
- WEB-03 was explicitly authorized, including the carried-over Gentle saturation tweak.
- Source site main at gate start: `50c0fbfc8f6ea5852a572818ea89d3e74e6c2738`.
- Latest verified stable firmware at preflight: `v3.2.4`, tag SHA `69a640d9767ec7198572eb9b5073ed71f8f3d202`. UI baseline v3.2.3 display files have identical Git blobs in v3.2.4.
- Input contract: `src/interaction/interaction.c` and HOME/HELP branches of `src/ux_model/ux_model.c` at v3.2.4. Keyboard and pointer events in the browser are mapped to nine named virtual HAT controls. Real HID/BLE is **not** involved.
- The operator requires all UI/README/test strings **in English**, browser tests **in GitHub Pages production**, not Debian.

## Scope boundary vs WEB-04

WEB-03 ports physical-key **press/release**, no duplicate action on repeated keydown, Help/Back/Lock behavior, unlock consumes first release, cancellation on blur/pointercancel/hidden tab, keyboard alternatives, and initial HOME selection focus. **WEB-04** owns all 45 screen templates, full navigation graph, profile/editor screens, dynamic screen projections and complete menu routes. WEB-05 owns virtual BLE devices/persisted state. To validate WEB-03 without falsely claiming a BLE connection, the website offers explicit **First mouse**, **Connected demo**, and **Saved mouse search** modes. The HOME title says `DEMO MOUSE`. Unsupported routes show an English WEB-04 notice.

## Operator-requested Gentle refinement

- WEB-02 Gentle `#28142c` was selected as a direction; WEB-03 default is a **more vivid, less gray** `#300c39` (RGB 48,12,57).
- Only web LCD *dark-magenta background* changed; firmware foreground colors, title magenta, font bitmaps and 240×240 positions remain unchanged.
- Original physical `#080008` and WEB-02 Soft `#190b1d` are still available.
- Physical UF2, tags, SHA256SUMS and `remappingbridge` repository untouched.

## Rollback

WEB-03 site branch: `web/web-03-hat-help-lock-gentle`; site PR #4. If the candidate is rejected after production publication, revert its merge commit and restore accepted WEB-02 site `main` commit `50c0fbfc8f6ea5852a572818ea89d3e74e6c2738`, not the firmware.
