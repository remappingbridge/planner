# HOPE-06 — physical acceptance

Status: **ACCEPTED — CORRECTED REWORK PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-06-pair-new`
- commit: `6f4d8890a6011e679efb56bc098f81844632074a`
- draft PR: `#8`
- UF2: `HOPE-06-pair-new-pico2w.uf2`
- size: **890,368 bytes**
- SHA-256: `e118c3e2bd17f60b9315d7159ae11fb4c052103ba723a55f60b0dfcd3d3b9f02`

## Required physical scenarios

1. Reach Pair New from an available current route and confirm the exact canonical `PAIR NEW MOUSE` screen.
2. Confirm the old `PAIR MOUSE / SEARCHING BLE HID / TARGET MOUSE / AUTO SEARCH ACTIVE` visual never appears.
3. With one Mouse already connected, enter Pair New and continue moving/clicking it throughout candidate discovery; existing Mouse forwarding must remain uninterrupted and authoritative.
4. While Pair New is running, expose a second Mouse that is already saved/bonded. It must **not** be accepted as the new candidate and the same 15-second Pair New window must continue.
5. If available, expose a BLE HID device that is explicitly non-Mouse by HID appearance; it must not be accepted.
6. Start a fresh Pair New window and expose a genuinely new/unsaved BLE HOGP Mouse. Complete its pairing.
7. Until that candidate has completed security + HIDS + descriptor Mouse qualification, the old current Mouse must remain the only authoritative Mouse.
8. During candidate qualification, candidate movement/buttons must not leak to USB.
9. At successful handoff, any old held Mouse button or Escape/remap output must be released; no stuck state may remain.
10. After handoff, only the newly promoted Mouse must control USB; old Mouse input must no longer be authoritative.
11. Reboot and verify the newly paired Mouse remains saved/persisted.
12. Start Pair New again with a current Mouse, then press B before success. Pair New must cancel, current Mouse must remain unchanged/usable, and HOME resolution must occur.
13. Start Pair New again and let the full **15 seconds** expire without an unsaved candidate. Current Mouse must remain unchanged; search must stop. HOPE-07 retry text must not appear early.
14. After timeout, a newly advertising Mouse must not be accepted unless Pair New is explicitly entered again.
15. Start Pair New and press/release Y. Presentation must lock, Pair New must cancel, and current Mouse/saved state must remain intact.
16. Unlock with one complete HAT interaction. It must be consumed and normal HOME resolution must occur.
17. Repeat Pair New with no live Mouse. Cancel and timeout must not fabricate a connected Mouse.
18. Confirm accepted HOPE-01/02/08/24/09/25 screens and flows remain functional.
19. Confirm current profile/remap behavior and persistence remain functional before and after a successful handoff.
20. Confirm no Bluetooth Keyboard/Composite Pair New behavior was introduced.

## Operator result

Operator declaration: **FAIL**.

Failure reported by the operator on 2026-09-23: a new Mouse did not pair.

## Root cause found

The failure is not caused by the future `saved-devices` UI gate. Pair New already queries the BLE LE device database directly.

The candidate firmware was built with:

- `MAX_NR_HCI_CONNECTIONS 1`
- `MAX_NR_GATT_CLIENTS 1`
- `MAX_NR_HIDS_CLIENTS 1`

Therefore the runtime architecture added by HOPE-06 could not actually keep the current Mouse connected while creating a second candidate HOGP connection. The compiler accepted the code, but BTstack was statically configured for only one concurrent connection/client.

HOPE-06 remains open on PR #8 and must be corrected/rebuilt/retested.


## Corrected rework candidate

The first failure root cause has been corrected without advancing to HOPE-04.

- branch: `hope/hope-06-pair-new`
- corrected commit: `ac685b6d05de20706aa40c3c04591aab0639c98e`
- draft PR: `#8`
- CI run: `35823937034` — **SUCCESS**
- UF2: `HOPE-06-pair-new-rework-pico2w.uf2`
- size: **890,368 bytes**
- SHA-256: `1fab62b23d68e28432a311b3f0bcddca9e9b3c320e90aca7222e3bbc2ebaab27`

### Re-test focus

Repeat the Pair New scenarios, with special emphasis on:

1. keep the current Mouse connected and usable;
2. enter Pair New;
3. put a genuinely new Mouse in pairing mode;
4. verify the candidate now establishes a second temporary BLE/HIDS session and completes qualification;
5. verify handoff occurs only after qualification;
6. verify a saved Mouse remains ignored as a new candidate;
7. verify B, timeout, and Y cancel preserve the current Mouse.

Operator result for the corrected candidate: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Corrected candidate `ac685b6d05de20706aa40c3c04591aab0639c98e` is the physically accepted HOPE-06 implementation.


## Promotion

- corrected PR #8 candidate physically accepted and promoted.
- accepted main SHA: `90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`
- next eligible gate: **HOPE-26 — help-pair-new**.
