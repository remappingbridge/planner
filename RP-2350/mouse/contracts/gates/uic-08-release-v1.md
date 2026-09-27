# UIC-08 — UI↔Core Contract v1.0.0 Release

Status: **BLOCKED**.

## Objective

Promote the proven candidate to an immutable shared contract release and pin compatible component revisions.

## Dependencies

UIC-06 ACCEPTED and UIC-07 ACCEPTED.

## Tasks

1. Resolve all candidate feedback and freeze normative language/schema/C binding.
2. Create `contracts/ui-core/releases/v1.0.0/` with immutable artifacts.
3. Record mouse-ui adapter commit and mouse-core conformance commit implementing v1.
4. Define compatibility/version declaration mechanism for both components.
5. Run complete shared conformance suite from neutral fixtures.
6. Update mouse, mouse-ui, mouse-core and planner documentation to reference released v1.

## Automated / documentary acceptance

- [ ] neutral conformance suite green on both sides
- [ ] release tree contains no unresolved normative TODO
- [ ] versioning/compatibility declaration is testable
- [ ] release artifacts are content-stable

## Human acceptance

- [ ] explicit human acceptance of the v1 boundary and release readiness

## Deliverables

- immutable UI↔Core v1.0.0
- component compatibility pins
- UIC-08 evidence

## Forbidden scope

- full product integration claim
- hardware acceptance claim
- post-release semantic edits in place

