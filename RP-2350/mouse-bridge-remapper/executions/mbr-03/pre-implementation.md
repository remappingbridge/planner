# MBR-03 pre-implementation record

Gate: `mbr-03 — Waveshare renderer and HAT physical acceptance`

Status: **IMPLEMENTATION STARTED**

## 1. Dependency and base

Accepted predecessor:

`tiagooliveirajs/mouse-bridge-remapper@643278c0ec94ab0c64ad88bcba2a770b2d368f61`

Planner source-of-truth before implementation:

`tiagooliveirajs/repo-planner@371c717ed58bd85c5ad5684892aeec5fa1c68141`

MBR-02 is accepted. The current implementation must preserve its host-pure UX model and connected-HOME Pair New amendment.

## 2. Product amendment applied before renderer work

The current product literal for `home-searching-help` is the 2026-09-20 amendment:

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

This is a literal-only screen amendment; saved-search semantics remain unchanged.

## 3. MBR-03 objective

Adapt the physically accepted BLU2USB G03 renderer/HAT behavior to the frozen MBR semantic frame:

- Waveshare Pico-LCD-1.3 / ST7789, 240x240;
- 5x7 glyph source scaled 2x;
- 10x14 glyph box, 11 px horizontal advance;
- title x=7/y=8;
- body first y=39 with 26 px advance;
- hint region with accepted bottom anchoring and dark-magenta separator;
- exact MBR semantic width of 21 characters;
- semantic colors title/body/option/white/cyan;
- active-low HAT inputs on GPIO 2/18/16/20/3 and 15/17/19/21;
- 20 ms debounce and 1 ms scan cadence;
- release-triggered application behavior supplied by the existing host-pure interaction engine.

## 4. Expected code/modules

Expected destination changes:

- `include/mbr/renderer/renderer.h`
- `src/renderer/renderer.c`
- `include/mbr/hat/hat.h`
- `src/hat/hat.c`
- `src/app/main.c`
- `CMakeLists.txt`
- `.github/workflows/ci.yml`
- MBR-02 golden screen fixture/tests for the amended Help literal.

No Bluetooth, USB HID, persistence, profile, or Pair New runtime implementation is introduced by this gate.

## 5. Provenance and regression risks

Renderer/HAT implementation is a behavior-preserving adaptation of accepted BLU2USB G03/G06 evidence, not a blind copy. Relevant inherited lessons:

- physical vertical relocation must remain exact;
- didactic token columns are canonical;
- semantic color precedence is selection/pressed white over cyan current;
- Help owns all input;
- active-low inputs require debounce;
- no terminal/serial interaction is required for physical acceptance;
- renderer never owns application/search/profile truth.

The accepted MBR-02 projector remains the source of literal rows and semantic spans.

## 6. Automated verification

Required:

- host configure/build;
- `bootstrap_contract`;
- `ux_golden_contract`;
- `ux_behavior_contract`;
- `architecture_contract`;
- Pico 2 W production configure/build;
- non-empty UF2 with SHA-256/size recorded;
- structural inspection that no production CDC/UART/debug path is introduced.

## 7. Physical acceptance boundary

mbr-03 is not complete from CI alone. The operator must flash the exact candidate UF2 and report numbered scenario results.

The physical matrix must cover renderer/HAT color/geometry, pressed/release feedback, Help consumption, ordinary Lock/unlock, instructional behavior, HOME shortcut, long-name projection and the exact amended `home-searching-help` literal.

If a physical scenario fails, mbr-03 remains open and the candidate evidence is invalidated after the fix.