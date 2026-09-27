# MBR-04 candidate evidence

Status: **IMPLEMENTATION CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING / DEPENDENCY OPEN**

This evidence records an implementation candidate prepared on explicit operator instruction while MBR-03 remains the open physical gate. It does **not** change the planner's dependency rule, does not mark MBR-04 accepted, and does not authorize merging the product branch into main before MBR-03 physical closure.

## Product repository

- repository: `tiagooliveirajs/mouse-bridge-remapper`
- branch: `mbr/mbr-04-usb-hid`
- final candidate head: `98cef435b44125ddf6d2cec7c9864d30790ee181`
- base stack: MBR-03 candidate branch
- product MBR-03 physical acceptance remains open.

## Implemented contract

- `usb_hid` is the sole TinyUSB owner.
- VID `0xCAFE`, PID `0x4011`, bcdDevice `0x0100`.
- manufacturer `tiagooliveirajs`; product `Mouse Bridge Remapper`; no serial.
- exactly two HID interfaces: interface 0 Mouse, interface 1 Keyboard.
- Mouse descriptor is the TinyUSB five-button relative Mouse contract with X/Y/wheel/horizontal pan.
- Keyboard descriptor is the standard eight-byte keyboard report shape; product logic generates only Escape.
- synthetic Escape uses HID usage `0x29` and has explicit down/hold/up state.
- CDC/MSC/MIDI/vendor interfaces are disabled.
- no production path forces USB disconnect/reconnect.
- host report builders consume only canonical `mbr_output_state_t`.
- TinyUSB primitives remain isolated to `usb_hid`.
- isolated qualification firmware exercises Mouse report fixtures and live Escape HAT input.
- production and qualification USB/UART stdio are disabled.

## Automated evidence

Final CI run: **35482107144** (run #95), conclusion **success**.

- host-architecture: SUCCESS
- pico2-w-production: SUCCESS
- host tests include `usb_hid_contract`: PASS
- architecture USB ownership guards: PASS
- production Pico 2 W build: PASS
- MBR-04 qualification UF2 build: PASS
- UF2 non-empty verification: PASS
- artifact upload: PASS

Artifact:

- name: `mbr-04-pico2w-usb-hid-uf2`
- ID: `10595949171`
- archive digest: `sha256:b34d73126f03651f951969949b8a27a84c5f1da36620ff2bd64c2500560db1a9`
- contents: `mouse_bridge_remapper.uf2`, `mbr_usb_hid_qualification.uf2`

Final qualification UF2:

- file: `mbr_usb_hid_qualification.uf2`
- size: 38912 bytes
- SHA-256: `9a046193cad84d8ef146eebd92e4f78da5553c8d041a963b2a1580907df02dd7`

Final production UF2:

- file: `mouse_bridge_remapper.uf2`
- size: 98304 bytes
- SHA-256: `9b88eedea157a981e61eb52610d11ef9b182cc857402708addaa6d6512c83f0e`

## Physical closure scenarios

Use only the MBR-04 qualification UF2 for the MBR-04 physical test.

1. **Enumeration identity** — flash qualification UF2 and confirm USB VID/PID `CAFE:4011` and bcdDevice `0100`.
2. **Strings** — confirm manufacturer is exactly `tiagooliveirajs`, product exactly `Mouse Bridge Remapper`, and no serial string is present.
3. **Interface count/order** — confirm exactly two HID interfaces, Mouse first and Keyboard second.
4. **No debug interface** — confirm no CDC, serial, MSC, MIDI or vendor-debug USB interface appears.
5. **Mouse capabilities** — confirm five mouse buttons plus relative X/Y, wheel and horizontal pan are exposed.
6. **Movement/scroll fixtures** — observe the qualification firmware's deterministic X/Y/wheel/pan fixtures on the host.
7. **Mouse button fixtures** — hold/release JOY UP=Left, JOY DOWN=Right, JOY PRESS=Middle, KEY X=Forward, KEY Y=Backward; each must produce a matching down/up pair.
8. **Escape hold** — hold KEY A and confirm `KEY_ESC` stays down; release KEY A and confirm the Escape release.
9. **Keyboard exclusivity** — while running the qualification firmware, no keyboard key other than Escape is generated.
10. **Stable enumeration** — monitor host USB/input logs while operating all HAT controls; no spontaneous disconnect/reconnect or re-enumeration may occur.
11. **Backpressure safety** — repeated fixture traffic must not change the fixed descriptor/interface shape or corrupt held Mouse/Escape state.
12. **Production boundary** — after the qualification test, the production UF2 may be inspected/build-verified, but it is not the physical MBR-04 qualification image and must not be used as the numbered qualification test image.

## Acceptance boundary

Physical acceptance is still **PENDING**. CI success proves build/test correctness only. MBR-04 must remain unaccepted until the operator closes the numbered scenarios above. MBR-03 remains the predecessor physical gate and must be closed before MBR-04 can be integrated into the normal gate sequence.
