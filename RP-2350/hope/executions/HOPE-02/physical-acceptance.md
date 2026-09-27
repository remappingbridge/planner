# HOPE-02 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-02-first-mouse-connected`
- commit: `e8b66a324ba74ab41a5538299accced28d1f2add`
- draft PR: `#3`
- UF2: `HOPE-02-first-mouse-connected-pico2w.uf2`
- size: 880,128 bytes
- SHA-256: `348077b46a5b74a5df547f00cdac28df1bb32dd4aeb50df6fc2bcd1188276589`

## Required physical scenarios

1. Boot into the accepted HOPE-01 `SEARCHING FIRST MOUSE` screen.
2. Pair a valid BLE HOGP Mouse.
3. After the Mouse reaches READY, the next screen must be exactly `FIRST MOUSE CONNECTED`.
4. Confirm that `MOUSE PAIRED / MOUSE CONNECTED / READY TO USE` never appears.
5. Confirm exact 9-row copy and geometry.
6. Confirm body background is black and the `KEY Y: LOCK` hint field is dark magenta.
7. Confirm title magenta and instructional controls light gray.
8. Press/release Joy Up/Down/Left/Right/Press and A/B/X: only matching visible tokens become white while held; release performs no navigation.
9. Confirm B is inert and does not go Back.
10. Press Y: while held, both the visible `KEY Y` and `KEY Y: LOCK` hint become white; the screen must not lock yet.
11. Release Y: backlight must turn off and the UI must remain logically on this success screen while locked.
12. Perform one complete interaction with any HAT control: it must unlock, restore backlight, consume the interaction and resolve to the inherited G06 HOME without also navigating there.
13. Confirm Mouse X/Y movement continues to reach the host.
14. Confirm Left/Right/Middle and supported scroll/Forward/Backward.
15. Confirm G06 profile/remap/persistence behavior remains functional.
16. Reboot/reconnect and confirm neither the removed G06 first-search visual nor the removed G06 success visual reappears at their replaced points.
17. Confirm no Bluetooth Keyboard/Composite pairing was added.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `e8b66a324ba74ab41a5538299accced28d1f2add` is the physically accepted HOPE-02 implementation.


## Promotion

- PR #3 promoted after operator acceptance.
- accepted main SHA: `d13f905fc2a817f464f3683edd4bf689247c30ed`
- next eligible gate: **HOPE-08 — home-searching**.
