# MINT-04 — Recovery & Safety

Status: **BLOCKED**.

## Objective

Prove cancellation, disconnect, stale/late, held-output and power recovery behavior in the composed product.

## Dependencies

MINT-03 ACCEPTED.

## Tasks

1. Disconnect during active profiles.
2. Cancel/Help/Lock during Pair/apply/remove.
3. Delayed backend callbacks after cancellation.
4. Power loss/reboot around persistence/handoff/remove.
5. Held Mouse/Escape cleanup on every teardown.

## Automated / documentary acceptance

- [ ] fault-injection/integration logs cover each race
- [ ] no stale completion violates frozen state

## Human acceptance

- [ ] physical recovery/safety suite accepted

## Deliverables

- performance tuning that changes semantics

## Forbidden scope

- recovery evidence
- MINT-04 record

