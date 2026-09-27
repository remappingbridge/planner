# MBR-01 pre-implementation record

Gate: `mbr-01 — Clean bootstrap and architecture enforcement`  
Status: **IN PROGRESS**

## Entry / dependencies

- `mbr-00` is COMPLETE / ACCEPTED.
- Product base: `tiagooliveirajs/mouse-bridge-remapper@efe3660eece4a2866615ec19270a04e498d485e9`.
- Planner base: `tiagooliveirajs/repo-planner@7fba1b7aae7ad15f477dc6fc9eeb94358042677d`.
- Immutable inherited implementation evidence: `tiagooliveirajs/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`.
- Implementation branch: `mouse-bridge-remapper:mbr/mbr-01-clean-bootstrap`.
- Planner execution branch: `repo-planner:mbr/mbr-01-clean-bootstrap`.

## Objective

Establish a clean implementation scaffold for Mouse Bridge Remapper whose build composition and automated architecture guards encode the MBR-00 product boundaries before behavioral features are implemented.

## Expected implementation areas

- root `CMakeLists.txt`;
- `cmake/MouseBridgeRemapperModules.cmake`;
- `ci/toolchain.env`;
- `.github/workflows/ci.yml`;
- public headers under `include/mbr/...`;
- module scaffolds under `src/{domain,mouse_registry,mouse_session,output_state,profiles,remap,pairing_coordinator,bt_runtime,ble_hogp,logitech_hidpp,product_storage,usb_hid,interaction,ui_projector,renderer,hat,app}`;
- host tests and static architecture guard suite under `tests/`.

## Frozen product decisions used

- saved registry may contain many Mouse records, but authoritative ready Mouse count is <= 1;
- Pair New may later use one non-authoritative replacement candidate, but candidate output is never authoritative before promotion;
- BLE HOGP Mouse only; no Bluetooth Classic Mouse;
- no Bluetooth Keyboard or Composite product modules/flows;
- synthetic USB Escape remains a later fixed output-only exception;
- one CYW43/BTstack owner;
- one TinyUSB owner (`usb_hid`);
- no diagnostic CDC production identity;
- no transport/HAL primitives in pure/domain/UI orchestration boundaries;
- no `.c` textual includes or transport macro interception;
- production board is Pico 2 W.

## Inherited G06 evidence revalidated for this gate

At exact G06 SHA, `CMakeLists.txt`, `cmake/Blu2UsbModules.cmake`, `tests/test_architecture.py`, `ci/toolchain.env` and `.github/workflows/ci.yml` were inspected. Reuse is structural/reference only; Keyboard/Composite and Classic-HID graph elements are explicitly excluded.

Pinned starting toolchain inputs inherited from G06:

- CI runner: Ubuntu 24.04;
- Pico SDK: 2.2.0;
- `gcc-arm-none-eabi` package: `15:13.2.rel1-2`;
- upstream ARM GCC: `13.2.Rel1`.

## Regressions at risk

- accidental restoration of G06/G07 Keyboard or Composite scope;
- duplicate ownership of TinyUSB or BTstack;
- raw BTstack/TinyUSB/GPIO/SPI/flash leakage into architecture-pure modules;
- accidental production debug CDC/UART/USB stdio;
- speculative simultaneous-authoritative-Mouse aggregation/focus/capacity state;
- build graph allowing a second authoritative session manager;
- toolchain drift from the accepted starting baseline.

## Out of scope

- canonical interaction/UI behavior (mbr-02);
- physical renderer/HAT implementation (mbr-03);
- final USB descriptors/report behavior (mbr-04);
- real BLE HOGP forwarding (mbr-05);
- profiles/persistence/HID++ parity (mbr-06);
- saved/new lifecycle and Pair New runtime handoff (mbr-07);
- any physical acceptance.

Module files in mbr-01 are intentionally minimal compileable scaffolds. They establish ownership/dependency boundaries only and must not be interpreted as behavioral implementation.

## Verification plan

Host:

```sh
cmake -S . -B build-host -DMBR_BUILD_PICO=OFF -DMBR_BUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Release
cmake --build build-host --parallel
ctest --test-dir build-host --output-on-failure
```

Pico 2 W production:

```sh
cmake -S . -B build-pico -DMBR_BUILD_PICO=ON -DMBR_BUILD_TESTS=OFF -DPICO_BOARD=pico2_w -DCMAKE_BUILD_TYPE=Release
cmake --build build-pico --parallel
test -s build-pico/mouse_bridge_remapper.uf2
```

Architecture suite must reject forbidden module names/tokens, ownership leaks, textual `.c` includes/macro interception, debug CDC/stdio, wrong board, and unfrozen module graph.

CI must execute both host/architecture and pinned Pico 2 W production jobs, and upload the non-empty scaffold UF2 as structural evidence.

## Physical scenarios

None. mbr-01 has no physical acceptance. A generated UF2 is only a build/scaffold artifact.

## Rollback / recovery

The destination implementation branch starts exactly from the accepted mbr-00 product-documentation SHA. If the scaffold violates the frozen architecture or cannot build under the pinned baseline, keep `main` unchanged, correct the branch, rerun automated evidence, and only then integrate. No descriptor/persistence migration exists yet, so rollback is branch-level only.
