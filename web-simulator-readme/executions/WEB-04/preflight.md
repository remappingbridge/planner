# WEB-04 — Source audit, constraints and original scope

**Date:** October 12, 2026. **State:** candidate implementation, operator acceptance pending.

## Dependencies and operator instruction

- WEB-03 **accepted** in operator's explicit message "gate aceito. prossiga para o proximo" and recorded in [WEB-03 acceptance](../WEB-03/operator-acceptance.md). Planner PR #22 merged as `2efac80d83cfb480a381423c24ced436a86dab4b`.
- The operator added UI requirements for WEB-04: **remove the LCD BACKGROUND section; always use Gentle; reduce LCD display size; place joystick to the left and A/B/X/Y to the right in a single vertical column** for closer physical-HAT resemblance.
- WEBSITE source before WEB-04: accepted WEB-03 `main` at `d78533cbd274647b5c521cf8132e2a2d148cf3e3`.
- Firmware latest verified release at start: **v3.2.4**, tag `69a640d9767ec7198572eb9b5073ed71f8f3d202`. Canonical `src/ux_model/ux_model.c` Git blob `132010179de09ea81f4543e9ca83def09c0a743f`; C renderer blob `61c4fe3d547ba05c3e24de86518d807047b50a77`. Both are byte-identical to v3.2.3. v3.2.4 fixes a Zoom In HID chord only.
- **English-only:** all UI/HTML/ARIA messages in `remappingbridge` and `remappingbridge.github.io` remain English.
- **Production tests only:** operator will use `https://remappingbridge.github.io/` and `https://remappingbridge.github.io/tests/`, not local Debian files.

## 45-screen source catalog details

Source list comes **directly** from the `screens[BLU2USB_SCREEN_COUNT]` static C initializer: 45 distinct enum IDs, each with exactly nine rows and the dynamic-row mask, 9×21 displayed cells and 240×240 physical Canvas. The original C `HELP_REMAPPER_OPTIONS` contains two **22-character source lines**: preserve the raw source exactly in catalog and clip at framebuffer projection, matching C `blu2usb_ui_frame_set_text()`. Never rewrite the source to make its literal length 21.

Navigation structure references `src/ux_model/ux_model.c`, input release semantics `src/interaction/interaction.c`, focus marker `src/renderer/renderer.c`, and text/colors `src/renderer/profile_feedback.c`. Legacy v1 29-screen routes and removed Standard/Escape UI screens cannot be restored.

## WEB-04 limits

- Build **visual**, **mock-only navigation** for all 45 screen templates, HOME / Saved / Pair / Retry / Movement / Remapping / 6 COMBINATIONS / 5 SHORTCUTS / Help / Lock / Back, with controlled initial `First mouse`, `Connected demo`, and `Saved mouse search`.
- Provide a **collapsed screen-inspector QA control**, on the existing single application page only, so all 45 screens can be examined without fabricating Bluetooth pairing or persistence outcomes.
- Operations requiring a physical BLE bond or persistent state **must not** report success. `commit-pending` feedback will explicitly state "Preview only" and "No settings saved". Full virtual BLE belongs to WEB-05; profile/Movement behavior WEB-06; Modifier shortcut assignments/active colors WEB-07.
- No firmware C changes, UF2, Release or BLE connection. No framework, Node.js, npm, site authored GitHub Actions or conventional site navigation.
- **Always render web dark-magenta with Gentle `#300c39`**. Physical magenta title and all other semantic foreground colors unchanged.

## Rollback

Site WEB-04 branch: `web/web-04-canonical-screens-hat-layout`; accepted WEB-03 site main fallback `d78533cbd274647b5c521cf8132e2a2d148cf3e3`. Planner evidence remains separate until gate acceptance.
