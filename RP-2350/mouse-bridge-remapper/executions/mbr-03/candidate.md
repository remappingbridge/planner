# MBR-03 implementation candidate evidence

Gate: `mbr-03 — Waveshare renderer and HAT physical acceptance`

Status: **IMPLEMENTED / PHYSICAL ACCEPTANCE PENDING**

## Accepted predecessor

`tiagooliveirajs/mouse-bridge-remapper@643278c0ec94ab0c64ad88bcba2a770b2d368f61`

## Current candidate

Product branch: `mbr/mbr-03-renderer-hat`

Candidate head: `4d4c2b9852e0db7390d75fac943294437db0d762`

Pull request: `#3 — MBR-03: Waveshare ST7789 renderer and HAT`

## Automated evidence

Final branch push CI run: `35481175036`.

- `host-architecture`: SUCCESS;
- `pico2-w-production`: SUCCESS;
- host configure/build/tests passed, including `renderer_hat_contract`;
- Pico 2 W production and qualification firmware configured and built;
- both UF2s were non-empty and uploaded;
- production USB stdio and UART stdio remain disabled.

Actions artifact:

- name: `mbr-03-pico2w-renderer-hat-uf2`;
- artifact ID: `10594974918`;
- archive digest: `sha256:cc8e496331f6cb3e92e66627d01b51509fee4bbb880573ad8d99824d6c8d1e6f`;
- expires: 2026-12-19.

## UF2 hashes

| Artifact | Size | SHA-256 | Purpose |
|---|---:|---|---|
| `mouse_bridge_remapper.uf2` | 77312 bytes | `382afe84c787a34e4c7bde6e70327de03e449fb62f7d06c758bb435202459cc2` | production candidate |
| `mbr_renderer_hat_qualification.uf2` | 78336 bytes | `9e9151d674b166ee546e4e82099243d75f01f44bdaa63bcb81ea063b3fb9dd41` | physical renderer/HAT qualification fixture |

The qualification firmware is not a production feature. It is a separate firmware target that cycles the 30 canonical screen projections so the physical renderer/HAT gate can be tested without adding a diagnostic interface or hidden control to production firmware.

## Physical acceptance scenarios

Use the exact `mbr_renderer_hat_qualification.uf2` candidate above.

1. **Boot/display:** flash the qualification UF2. The display initializes at 240x240 and begins the 30-screen cycle. No serial terminal is required.
2. **All 30 screens:** allow the cycle to show every canonical screen. Confirm text, 21-character width, title/body placement and no clipping.
3. **Updated HOME searching Help:** when `home-searching-help` appears, verify exactly:

   ```text
   HOME SEARCHING HELP
   THE MATCHING ATTEMPT
   TOOK PLACE ONLY FOR
   DEVICES ALREADY SAVED
   IN THE PREFERENCES,
   BUT NOT FOR DEVICES
   THAT WERE NOT SAVED.

   ANY KEY: BACK
   ```

4. **Colors:** verify title magenta, body off-white yellow, ordinary option light gray, selected/pressed white, current/connected cyan and dark-magenta hint region.
5. **Press/release feedback:** on screens with visible HAT labels, hold each joystick/key control long enough to see the visible label become white, then release and confirm it returns to its semantic color.
6. **Debounce:** perform quick press/release taps and confirm no duplicate visual transitions are produced by switch bounce.
7. **Help ownership:** while any Help screen is visible, press/release any HAT control and confirm the input is consumed by Help rather than executing the underlying screen action.
8. **Ordinary Lock:** on a screen displaying `KEY Y: LOCK`, release Key Y. Confirm the LCD/backlight turns off. Release one HAT control and confirm the first interaction only unlocks the presentation.
9. **Instructional Lock/Unlock:** on `FIRST MOUSE CONNECTED` and `PRESS TO LEARN KEYS`, release Key B to lock, then release Key X to unlock; confirm the unlock interaction is consumed.
10. **HOME shortcut:** on `FIRST MOUSE CONNECTED` or `LEARN THE KEYS`, release Key Y and verify HOME projection appears; the qualification cycle then continues.
11. **Didactic coordinates:** verify `JOY UP` column 8, `JOY` columns 3/10/17, `LEFT/PRESS/RIGHT` columns 3/9/16, `JOY DOWN` column 7, and right-side Key A/B/X at column 16.
12. **Long name:** verify the qualification Mouse title shows only the first 21 supported characters with no ellipsis or scrolling, while the full stored fixture name is not visually expanded.
13. **Special glyphs:** verify commas, parentheses, slash/backslash, `<` and `>` render as visible glyphs where present in the canonical screen set.
14. **Stability:** let the qualification cycle run for at least 5 full cycles. Confirm no screen corruption, stuck backlight state, frozen HAT input or serial dependency.

## Acceptance boundary

CI is green, but mbr-03 is not accepted yet. The gate remains open until the operator reports PASS/FAIL for the numbered physical scenarios on the exact qualification UF2. A failed scenario requires correction and a new candidate hash.