# MBR-05 pre-implementation

Gate: `mbr-05 — Canonical Mouse core and one BLE HOGP passthrough`

Status: **IMPLEMENTATION IN PROGRESS / PHYSICAL ACCEPTANCE NOT STARTED**

## Dependency closure

- MBR-03: COMPLETE / ACCEPTED
- MBR-04: COMPLETE / ACCEPTED
- integrated product main at implementation start: `1062974972ab11c6500489e181e2e7f6488c9ccc`

## Stack base

Implementation branch `mbr/mbr-05-ble-hogp-mouse` was created from the accepted MBR-04 candidate tree `98cef435b44125ddf6d2cec7c9864d30790ee181`.

## Required behavior

- exactly one authoritative live Mouse;
- BLE HOGP Mouse only;
- one CYW43/BTstack lifecycle owner;
- HIDS Report Protocol;
- Report Map Mouse classification;
- reject keyboard-only candidates;
- canonical five buttons, relative X/Y, wheel and horizontal pan;
- duplicate Report-ID framing normalization;
- malformed/truncated report rejection;
- session generation and stale-event filtering;
- bounded runtime queue;
- disconnect/overflow output release;
- bonded reconnect using resolving-list/whitelist facilities with 8-second connection-attempt bound;
- fixed MBR-04 USB output remains unchanged;
- no G06 profiles, persistence, HID++ or Pair New lifecycle implementation yet.

## Verification

Host tests, architecture checks and Pico 2 W build are required before physical acceptance.

## Out of scope

Bluetooth Keyboard/Composite product support, simultaneous live Mice, G06 profiles/persistence/HID++, Pair New handoff and full real UX effect integration.
