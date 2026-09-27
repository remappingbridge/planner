# HOPE-31 — final inventory and documentation

Status: **ACTIVE / FINAL GATE**.

- accepted base: `remappingbridge/remappingbridge@8aa50611bcaf1a0091de6b111de0c6b7e4a67646`
- operator order: 2026-09-26
- no gate follows HOPE-31.

## Final inventory rule

The historical plan said 30 canonical screens. That count is superseded by the accepted HOPE-23 replacement scope: the user-facing `learn-the-keys` feature was cancelled, while HOPE-01 `searching-first` remains the automatic first-Mouse bootstrap.

The final runtime must therefore contain **29 canonical screens**, not an artificial 30.

## Required cleanup

Remove from the runtime model:

- legacy G06 `MOUSE_STATUS`;
- legacy G06 `OTHER_DEVICES_STATUS`;
- legacy G06 `MOUSE_HELP`;
- legacy G06 `DEVICES_HELP`;
- duplicate/unreachable `CUSTOM_APPLIED` screen ID/template. Accepted Custom confirmation stays in `EDIT CUSTOM REMAP`;
- legacy internal name `BLU2USB_SCREEN_LEARN_KEYS`; rename the same accepted automatic screen to `BLU2USB_SCREEN_SEARCHING_FIRST`.

Remove associated dead state/navigation, including `status_page`.

## Documentation

Create final authoritative documentation under `remappingbridge/remappingbridge/docs/hope` covering:

- exact 29-screen inventory and gate mapping;
- final navigation and global control rules;
- simple architecture actually implemented;
- BLE saved-Mouse identity/name persistence and removal;
- profiles/remapping persistence;
- distinction between event-driven automatic screens and user-selected routes;
- explicit cancellation of user-facing learn-the-keys.

Historical Gxx/early UX docs may remain as implementation history, but must be clearly marked non-authoritative for final HOPE UX.

## Verification

Automated tests must prove:

- `BLU2USB_SCREEN_COUNT == 29`;
- all 29 screen IDs have a template/title;
- obsolete G06 screen IDs/strings are absent from the runtime UX model;
- `CUSTOM_APPLIED` is absent;
- `SEARCHING_FIRST` is preserved and no `LEARN_KEYS` screen ID remains;
- accepted HOME option counts remain 3/2/2;
- all existing functional tests pass;
- Pico 2 W production build passes.

Physical acceptance remains required for the final candidate.
