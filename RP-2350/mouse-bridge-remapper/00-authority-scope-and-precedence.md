# Mouse Bridge Remapper — authority, scope and precedence

Status: **MBR-00 COMPLETE / CONTRACT FROZEN**.

This directory is the planning authority for `tiagooliveirajs/mouse-bridge-remapper`.

## 1. Objective

Build a Raspberry Pi Pico 2 W / RP2350 appliance dedicated to BLE HOGP Mouse bridging and Mouse-button remapping, preserving applicable behavior physically accepted in BLU2USB through G06 while implementing the current Mouse Bridge Remapper product contract.

The product may keep multiple mice saved, but only one Mouse may be authoritative/connected at a time.

## 2. Source-of-truth precedence

Use this order when requirements overlap:

1. current product documentation in `tiagooliveirajs/mouse-bridge-remapper`, including later accepted product amendments;
2. `requirements/2026-09-20-connected-home-pair-new.md` for the connected-HOME amendment;
3. `requirements/2026-09-20-pair-new-help-and-handoff.md` for the latest Pair New/help clarification;
4. `requirements/2026-09-20-single-connected-mouse.md` for single-live-Mouse simplification;
5. `requirements/2026-09-19-user-rules.md` for original layout/behavior not superseded later;
6. accepted BLU2USB G06 at SHA `7eee024ad4ee726c5a85ffa2f32b9f47187878af` for inherited Mouse behavior;
7. earlier accepted G01-G05 corrections inherited by G06 where not superseded;
8. infra-planner historical material and G07+ work as research/process evidence only.

`07-mbr-00-frozen-contract.md` records the resolved decisions. `02-ambiguity-register.md` is closed by MBR-00.

## 3. Immutable G06 reference

- repo `tiagooliveirajs/blu2usb`;
- branch `gate/g06-profiles-remap-logitech-hidpp`;
- accepted SHA `7eee024ad4ee726c5a85ffa2f32b9f47187878af`;
- accepted UF2 SHA-256 `d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88`;
- applicable G06 physical scenarios reported PASS on that exact candidate.

The reference is behavioral/architectural evidence, not permission for wholesale copying.

## 4. Hard included scope

- BLE HOGP Mouse discovery/classification/security/bonding/reconnect/forwarding;
- multiple saved mice, <=1 authoritative live Mouse;
- one optional non-authoritative Pair New replacement candidate during explicit qualification;
- canonical buttons/X/Y/wheel/pan;
- Passthrough, Standard, Escape, Custom;
- persistent global Custom template + draft;
- Logitech HID++ Forward correction;
- saved-device removal/credential cleanup;
- Waveshare HAT/LCD UI;
- fixed USB Mouse + minimal synthetic-Escape Keyboard output;
- power-loss-safe product state separate from BT credentials.

## 5. Explicitly excluded

- >1 authoritative ready Mouse;
- multi-connected count/focus/capacity UI/runtime;
- cross-Mouse aggregation;
- Bluetooth Classic Mouse;
- Bluetooth Keyboard pairing/input;
- Bluetooth Composite product support;
- Keyboard/Composite registries/screens/transports;
- G07 Keyboard implementation as production base;
- diagnostic CDC/debug product personality.

## 6. Pair New authority

Pair New is new-only and uses replacement handoff:

- existing healthy Mouse remains live during search;
- saved candidates are ignored as Pair New winners;
- first unsaved qualified candidate becomes replacement-ready;
- old held state is released and old session disconnected only at handoff;
- old saved record/bond remains;
- new candidate then becomes sole authoritative Mouse;
- timeout/cancel before handoff leaves old Mouse connected.

To reconnect a saved Mouse, current Help instructs unplugging the current Mouse and navigating Back until HOME reaches `SEARCHING`.

## 7. HOME/search authority

- no saved -> `searching-first`, repeated 8-second FIRST_MOUSE cycles;
- saved + live -> `home-connected`;
- saved + no live -> `home-searching` + 8-second SEARCH_SAVED;
- timeout/cancel -> `DEVICE NOT FOUND`;
- Pair New window -> 15 seconds.

## 8. USB authority

Project/development identity frozen by MBR-00:

- VID `0xCAFE`, PID `0x4011`, bcdDevice `0x0100`;
- manufacturer `tiagooliveirajs`;
- product `Mouse Bridge Remapper`;
- no serial;
- HID Mouse interface 0;
- minimal synthetic-Escape HID Keyboard interface 1;
- no CDC/debug interface;
- no Bluetooth-driven re-enumeration.

The VID convention is not a claim of commercial USB-IF allocation.

## 9. Connected HOME amendment

The 2026-09-20 connected-HOME amendment is a product-contract change approved before MBR-02 acceptance. It supersedes only the former `home-connected` layout/reachability rule: the connected Mouse name is the title; Pair New is the first visible option; the remap summary is second; Saved Devices and Learn the Keys are third/fourth. Pair New remains new-only and does not disconnect the current Mouse at entry.

## 10. Gate state

- `mbr-00`: **COMPLETE / ACCEPTED**, with the connected-HOME amendment superseding only its former HOME layout;
- `mbr-01`: **COMPLETE / ACCEPTED**;
- `mbr-02`: current implementation gate, acceptance pending exact-head CI/integration;
- later gates remain dependency-gated.

MBR-00 performed documentation/provenance/contract work only. It produced no firmware implementation, build, UF2 or physical acceptance claim.

## 11. No-regression principle

Later gates may not weaken release safety, generic Mouse fallback, bonded reconnect, persistence integrity, HID++ hold semantics, release-triggered HAT behavior, accepted renderer geometry/color priority, fixed USB identity, or Bluetooth Keyboard/Composite exclusions without an explicit contract change and revalidation.
