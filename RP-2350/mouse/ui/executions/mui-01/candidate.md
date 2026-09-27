# MUI-01 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-01-renderer`;
- base: accepted MUI-00 `f0007cb7f5c19543238b564b0295256e57fec3aa`;
- candidate commit: `4daa0963e476eebd61cd7049b43cba582413144a`;
- commit message: `MUI-01: implement pure RGB565 renderer`.

## Implemented scope

- framebuffer bounded write/read primitives with out-of-range rejection;
- new pure `mouse_ui_renderer` library depending only on `mouse_ui_domain`;
- generic semantic 9×21 render frame with `{character, tone}`, `hint_row`, and `didactic`;
- accepted predecessor 5×7 uppercase/digit/punctuation glyph set, doubled to 10×14 pixels;
- x origin 7, title y 8, body y 39, 11 px horizontal advance;
- ordinary 26 px body spacing and didactic 25 px spacing;
- bottom-anchored hint geometry;
- full dark-magenta (`0x0801`) didactic background;
- ordinary black body + dark-magenta hint field;
- semantic RGB565 tones: TITLE `F81F`, BODY `FFB8`, ACTION `C618`, WHITE `FFFF`, CYAN `07FF`;
- deterministic renderer tests and framebuffer hashes;
- `mouse-ui-render-probe` for optional 240×240 PPM evidence;
- renderer documentation and updated build/test instructions;
- architecture guard extended to renderer files and renderer downward-dependency rules.

## Architecture boundary

~~~text
mouse_ui_renderer
      ↓
mouse_ui_domain
~~~

The renderer has no dependency on app, interaction, SDL, screen IDs, navigation, profiles, mocks, Bluetooth, USB, or persistence.

## Deterministic fixtures

Normal representative frame:

- includes TITLE, ACTION, WHITE, CYAN;
- ordinary body geometry;
- `hint_row=7` with boundary y=177 and hint rows y=188/y=214;
- framebuffer hash: `a6e38efd9c0561dd`.

Didactic representative frame:

- full dark-magenta background;
- didactic 25 px row spacing;
- framebuffer hash: `7f9297c7748aec05`.

These are generic renderer fixtures, not implementations of MBR screens.

## GitHub Actions evidence

- workflow: `mouse-ui CI`;
- run: `35566198419`;
- head: `4daa0963e476eebd61cd7049b43cba582413144a`;
- overall conclusion: **success**;
- `host-debug` job `106228388358`: **success**;
- `host-asan-ubsan` job `106228388499`: **success**.

Both jobs reported:

~~~text
foundation_contract                     Passed
renderer_contract                       Passed
architecture_guard                      Passed
architecture_guard_forbidden_fixture    Passed
100% tests passed, 0 tests failed out of 4
~~~

No ASan/UBSan finding was reported.

## Automated acceptance mapping

- [x] 240×240 framebuffer size/format and bounded read/write;
- [x] glyph/palette/geometry/background tests;
- [x] normal/didactic deterministic hashes;
- [x] no SDL dependency in renderer; architecture guard green.

## Human visual acceptance — PASS

On Debian:

~~~bash
git fetch origin
git switch mui/mui-01-renderer
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
mkdir -p build/ppm
./build/mouse-ui-render-probe build/ppm
xdg-open build/ppm/mui-01-normal.ppm
xdg-open build/ppm/mui-01-didactic.ppm
~~~

Expected terminal hashes:

~~~text
normal hash:   a6e38efd9c0561dd
didactic hash: 7f9297c7748aec05
~~~

On 2026-09-21 the operator explicitly accepted the gate after running the Debian flow. Reported terminal evidence:

~~~text
100% tests passed, 0 tests failed out of 4
normal hash:   a6e38efd9c0561dd
didactic hash: 7f9297c7748aec05
PPM evidence written to build/ppm
~~~

The PPM evidence was reviewed as part of the gate acceptance. The candidate was then promoted to `mouse-ui/main`.

Human review criteria were:

1. normal fixture: magenta title, gray actions, white selected row, cyan connected row, black body field, dark-magenta hint field;
2. title begins near x=7/y=8 and first body row near y=39;
3. hint rows are bottom anchored with no overlap/cutoff;
4. didactic fixture has dark-magenta background to all four edges;
5. 5×7 doubled glyphs are legible and consistent with the predecessor baseline.

## Out of scope / not claimed

- no screen projector or canonical 30-screen inventory;
- no navigation/interaction behavior beyond MUI-00 foundation;
- no mock world;
- no SDL desktop shell, scale, or backlight;
- no backend/physical display behavior.

## Rollback

If rejected, abandon `mui/mui-01-renderer` and return to accepted MUI-00 `f0007cb7f5c19543238b564b0295256e57fec3aa`.
