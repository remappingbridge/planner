# MCORE-02 — BLE Session Lifecycle

Status: **BLOCKED**.

## Objective

Implement physical Mouse discovery/pairing/reconnect with FIRST/SAVED/PAIR_NEW separation and one authoritative live session.

## Dependencies

MCORE-01 ACCEPTED.

## Tasks

1. CYW43/BTstack lifecycle and security/bonding.
2. Saved-only reconnect qualification.
3. Unsaved-only Pair New qualification.
4. Single authoritative session arbitration.
5. Contract search/current-state publication and cancellation behavior.
6. Physical timing/evidence for product search windows.

## Automated / documentary acceptance

- [ ] host/state tests plus target build green
- [ ] saved candidate rejected by Pair New
- [ ] no two authoritative sessions
- [ ] cancel/timeout leaves valid current session

## Human acceptance

- [ ] physical BLE scenarios on target accepted

## Deliverables

- USB/remap implementation
- Bluetooth keyboard/composite product scope

## Forbidden scope

- BLE lifecycle implementation
- BT evidence
- MCORE-02 record

