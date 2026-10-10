# Movement Options — frozen baseline and product decisions

Status: PLANNING / NO IMPLEMENTATION.

## Inspected v1.0 reality (not legacy assumptions)
- v1.0 final screen count is 29, with connected HOME (3 selectable routes), searching/retry HOME, Saved Devices (one mouse/page), Remove This, and profile flow.
- Connected HOME runtime currently uses BLU2USB_SCREEN_HOME, title = saved mouse name, row 1 = current mapping summary (selectable), rows 2 and 3 = saved and pair; row selection is resolved in ux_model.c, drawn in renderer.c.
- Non-connected HOMEs do not expose remapping. New Movement Options is connected-HOME-only.
- Current rendered profile in Saved Devices is based on global ux.active_profile, not independently persisted per saved mouse. Do not falsely treat v1.0 button profiles as per-mouse.
- Version 1.0 profile state uses a 14-byte serialized product record within a 64-byte capacity, while BTstack saved-name registry is keyed by BLE address/type/IRK in separate TLV. The settings feature needs a separate identity-scoped record, not index-based state.
- Fixed USB Mouse + Keyboard identity, BLE processing, held-state ownership and Logitech behavior already work. Avoid touching those beyond a narrowly scoped motion transform.

## Decisions from operator's attachment (explicit)
- Preserve general RemappingBridge rules.
- Parenthesized explanations are not display text.
- One implementation gate per non-Help screen, one combined Help gate.
- Current values are cyan; Slow values begin at 1-based column 16, Fast at 1-based column 17.
- Connected HOME adds MOVEMENT OPTIONS.
- MOVEMENT OPTIONS displays HORIZONTAL DPI, VERTICAL DPI and COUNTERCLOCKWISE / ROTATION N-DEGREE, with KEY A: RESET ALL; per-mouse values are saved.
- Two paginated Slow/Fast pages for each axis, plus four 90-degree-step rotations.
- Saved Devices adds DPI and rotation information.
- Remove warning/help must mention movement preferences.

## Inferences to preserve intent and v1.0 design (not literal new requirements)
D-01. Menu's 'DPI' is a **relative movement multiplier**, not a device DPI sensor read or negotiated physical DPI. Labels and x-values remain as provided. Host acceleration may alter visible distance; firmware applies linear gain.
D-02. Transform ordering is rotation first, then horizontal/vertical scaling in OUTPUT POINTER AXES. This reproduces the successful experiment: UI 270° counterclockwise + H=2x + V=1x => USB X=-2*mouse Y, USB Y=mouse X.
D-03. 270° counterclockwise uses mathematical rotation expressed in Y-down screen coordinates. Do not copy the original experiment's 'rotation-90' label into the UX; test direction vectors to avoid convention inversion.
D-04. The source repeats 'horizontal-slow-dpi' for horizontal FAST and 'vertical-slow-dpi' for vertical FAST; canonical runtime IDs instead are horizontal-fast-dpi and vertical-fast-dpi. This corrects naming only, not UX content.
D-05. 'KEY PRESS: ACCESS' on Movement Options is interpreted as physical JOY PRESS (v1.0 HAT has JOY PRESS and keys A/B/X/Y, not a separate KEY PRESS).
D-06. Up/Down selects and wraps in option pages even when hints omit those controls, as inherited from v1.0. Left/Right wraps only within Slow/Fast pages of the SAME axis.
D-07. Enter DPI submenu on its Slow page with the current value selected if present there; otherwise Fast with current value selected. First-ever defaults (1x) start at Slow. Joy Press alone does not APPLY; KEY A performs APPLY AND BACK, preserving source-specific semantics.
D-08. On selecting another DPI item, cyan remains on the actually persisted current value; selected candidate is white. Leaving via hidden KEY B cancels. On Apply success return to Movement Options and refresh current values; on storage failure remain on selector, with no false cyan success.
D-09. KEY B performs contextual Back on Movement Options and selector pages, even when absent from hints. KEY Y locks normal screens when allowed and is not shown unless specified; help consumes ALL keys.
D-10. For Remove This, attachment explicitly changes Help shortcut to KEY Y: HELP, overriding that screen's historical KEY X: HELP and its Key Y lock action. No hidden KEY X Help route on Remove This; Key X behaves inert there. All Help pages consume Key Y as Back, not Lock. Preserve Key Y lock elsewhere.
D-11. Help pages 'help-slow-dpi' and 'help-fast-dpi' are shared by both horizontal and vertical flows (owner screen restored). 'rotation-help' is separate, existing 'help-remove-this' is updated in place, not duplicated.
D-12. Source typo 'BUTTOM' is normalized to BUTTON in help copy. The fixed v1.0 21-column limit and nine-row layout take precedence over comments and excessively long sample mouse names; use existing HOME title sanitization/truncation.
D-13. Per-Mouse state absent on a newly bonded Mouse defaults to H=1x, V=1x, rotation=0°, while previously bonded Mice without a record receive identical defaults without disturbing their legacy profile/template.
D-14. Current values shown in cyan in Movement Options and DPI/Rotation selector; Saved Devices uses cyan specifically for saved numeric settings to show applied values, while its existing name/status conventions remain as v1.0.
D-15. The optional display string 'DPI: H ... - V ...' uses numeric values WITHOUT 'x' exactly as the attachment's Saved Devices example; selection pages use values with x (e.g., 0.75x).

## Explicit non-goals
- No dynamic DPI acquisition, per-device HID resolution programming, OS pointer acceleration changes, acceleration curves or smoothing.
- No rotation of wheel/pan or button/key events.
- No new settings for disconnected Mouse through HOME; Saved Devices remains inspect/remove only.
- No overhaul of global button remap/profile persistence, BLE bonding UX or hardware rendering geometry.
- No auto-promoting to main, no release renaming, no work started until explicitly authorized.

## Anchors
Production baseline release/v1.0.0 @ 30c4dd87922bb566248832ba4716774c0cb29755.
Reference transformations blu2usb @ a8c4c1d (USB=-y,x) and eb696be (USB=-2y,x).
Initial isolated branch: feature/movement-options-v1.0 (identical to release base on creation).
