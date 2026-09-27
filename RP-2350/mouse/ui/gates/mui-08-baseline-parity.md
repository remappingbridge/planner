# MUI-08 — Clean MBR-08 Frontend Baseline

Status: **ACCEPTED**.

## Objective

Prove that the new C frontend reproduces the intended MBR-08 UX baseline, clean architectural boundaries, and desktop laboratory features; then establish the baseline from which UX exploration can safely diverge.

## Dependencies

MUI-07 ACCEPTED.

## Tasks

1. Run complete automated suite: architecture, interaction, mock, semantic projection, renderer, navigation scenarios, desktop presentation calculations, inspector/evidence contracts, sanitizers.
2. Generate/review the complete 30-screen matrix at baseline scale/backlight reference.
3. Exercise all major user-observable baseline flows through the C desktop application.
4. Compare active specs against implementation and resolve any undocumented divergences.
5. Review dependency graph for SDL/core/mock/projector/renderer leakage.
6. Review special-case density and rebuild any area that already violates clean-module criteria.
7. Record exact build toolchain, candidate commit, artifacts, hashes, known limitations, and human visual/navigation results.
8. Update active documentation only for explicitly accepted baseline clarifications.
9. Create an accepted baseline tag after approval; do not start UX redesign before baseline status is clear.

## Deliverables

- [x] accepted C-only MBR-08 frontend baseline
- [x] complete evidence record
- [x] clean architecture review
- [x] baseline executable/artifact
- [x] stable baseline ref/commit suitable as base for `lab/*` experiments

## Automated acceptance

- [x] all automated tests green
- [x] sanitizers clean where supported
- [x] all 30 screens covered by semantic + renderer regression
- [x] all requested scale/backlight/inspector desktop requirements verified
- [x] no backend/SDL leakage across documented boundaries
- [x] documentation and code inventory agree

Accepted baseline: `remappingbridge/mouse-ui@537b0f6fdd188b283cf10648b1cc6dbdacbfe20d` on `main` and `baseline/mui-08-accepted`.

Final CI run `35573134854` passed both Debug and ASan/UBSan with **12/12 tests**. The debug job generated and uploaded the complete baseline evidence artifact, including the raw 30-screen evidence and the 200%/750% presentation matrix.

## Human acceptance

- [x] consolidated 30-screen baseline accepted
- [x] first use, HOME, Pair New, profiles, Custom, Saved Devices, Help and Lock baseline accepted
- [x] inspector/evidence workflow accepted
- [x] startup defaults **200% scale / 750% backlight** accepted

Explicit operator acceptance recorded on 2026-09-21: "gate 8 aceito".

## Forbidden scope

- new post-MBR-08 UX redesign
- mouse-core implementation
- public contract v1 release
- embedded ST7789 integration

## Rollback / rebuild point

If parity is achieved with unhealthy architecture, do not accept. Rebuild the offending module/gate from the latest clean accepted dependency and rerun parity.

