# MUI-06 — SDL2 Desktop Laboratory

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-06-desktop-lab`, commit `c621fd538c515fa9591eb80afaf6130dfe6a7add`.

Evidence: `../executions/mui-06/candidate.md`.

## Objective

Deliver the C-only Debian desktop application around the pure frontend core, including the dark development shell, requested visual controls, and precise semantic element inspection.

## Dependencies

MUI-05 **ACCEPTED** at `acdce2b26d661b9855a3220d5c95858eab1fb3ad`.

## Implemented scope

1. SDL2 is confined to the desktop executable/font adapter under `src/platform/desktop`; pure domain, interaction, mock, projector, renderer, navigation, and desktop-support calculations remain SDL-free.
2. Dark high-contrast development shell distinct from the product framebuffer.
3. Logical RGB565 240×240 framebuffer presented through an ARGB8888 SDL texture with nearest-neighbor scaling.
4. Exact scale presets: 75%, 100%, 125%, 150%, 200%, 300%.
5. Virtual backlight 0–1000%, slider plus 0/100/300/500/750/1000 presets.
6. Lock forces effective presentation gain to 0 without modifying the selected gain or logical framebuffer.
7. Keyboard HAT mappings and clickable HAT controls emit separate PRESS/RELEASE events.
8. Editable virtual Mouse name/ID, CONNECT/DISCONNECT, +1/+8/+15 seconds, HOME, REBOOT, FACTORY RESET, and pending-operation success/failure controls.
9. State panel and rolling semantic event log.
10. Semantic element Inspector with pointer hit-test, Tab/Shift+Tab traversal, shell-side outline, metadata panel, and Ctrl+C / button copy of compact bug reference.
11. Inspector overlay is drawn after LCD texture presentation and never mutates the RGB565 framebuffer.
12. F12 / button PPM capture of the raw logical framebuffer.
13. SDL-free desktop-support tests for scale, gain, hit-testing, reference formatting, and framebuffer immutability.

## Deliverables

- `mouse-ui` C/SDL2 Debian desktop executable;
- `mouse-ui_desktop_support` SDL-free testable presentation/inspection library;
- dark shell, virtual LCD/HAT, state/log panels, mock controls;
- semantic Inspector and copyable bug reference;
- deterministic PPM capture;
- `desktop_support_contract` and SDL dummy-driver smoke;
- updated README/build/desktop-shell documentation.

## Automated acceptance

- [x] desktop builds without SDL leaking into core libraries
- [x] all six scale presets produce expected presented dimensions
- [x] backlight covers 0–1000%, saturates presentation channels, preserves black, and leaves logical hashes unchanged
- [x] Lock effective backlight = 0 and unlock restores selected gain
- [x] inspector resolves semantic IDs/bounds from projector metadata rather than pixels/OCR
- [x] inspector overlay does not change framebuffer hashes
- [x] compact bug reference format is deterministic

Final CI run `35569942173`, head `c621fd538c515fa9591eb80afaf6130dfe6a7add`, completed successfully in both `host-debug` and `host-asan-ubsan`. Both jobs reported 9/9 CTest contracts passing and `mouse-ui MUI-06 SDL smoke PASS: 300%=720x720`. No sanitizer finding was reported.

## Human acceptance

- [x] dark shell is comfortable/readable on Debian desktop
- [x] at 300% scale the 240×240 LCD presents as 720×720 without smoothing
- [x] all required controls can be operated without physical hardware
- [x] bug can be cited unambiguously using `screen=<id> element=<id>` from inspector

Explicit operator acceptance was recorded on 2026-09-21: "gates 6 e 7 aceitos".

Run on Debian:

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

Expected automated results:

~~~text
100% tests passed, 0 tests failed out of 9
mouse-ui MUI-06 SDL smoke PASS: 300%=720x720
~~~

During the interactive review, exercise scale/backlight, keyboard and clickable HAT, virtual Mouse CONNECT/DISCONNECT, deterministic time controls, Lock/unlock, operation success/failure, Inspector traversal/hit-test/copy, and framebuffer capture.

## Forbidden scope

- real backend connection
- web/JavaScript frontend
- product LCD GPIO/SPI adapter
- new UX redesign beyond baseline

Candidate review confirms none of these scopes were introduced.

## Rollback / rebuild point

If the SDL shell becomes coupled to product logic or proves difficult to maintain, abandon `mui/mui-06-desktop-lab` and return to accepted MUI-05 `acdce2b26d661b9855a3220d5c95858eab1fb3ad`. Retain the SDL-free desktop-support tests and rebuild `src/platform/desktop` independently.
