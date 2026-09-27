# MUI-06 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-06-desktop-lab`;
- base: accepted MUI-05 `acdce2b26d661b9855a3220d5c95858eab1fb3ad`;
- desktop-support foundation: `ebda83ff7c0b54a26c684b9deacffd683165c786`;
- SDL shell implementation: `4fdf5e6bcda060aa20e278934b63cf8cf4a5821d`;
- final candidate after CI/CMake normalization: `c621fd538c515fa9591eb80afaf6130dfe6a7add`.

## Architecture

~~~text
domain / interaction / mock / projector / renderer / navigation
                         ↓
           SDL-free desktop support
          scale / gain / hit-test / refs / PPM
                         ↓
              platform/desktop SDL2
              window / texture / input
              controls / panels / overlay
~~~

SDL2 is linked only by the `mouse-ui` desktop executable. The public desktop-support header and support implementation are guarded against SDL symbols/includes, while existing architecture guards continue to reject SDL from pure/core frontend layers.

## Desktop presentation

- product framebuffer remains 240×240 RGB565;
- SDL texture is 240×240 ARGB8888 and is presented nearest-neighbor;
- presets map 75/100/125/150/200/300% to 180/240/300/360/480/720 pixels;
- default scale is 300%;
- selected backlight defaults to 300%;
- gain range is 0–1000%;
- black remains black and channels saturate at 255;
- Lock makes effective gain 0 while preserving selected gain.

## Interaction and mock controls

Keyboard mappings:

~~~text
Arrows      -> JOY directions
Enter/Space -> JOY PRESS
A/B/X/Y     -> HAT A/B/X/Y
~~~

Clickable virtual HAT buttons send separate mouse-down PRESS and mouse-up RELEASE semantic events. SDL key repeats are ignored.

The shell exposes editable virtual Mouse name, Mouse ID +/- controls, CONNECT, DISCONNECT, +1/+8/+15 seconds, HOME, REBOOT, FACTORY RESET, and immediate OP SUCCESS / OP FAIL result injection for pending semantic operations.

## State and event inspection

The shell state panel displays current screen, virtual clock, Lock, saved/current Mouse, search purpose/status, operation kind/status, scale, selected backlight, and effective backlight.

A rolling event log records recent HAT PRESS/RELEASE and laboratory actions.

## Semantic Inspector

The Inspector uses MUI-04 `mui_element_t` metadata directly:

- pointer hover/click hit-tests logical bounds;
- Tab/Shift+Tab cycles semantic elements;
- selected element gets a yellow shell-side outline;
- metadata panel shows ID, role, state, bounds, text;
- Ctrl+C or `COPY REF` copies a deterministic compact reference such as `screen=home-connected element=menu.remap-summary state=selected bounds=...`;
- no OCR/pixel inference is used.

The outline is drawn after the product LCD texture is copied to the SDL renderer. Desktop-support tests verify inspection/reference operations leave the logical framebuffer hash unchanged.

## Capture

`CAPTURE PPM` and F12 write the raw logical product framebuffer to `mouse-ui-capture.ppm`. The capture excludes shell chrome, backlight gain, and Inspector outline by design.

## Automated tests

`desktop_support_contract` verifies:

- all scale dimensions;
- 0–1000 gain clamping and Lock effective gain;
- black preservation and saturation;
- dark-magenta 300% presentation conversion;
- topmost semantic bounds hit-test;
- deterministic state vocabulary/reference formatting;
- Inspector operations do not mutate framebuffer hash.

## CI history

The first desktop-support-only commit passed its own CI. During SDL shell integration, workflow/CMake text-composition issues were corrected before candidate acceptance. They did not represent product/frontend behavior failures.

Final verification:

- workflow run: `35569942173`;
- head: `c621fd538c515fa9591eb80afaf6130dfe6a7add`;
- `host-debug`: **success**;
- `host-asan-ubsan`: **success**.

Both jobs reported:

~~~text
desktop_support_contract                Passed
100% tests passed, 0 tests failed out of 9
mouse-ui MUI-06 SDL smoke PASS: 300%=720x720
~~~

No AddressSanitizer/UndefinedBehaviorSanitizer finding was reported.

## Human desktop review — accepted

Run:

~~~bash
sudo apt update
sudo apt install -y build-essential cmake git pkg-config libsdl2-dev
git fetch origin
git switch mui/mui-06-desktop-lab
git pull
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui --smoke
./build/mouse-ui
~~~

Review shell readability, 300%=720×720 nearest-neighbor presentation, all six scale presets, backlight presets/slider through 1000%, Lock selected/effective gain behavior, keyboard/on-screen HAT PRESS/RELEASE, virtual Mouse and time controls, operation success/failure injection, state/event panels, Inspector pointer and Tab traversal, Ctrl+C bug reference, and PPM capture.

## Out of scope / not claimed

- no Bluetooth/backend implementation;
- no web/JavaScript frontend;
- no RP2350/ST7789/GPIO/SPI adapter;
- no new product UX redesign;
- no MUI-07 named scenario/fault laboratory yet.

## Rollback

If rejected, abandon `mui/mui-06-desktop-lab` and return to accepted MUI-05 `acdce2b26d661b9855a3220d5c95858eab1fb3ad`. The pure tests and accepted MUI-00–05 assets remain valid.

## Downstream provisional work

MUI-07 was implemented provisionally on top of this exact candidate after explicit operator instruction to continue. This does **not** constitute MUI-06 acceptance. If MUI-06 is rejected, MUI-07 must be rebased/revalidated rather than promoted as-is.

## Acceptance record

On 2026-09-21 the operator explicitly accepted MUI-06 together with MUI-07 (`gates 6 e 7 aceitos`). The accepted dependency chain was then promoted through MUI-07 on `mouse-ui/main`.
