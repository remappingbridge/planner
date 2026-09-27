# UIC-05 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Joint human architecture review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-05 — Contract v1 Candidate`

Dependency: **UIC-04 ACCEPTED**.

Accepted source baselines:

~~~text
remappingbridge/mouse main accepted through UIC-04:
dff0b9c0fadb856b4fe0f2c7f9f4b76f84de984a

remappingbridge/repo-planner main accepted through UIC-04:
3fd2c1e0e552833edb22eb443d43dc11338b326f

mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-05-v1-candidate
rollback base: dff0b9c0fadb856b4fe0f2c7f9f4b76f84de984a
candidate head: 58e817b4c054cca730fef8417f943fd22803a3ad
behind main: 0
~~~

No immutable release directory/version package was created.

## Candidate artifact set

### Consolidated normative specification

`contracts/ui-core/drafts/uic-05-v1-candidate.md`

Consolidates accepted UIC-00..UIC-04 semantics:

- descriptor/version compatibility;
- 64-bit identities and allocation ownership;
- bounded UTF-8 names;
- profile/Custom model;
- stable errors;
- Snapshot and SnapshotReadResult;
- search/operation state;
- complete intent vocabulary;
- asynchronous activity/result lifecycle;
- ordered notification stream;
- Pair/Profile/Custom/Remove commit points;
- cancellation/stale/late protection;
- persistence boundary;
- C execution/ownership/threading model;
- extension policy.

It explicitly records that no MUST-level semantic decision owned by UIC-05 remains open.

### Machine-readable language-neutral schema

`contracts/ui-core/drafts/uic-05-v1.schema.json`

Covers:

- ContractDescriptor;
- SnapshotReadResult / Snapshot;
- Saved Mouse / candidate / Custom;
- search and operation state;
- Intent;
- submission result;
- ActivityResult / ConnectionChanged notifications;
- stable errors and all tagged domains;
- sequence documents for conformance/race vectors.

### Proposed bounded C binding

`contracts/ui-core/drafts/uic-05-c-binding.h`

Candidate C properties:

~~~text
contract major/minor: 1 / 0
mouse_id: uint64_t
intent_id: uint64_t
activity_id: uint64_t
revision: uint64_t
notification_seq: uint64_t
zero ID: reserved none/invalid
max saved mice: 16
max semantic Mouse name: 63 UTF-8 bytes
Custom sources: 5
~~~

Public tagged domains use explicit `uint32_t` constants rather than implementation-defined C enums.

The call surface is:

~~~text
mouse_uic_v1_get_descriptor(...)
mouse_uic_v1_read_snapshot(...)
mouse_uic_v1_submit_intent(...)
mouse_uic_v1_poll_notification(...)
~~~

### Ownership / lifetime

The binding freezes candidate rules:

- provider object is Core/integration-owned;
- caller owns input/output buffers;
- provider cannot retain pointers into caller structs after a call returns;
- no allocator/free operation crosses the boundary;
- output is copied by value;
- one provider instance is externally serialized by caller;
- one provider instance is not reentrant;
- Core internal thread/IRQ/event-loop implementation remains private.

### ABI versus serialization

The C structs are in-process binding objects only.

They are explicitly forbidden as disk/flash/network/wire/IPC serialization formats.

### Schema ↔ C equivalence

`contracts/ui-core/drafts/uic-05-schema-c-equivalence.md`

Defines one-to-one mapping for candidate objects, scalar domains, optional/null flags,
Custom source indexes, submission rules, activity result classes, extension rules and ABI
scope.

### Candidate source/artifact manifest

`contracts/ui-core/drafts/uic-05-candidate-manifest.json`

Records accepted source commits and blob hashes for the candidate's principal artifacts.

## Conformance vectors

Directory:

`contracts/ui-core/fixtures/uic-05/`

Independent candidate vectors:

1. `01-descriptor.json`
2. `02-connected-snapshot.json`
3. `03-profile-apply-sequence.json`
4. `04-limit-rejection.json`
5. `05-cancel-late-sequence.json`
6. `06-pair-handoff-sequence.json`
7. `07-live-remove-sequence.json`
8. `08-snapshot-unavailable.json`
9. `09-custom-apply-sequence.json`
10. `10-search-timeout.json`
11. `11-authority-lost-error.json`

These cover representative state, rejection, cancellation/late work, Pair handoff, live
removal ordering, Custom atomic commit, timeout and initialization/persistence failure.

## UIC-00 full traceability audit

Artifact:

`contracts/ui-core/traceability/uic-05-v1-candidate-coverage.json`

Results:

~~~text
source rules: 88
BR-001..BR-088: complete
duplicate rule IDs: 0

ownership disposition:
- shared semantics -> expressed in v1 candidate
- UI-local -> intentionally excluded
- Core-local -> intentionally excluded
~~~

The candidate therefore provides an explicit disposition for every frozen UIC-00 rule.

## UIC-05-owned decisions closed

Closed in the decision register:

- OD-003 — concrete identity widths/none value;
- OD-016 — global Custom semantic ownership vs private physical persistence;
- OD-017 — proposed exact C candidate binding;
- OD-018 — memory ownership/lifetime;
- OD-019 — thread safety/reentrancy;
- candidate-binding portion of OD-020 — major/minor constants and extension policy.

Remaining planner decisions belong to later implementation/release gates:

- OD-020 immutable release tag/package metadata — UIC-08;
- OD-021 UI adapter — UIC-06;
- OD-022 Core conformance harness — UIC-07;
- OD-023 immutable release package — UIC-08.

No later item is an intentionally undefined MUST-level v1 semantic rule.

## Automated validation

Permanent candidate validator:

`contracts/ui-core/tools/validate_uic05.py`

Workflow:

`.github/workflows/uic-05-candidate.yml`

Final head validation:

~~~text
workflow: UIC-05 candidate validation
run: 35686936476
head_sha: 58e817b4c054cca730fef8417f943fd22803a3ad
status: completed
conclusion: success

steps:
- Validate candidate semantics: success
- Compile C11 binding smoke: success
- Compile C++17 include smoke: success
- Parse all candidate JSON: success
~~~

Validator assertions include:

- semantic schema and C tagged domains agree;
- limits/version constants agree;
- all required capabilities exist;
- no private MUI/BTstack/TinyUSB/HID++/HCI/GATT identifier leaks into C API;
- candidate vector invariants pass;
- candidate manifest/vector set is coherent;
- all 88 UIC-00 rules are covered;
- UIC-05-owned unresolved decisions are closed.

## Repository scope audit

Compared with accepted `mouse` main baseline:

- contract candidate/spec/schema/C binding added;
- candidate fixtures/traceability/validator/CI added;
- README/versioning/decision register updated;
- no `contracts/ui-core/releases/v1...` directory created;
- no mouse-ui layout source changed;
- no mouse-core implementation created/changed;
- no UI adapter implementation started.

## Acceptance checklist

Automated/documentary:

- [x] schema and C binding express the same semantics
- [x] all UIC-00 traceability rows are satisfied
- [x] fixtures validate representative and race cases
- [x] no unresolved MUST-level semantic ambiguity remains

Human:

- [x] joint architecture review accepts candidate as implementable by both repositories

## Scope control

Performed:

- complete v1 candidate spec;
- machine-readable schema;
- proposed C binding;
- ownership/lifetime/threading rules;
- compatibility/extension policy;
- conformance vectors;
- full UIC-00 coverage audit;
- automated C/JSON/semantic validation;
- UIC-05 evidence.

Not performed:

- immutable release directory;
- full Core implementation;
- frontend layout change;
- UI adapter implementation;
- Core conformance harness implementation;
- UIC-06/UIC-07 work.

## Process note

The UIC-05 gate file has the same apparent Deliverables/Forbidden-scope inversion as the
earlier UIC gate documents. Execution follows Objective, Tasks, roadmap and acceptance
criteria: candidate spec/C binding/fixtures/evidence are required, while release
publication, full Core implementation and layout changes are excluded.

UIC-05 is accepted. Under the one-gate-at-a-time execution rule, UIC-06 is now the next eligible gate; UIC-07 remains blocked until UIC-06 is accepted.
