# MBR-01 completion report

Gate: `mbr-01 — Clean bootstrap and architecture enforcement`  
Status: **COMPLETE / ACCEPTED**

## Objective achieved

Established the first compileable Mouse Bridge Remapper implementation scaffold from the MBR-00 frozen contract. The gate encodes product ownership/dependency boundaries in CMake and automated architecture guards before behavioral features are added.

No behavioral or physical acceptance is claimed by this gate.

## Entry subjects

- Product base: `tiagooliveirajs/mouse-bridge-remapper@efe3660eece4a2866615ec19270a04e498d485e9`.
- Planner base: `tiagooliveirajs/repo-planner@7fba1b7aae7ad15f477dc6fc9eeb94358042677d`.
- Historical accepted implementation evidence: `tiagooliveirajs/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`.
- Product implementation branch: `mbr/mbr-01-clean-bootstrap`.
- Product exact accepted branch head: `826c50dab3b105c6bcecef6a6dbba401506aefc9`.
- Product PR: `#1 — MBR-01: clean bootstrap and architecture enforcement`.
- Integrated product `main`: `cee10ee157ce0d7f6655df203327422c3c40e6b3`.

## G06 evidence inspected

At the exact accepted G06 SHA, mbr-01 re-inspected and used only appropriate structural/build evidence from:

- `CMakeLists.txt`;
- `cmake/Blu2UsbModules.cmake`;
- `tests/test_architecture.py`;
- `ci/toolchain.env`;
- `.github/workflows/ci.yml`;
- accepted source/build graph context.

The G06 build pattern was adapted rather than copied wholesale. Keyboard/Composite/Classic-HID and later G07 multicore/Core1 architecture are excluded.

## Implementation delivered

### Build / CI

Created:

- root `CMakeLists.txt` with host and Pico modes;
- `cmake/MouseBridgeRemapperModules.cmake` as the frozen module/dependency facade;
- `ci/toolchain.env`;
- `.github/workflows/ci.yml`;
- `.gitignore` for build outputs.

The production scaffold is fixed to `PICO_BOARD=pico2_w`. Production USB/UART stdio is disabled.

### Frozen conceptual modules materialized

- `domain`
- `mouse_registry`
- `mouse_session`
- `output_state`
- `profiles`
- `remap`
- `pairing_coordinator`
- `bt_runtime`
- `ble_hogp`
- `logitech_hidpp`
- `product_storage`
- `usb_hid`
- `interaction`
- `ui_projector`
- `renderer`
- `hat`
- `app`

Most modules are intentionally minimal compileable scaffolds; later gates own their behavioral implementation.

### Structural Mouse-session invariant

`mouse_session` owns exactly one `mbr_authoritative_mouse_slot_t` representation. Promotion refuses a second authoritative session while the slot is occupied.

`pairing_coordinator` has a separate `mbr_pairing_candidate_t` for a non-authoritative replacement candidate. Creating/qualifying that candidate does not increase the authoritative ready count. This preserves the MBR-00 Pair New handoff model without introducing simultaneous authoritative mice.

### Architecture guards

`tests/test_architecture.py` freezes the module graph and rejects, among other violations:

- `classic_hid` and `keyboard_transport` production architecture;
- superseded `hid_aggregator`, multi-Mouse focus/count/capacity architecture;
- Pico multicore/Core1 runtime architecture (`pico_multicore`, `multicore_launch_core1`);
- raw platform/transport dependencies in host-pure modules;
- Bluetooth runtime primitives outside the permitted runtime/adapters;
- CYW43/BTstack lifecycle ownership outside `bt_runtime`;
- TinyUSB ownership outside `usb_hid`;
- GPIO/SPI ownership outside `hat`/`renderer`;
- raw flash ownership outside `product_storage`;
- raw HAL/transport primitives in `app`;
- textual `.c` includes and transport/HAL macro interception;
- forced USB `tud_disconnect()`/`tud_connect()` re-enumeration;
- production CDC/USB/UART debug stdio;
- an unexpected second production firmware executable;
- authoritative Mouse session storage as an array.

### Host bootstrap test

`tests/test_bootstrap.c` verifies:

- scaffold version identity `0.1.0-mbr01`;
- authoritative ready count starts at zero;
- first Mouse can become authoritative;
- second authoritative promotion is rejected;
- a separate Pair New candidate can become replacement-ready without increasing authoritative ready count;
- clearing the live slot returns ready count to zero.

## Exact automated acceptance evidence

Final exact-head pre-merge GitHub Actions run:

- run ID: `35477941473`;
- source SHA: `826c50dab3b105c6bcecef6a6dbba401506aefc9`;
- workflow: `Mouse Bridge Remapper CI`.

### Host / architecture job

Job `host-architecture`: **SUCCESS**.

Observed steps all succeeded:

1. checkout exact branch head;
2. CMake host configure;
3. host build;
4. `ctest --output-on-failure`.

The host suite includes both `bootstrap_contract` and `architecture_contract`.

### Pico 2 W production job

Job `pico2-w-production`: **SUCCESS**.

Observed environment/build facts:

- runner: Ubuntu 24.04;
- Pico SDK tag: `2.2.0`;
- Pico SDK checkout commit observed: `a1438dff1d38bd9c65dbd693f0e5db4b9ae91779`;
- ARM GCC package: `15:13.2.rel1-2`;
- compiler: `arm-none-eabi-gcc 13.2.1 20231009`;
- board: `pico2_w`;
- platform: `rp2350-arm-s`;
- production configure: success;
- production build: success;
- non-empty UF2 verification: success;
- artifact upload: success.

Exact structural UF2:

- path: `build-pico/mouse_bridge_remapper.uf2`;
- size: `12288` bytes;
- SHA-256: `3110c90819a67eab761d75fae8ab396823e343dc3a0ea3ac16e9868c5155d452`.

Uploaded workflow artifact:

- name: `mbr-01-pico2w-scaffold-uf2`;
- artifact ID: `10594907592`;
- artifact archive size: `5051` bytes;
- artifact archive digest: `sha256:9a27d11ad1801122f37e520a66e12882849097e7969d220f2274eb7b3772b8a3`.

The UF2 is a structural scaffold artifact only. It is not a functional firmware candidate and requires no physical operator test in mbr-01.

## Integration and post-merge revalidation

Before merge, the product branch was 3 commits ahead of `main` and 0 behind.

PR #1 merged successfully after exact-head CI was green.

Integrated product subject:

`tiagooliveirajs/mouse-bridge-remapper@cee10ee157ce0d7f6655df203327422c3c40e6b3`

The merge commit has parents `efe3660eece4a2866615ec19270a04e498d485e9` and accepted implementation head `826c50dab3b105c6bcecef6a6dbba401506aefc9`.

The `main` push triggered a second complete CI run on the exact integrated merge SHA:

- run ID: `35478020586`;
- source SHA: `cee10ee157ce0d7f6655df203327422c3c40e6b3`;
- workflow conclusion: **SUCCESS**.

This post-merge run revalidates the same tree under `main`, so integration did not invalidate the host/architecture or Pico 2 W build evidence.

## Physical acceptance

Not required for mbr-01 and not performed.

No claim is made that the scaffold:

- renders the product UI;
- enumerates with the final MBR USB HID descriptors;
- pairs or forwards a BLE Mouse;
- applies remapping;
- persists state;
- performs Logitech HID++;
- executes Pair New or saved reconnect behavior.

Those capabilities remain assigned to later gates.

## Gate conclusion

**MBR-01 acceptance criteria are satisfied.** The clean bootstrap, frozen module graph, architecture ownership guards, host build/tests, Pico 2 W production build, structural UF2 evidence, PR integration and post-merge revalidation are complete.

## Next executable point

`mbr-02 — Interaction engine, UI projector and golden screen model`.

Before executing mbr-02, re-read current `main` of both repositories, MBR-00 frozen contract/migration manifest, this completion report, `05-gates.md`, `06-execution-rules.md`, and the canonical product screen reference. Do not advance directly to renderer, USB or Bluetooth implementation.