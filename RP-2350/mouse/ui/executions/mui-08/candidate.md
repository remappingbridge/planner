# MUI-08 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-08-baseline-parity`;
- accepted base: MUI-07 `8694ae242e81fe2f74b00efede90962d8701161b`;
- baseline implementation/manual commit: `a19e4fc5070cd1f26d91cb80d0995eda66052622`;
- final parity/documentation cleanup: `3154916ba7d01a7c916c22f8ae67d8e99c32bc99`;
- acceptance/documentation commit: `537b0f6fdd188b283cf10648b1cc6dbdacbfe20d`.

## Requested final desktop defaults

~~~text
Scale:     200% -> 480x480
Backlight: 750%
~~~

These defaults are compile-time constants in desktop support and are asserted by `desktop_support_contract`, `baseline_contract`, the SDL smoke, the documentation inventory guard, and the definitive root README/manual.

## Frozen frontend inventory

- 30 canonical screens;
- 15 named deterministic scenarios;
- logical LCD 240×240 RGB565;
- scale presets 75/100/125/150/200/300%;
- virtual backlight 0–1000%;
- dark SDL2 shell;
- semantic HAT PRESS/RELEASE;
- Help/Lock/Profile/Custom/Saved/Pair flows;
- semantic Inspector and stable element IDs;
- scenario/fault laboratory;
- scenario-aware compact bug references;
- TXT/JSON/PPM evidence bundles.

## New MUI-08 automated contracts

`baseline_contract` verifies:

- exact 30-screen inventory;
- exact 15-scenario inventory;
- all 30 screens project, validate semantic elements, render, and hash nonzero;
- every named scenario initializes deterministically twice;
- default scale 200% => 480×480;
- default backlight 750%;
- Lock forces effective backlight 0;
- backlight maximum remains 1000%.

`documentation_inventory` verifies that the definitive Portuguese user manual and technical desktop/evidence documentation agree with the implemented defaults and inventory.

## Complete matrix evidence

`mouse-ui-baseline-probe` generates a nearest-neighbor 5×6 matrix of all 30 screens using the actual desktop startup presentation defaults:

~~~text
mui-08-default-200pct-750pct.ppm
~~~

`mouse-ui-screen-probe` separately preserves raw 240×240 evidence for every screen plus semantic rows, inspectable element metadata, framebuffer hashes, and the raw 5×6 matrix.

## Architecture review

No rebuild trigger was found during MUI-08 review:

- SDL remains confined to the desktop executable/font adapter;
- renderer does not own navigation semantics;
- projector owns product meaning and inspectable elements;
- navigation owns UX transitions and observable async state;
- mock remains semantic and contains no Bluetooth/USB/storage implementation;
- desktop-support is SDL-free and owns only scale/gain/hit-test/reference/PPM helpers;
- lab is SDL-free and owns scenarios/faults/evidence;
- architecture guards continue rejecting platform/backend leakage.

Special cases remain in the layers that own their semantics; no evidence justified a rebuild before baseline freeze.

## Documentation reconciliation

The root `README.md` is now the definitive Portuguese user manual. It includes:

- installation/build/run;
- default 200% zoom and 750% backlight;
- keyboard/HAT controls;
- scale/backlight/Lock behavior;
- Mouse/time controls;
- all 15 scenarios;
- fault injection;
- Inspector/COPY REF;
- evidence TXT/JSON/PPM;
- recommended flow tests;
- raw and presented 30-screen matrix generation;
- complete baseline verification commands;
- hardware/backend scope boundary.

A stale developer instruction that mislabeled `./build/mouse-ui` as the historical foundation probe was corrected; the foundation executable is now correctly documented as `./build/mouse-ui-foundation-probe`.

## Final CI

- workflow run: `35573134854`;
- head: `3154916ba7d01a7c916c22f8ae67d8e99c32bc99`;
- `host-debug`: success;
- `host-asan-ubsan`: success;
- CTest: `100% tests passed, 0 tests failed out of 12`;
- `baseline_contract`: PASS;
- `documentation_inventory`: PASS;
- SDL smoke: `mouse-ui MUI-08 SDL smoke PASS: default=200% 480x480 backlight=750%`;
- baseline probe: PASS;
- sanitizers: no reported finding.

## CI artifact

- artifact id: `10627026415`;
- SHA-256 of uploaded artifact ZIP: `baeb7c5939c5b337a5f035dd7bee1d87f123bcb29904979cdcd74f51d6934844`;
- run artifact URL: `https://github.com/remappingbridge/mouse-ui/actions/runs/35573134854/artifacts/10627026415`.

The artifact contains the default 200%/750% presentation matrix, screen evidence directory, baseline output, scenario trace, and navigation trace.

## Human review — accepted

Run:

~~~bash
git fetch origin
git switch mui/mui-08-baseline-parity
git pull
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/mouse-ui-baseline-probe build/mui08
./build/mouse-ui
~~~

Confirm startup at **200% / 750%**, inspect representative screen families including 300% scale, and exercise first use, HOME, Pair New, profiles, Custom, Saved Devices, Help and Lock. MUI-06/MUI-07 acceptance already establishes the desktop/scenario tooling; this review closes the consolidated baseline.

## Promotion record

MUI-08 was explicitly accepted on 2026-09-21. `mouse-ui/main` now points to `537b0f6fdd188b283cf10648b1cc6dbdacbfe20d`.

The available GitHub connector does not expose Git tag creation. To preserve a named stable baseline through the available repository controls, branch `baseline/mui-08-accepted` was created at the same exact commit and is intended not to move.

## Rollback

If the consolidated baseline is rejected, keep accepted `mouse-ui/main` at MUI-07 `8694ae242e81fe2f74b00efede90962d8701161b`, preserve the MUI-08 tests/manual/evidence as diagnostic assets, and rebuild only the rejected area.

## Final acceptance CI

Acceptance commit `537b0f6fdd188b283cf10648b1cc6dbdacbfe20d` reran CI as workflow `35573845791`.

Both Debug and ASan/UBSan passed 12/12 tests. Final evidence artifact:

- artifact ID: `10627277297`;
- SHA-256: `a0738c98239b190d02da7e82fec0db637bb914bc90625085aae21ae7e21bdab7`.
