# mouse-ui roadmap — MUI-00 through MUI-08

Objective: reach a clean, C-only desktop frontend that reproduces the MBR-08 UX baseline and is safe to evolve or rebuild.

| Gate | Name | Primary result | Depends on |
|---|---|---|---|
| MUI-00 | Foundation | C11/CMake architecture, bounded core types, CI/test skeleton | docs baseline |
| MUI-01 | Renderer | deterministic 240×240 RGB565 renderer + glyph/palette geometry | MUI-00 |
| MUI-02 | Interaction | semantic HAT press/release, epoch ownership, Lock interaction primitives | MUI-00 |
| MUI-03 | Mock World | deterministic product-view model, intents/results, virtual clock/scenario engine | MUI-00 |
| MUI-04 | Screen Projection | all 30 baseline screens, dynamic fields, stable element IDs/bounds, semantic goldens | MUI-01..03 |
| MUI-05 | Navigation & UX Flows | HOME/Profile/Custom/Saved/Pair/Help/Lock end-to-end state flows | MUI-04 |
| MUI-06 | SDL2 Desktop Lab | dark shell, scale, 0–1000% backlight, virtual HAT, inspectors, event/state panels | MUI-05 |
| MUI-07 | Scenario & Bug Lab | scenario catalog, fault injection, evidence capture/export, deterministic regression flows | MUI-06 |
| MUI-08 | Baseline Parity | complete MBR-08 frontend parity review, cleanup, docs/test freeze, accepted baseline tag | MUI-07 |

## Sequencing rule

Do not mix UX redesign with the reconstruction program unless a blocking ambiguity requires an explicit decision. MUI-08 establishes the clean baseline; exploratory redesign begins afterward.

## Acceptance vocabulary

- `NOT STARTED` — no candidate implementation;
- `IN PROGRESS` — implementation underway;
- `AUTOMATED PASS` — machine criteria green, human criteria unresolved where applicable;
- `HUMAN PASS` — requested human visual/navigation acceptance recorded;
- `ACCEPTED` — gate baseline accepted and suitable as dependency;
- `REJECTED/REBUILD` — behavior or architecture must be retried from a clean point.

No gate is accepted merely because a later gate exists.

## Program completion

MUI-00 through MUI-08 are **ACCEPTED** as of 2026-09-21.

Accepted frontend baseline:

~~~text
remappingbridge/mouse-ui
main @ 537b0f6fdd188b283cf10648b1cc6dbdacbfe20d
baseline/mui-08-accepted @ same commit
~~~

There is no planned MUI-09 reconstruction gate. Post-baseline UX work uses `lab/*`, `candidate/*`, and `rebuild/*` branches from the accepted baseline.

## UI Layout 1.0 product freeze — 2026-09-22

The final post-MUI UX corrections were merged via PR #2, then business/architecture documentation and version metadata were frozen on main.

~~~text
behavior merge: 65c2040f71dd68bd054fc9c3aa24d47d53e58ead
final freeze:   e8adad7919e931c92515bf655ef4050876a8e7a9
stable ref:     release/ui-layout-v1.0
CI:             35682121924
result:         13/13 PASS in Debug and ASan/UBSan
~~~

This closes UI layout work for version 1.0. The next product program is UIC under `mouse/contracts/`.
