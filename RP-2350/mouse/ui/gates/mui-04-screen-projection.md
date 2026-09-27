# MUI-04 — Screen Projection & Inspectable Elements

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-04-screen-projection`, commit `8aed51e00eaadff351e77778f92646ec155bae9d`.

Evidence: `../executions/mui-04/candidate.md`.

## Objective

Reproduce all 30 MBR-08 baseline screens as semantic projections with dynamic fields, stable inspectable element IDs, logical bounds, readable golden tests, and locked renderer hashes.

## Dependencies

MUI-01, MUI-02, and MUI-03 are **ACCEPTED**. Candidate is based on accepted MUI-03.

## Tasks

1. Define the 30 baseline screen IDs/families from active `mouse-ui/docs/spec`.
2. Implement screen-family definitions and data-driven rows where practical; avoid a monolithic screen-specific application/navigation state machine.
3. Project exact baseline literals/dynamic name/profile/status values and semantic tones.
4. Implement HOME 15-character + conditional standalone `MOUSE` suffix rule and Saved Devices 21-character rule.
5. Define stable semantic element IDs/roles for meaningful titles/options/status/hints/custom rows.
6. Attach logical 240×240 bounds and state/tone metadata to inspectable elements before rendering.
7. Implement semantic golden format readable in text diffs.
8. Assert element IDs are unique within a projected screen and stable across selection/tone changes.
9. Render all projected frames through MUI-01 and lock deterministic framebuffer hashes.

## Deliverables

- pure `mouse_ui_projector` library;
- canonical 30-screen ID/template inventory split into screen families;
- 270-line semantic golden file `tests/goldens/mui-04/screens.txt`;
- 30-screen locked hash manifest `tests/goldens/mui-04/hashes.txt`;
- stable inspectable element metadata: ID, role, logical bounds, text, tone, state flags, row/column;
- `mouse-ui-screen-probe` generating 30 PPMs, a 5×6 matrix, semantic rows, element inventory, and hash manifest;
- `docs/development/screen-projection.md`.

## Automated acceptance

- [x] all 30 baseline screens project
- [x] exact required baseline literals/dynamic rules pass
- [x] semantic goldens pass
- [x] inspectable elements expose stable unique IDs and valid logical bounds
- [x] selected/pressed white priority and active/connected cyan baseline rules pass
- [x] all canonical projected frames render deterministically against locked hashes

Initial capture run `35567838662` passed 7/7 tests and emitted all 30 canonical hashes. Those values were then committed as an independent manifest. Verification run `35567930111` passed 7/7 tests in both `host-debug` and `host-asan-ubsan`, proving the projector matches the locked semantic rows and RGB565 hashes.

## Human acceptance

- [x] review generated screen matrix/PPMs for clipping, color, full didactic backgrounds, and readability
- [x] review element ID vocabulary for bug-report usefulness

Run on Debian:

~~~bash
git fetch origin
git switch mui/mui-04-screen-projection
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure

mkdir -p build/mui04
./build/mouse-ui-screen-probe build/mui04
xdg-open build/mui04/mui-04-matrix.ppm
~~~

Useful ID review commands:

~~~bash
grep '^home-connected|' build/mui04/elements.txt
grep '^remapper-options|' build/mui04/elements.txt
grep '^custom-edit|' build/mui04/elements.txt
grep '^saved-devices|' build/mui04/elements.txt
grep '^searching-first|' build/mui04/elements.txt
~~~

Review especially the stable IDs `menu.remap-summary`, `saved.status`, `saved.profile`, `saved.remove`, `custom.row.*`, `profile.*`, `target.*`, and `didactic.*`. Bounds must remain in logical 240×240 coordinates and should be useful in bug reports.

## Forbidden scope

- end-to-end navigation
- SDL inspector UI
- UX redesign beyond ambiguity fixes
- backend implementation

Candidate review confirms these scopes remain outside MUI-04. Projection state is manually supplied; MUI-05 will own navigation transitions.

## Rollback / rebuild point

Goldens, element IDs, and locked hashes are durable assets. If projector structure becomes condition-heavy or crosses navigation boundaries, rebuild by screen family from accepted MUI-03 `fe7acaa5059dcc8e489e031082c57f938dff59ec` using these fixtures.

Acceptance record: on 2026-09-21 the operator reran `mouse-ui-screen-probe` on Debian and supplied all 30 canonical hashes. Every value matched the locked MUI-04 manifest exactly. The operator instructed the process to advance if the candidate was correct; this was treated as acceptance of the visual/ID gate and the candidate was promoted to `mouse-ui/main` before MUI-05 began.
