# MCORE-01 — Registry & Persistence

Status: **ACCEPTED**.

## Objective

Implement durable product registry/profile/Custom state with recovery and stable identity.

## Dependencies

MCORE-00 ACCEPTED.

## Tasks

1. Persistent saved Mouse schema and stable IDs.
2. Name/profile storage and confirmed state.
3. Global Custom template persistence.
4. Versioned storage schema, integrity/check/recovery, factory reset.
5. Atomic update tests including interrupted writes.

## Automated / documentary acceptance

- [x] power-loss/recovery host fixtures pass
- [x] stable identity never aliases another record
- [x] capacity/encoding follows released contract
- [x] factory reset returns empty safe state

## Human acceptance

- [x] review persistence/recovery evidence

## Deliverables

- registry module
- persistence tests/evidence

## Forbidden scope

- BLE pairing implementation
- UI ordering as storage identity

