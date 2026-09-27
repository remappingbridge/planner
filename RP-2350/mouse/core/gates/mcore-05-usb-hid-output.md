# MCORE-05 — USB HID Output

Status: **BLOCKED**.

## Objective

Deliver normalized/remapped output through TinyUSB Mouse plus output-only Keyboard Escape semantics.

## Dependencies

MCORE-04 ACCEPTED.

## Tasks

1. USB Mouse descriptor/report delivery.
2. Keyboard capability limited to synthetic Escape output.
3. Backpressure/poll/timing-safe held-state delivery.
4. Release-all on teardown/recovery.
5. Target USB enumeration/report evidence.

## Automated / documentary acceptance

- [ ] host descriptor/report tests
- [ ] Mouse + Escape outputs preserve press/hold/release
- [ ] no Bluetooth keyboard input scope
- [ ] release-all behavior tested

## Human acceptance

- [ ] physical host USB enumeration and input acceptance

## Deliverables

- general keyboard remapper
- UI code

## Forbidden scope

- TinyUSB output layer
- physical USB evidence

