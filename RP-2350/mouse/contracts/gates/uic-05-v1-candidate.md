# UIC-05 — Contract v1 Candidate

Status: **BLOCKED**.

## Objective

Assemble a complete reviewable UI↔Core v1 release candidate from accepted semantics.

## Dependencies

UIC-04 ACCEPTED.

## Tasks

1. Create language-neutral normative schema/spec covering Snapshot, Intent, Event/Result, limits/errors/versioning.
2. Create proposed C binding with explicit ownership/lifetime and bounded types.
3. Define compatibility rules and extension/reserved-field policy.
4. Create machine-readable fixtures/goldens independent of either implementation.
5. Audit names/types for UI or Core implementation leakage.
6. Publish candidate under `contracts/ui-core/drafts/` with exact source evidence.

## Automated / documentary acceptance

- [ ] schema and C binding express the same semantics
- [ ] all UIC-00 traceability rows are satisfied
- [ ] fixtures validate representative and race cases
- [ ] no unresolved MUST-level semantic ambiguity remains

## Human acceptance

- [ ] joint architecture review accepts candidate as implementable by both repositories

## Deliverables

- release directory creation
- full Core implementation
- layout change

## Forbidden scope

- v1 candidate spec
- C binding draft
- fixtures/conformance vectors
- UIC-05 evidence

