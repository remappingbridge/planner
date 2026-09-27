# MBR-00 frozen contract

Gate: `mbr-00`  
Status: **ACCEPTED**  
Nature: documentation/provenance/contract freeze only.

## 1. Provenance

- Destination product base entering gate: `tiagooliveirajs/mouse-bridge-remapper@db2f96606240ffc7a2a4f3bac24773d34aec0e59`.
- Planner base entering gate: `tiagooliveirajs/repo-planner@bc5d6913dfdb26eda89689fb2b1cfbb878070022`.
- Historical accepted implementation baseline: `tiagooliveirajs/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`.
- Accepted G06 UF2 SHA-256: `d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88`.
- G07+ Keyboard work is not production baseline.

## 2. Product identity

Mouse Bridge Remapper is a BLE HOGP Mouse bridge/remapper for Raspberry Pi Pico 2 W with Waveshare Pico-LCD-1.3 UI.

It may store multiple saved Mouse records, but product-visible authoritative runtime allows zero or one connected Mouse.

Bluetooth Keyboard and Bluetooth Composite product roles are absent. Bluetooth Classic Mouse is absent.

## 3. Runtime state

```text
Saved registry: 0..N Mouse records
Authoritative live slot: None | MouseSession
Optional Pair New candidate: None | non-authoritative CandidateSession
```

At all times:

```text
authoritative_ready_mouse_count <= 1
```

A Pair New candidate cannot emit authoritative product Mouse output before promotion.

## 4. HOME resolver

```text
registry empty
  -> searching-first + FIRST_MOUSE

saved + authoritative Mouse
  -> home-connected

saved + no authoritative Mouse
  -> home-searching + SEARCH_SAVED
```

- FIRST_MOUSE cycle: 8 seconds, repeated automatically while registry remains empty.
- SEARCH_SAVED: 8 seconds.
- first eligible saved Mouse reaching ready wins.
- expiry/cancel -> `home-retry` / `DEVICE NOT FOUND`.
- disconnect on HOME: resolver immediately.
- disconnect on non-HOME page: connection truth updates; resolver runs when HOME is next accessed.

## 5. Pair New replacement contract

PAIR_NEW lasts 15 seconds and accepts only an unsaved BLE HOGP Mouse.

While search runs, a healthy current Mouse remains authoritative and usable.

Already-saved candidates are ignored for Pair New acceptance.

First fully qualified unsaved candidate becomes `REPLACEMENT_READY`. Handoff order:

1. stop new input from old authoritative session;
2. release all held Mouse/Escape output from old session;
3. disconnect and clear old authoritative session while preserving its saved record and bond;
4. persist/verify new Mouse product state as required;
5. promote new candidate to sole authoritative ready session;
6. stop Pair New.

Timeout/cancel before handoff leaves old Mouse connected.

If the old Mouse is manually unplugged during Pair New/help, Pair New remains new-only. To reconnect saved, navigate Back until HOME resolves to SEARCH_SAVED.

## 6. Exact Pair New Help screens

### `help-pair-new`

```text
PAIR NEW DEVICE HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

### `help-retry-pair-new`

```text
DEVICE NOT FOUND HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

## 7. Profiles

Canonical profile kinds:

| Profile | Left | Right | Middle | Forward | Backward |
|---|---|---|---|---|---|
| PASSTHROUGH | Left | Right | Middle | Forward | Backward |
| STANDARD | Forward | Backward | Middle | Left | Right |
| ESCAPE | Escape | Backward | Forward | Left | Right |

CUSTOM sources are Left/Right/Middle/Forward/Backward and targets are Left/Right/Middle/Escape/Forward/Backward.

`STANDARD` is canonical. Historical `DEFAULT` is alias only.

Movement/wheel/pan pass through.

Apply success requires runtime+persistence confirmation.

Global Custom template and dirty/unapplied draft semantics are retained from G06.

## 8. USB contract

- VID `0xCAFE`
- PID `0x4011`
- bcdDevice `0x0100`
- manufacturer `tiagooliveirajs`
- product `Mouse Bridge Remapper`
- no serial (`iSerialNumber = 0`)
- interface 0 HID Mouse
- interface 1 minimal HID Keyboard for synthetic Escape only
- no CDC/MSC/MIDI/vendor-debug interface
- fixed from boot; no Bluetooth/profile/UI-driven re-enumeration

`0xCAFE` is a project/local development convention, not a USB-IF commercial allocation claim.

## 9. Saved Devices and names

- connected: cyan name + `STATUS: CONNECTED`;
- disconnected: ordinary name + `STATUS: DISCONNECTED`;
- at most one connected/cyan page;
- names stored fully within schema limit;
- display first 21 renderer-supported characters, no ellipsis/scroll;
- fallback `UNKNOWN MOUSE`.

## 10. UI controls

Canonical literal/control source: destination `docs/manual/06-screen-reference.md`.

- actions on release;
- Help consumes every input;
- no hidden controls;
- `searching-first`: all HAT controls didactic only;
- `first-mouse-connected` / `learn-the-keys`: joystick+Key A didactic, B Lock, X Unlock while locked, Y HOME;
- ordinary `KEY Y: LOCK` only where printed;
- `escape-active` intentionally keeps `JOY LEFT: GO TO HOME` and invokes HOME resolver.

Frozen title: `PRESS TO LEARN KEYS`.

Frozen 1-based columns: JOY UP 8; JOY 3/10/17; LEFT/PRESS/RIGHT 3/9/16; JOY DOWN 7; first-search A/X 2/16 and B/Y 2/16; instructional A/B/X 16; LOCK SCREEN 1; AND UNLOCK 2; OPEN HOME -> KEY Y 3.

## 11. Literal normalization

Canonical screen table corrects obvious transcription errors: `T0`→`TO`, `FORWARED`→`FORWARD`, `kEY`→`KEY`, `DEFAULT OPTIONS`→`DEFAULT OPTION`.

## 12. Persistence / safety

- versioned integrity-protected product state;
- two alternating verified generations or equivalent;
- corrupt newest -> previous valid;
- product state cannot overwrite BT credentials;
- profile/Custom state restored before authoritative input;
- removal is transactional/recoverable;
- disconnect/handoff/removal/overflow/profile transition release held output safely;
- stale session/transaction events rejected by generation/ID.

## 13. Logitech HID++

Preserve accepted G06 Forward diversion/held semantics for supported Logitech devices, with generic HOGP fail-safe and Passthrough restoration.

## 14. Explicit exclusions

No:

- Bluetooth Keyboard/Composite product support;
- Bluetooth Classic Mouse;
- >1 authoritative ready Mouse;
- multi-connected HOME/count/focus;
- cross-Mouse aggregation;
- simultaneous-HIDS capacity work;
- production diagnostic CDC;
- G07 Keyboard implementation as production base.

## 15. MBR-02 connected HOME amendment

The MBR-00 contract remains the historical accepted baseline, with this later product amendment superseding only the former `home-connected` layout/reachability rule:

- connected Mouse name is the dynamic `home-connected` title;
- visible options are Pair New, current remap summary, Saved Devices, Learn the Keys;
- Pair New is the first visible connected-Mouse entry and opens `pair-new` without disconnecting the current Mouse;
- selecting the remap summary opens `remapper-options`.

All other MBR-00 decisions remain in force. See `requirements/2026-09-20-connected-home-pair-new.md`.

## 16. Post-MBR-02 home-searching Help amendment

A later product amendment supersedes only the literal layout of `home-searching-help`:

```text
HOME SEARCHING HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
```

The amendment does not change saved-search eligibility, the 8-second `SEARCH_SAVED` timing, Help ownership, or any other screen. See `requirements/2026-09-20-home-searching-help.md`.

## 17. Gate exit

There is no unresolved product decision required for mbr-01 through mbr-07 after the current amendments. Any future contract change must be documented before code and may invalidate downstream evidence.
