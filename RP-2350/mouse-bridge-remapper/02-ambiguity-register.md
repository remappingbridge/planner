# Ambiguity and decision register

Status: **CLOSED BY MBR-00**.

MBR-00 resolved every product/architecture ambiguity required by mbr-01 through mbr-07. Implementation may not reopen these choices silently.

## D-001 — Escape output

**RESOLVED:** retain Escape through fixed minimal USB HID Keyboard output. No Bluetooth Keyboard pairing/input and no Bluetooth Composite product role.

## D-002 — Live Mouse capacity

**RESOLVED:** multiple saved Mouse records; zero or one authoritative/ready Mouse. A transient non-authoritative replacement candidate may exist during explicit Pair New qualification, but authoritative ready count is never greater than one.

No `N DEVICES CONNECTED`, count 999, cross-Mouse aggregation, live-Mouse focus selector or simultaneous-HIDS capacity work.

## D-003 — Pair New sequencing

**RESOLVED by current Help-flow clarification:** Pair New does not disconnect a healthy current Mouse at search start.

- current Mouse remains live/usable;
- Pair New searches only for unsaved BLE HOGP Mouse;
- already-saved candidates are ignored for Pair New acceptance;
- first fully qualified unsaved candidate becomes non-authoritative replacement-ready;
- then old input is frozen, held output released, old session disconnected/cleared while saved record/bond remain, new product state confirmed, and candidate promoted;
- timeout/cancel before handoff leaves old Mouse live.

Authority: `requirements/2026-09-20-pair-new-help-and-handoff.md`.

## D-004 — Saved reconnect/HOME

**RESOLVED:** unified HOME resolver:

```text
no saved -> searching-first
saved + live -> home-connected
saved + no live -> home-searching + SEARCH_SAVED
```

SEARCH_SAVED = 8 seconds. First saved Mouse reaching ready wins. Expiry/cancel -> `home-retry` / `DEVICE NOT FOUND`.

If disconnect occurs while HOME is visible, resolve immediately. On another page, update connection truth and resolve when HOME is next accessed.

## D-005 — Pair New Help literal text

**RESOLVED:** the exact `help-pair-new` and `help-retry-pair-new` blocks supplied 2026-09-20 are canonical. They instruct the user to unplug the current Mouse and Back until SEARCHING appears when the desired device is saved.

## D-006 — Pair New saved candidate

**RESOLVED:** ignore it as a Pair New winner and continue the same new-only window. Never overwrite/delete the saved record and never silently change Pair New into saved reconnect.

## D-007 — `KEY B: BACK TRY SAVED`

**RESOLVED:** leave Pair New through the ordinary HOME resolver. Current Mouse still live -> `home-connected`. Current Mouse unplugged/no live -> `home-searching` and automatic SEARCH_SAVED.

## D-008 — USB identity

**RESOLVED for project/development product:**

- VID `0xCAFE`
- PID `0x4011`
- bcdDevice `0x0100`
- manufacturer `tiagooliveirajs`
- product `Mouse Bridge Remapper`
- no serial
- interface 0 Mouse
- interface 1 minimal Keyboard output for synthetic Escape
- no CDC/debug interface

`0xCAFE` is not a claim of USB-IF commercial vendor allocation.

## D-009 — Profile vocabulary

**RESOLVED:** canonical profile name is `STANDARD`; menu text is `STANDARD REMAP`; HOME summary is `REMAPPED TO STANDARD`; Saved Devices shows `PROFILE: STANDARD`. Historical `DEFAULT REMAP` is an alias only.

## D-010 — Didactic title and coordinates

**RESOLVED:** title `PRESS TO LEARN KEYS`.

Frozen 1-based columns:

- `JOY UP` 8
- three `JOY` 3/10/17
- `LEFT`/`PRESS`/`RIGHT` 3/9/16
- `JOY DOWN` 7
- first-search `KEY A`/`KEY X` 2/16
- first-search `KEY B`/`KEY Y` 2/16
- instructional right-side `KEY A/B/X` 16
- `LOCK SCREEN` 1
- `AND UNLOCK` 2
- `OPEN HOME -> KEY Y` 3

Source uses of “linha 16” in this coordinate context are normalized as column 16.

## D-011 — Screen ID

**RESOLVED:** `searching-first` is canonical. `searching-first-mouse` is historical prose only.

## D-012 — Escape-active HOME shortcut

**RESOLVED:** keep `JOY LEFT: GO TO HOME` as an intentional explicit new-screen exception. It invokes the unified HOME resolver.

## D-013 — Lock availability / instructional controls

**RESOLVED:** no hidden Lock/control inheritance.

- ordinary `KEY Y: LOCK` only where visibly declared;
- `searching-first`: all shown controls didactic only;
- `first-mouse-connected` and `learn-the-keys`: joystick + Key A didactic, Key B Lock, Key X Unlock while locked, Key Y HOME;
- Help consumes every control as Back.

## D-014 — Saved Devices disconnected word

**RESOLVED:** `STATUS: DISCONNECTED`.

## D-015 — Long Mouse names

**RESOLVED:** persist full normalized available name within schema limits; render first 21 renderer-supported characters, no ellipsis/scroll; empty/unusable -> `UNKNOWN MOUSE`.

## D-016 — Timing

**RESOLVED:**

- FIRST_MOUSE finite cycle 8s, repeated automatically while registry empty;
- SEARCH_SAVED 8s;
- PAIR_NEW 15s.

## D-017 — Literal normalization

**RESOLVED:** canonical `docs/manual/06-screen-reference.md` wins. Obvious transcription errors are normalized (`T0`→`TO`, `FORWARED`→`FORWARD`, `kEY`→`KEY`, `DEFAULT OPTIONS`→`DEFAULT OPTION`).

## D-018 — Mouse transport

**RESOLVED:** BLE HOGP only. Bluetooth Classic Mouse is not included.

## D-019 — Connected HOME Pair New entry

**RESOLVED by 2026-09-20 product amendment:** `home-connected` uses the current connected Mouse name as its dynamic title and exposes four visible options in this order: `PAIR NEW MOUSE`, current remap summary, `SAVED DEVICES`, `LEARN THE KEYS`. The first option opens `pair-new` while the current Mouse remains authoritative and usable. The remap summary opens `remapper-options`.

Authority: `requirements/2026-09-20-connected-home-pair-new.md`.

This closes the MBR-02 reachability blocker without introducing hidden controls or changing the one-authoritative-Mouse invariant.

## Change discipline

Any future change to these choices is a product-contract change and must update documentation/planning before code. The executor may not treat a later implementation convenience as authority to reopen a closed decision.
