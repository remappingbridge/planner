# HOPE-30 — candidate

Status: **IMPLEMENTED / AUTOMATED PASS / PHYSICAL ACCEPTANCE PENDING**.

- accepted base: `07abebc67d202ad67c52f325d6153b9ed0d90ab6`
- branch: `hope/hope-30-help-remove-this`
- draft PR: `#18`
- candidate head: `956906c2320c99937875bbbb95e6372945898424`

## Implemented behavior

- canonical Mouse UI v1 `help-remove-this` screen;
- `KEY X` from `remove-this` opens Help before physical removal starts;
- Help text is exactly `REMOVE MOUSE HELP`, `COMPLETELY REMOVE THE`, `AUTOMATIC CONNECTION`, `WHEN TURNING ON THE`, `DEVICE AND DELETE ITS`, `BUTTON REMAPPING`, `PROFILE.`, blank row, `ANY KEY: BACK`;
- every complete HAT control exits Help back to `remove-this`;
- `KEY Y` exits Help and never invokes global Lock there;
- the pinned HOPE-05 removal identity survives the Help round-trip and connected-first page reorder;
- Help cannot be entered after physical removal has already started;
- no HOPE-23/HOPE-31 implementation was started; those remain deferred to a different feature/series.

## Automated evidence

- GitHub Actions CI: `#93` / run `35995034296`
- host/architecture: **PASS**
- host test suite: **41/41 PASS**
- Pico 2 W production: **PASS**
- UF2 artifact verification/upload: **PASS**
- UF2: `HOPE-30-help-remove-this-956906c-pico2w.uf2`
- size: **912,384 bytes**
- SHA-256: `3de284a57a243759839f3b427f9d4a6060b11c0ecae64ba337099b08209b8a5f`

This is the final gate of the current HOPE series. Do not promote PR #18 before the operator physically accepts this exact candidate.
