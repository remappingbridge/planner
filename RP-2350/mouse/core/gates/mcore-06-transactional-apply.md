# MCORE-06 — Transactional Profile/Custom Apply

Status: **BLOCKED**.

## Objective

Make profile/Custom success mean runtime state and persistence have both reached the contract commit point.

## Dependencies

MCORE-05 ACCEPTED.

## Tasks

1. Coordinate remap transition, held-output cleanup and persistence.
2. Rollback/failure behavior for persistence/runtime errors.
3. Publish correlated Pending/Success/Failure according to v1.
4. Custom draft/applied ownership per contract.
5. Power interruption/reboot tests.

## Automated / documentary acceptance

- [ ] no optimistic success
- [ ] failure preserves prior confirmed profile
- [ ] reboot restores committed state
- [ ] contract vectors pass

## Human acceptance

- [ ] physical apply/reboot scenarios accepted

## Deliverables

- Pair handoff/removal

## Forbidden scope

- transaction coordinator
- apply evidence

