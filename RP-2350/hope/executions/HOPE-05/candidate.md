# HOPE-05 — candidate

Status: **IMPLEMENTED / AUTOMATED PASS / PHYSICAL ACCEPTANCE PENDING**.

- accepted base: `a459316fd2c9eefb9fc85e6656cd96134f22d0a0`
- branch: `hope/hope-05-remove-this`
- draft PR: `#17`
- candidate head: `6359472553df98da57a4fb8af2d28942e9deda67`

## Implemented behavior

- canonical Mouse UI v1 `remove-this` screen;
- `JOY PRESS` from the selected `saved-devices` page opens the confirmation screen;
- target Mouse identity is pinned when the screen opens, so connected-first reordering cannot change which Mouse `KEY A` removes;
- selected Mouse name uses the accepted canonical HOME/saved-device formatting and is cyan only when that exact target is current;
- `KEY B` cancels to the same logical saved Mouse page before removal starts;
- `KEY A` starts exactly one physical removal and remains on `remove-this` while pending;
- repeated `KEY A` while pending is inert;
- if the target is current, HID Mouse and synthetic-remap output are released and the BLE session is disconnected before credential deletion;
- removal deletes all LE Device DB bond entries equivalent to the selected BLE identity/IRK;
- removal deletes the target from the persistent saved-name registry;
- removing a disconnected Mouse does not disconnect a different current Mouse;
- successful removal with saved Mice remaining returns to a valid `saved-devices` page;
- removing the final saved Mouse enters `searching-first` and resumes first-Mouse discovery;
- `KEY X: HELP` is present in the canonical screen but intentionally inert in HOPE-05; `help-remove-this` belongs to HOPE-30.

## Automated evidence

- GitHub Actions CI: `#91` / `35993815633`
- host/architecture: **PASS**
- host test suite: **39/39 PASS**
- Pico 2 W production: **PASS**
- production UF2 verification/upload: **PASS**
- UF2: `HOPE-05-remove-this-6359472-pico2w.uf2`
- size: **911,872 bytes**
- SHA-256: `b2770517744cf6f3d71933c57a963f502e563f0e03bc76b45e73f07012004070`

Do not promote PR #17 before the operator physically accepts this exact candidate.
