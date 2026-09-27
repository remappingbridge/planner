# MUI-01 — RGB565 Renderer

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-01-renderer`, commit `4daa0963e476eebd61cd7049b43cba582413144a`.

Evidence: `../executions/mui-01/candidate.md`.

## Objective

Implement a deterministic platform-independent renderer for the 240×240 product surface, preserving the MBR-08 visual baseline without navigation/backend logic.

## Dependencies

MUI-00 **ACCEPTED** at `f0007cb7f5c19543238b564b0295256e57fec3aa`.

## Tasks

1. Implement canonical RGB565 framebuffer clear/write primitives.
2. Port/verify required 5×7 glyph set and doubled-pixel text geometry.
3. Implement semantic tones/palette and MBR-08 title/body/hint geometry.
4. Support full didactic dark-magenta backgrounds and ordinary hint-region background rules.
5. Keep renderer input semantic; renderer must not know screen navigation or product operations.
6. Add deterministic framebuffer hashing and optional PPM dump utility for human debugging.
7. Add renderer tests for coordinates, clipping, palette, glyphs, backgrounds, and known frames.

## Deliverables

- pure C `mouse_ui_renderer` library
- `renderer_contract` tests
- `mouse-ui-render-probe` host PPM/hash utility
- `docs/development/renderer.md`

## Automated acceptance

- [x] 240×240 framebuffer size/format contract passes
- [x] canonical glyph/palette/geometry tests pass
- [x] known semantic frames produce stable expected hashes
- [x] renderer compiles/tests with no SDL dependency

Automated evidence: GitHub Actions run `35566198419`; both `host-debug` and `host-asan-ubsan` passed 4/4 CTest contracts including `renderer_contract` and the architecture guards.

Locked representative hashes:

- normal frame: `a6e38efd9c0561dd`;
- didactic frame: `7f9297c7748aec05`.

## Human acceptance

- [x] review representative title/body/hint/didactic PPM output for visual correctness

Generate with:

~~~bash
git fetch origin
git switch mui/mui-01-renderer
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
mkdir -p build/ppm
./build/mouse-ui-render-probe build/ppm
~~~

Then inspect `build/ppm/mui-01-normal.ppm` and `build/ppm/mui-01-didactic.ppm`.

Human acceptance was reported on 2026-09-21 after the Debian run produced `100% tests passed, 0 tests failed out of 4`, hashes `a6e38efd9c0561dd` / `7f9297c7748aec05`, and the PPM evidence was written successfully. The gate was explicitly accepted and the candidate was promoted to `mouse-ui/main`.

## Forbidden scope

- screen navigation
- mock backend state
- SDL scale/backlight
- screen-specific product logic inside renderer

Candidate review confirms the renderer consumes only a generic 9×21 semantic frame (`character + tone`, `hint_row`, `didactic`) and has no screen enum, navigation, profile, mock, or SDL dependency.

## Rollback / rebuild point

Keep semantic/render tests; if renderer structure becomes screen-specific, rebuild from accepted MUI-00 `f0007cb7f5c19543238b564b0295256e57fec3aa` plus the MUI-01 test vectors.
