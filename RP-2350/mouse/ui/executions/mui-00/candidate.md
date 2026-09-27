# MUI-00 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-00-foundation`;
- base: `ecfe89918813269783269a66734cdf0aa29a0539` (`main` at gate start);
- candidate commit: `f0007cb7f5c19543238b564b0295256e57fec3aa`;
- commit message: `MUI-00: establish C11 frontend foundation`.

## Implemented scope

- C11/CMake project split into `mouse_ui_domain`, `mouse_ui_interaction`, and `mouse_ui_app` libraries;
- explicit `mui_app_t` application context rather than hidden global mutable state;
- fixed 240×240 RGB565 framebuffer (`57600` pixels / `115200` bytes);
- bounded 64-byte frontend string type with explicit truncation result;
- semantic JOY/KEY control IDs plus PRESS/RELEASE event phase and deterministic sequence field;
- minimal interaction observation/context composition only; MUI-02 press/release ownership behavior remains out of scope;
- foundation executable `mouse-ui` that initializes the app and reports framebuffer contract/hash;
- strict GCC/Clang warnings: `-Wall -Wextra -Wpedantic -Wshadow -Werror`;
- optional host ASan + UBSan build via `MUI_ENABLE_SANITIZERS=ON`;
- CTest harness;
- architecture guard for forbidden platform/backend tokens and upward layer dependencies;
- intentional `SDL2/SDL.h` negative fixture, configured as a CTest `WILL_FAIL` contract;
- GitHub Actions matrix for normal Debug and ASan/UBSan;
- exact Debian build/test instructions in `docs/development/build-and-test.md`.

## Architecture boundary

Current dependency direction:

~~~text
mouse_ui_domain
      ↓
mouse_ui_interaction
      ↓
mouse_ui_app
~~~

The core guard rejects references to SDL, BTstack, TinyUSB, CYW43, Pico SDK, GPIO, SPI, and flash implementation tokens. It also rejects `domain -> interaction/app` and `interaction -> app` upward dependencies.

SDL2 was **not** introduced as a runtime dependency. The only SDL source token is the intentional forbidden fixture proving the guard detects it.

## Local pre-commit validation

Validated in a clean temporary host tree with GCC 14.2.0.

Normal Debug:

~~~text
foundation_contract                     PASS
architecture_guard                      PASS
architecture_guard_forbidden_fixture    PASS
100% tests passed, 0 failed out of 3

mouse-ui MUI-00 foundation
logical LCD: 240x240 RGB565
framebuffer pixels: 57600
placeholder hash: 2d9ab45bcfc84b25
~~~

ASan/UBSan build repeated the same 3/3 PASS and probe output with no sanitizer finding.

During pre-commit validation, strict compilation caught missing explicit `<stddef.h>` includes for `NULL` in two source files. These were corrected before the candidate commit; the committed candidate was then rebuilt/tested from clean build directories.

## GitHub Actions evidence

- workflow: `mouse-ui CI`;
- run: `35565090706`;
- head: `f0007cb7f5c19543238b564b0295256e57fec3aa`;
- overall conclusion: **success**;
- job `host-debug` (`106225198086`): **success**;
- job `host-asan-ubsan` (`106225198279`): **success**.

Both jobs reported:

~~~text
foundation_contract                     Passed
architecture_guard                      Passed
architecture_guard_forbidden_fixture    Passed
100% tests passed, 0 tests failed out of 3
~~~

Both probes reported the deterministic black placeholder framebuffer hash:

`2d9ab45bcfc84b25`

## Automated acceptance mapping

- [x] clean configure/build — local Debug + GitHub `host-debug`;
- [x] unit test harness — `foundation_contract`;
- [x] forbidden dependency fixture rejected — `architecture_guard_forbidden_fixture` succeeds because rejection is expected;
- [x] ASan/UBSan — local sanitized build + GitHub `host-asan-ubsan`, no findings.

## Human acceptance — PASS

Run on the intended Debian workstation:

~~~bash
git fetch origin
git switch mui/mui-00-foundation
rm -rf build build-sanitize
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui

cmake -S . -B build-sanitize -DCMAKE_BUILD_TYPE=Debug -DMUI_ENABLE_SANITIZERS=ON
cmake --build build-sanitize --parallel
ctest --test-dir build-sanitize --output-on-failure
./build-sanitize/mouse-ui
~~~

Expected probe:

~~~text
mouse-ui MUI-00 foundation
logical LCD: 240x240 RGB565
framebuffer pixels: 57600
placeholder hash: 2d9ab45bcfc84b25
desktop shell: not implemented (MUI-06)
~~~

On 2026-09-21 the operator ran the documented Debian commands and reported `100% tests passed, 0 tests failed out of 3` and the exact expected probe/hash `2d9ab45bcfc84b25`. The module dependency direction was re-reviewed against the accepted architecture and found consistent. MUI-00 was then promoted to `mouse-ui/main`.

## Out of scope / not claimed

- no SDL desktop UI;
- no renderer/glyph implementation beyond framebuffer primitives;
- no MBR screen projections;
- no navigation state machine;
- no semantic mock world;
- no BLE/USB/storage/HID++ code;
- no UI↔Core public contract release;
- no physical hardware claim.

## Rollback

If rejected, abandon `mui/mui-00-foundation` and return to `mouse-ui@ecfe89918813269783269a66734cdf0aa29a0539`. No backend or persistent product state is involved.
