# HOPE-00 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Copy the accepted BLU2USB G06 baseline exactly into `remappingbridge/remappingbridge`, without changing behavior, UI, architecture, pairing, remapping or persistence.

## Dependency

HOPE preflight is complete. HOPE-00 is the first eligible gate in the official order.

## Pinned provenance

- destination base: `remappingbridge/remappingbridge@4a562da54eed22f4987b9b869209dcf44e1e0023`
- destination base branch: `main`
- implementation branch: `hope/hope-00-exact-g06-baseline`
- BLU2USB G06 source: `remappingbridge/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- normative G06 branch: `gate/g06-profiles-remap-logitech-hidpp`
- pinned G06 tree documented by the program: `3a92348b25112abf67a879307c2273a9b018bedd`
- Mouse UI v1 reference pin: `remappingbridge/mouse-ui@e8adad7919e931c92515bf655ef4050876a8e7a9`

Mouse UI v1 is recorded only for provenance. No Mouse UI screen or rule is introduced by HOPE-00.

## Current old screen / new screen

- old/current: exact BLU2USB G06 screen set and behavior.
- new: none. HOPE-00 is a baseline transfer only.

## Expected files

The complete G06 repository tree is transferred into the destination branch. The recursive G06 tree contains 81 blobs (123 tree entries including directories), totaling 399,156 blob bytes.

The transfer must preserve:
- every path;
- every byte of every blob;
- executable mode where present;
- the complete G06 directory structure.

## Reused

All firmware, tests, CI, documentation and build files from the pinned G06 baseline are reused unchanged.

## Explicit removals

No G06 file or behavior is removed.

The destination's initial placeholder tree is replaced by the exact G06 tree. The G06 baseline already contains its own `LICENSE`, so no destination-only placeholder file remains outside the copied tree.

## Out of scope

- any Mouse UI v1 screen;
- UX improvement;
- refactor;
- architecture change;
- UI↔Core contracts;
- mouse-core architecture;
- Keyboard pairing;
- Composite pairing;
- future HOPE gates.

## Automated verification

Host build/tests:

~~~bash
cmake -S . -B build-host \
  -DBLU2USB_BUILD_PICO=OFF \
  -DBLU2USB_BUILD_TESTS=ON \
  -DCMAKE_BUILD_TYPE=Release
cmake --build build-host --parallel
ctest --test-dir build-host --output-on-failure
~~~

Pico 2 W production build, using the pinned toolchain/SDK from `ci/toolchain.env`:

~~~bash
cmake -S . -B build-pico \
  -DBLU2USB_BUILD_PICO=ON \
  -DBLU2USB_BUILD_TESTS=OFF \
  -DPICO_BOARD=pico2_w \
  -DCMAKE_BUILD_TYPE=Release
cmake --build build-pico --parallel
test -s build-pico/blu2usb_picow.uf2
sha256sum build-pico/blu2usb_picow.uf2
~~~

GitHub Actions on the gate branch is also expected to reproduce the canonical G06 host and Pico 2 W jobs.

## Physical scenarios

HOPE-00 requires physical regression against accepted G06 behavior. At minimum, execute the complete G06 physical matrix G06-01 through G06-14 from `docs/technical/04-g06-profiles-remap-hidpp-validation.md`, plus the universal HOPE checks:

1. normal boot and intact ST7789 rendering;
2. original G06 screens/copy/geometry/colors unchanged;
3. Mouse pairing and bonded reconnect;
4. Mouse X/Y movement;
5. Left/Right/Middle click behavior;
6. wheel/Forward/Backward behavior where supported;
7. Passthrough/Default/Escape/Custom profiles and feedback;
8. Custom mapping and persistence;
9. profile persistence across power cycle;
10. Logitech HID++ Forward diversion behavior required by G06;
11. lock/unlock behavior while remap is active;
12. fixed USB Mouse + Keyboard identity without unwanted re-enumeration;
13. no new Bluetooth Keyboard pairing;
14. no new Bluetooth Composite pairing.

## Regression risks

- byte or mode mismatch while copying the G06 tree;
- accidental use of a later BLU2USB branch;
- accidental introduction of a Mouse UI v1 screen;
- CI/build drift caused by missing copied files;
- physical behavior differing despite a successful source-level copy.

Any mismatch blocks candidate status. Physical acceptance remains operator-only.
