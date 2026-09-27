# MINT-06 — Product Release Candidate

Status: **BLOCKED**.

## Objective

Freeze a reproducible product release candidate with exact component pins, artifacts, documentation and rollback point.

## Dependencies

MINT-05 ACCEPTED.

## Tasks

1. Pin UI/Core/contract/integration commits.
2. Build distributable firmware artifacts and hashes.
3. Create release notes and user/technical docs.
4. Define upgrade/factory-reset/storage compatibility.
5. Create stable release reference and rollback reference.

## Automated / documentary acceptance

- [ ] clean rebuild reproduces artifacts/hashes or documented deterministic exceptions
- [ ] all release gates green

## Human acceptance

- [ ] explicit product release acceptance

## Deliverables

- unreviewed post-freeze changes

## Forbidden scope

- product release candidate
- artifact hashes
- version manifest
- MINT-06 evidence

