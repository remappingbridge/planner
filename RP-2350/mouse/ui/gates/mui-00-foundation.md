# MUI-00 — Foundation

Status: **ACCEPTED**.

Accepted candidate: `remappingbridge/mouse-ui` branch `mui/mui-00-foundation`, commit `f0007cb7f5c19543238b564b0295256e57fec3aa`.

Promoted to `mouse-ui/main` on 2026-09-21 after automated and Debian human verification.

Evidence: `../executions/mui-00/candidate.md`.

## Objective

Create the minimum clean C11 frontend architecture and testable build skeleton without implementing product screens or backend behavior.

## Dependencies

Active `mouse-ui/docs` architecture/process baseline.

## Tasks

1. Create CMake project with explicit frontend libraries/modules rather than one monolithic executable.
2. Establish pure core types: logical 240×240 RGB565 framebuffer, bounded strings/capacities, semantic control/event identifiers, explicit app/context ownership.
3. Define module dependency direction and include boundaries so SDL/backend types cannot leak into core headers.
4. Create host unit-test harness and deterministic test entry points.
5. Enable strict host warnings and Debug sanitizer configuration where supported.
6. Create CI host build/test job(s) for normal Debug plus sanitizers where practical.
7. Add architecture checks for forbidden dependencies/includes at the frontend boundary.
8. Document exact developer build/test commands.

## Deliverables

- `mouse-ui` CMake build with core/test targets.
- Empty/placeholder framebuffer path that proves module composition.
- CI and architecture tests.
- Developer build documentation.

## Automated acceptance

- [x] clean configure/build on supported Debian/CI toolchain
- [x] unit test harness executes successfully
- [x] architecture guard rejects an intentional forbidden SDL/core dependency fixture or equivalent contract test
- [x] ASan/UBSan configuration runs without findings on baseline tests where supported

Automated evidence: GitHub Actions run `35565090706`, both host jobs successful; 3/3 CTest contracts passed.

## Human acceptance

- [x] build/run instructions are understandable and reproducible on Debian
- [x] module layout matches documented responsibility boundaries

On 2026-09-21 the operator executed the documented Debian flow and reported `100% tests passed, 0 tests failed out of 3`, followed by the exact expected foundation probe including framebuffer hash `2d9ab45bcfc84b25`. The candidate structure was re-reviewed against the documented `domain -> interaction -> app` dependency direction before promotion.

## Forbidden scope

- SDL product shell functionality beyond a minimal compile probe
- real MBR screens/navigation
- BLE/USB/storage/Core implementation
- public UI↔Core contract release

None of the forbidden scopes were introduced.

## Rollback / rebuild point

Documentation-only baseline: `mouse-ui@ecfe89918813269783269a66734cdf0aa29a0539`. Accepted MUI-00 baseline: `f0007cb7f5c19543238b564b0295256e57fec3aa`.
