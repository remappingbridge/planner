# HOPE-06 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `pair-new` and replace the legacy G06 Pair Mouse flow in-place.

## Dependency

Accepted gates: HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25.

Accepted destination base:

- repository: `remappingbridge/remappingbridge`
- base: `main@def2743022c3b522190eac06b97af0d4148348bd`
- branch: `hope/hope-06-pair-new`

## Canonical screen

~~~text
PAIR NEW MOUSE
TRYING TO CONNECT
A NEW MOUSE THAT
IS NOT LISTED
IN SAVED DEVICES

KEY B: CANCEL
KEY X: HELP
KEY Y: LOCK
~~~

## Frozen Pair New semantics

- Pair New window: **15 seconds**.
- Search accepts only an **unsaved BLE HOGP Mouse**.
- Saved candidates are ignored and the same 15-second window continues.
- Explicit non-Mouse HID candidates are rejected.
- If a Mouse is already live, it remains the sole authoritative Mouse and keeps forwarding input while the candidate is discovered and qualified.
- Candidate HID reports are never forwarded before promotion.
- Candidate must complete security + HIDS connection + descriptor parsing and classify as Mouse before it is replacement-ready.
- Only then perform atomic handoff:
  1. stop accepting old-session input;
  2. release held Mouse/Escape output at product layer;
  3. disconnect/clear old live session;
  4. retain/persist the newly qualified Mouse;
  5. promote candidate to sole current/ready session.
- Cancel or timeout before handoff preserves the old live Mouse.
- If no old Mouse is live, cancel/timeout simply leaves no fabricated current Mouse.
- KEY B cancels Pair New and returns through HOME resolver.
- KEY X belongs to HOPE-26; it remains visually present but must not introduce Help early.
- KEY Y locks presentation, cancels Pair New and preserves current Mouse/saved state.

## Replacement rule

The old `BLU2USB_SCREEN_PAIR_MOUSE` slot is transformed in-place into canonical `PAIR NEW MOUSE`.

Legacy Pair Mouse copy and its old retry/error semantics must not remain as fallback.

Legacy success screen after Pair Mouse is also removed from this flow. Successful Pair New returns through HOME resolution; HOPE-03 will later replace the connected HOME placeholder.

## BLE adaptation

G06 currently owns one authoritative session. HOPE-06 keeps that architecture but adds one bounded, temporary **candidate session** inside the same BLE HOGP module:

- current session remains unchanged and authoritative;
- candidate owns separate connection handle, HIDS cid, parser and descriptor slice;
- HIDS callbacks are routed by HIDS cid;
- security events are routed by connection handle;
- candidate reports are ignored before promotion;
- candidate is discarded on cancel/timeout/failure;
- promotion swaps candidate state into the existing authoritative G06 session.

No separate mouse-core/contracts architecture is introduced.

## Runtime events/hooks

Add minimal Pair New controls/events:

- request Pair New;
- cancel Pair New;
- Pair New started;
- Pair New timeout;
- Pair New ready/promoted as needed for UI transition.

## UI integration

- Any current incremental path selecting `PAIR NEW MOUSE` uses the transformed `BLU2USB_SCREEN_PAIR_MOUSE` slot.
- Entering Pair New requests the 15-second search.
- B or Y cancels the candidate search.
- On timeout remain within Pair New family using a temporary in-place retry presentation only if strictly needed; canonical `retry-pair-new` belongs to HOPE-07 and must not be introduced early. Therefore HOPE-06 candidate will use the existing Pair New screen after timeout with search stopped unless the gate specification requires a separate visible retry screen; no HOPE-07 text may appear.
- On successful handoff resolve HOME using existing incremental states.

## Automated verification

Tests must prove:

1. exact Pair New literal/layout;
2. old Pair Mouse copy absent;
3. B leaves Pair New through HOME resolver;
4. X does not open future Help;
5. Y locks;
6. candidate-search runtime events decode;
7. saved-peer filter distinguishes saved vs unsaved addresses;
8. current-session reports remain authoritative while candidate is pending;
9. candidate reports are suppressed;
10. candidate promotion can replace current session state only after parser Mouse qualification;
11. cancel/timeout do not replace current session;
12. no Keyboard/Composite Pair New path is introduced;
13. all prior G02–G06 + accepted HOPE regressions remain green.

## Physical acceptance

1. Reach Pair New from any currently available incremental route.
2. Verify exact canonical `PAIR NEW MOUSE` layout; old Pair Mouse visual must never appear.
3. With current Mouse connected, start Pair New and continue moving/clicking current Mouse during search; forwarding must remain uninterrupted.
4. Keep a previously saved second Mouse nearby; Pair New must ignore it as a new candidate.
5. Present a new unsaved BLE HOGP Mouse and complete its pairing/qualification.
6. Old Mouse remains authoritative until the new Mouse is fully qualified.
7. At handoff, held old Mouse/Escape outputs must be released and only the new Mouse becomes authoritative.
8. Confirm new Mouse forwards movement/buttons after promotion.
9. Start Pair New again and press B before success; current Mouse remains connected/unchanged and HOME resolver is used.
10. Start Pair New again and allow 15 seconds to expire; current Mouse remains connected/unchanged and no saved Mouse is accidentally accepted.
11. Start Pair New and press Y; presentation locks, Pair New cancels, current Mouse remains intact; unlock is consumed and HOME resolves normally.
12. With no live Mouse, Pair New cancel/timeout must not fabricate one.
13. Confirm accepted HOPE-01/02/08/24/09/25 remain functional.
14. Confirm remap/profile persistence remains functional.
15. Confirm no Bluetooth Keyboard/Composite pairing is introduced.

## Risks

- BTstack multi-HIDS routing by wrong cid;
- candidate security event mutating current-session state;
- current Mouse input interruption during candidate qualification;
- accidental acceptance of already-saved peer;
- candidate report leakage before promotion;
- timeout/cancel race with candidate connection complete;
- promoting candidate before descriptor Mouse classification.
