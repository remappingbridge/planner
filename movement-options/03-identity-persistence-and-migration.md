# Per-Mouse persistence, identity, migration and deletion

Status: PLANNED / NOT IMPLEMENTED.

## Existing truth and problem
- v1.0 has separate BLE bonds in BTstack LE Device DB, plus persistent names in a BTstack TLV product record keyed by LE address type/address/IRK. A saved-device *page number* or raw BTstack DB slot number is NOT a stable identity.
- Saved Devices pages are logical, with currently connected peer shown first.
- Button mapping profile state is currently one global 14-byte serialized product record; it is NOT already a complete per-Mouse settings registry in the actual code, despite some older architectural aspirations. New movement persistence must not quietly assume the global profile record is per-device.
- v1.0 product storage capacity is 64-byte payload with double sector backing; eight full BLE identities (type+addr+IRK) and movement factors would not fit if appended to global 14-byte record.
- The profile/custom record and saved-name TLV MUST remain untouched/compatible by migration.

## Persistent MovementProfile (per logical saved Mouse)
Proposed conceptual record:

    MovementProfileV1:
       key: logical BLE identity (address type, 6-byte address, IRK when present)
       horizontal_gain_quarters: uint8 enum {1,2,3,4,5,6,8,12}
       vertical_gain_quarters:   uint8 enum {1,2,3,4,5,6,8,12}
       rotation_ccw_quadrants:    uint8 enum {0,1,2,3}
       schema_version / validity metadata

Defaults: horizontal=4/4 (1x); vertical=4/4 (1x); rotation=0. Missing or invalid data is treated as a default for that Mouse only, not copied from another Mouse.

Uniqueness: use existing BLE bond equivalence logic (same identity address or identity resolving key/IRK), not string/name, connect order, display order or transient random resolvable BLE address. Key capture and compare MUST be performed through the established BTstack identity semantics. Never publish or log BLE addresses or other identity internals as screen content.

Capacity: support at least all eight currently UI-addressable saved Mice. Reject a storage mutation that would silently evict another bonded Mouse's preferences; apply must remain unconfirmed rather than silently losing data.

## Persistence design decision: separate versioned TLV tag(s)
Use a dedicated, schema-versioned movement registry in the existing BTstack TLV/flash infrastructure, separate from:
- existing BTstack bond keys;
- existing names tag;
- product profiles/custom serialized 14-byte record.

Before implementing, audit actual reserved tags, TLV API, flash ownership and maximum supported value size. Assign collision-free tag(s), freeze layout/endian encoding, and create golden serialization vectors. Suggested robust approach: two independently tagged slots with generation counter and checksum plus readback, selecting newest valid slot; if the underlying TLV already guarantees atomic replacement and recovery, document and test that guarantee before simplifying. No flash-sector overlap, no global product storage size increase just to hold identity records, no reinitialization of saved names.

Save operation is identity-scoped and all-or-nothing:
1. Capture logical connected identity and expected settings generation when opening Movement Options.
2. On Apply/Reset, verify captured identity is still the current same saved Mouse.
3. Build a complete candidate record copy changing only the selected axis/angle (or resetting all).
4. Validate factor/rotation enums, uniqueness, size and limits.
5. Write new version to inactive slot/commit target; verify success/readback/CRC.
6. Swap active RAM profile to committed version only when confirmed, then acknowledge to UX.
7. On any error, keep previous confirmed RAM and old valid record; keep editor state and avoid a false cyan new current value.

A device reconnect in another physical LE slot must map to the same MovementProfile via the same logical identity. The connected Mouse's movement settings are loaded on connection confirmation; when Mouse A disconnects, Mouse B's settings must not be inherited by B. UI always queries saved peers' profiles by identity.

## Migration / compatibility with v1.0
- On upgrading untouched 1.0 firmware: movement registry does not exist, so all existing saved Mice appear with H=1x V=1x Rotation=0°; prior button mapping and global CustomTemplate remain intact, with no forced erase/re-pair.
- Firmware reboot with valid v1 movement registry restores exactly the saved per-Mouse values and UI correct cyan fields; invalid/partial registry falls back safely to last valid copy or defaults (never hard fault / erase BLE DB).
- Downgrade to old v1.0 should ignore new movement TLV. Re-upgrade should preserve it if old firmware did not erase its tag. Test this claim against actual BTstack flash storage behavior, do not assume compatibility blindly.
- Future schema versions require explicit migration tests. Unknown versions must not be parsed as valid v1 records.
- Pair New: a genuinely new Mouse gets defaults; a correctly resolved already-saved identity retains its record; no accidental duplication due to a random BLE private address.
- Two identical mouse names are not two identities; never key by name or displayed page number.

## Remove device (source requires settings cleanup)
Existing removal pins a target logical bond identity and deletes equivalent bond/name records, including disconnect and HID release if connected. Extend the existing path to purge the corresponding movement profile atomically/idempotently:
- capture identity BEFORE deleting bond slots;
- on user Key A, perform existing ownership release/disconnect policy unchanged;
- only purge movement record of that precise identity, no neighbors;
- coordinate removal events and persistence failure/partial reboot so an orphaned record cannot later attach to an unrelated bond;
- clean orphans on boot by checking real saved identities, but do not wipe valid identity records merely because a Mouse is temporarily disconnected;
- prevent double removal confirmation, page reordering race, stale selected ordinal and deletion of wrong mouse;
- after final deletion, no H/V/rotation restoration on re-pairing as a newly saved Mouse.

If flash write fails after a bond was deleted, preserve a recoverable/tombstone cleanup intention or idempotent next-boot garbage collection. Do not display an untrue 'preferences deleted' confirmation. Gate must include fault injection for this case; settle exact on-device failure presentation using accepted screens (no extra unrequested error screen) before writing production firmware.

## Host-side tests
- serialization round-trip, version, CRC/generation, A/B slot failure, read-back mismatch and erased/uninitialized flash;
- 1->8 bonded Mice, distinct settings, identical names, different addresses, resolved IRK equivalence, BLE slot reuse/reordering;
- moving current connected Mouse to page 1 changes only presentation, not state association;
- apply H or V leaves other values/rotation unchanged; Reset All touches only target Mouse;
- USB/event pipeline and screen show one consistent committed version; save failure leaves old values;
- disconnect/reconnect, pairing, stale apply command and BLE background changes during selection;
- remove A while B connected, remove current A, deletion failure, re-pair A, duplicates/orphans cleanup;
- backward compatibility of original 14-byte profile record and saved names; no modification to unrelated tags.
