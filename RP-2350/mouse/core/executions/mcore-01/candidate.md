# MCORE-01 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human persistence/recovery acceptance: **ACCEPTED by user on 2026-09-22**.

## Gate

MCORE-01 — Registry & Persistence

Dependency: **MCORE-00 ACCEPTED**.

Released contract baseline remains:

~~~text
remappingbridge/mouse
UI↔Core Contract v1.0.0
main release commit:
b26f77e27372bfcd7aa54235354b163394484a67
stable ref:
release/ui-core-v1.0.0
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse-core
branch: mcore/mcore-01-registry-persistence
rollback base:
4c3e339c16535b429e5ea53354f084a2052345a5
candidate head:
b006a25bed3a6a36fa76513494a3af1b7a81a789
ahead of main: 21
behind main: 0
~~~

## Persistent product state

The registry now durably owns:

- stable saved Mouse IDs;
- bounded UTF-8 Mouse names;
- confirmed profile per saved Mouse;
- global confirmed Custom mapping;
- monotonic next Mouse ID;
- persistence generation.

It intentionally does **not** persist:

- current/live session authority;
- search state;
- pending operation state;
- notification/replay runtime state;
- UI ordering or screen/navigation state.

## Stable identity

Mouse IDs are allocated monotonically.

Deleting a saved Mouse does not return its ID to the allocation pool.

The next ID is persisted, so reboot cannot cause aliasing with a previously deleted
record.

Factory reset is the only operation that intentionally restarts the registry namespace.

## Versioned binary schema

Schema version:

~~~text
MCORE_REGISTRY_SCHEMA_VERSION = 1
record bytes = 1272
journal records = 2
~~~

Record fields are explicitly encoded little-endian:

- magic;
- schema version;
- record size;
- generation;
- next Mouse ID;
- saved count;
- reserved field;
- five global Custom targets;
- 16 fixed saved-Mouse slots;
- CRC32.

Each saved slot stores:

- 64-bit stable ID;
- confirmed profile;
- one-byte UTF-8 name length;
- 63 name bytes.

The format is not produced by dumping C structs.

## Rolling recovery journal

The durable blob keeps at most two complete generations:

~~~text
[N]
[N, N+1]
[N+1, N+2]
~~~

The newest valid generation is selected during recovery.

Validation requires:

- matching magic;
- supported schema version;
- expected record size;
- CRC32;
- valid IDs/profiles/Custom targets;
- unique saved IDs;
- saved IDs below the persisted next ID;
- released capacity/name constraints.

A torn/incomplete newest record is ignored.

A CRC-corrupt newest record falls back to the prior valid generation.

If no valid generation exists, Core publishes:

~~~text
SnapshotReadResult = UNAVAILABLE
error = PERSISTENCE_FAILURE
retryability = LATER
visibility = GENERIC_USER_FAILURE
~~~

rather than fabricating an empty registry.

## Persistence commit boundary

The MCORE-00 blob seam is now documented as an atomic durable commit boundary:

~~~text
store() == OK
=> complete new blob is durable

store() failure
=> prior committed blob remains readable

erase() == OK
=> durable empty storage

erase() failure
=> prior committed blob remains readable
~~~

The physical flash/page mechanism remains private to a later platform-driver gate.

## No optimistic confirmed state

Registry mutations build a candidate image and call persistence first.

Only after persistence success does the in-memory confirmed state change.

This applies to:

- add Mouse;
- profile change;
- global Custom change;
- remove Mouse.

A failed store leaves generation and confirmed state unchanged.

## Factory reset

Successful reset:

- erases durable data;
- saved_count = 0;
- current Mouse = none;
- search/operation state cleared;
- Custom returns to identity mapping;
- generation = 0;
- next Mouse ID = 1;
- Snapshot remains available.

Failed erase preserves the prior durable and in-memory confirmed state.

## Released contract constraints

Host tests verify:

- maximum 16 saved Mouse records;
- 63 UTF-8 byte names accepted;
- 64-byte name rejected;
- embedded NUL rejected;
- malformed UTF-8 rejected;
- public profile/Custom domains respected.

## Power-loss and corruption fixtures

The fake platform now supports:

- fail-next-store while preserving prior durable blob;
- fail-next-erase;
- persistence truncation;
- persisted-byte corruption.

MCORE-01 fixtures prove:

1. durable reboot round-trip;
2. saved/profile/Custom recovery;
3. deleted IDs are not reused after reboot;
4. failed store is not optimistic;
5. journal truncated after one complete generation recovers prior state;
6. corrupt newest CRC recovers prior state;
7. corrupt only generation produces Snapshot UNAVAILABLE;
8. successful factory reset returns empty safe state;
9. failed factory reset preserves previous state;
10. live/current session authority is not persisted.

## Architecture guard

New guard:

~~~text
cmake/Mcore01RegistryGuard.cmake
~~~

It verifies required format-version markers and rejects direct ABI-struct serialization
patterns such as persistence by copying `mouse_uic_v1_snapshot_t` or
`mouse_uic_v1_saved_mouse_t` memory layouts.

Final result: **PASS**.

The inherited MCORE-00 platform guard was made identifier-specific after a comment word
("intentionally") triggered the broad substring "intent". This was a guard-only false
positive; no platform seam had acquired contract/UI state.

## Documentation

Added:

~~~text
docs/architecture/mcore-01-registry-persistence.md
~~~

It documents:

- persistent ownership;
- exact binary layout;
- rolling journal;
- recovery rules;
- stable-ID policy;
- UTF-8/capacity constraints;
- factory-reset behavior;
- later-gate boundaries.

## Final CI

~~~text
repository: remappingbridge/mouse-core
workflow: mouse-core MCORE-01 registry persistence
run: 35691522521
head: b006a25bed3a6a36fa76513494a3af1b7a81a789
conclusion: SUCCESS
~~~

Both matrix jobs passed:

- host-debug
- host-asan-ubsan

Pre-build verification passed:

~~~text
UI-Core v1.0.0 release validation PASS
mouse-core UI-Core contract declaration PASS: v1.0.0 provider
MCORE-00 architecture guard PASS
MCORE-01 registry architecture guard PASS
~~~

CTest:

~~~text
1/6 uic07_core_conformance                 PASS
2/6 mcore00_foundation                     PASS
3/6 mcore01_registry_persistence           PASS
4/6 uic07_architecture_guard               PASS
5/6 mcore00_architecture_guard             PASS
6/6 mcore01_registry_architecture_guard    PASS

100% tests passed, 0 failed out of 6
~~~

Existing conformance probe remains green:

~~~text
UIC-07 probe PASS: rev=201 current=2 saved=2 notifications=3
~~~

## Scope control

Implemented:

- saved-Mouse registry module;
- stable monotonic identity allocation;
- versioned persistent schema;
- explicit encoding/decoding;
- CRC32 integrity;
- two-generation recovery journal;
- confirmed profile persistence;
- global Custom persistence;
- factory reset;
- corruption/interruption host fixtures;
- boot restoration into the Core Snapshot;
- persistence/recovery documentation and evidence.

Not implemented:

- BLE pairing/bonding;
- real physical flash/page driver;
- UI ordering as persistent identity;
- physical BLE scenarios;
- MCORE-02 work.

## Physical testing

MCORE-01 has no explicit physical acceptance requirement.

Its persistence/recovery requirement is satisfied at this gate by deterministic host
fixtures above the abstract persistence commit seam.

The next gate, MCORE-02, introduces real CYW43/BTstack BLE lifecycle and requires physical
target scenarios.

## Acceptance checklist

Automated/documentary:

- [x] power-loss/recovery host fixtures pass
- [x] stable identity never aliases another record
- [x] capacity/encoding follows released contract
- [x] factory reset returns empty safe state
- [x] debug and ASan/UBSan CI pass
- [x] released v1 conformance remains green
- [x] persistent format is versioned and CRC-protected
- [x] ABI structs are not used as the flash representation

Human:

- [x] review persistence/recovery evidence

MCORE-01 is accepted. MCORE-02 is now the next eligible gate.
