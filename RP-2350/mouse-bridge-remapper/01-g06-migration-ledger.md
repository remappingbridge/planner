# G06 migration and no-regression ledger

Status: **FROZEN BY MBR-00**.

Source baseline: BLU2USB G06 accepted SHA `7eee024ad4ee726c5a85ffa2f32b9f47187878af`.

This ledger records behavior to preserve/adapt/exclude. Observable correctness outranks source-file resemblance.

## 1. PRESERVE — interaction/renderer lessons

- HAT actions execute on release.
- Visible pressed controls are white while held.
- Help owns/consumes input with `ANY KEY: BACK`.
- Ordinary lock is presentation-only; Mouse/Bluetooth/remap/USB continue.
- Unlock interaction is consumed.
- Selected/pressed white overrides cyan current/connected; cyan returns afterward.
- Preserve accepted ST7789 pixel-relocation/vertical geometry unless current screen explicitly supersedes a coordinate.
- Assert target token positions, not coincidental matching characters; retain the historical Learn `KEY` assertion lesson.
- Physical labels must match real HAT keys (`KEY X: HELP`, not historical typo variants).

Current MBR-00 screen literals/control maps supersede historical G06 screens where they differ.

## 2. PRESERVE/ADAPT — canonical Mouse input safety

- Transport report layout never reaches application/USB/remap layers.
- Report Map classifies Mouse before acceptance.
- Canonical buttons, signed X/Y, vertical wheel and horizontal pan.
- Normalize accepted duplicated Report-ID framing; reject malformed/truncated frames.
- Duplicate button Down/Up is idempotent.
- Held target state is refcount/set based within the authoritative Mouse, because multiple physical sources can map to one target.
- Disconnect, replacement handoff, profile transition, removal, parser/runtime continuity loss release affected held state safely.
- Relative X/Y/wheel/pan are bounded and consumed only under USB submission/backpressure rules.
- LCD lock never pauses Mouse forwarding.
- Session generation rejects late callbacks after reconnect/replacement.

Cross-Mouse aggregation is **EXCLUDED** because the product has <=1 authoritative Mouse.

## 3. PRESERVE — BLE HOGP behavior

- BLE HOGP is the production Mouse transport.
- security/bonding/Report Protocol remain transport concerns.
- generic mice work without Logitech-specific support.
- HIDS/report/security failures use bounded recovery and cannot trap UI/USB.
- saved reconnect reuses BTstack credentials/resolving/accept-list mechanisms where applicable.
- bounded reconnect prevents absent saved peer from blocking indefinitely.

MBR-00 freezes SEARCH_SAVED at 8 seconds and FIRST_MOUSE as repeated 8-second cycles.

Bluetooth Classic Mouse, Bluetooth Keyboard and Bluetooth Composite product roles are excluded.

## 4. PRESERVE — exact profiles

| Source | Passthrough | Standard | Escape |
|---|---|---|---|
| Left | Left | Forward | Escape |
| Right | Right | Backward | Backward |
| Middle | Middle | Middle | Forward |
| Forward | Forward | Left | Left |
| Backward | Backward | Right | Right |

Movement/wheel/pan pass through.

Canonical MBR word is `STANDARD`; historical G06 `DEFAULT` is an alias only.

Profile change releases stale old-mapping held state. UI success only after runtime+persistent confirmation.

## 5. PRESERVE — Custom semantics

- one persistent global Custom template;
- sources Left/Right/Middle/Forward/Backward;
- targets Left/Right/Middle/Forward/Backward/Escape;
- source `APPLY AND BACK` updates/persists draft and immediately reprojects editor;
- dirty/unapplied draft survives reboot separately from last confirmed active profile;
- applying another preset does not erase Custom draft;
- full Custom apply success requires runtime+persistence confirmation.

Each saved Mouse stores its profile kind. A Custom-profile Mouse uses the global template when authoritative.

## 6. PRESERVE — product persistence quality

- schema version;
- integrity check (CRC or stronger equivalent);
- two alternating generations/slots or equivalent power-loss-safe method;
- corrupt/torn newest -> previous valid;
- product storage protected from BT credential storage;
- boot restores product state before Mouse input becomes authoritative;
- safe defaults if no valid record.

New schema includes multiple saved Mouse identities/names/profile kinds/capability metadata, but transient session handles are never persisted.

## 7. PRESERVE — Logitech HID++

- automatic vendor backend, not a user mode;
- preserve accepted `REPROG_CONTROLS_V4` feature `0x1b04` / Forward CID `0x0056` behavior where supported;
- true Forward down/hold/up survives remapping;
- Passthrough removes unnecessary diversion;
- unsupported peers fail safe to normal HOGP;
- disconnect/profile change/replacement releases vendor-derived held state.

Only current/candidate session-specific HID++ context is required; no simultaneous-authoritative-Mouse set.

## 8. ADAPT — connection model

G06's one logical active Mouse becomes an explicit generation-safe authoritative slot:

```text
saved_mice = many persistent records
authoritative_mouse = None | one MouseSession
replacement_candidate = optional non-authoritative candidate during PAIR_NEW
```

The candidate cannot forward authoritative Mouse output until handoff completes.

## 9. ADAPT — Pair New

This is new MBR behavior, not copied from G06:

- 15-second unsaved-only search;
- healthy current Mouse remains authoritative/usable while candidate is qualified;
- saved candidates ignored as Pair New winners;
- first valid unsaved candidate becomes replacement-ready;
- release-safe handoff old -> new;
- old saved record/bond preserved;
- timeout/cancel before handoff keeps old Mouse live;
- manual unplug + Back to HOME activates saved-search resolver, matching Help text.

## 10. ADAPT — USB identity

Preserve fixed-from-boot/no-reenumeration structural safety, but use MBR-00 identity:

- VID `0xCAFE`, PID `0x4011`, bcdDevice `0x0100`;
- manufacturer `tiagooliveirajs`;
- product `Mouse Bridge Remapper`;
- no serial;
- interface 0 Mouse;
- interface 1 minimal synthetic-Escape Keyboard;
- no CDC/debug interface.

Do not preserve old BLU2USB product strings/PID.

## 11. ADAPT — UX

Current product screen reference replaces G06 page hierarchy where specified.

Preserve renderer geometry/color/release/help/lock lessons but use MBR-00 literals:

- single connected Mouse HOME;
- automatic saved-search HOME when no live Mouse;
- Pair New/retry/help flow;
- exact new Help text;
- one saved Mouse per page;
- connected name cyan;
- disconnected status `DISCONNECTED`;
- STANDARD vocabulary;
- deterministic 21-character names;
- frozen didactic coordinates;
- intentional Escape GO TO HOME exception.

## 12. EXCLUDE

Never port as production product behavior:

- G07 Classic Keyboard paths;
- `classic_hid`, `keyboard_transport`;
- BLE Keyboard classification/input;
- Bluetooth Composite logical device support;
- Keyboard/Composite registry/pair/detail screens;
- multi-authoritative-Mouse runtime/aggregator/focus/capacity machinery;
- old BLU2USB `OTHER DEVICES` hierarchy;
- debug CDC/product personality.

## 13. Historical bug classes that must remain regressions

1. renderer pixel relocation regression;
2. Learn/title/coordinate drift;
3. wrong physical Help key;
4. action-on-press instead of release;
5. wrong Back-stack destination;
6. current/selection color collision;
7. stale connection display until next input;
8. hard-coded profile display;
9. optimistic Apply success;
10. stale Custom draft UI;
11. Custom draft reboot loss;
12. bonded Logitech reconnect failure;
13. Report-ID framing shift;
14. stuck held output on disconnect/overflow/profile change/removal/replacement;
15. Logitech Forward click-only instead of true hold;
16. Pico SDK/toolchain bootstrap traps.

These belong in successor gate regressions where relevant.
