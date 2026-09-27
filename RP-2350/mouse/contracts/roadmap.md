# UIC roadmap — UI↔Core Contract v1

| Gate | Name | Primary result | Depends on |
|---|---|---|---|
| UIC-00 | Semantic Inventory | classify every UI 1.0 business rule as UI-local / shared / Core-local | UI Layout 1.0 |
| UIC-01 | Snapshot Model | normative Core→UI state/snapshot semantics and invariants | UIC-00 |
| UIC-02 | Intent Model | normative UI→Core commands, preconditions and idempotency | UIC-01 |
| UIC-03 | Async Results & Ownership | correlation, cancellation, stale/late, ordering, handoff | UIC-02 |
| UIC-04 | Capabilities, Limits & Errors | public limits, name encoding, capabilities, error taxonomy | UIC-03 |
| UIC-05 | v1 Contract Candidate | language-neutral schema + C binding candidate + compatibility rules | UIC-04 |
| UIC-06 | mouse-ui Adapter | UI adapter implements candidate without changing Layout 1.0 | UIC-05 |
| UIC-07 | Core Conformance Harness | Core-side semantic harness/stub passes contract tests | UIC-05 |
| UIC-08 | Contract v1.0.0 Release | immutable released contract with both-side evidence | UIC-06, UIC-07 |

UIC-08 releases the boundary; it does not claim the full physical Core is implemented.
