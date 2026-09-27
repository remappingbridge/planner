# Target architecture — Mouse Bridge Remapper

Status: **FROZEN BY MBR-00**.

The product may save many mice but has zero or one authoritative live Mouse. Architecture must stay as simple as that contract permits.

## 1. Goals

1. Bluetooth product device type: Mouse only.
2. Mouse transport: BLE HOGP only.
3. Multiple saved Mouse records; at most one authoritative ready Mouse.
4. Pair New keeps a healthy current Mouse live while qualifying an unsaved replacement, then performs one safe handoff.
5. Unified HOME resolver for startup/navigation/disconnect recovery.
6. BLE details never leak into remap/UI/USB.
7. Held output is release-safe on disconnect/handoff/removal/profile change/failure.
8. Product state and BT credentials have separate ownership.
9. UI is semantic/event-driven and never calls BTstack directly.
10. Preserve accepted G06 reconnect, persistence, HID++, HAT, renderer and USB lessons.
11. No Bluetooth Keyboard/Composite product modules.
12. Synthetic Escape is a minimal fixed USB output exception only.

## 2. Component model

```text
HAT -> interaction -> application -> ui_projector -> renderer
                         |   |
                         |   +-> pairing_coordinator -> mouse_session -> ble_hogp -> bt_runtime
                         |
                         +-> profiles/remap -> output_state -> usb_hid
                         |
                         +-> mouse_registry -> product_storage

ble_hogp <-> logitech_hidpp (capability-driven)
bt_runtime -> BTstack credential store
```

## 3. Domain

```text
MouseId
  persistent saved identity

MouseSessionId
  MouseId + generation/token

SavedMouse {
  MouseId
  full_normalized_name
  confirmed_profile_kind
  capability_metadata
  vendor_metadata
}

AuthoritativeSlot = None | MouseSession
ReplacementCandidate = None | CandidateSession
```

A replacement candidate is non-authoritative and cannot forward product Mouse output before promotion.

Hard invariant:

```text
authoritative_ready_mouse_count <= 1
```

## 4. Canonical Mouse boundary

Adapters emit only:

```text
ButtonDown(LEFT|RIGHT|MIDDLE|FORWARD|BACKWARD)
ButtonUp(...)
Move(dx,dy)
Wheel(delta)
Pan(delta)
SessionGone(session_id)
```

No Report ID/field offsets leave the BLE adapter. Malformed frames are rejected. Duplicate transitions are idempotent.

## 5. Output state

No cross-Mouse aggregator exists.

Within the authoritative session, each target keeps a set/refcount of physical/remapped sources so two buttons mapping to the same target cannot prematurely release it. Escape has equivalent held-state tracking.

Relative movement/wheel/pan use bounded accumulation and USB backpressure-safe consumption.

## 6. Bluetooth runtime

Exactly one CYW43/BTstack lifecycle owner. Start from accepted G06 BLE-only runtime evidence; do not import G07 Classic Keyboard architecture.

An explicit candidate context during Pair New is allowed only to qualify a replacement. It never becomes authoritative before old-session cleanup.

## 7. Search coordinator

### FIRST_MOUSE

- registry empty;
- 8-second finite cycle;
- automatically repeat until success;
- first accepted valid unsaved Mouse wins.

### SEARCH_SAVED

- saved mice exist + no authoritative Mouse;
- starts whenever HOME resolves under that condition;
- 8-second window;
- first saved Mouse reaching ready wins;
- expiry/cancel -> `home-retry` / `DEVICE NOT FOUND`.

### PAIR_NEW

- 15-second new-only window;
- healthy current Mouse remains authoritative/usable during search;
- already-saved candidates ignored for Pair New acceptance;
- first valid unsaved candidate may reach `REPLACEMENT_READY`;
- then handoff:
  1. freeze old input;
  2. release old Mouse/Escape held output;
  3. disconnect/clear old authoritative session, preserving saved record/bond;
  4. persist/verify new product state;
  5. promote candidate as sole authoritative Mouse;
  6. stop Pair New.
- timeout/cancel before handoff leaves old Mouse live.

If user manually unplugs current Mouse during Pair New/help, Pair New remains new-only. HOME later sees saved + no live and starts SEARCH_SAVED.

## 8. Unified HOME resolver

```text
if registry.empty():
  searching-first + FIRST_MOUSE
else if authoritative_mouse.ready():
  home-connected
else:
  home-searching + SEARCH_SAVED
```

Disconnect while HOME visible invokes resolver immediately. Disconnect elsewhere updates runtime truth; resolver runs on next HOME access.

## 9. Registry/persistence

Product record:

```text
header { schema_version, generation, length, checksum }
saved_mice[]
global_custom_template
custom_draft
custom_draft_dirty
```

Use two alternating verified generations or proven equivalent. Corrupt newest -> previous valid. Product state cannot overwrite BT credentials.

Removal is transactional; if target is live, release/disconnect before deletion commit.

## 10. Profiles

Canonical kinds:

```text
PASSTHROUGH | STANDARD | ESCAPE | CUSTOM
```

Historical `DEFAULT` is alias-only. Connected authoritative Mouse is the runtime target. Each saved Mouse stores confirmed kind. Global Custom template remains shared.

Apply success requires runtime + persistent confirmation.

## 11. Fixed USB

`usb_hid` sole TinyUSB owner.

MBR-00 identity:

- VID `0xCAFE`, PID `0x4011`, bcdDevice `0x0100`;
- manufacturer `tiagooliveirajs`;
- product `Mouse Bridge Remapper`;
- no serial;
- interface 0 Mouse;
- interface 1 minimal Keyboard for synthetic Escape;
- no CDC/debug interface;
- no Bluetooth-driven re-enumeration.

## 12. UI

Canonical screen/control authority is destination `docs/manual/06-screen-reference.md`.

Connected HOME is explicitly reachable and has this semantic option graph:

```text
home-connected
  selection 0 -> PAIR NEW MOUSE -> pair-new
  selection 1 -> current remap summary -> remapper-options
  selection 2 -> SAVED DEVICES
  selection 3 -> LEARN THE KEYS
```

The title is the current authoritative Mouse name. Selecting Pair New does not disconnect the current Mouse; it starts the existing 15-second new-only replacement transaction.

Key rules:

- `home-connected` shows sole live Mouse name/profile;
- `home-searching` owns active SEARCH_SAVED;
- Pair New Help literal text is frozen from 2026-09-20 user decision;
- `STATUS: DISCONNECTED` is canonical disconnected word;
- name display = first 21 renderer-supported characters, fallback `UNKNOWN MOUSE`;
- no hidden controls;
- instructional B/X/Y and didactic coordinates are frozen;
- `JOY LEFT: GO TO HOME` on `escape-active` intentionally invokes HOME resolver.

## 13. Architecture guards

Reject:

- `.c` textual includes;
- raw BTstack outside Bluetooth runtime/adapters;
- TinyUSB outside `usb_hid`;
- GPIO/SPI outside HAT/renderer adapters;
- flash erase/program outside storage;
- UI transport calls;
- Bluetooth Keyboard/Composite modules;
- a second BT runtime owner;
- >1 authoritative ready Mouse;
- speculative simultaneous-Mouse aggregator/focus/capacity code;
- diagnostic CDC production descriptors.

## 14. Planned modules

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

No `classic_hid`, `keyboard_transport`, Bluetooth Composite module, multi-live-Mouse manager or cross-Mouse aggregator.
