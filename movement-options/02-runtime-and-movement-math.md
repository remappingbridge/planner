# Runtime architecture and movement math — implement later

Status: PLANNED ONLY / source evidence vs proposals clearly separated.

## Existing v1.0 path (verified)
BLE HOGP -> canonical mouse event -> remap -> hid_aggregator (relative X/Y and held buttons) -> app/service_usb_mouse -> usb_hid 8-bit relative USB report -> host.
src/app/main.c currently clamps X/Y to int8 before USB and consumes only the reported original deltas after a successful send. Fixed USB Mouse+Keyboard descriptors already exist. Vendor Logitech HID++ and buttons are outside the new motion feature.

## Proposed minimal extension
- New pure C module in src/movement/ with include/blu2usb/movement/movement.h (reusable, host-testable): typed gain and angle enums/lookup, deterministic transform/chunk helper and fixed-point carry.
- Keep app/main.c as composition owner. A current-mouse movement configuration is selected by BLE logical identity on CONNECTED / DISCONNECTED / PAIR-NEW-PROMOTED / REMOVE; never by display page or USB packet source address.
- On output, transform relative pointer X/Y only, **after remap/aggregation and before USB encoding**. Leave wheel, horizontal pan, buttons, synthetic Escape, held ownership, Logitech HID++ backend, BLE parser and USB descriptors unchanged.
- Add narrowly scoped UX model state/commands for movement current/candidate/APPLY/RESET, handled in main.c with confirmed result; the renderer projects current values and selected candidates.
- Add scoped per-identity movement persistence module (details in 03 file), not a new global Core/coordinator.

## Coordinate semantics: critical convention
Represent BLE and USB mouse coordinates with X positive RIGHT, Y positive DOWN. 'Counterclockwise' in UI is mathematical rotation in screen coordinates, not the original experiment's informal label. Matrix after conversion to Y-down:

    rotation 0°:    Rx =  x; Ry =  y
    rotation 90°:   Rx =  y; Ry = -x
    rotation 180°:  Rx = -x; Ry = -y
    rotation 270°:  Rx = -y; Ry =  x

Then apply gain to the OUTPUT axes:

    USB_X = H * Rx
    USB_Y = V * Ry

Sanity-proof: H=2x, V=1x, CCW=270° produces USB_X=-2*y and USB_Y=x exactly matching approved blu2usb experimental/g06-rotation-90-horizontal-2x (commit eb696be). Pure CCW=270° H=V=1x is equivalent to the prior fixed experiment's USB_X=-y, USB_Y=x. 90 vs 270 labeling is a coordinate-system convention, not a need to change the proven physical behavior.

## Allowed factors (EXACT rationals)
Encode gains as integer numerator q / 4, no floating point:
- slow page: NORMAL=4/4 (1x), SLIGHTLY SLOW=3/4 (0.75x), SLOW=2/4 (0.5x), VERY SLOW=1/4 (0.25x)
- fast page: SLIGHTLY FAST=5/4 (1.25x), FAST=6/4 (1.5x), VERY FAST=8/4 (2x), EXTREMELY FAST=12/4 (3x).
- angles enum {0,90,180,270}; defaults H=4, V=4, angle=0.

Naming: user-facing 'DPI' does NOT change sensor DPI and no mouse/vendor DPI write is required. Scale is constant independent of velocity; acceleration and desktop host DPI settings remain external.

## Lossless handling, precision and range
The 1x/2x G06 experiment's even-chunk invariant cannot be blindly generalized to 0.25x/1.25x/1.5x. Implement a general fixed-point motion ledger with fractional (quarter-step) carry per output axis and large-width math:

1. Snapshot pending original aggregate X/Y and current immutable movement settings epoch.
2. Rotate with a signed 64-bit intermediate BEFORE scaling/negation, including INT32_MIN, then multiply by q/4. Check representability before integer narrowing.
3. Choose a source delta chunk whose output fits signed USB int8 [-128,127], tracking exact fixed-point residue and **how much source will be consumed**. Include independent X/Y/Wheel/Pan; wheel and pan are unchanged and may chunk normally.
4. Calculate a candidate report and candidate post-send state. If USB unavailable/busy, consume NO source, change NO fractional carry, and preserve unchanged pending events. Avoid reapplying gain to already transformed output on retry.
5. After successful USB send, atomically consume only the original source deltas represented by the packet and commit fractional carry. Remainders persist to next USB packet. Never drop motion merely because a scaled component exceeds the int8 range.
6. Tiny positive/negative inputs at gains <1 can produce subpixel carry. Hold unconsumed subpixel input until it can produce a report, or account for it in the ledger only when sending another successful packet. Zero-output source steps must not get acknowledged without a recoverable remainder.
7. Prove conservation for any completed run: sum of transmitted output plus signed fractional remainder equals exact integer-rational transform of all consumed source deltas. Test negative symmetry and directional reversals; maximum residual magnitude less than one output unit per axis.
8. Mark/source-tag the pending motion epoch across an APPLY change, so source accumulated under old settings is not accidentally double-scaled or silently reinterpreted by new settings. Drain any full-pixel old-epoch output before switching; fractional <1-pixel remainder may be deterministically rounded/cleared at a documented transition, never clipped by saturation. If output is busy, defer activation until the boundary is safe.

Implementation choices for items 3, 6 and 8 must be resolved and demonstrated by host tests before final firmware integration. A bounded backlog and no unbounded blocking/retries in the main loop are mandatory.

## Apply semantics / separation from UI
- Existing input machine emits complete HAT interactions only on release. UX model sends SET_AXIS_GAIN, SET_ROTATION, or RESET_ALL commands only when confirmed by proper key interaction.
- Do not display new current value until identity-matched storage write/read-back succeeds, and settings have been installed into the runtime output pipeline. A failed write retains previous confirmed settings and candidate editor.
- A change in one axis retains untouched other axis and rotation. RESET ALL writes all three in one record update.
- Navigating across Slow/Fast only changes a staged candidate; no movement changes before KEY A.
- If Mouse disconnects or another saved Mouse becomes active between opening editor and APPLY, reject/dismiss stale command; do not write onto newly connected Mouse, leak settings across identities or mutate disconnected peer by accident.
- Movement passthrough is always 1x/1x/0 for unknown unsaved/invalid identity. No implicit 'use last Mouse settings'.
- Button remap changes must not reset gain and gain changes must not reset held button ownership.

## Expected code-touch map (not implemented)
include/blu2usb/ux_model/ux_model.h and src/ux_model/ux_model.c: screen IDs, correct menu row mapping, selection, Help origin, movement draft and commands.
src/renderer/renderer.c: value spans/cyan/white precedence, 2-row Rotation logical option, column-aligned Slow/Fast render and Saved Devices profile/motion summary.
src/app/main.c: motion pipeline integration, runtime config swap, command acknowledgment and BLE identity sync.
include/blu2usb/movement/movement.h and src/movement/movement.c: pure fixed-point transform/chunk helper.
src/ble_hogp/ble_hogp_pico.c (+ narrow header accessors): existing identity/IRK matching or minimal accessor; no second registry for BT credentials.
movement settings persistence dedicated .c/.h as warranted, with BTstack TLV access encapsulated or reusing existing TLV helper.
tests/CMakeLists.txt + host tests: vector math, all screen snapshots/nav, persistence/upgrade/failure, end-to-end source consumption.
CMakeLists.txt only to add the new pure module and tests, not to alter USB identity.

## Regression / acceptance vectors
At a minimum test all 8 gain factors independently on both axes and all 4 angles; identity 1x/1x/0, prior experiments 1x/1x/270 and 2x/1x/270, diagonals/circle/ellipse, small incremental and 16/32-bit extremes, USB busy followed by send, sign inversion, ±127/128 boundaries, varying acceleration outside firmware, held buttons, wheel/pan, lock, remove/reconnect and two distinct Mice settings.
