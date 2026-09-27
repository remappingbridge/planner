# HOPE-00 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-00-exact-g06-baseline`
- commit: `94036f5342889701b6c970cec05ae687fbf05a0d`
- UF2: `blu2usb_picow.uf2`
- size: 879,104 bytes
- SHA-256: `da0b0d4cfce77cd0922f1c1573672dc48ee3b8f3f0ddc08f206892407023cb63`

## Required physical matrix

Use the Pico 2 W + Waveshare HAT/ST7789 and BLE Mouse setup applicable to the accepted G06 validation.

Record PASS/FAIL for every scenario:

1. **G06-01 — G05 regression, live connection UX and fixed USB identity**
2. **G06-02 — PASSTHROUGH and success feedback**
3. **G06-03 — DEFAULT REMAP exact mapping**
4. **G06-04 — ESCAPE REMAP exact mapping**
5. **G06-05 — Synthetic Escape press/release**
6. **G06-06 — CUSTOM REMAP**
7. **G06-07 — Profile change while a mapped control was active**
8. **G06-08 — Generic/non-Logitech fail-safe**
9. **G06-09 — Logitech Forward hold under remap (Logitech-specific)**
10. **G06-10 — Logitech diversion removed by Passthrough (Logitech-specific)**
11. **G06-11 — Lock/UI while remap is active**
12. **G06-12 — USB identity stability through profile changes**
13. **G06-13 — Configuration persistence across power cycle**
14. **G06-14 — Logitech Lift bonded reconnect after Pico power cycle (Logitech-specific)**

Also confirm the universal HOPE-00 baseline checks:

- normal boot;
- ST7789/LCD rendering unchanged from G06;
- G06 copy/geometry/background/hints/colors unchanged;
- Mouse pairing/reconnect works;
- X/Y movement works;
- Left/Right/Middle work;
- wheel/Forward/Backward work when supported;
- no new Bluetooth Keyboard pairing;
- no new Bluetooth Composite pairing;
- no new Mouse UI v1 screen has appeared.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

This declaration is the authoritative physical acceptance for HOPE-00. The complete required G06 regression matrix and universal HOPE-00 baseline checks are therefore recorded as physically accepted by the operator.


## Promotion

- PR #1 promoted after operator acceptance.
- accepted main SHA: `16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`
- next eligible gate: **HOPE-01 — searching-first**.
