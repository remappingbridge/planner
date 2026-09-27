# UIC-00 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human architecture acceptance: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-00 — Semantic Inventory`

Planner source:
`mouse/contracts/gates/uic-00-semantic-inventory.md`.

## Dependency proof

Frozen UI source:

~~~text
repository: remappingbridge/mouse-ui
stable ref: release/ui-layout-v1.0
commit: e8adad7919e931c92515bf655ef4050876a8e7a9
product document: docs/product/ui-layout-v1.0.md
~~~

GitHub Actions dependency evidence:

~~~text
workflow: mouse-ui CI
run: 35682121924
head_sha: e8adad7919e931c92515bf655ef4050876a8e7a9
status: completed
conclusion: success
jobs:
  host-debug: success
  host-asan-ubsan: success
~~~

The stable branch `release/ui-layout-v1.0` resolves to the same commit.

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-00-semantic-inventory
rollback base: 7e238af7d2e4b642be9efb98bccf7c8711f04f84
candidate head: 5d1ac8edfd0c182e3fd8052826a7605bf22a1477
~~~

Changed contract artifacts:

1. `contracts/ui-core/drafts/ui-layout-v1.0-semantic-boundary.md`
2. `contracts/ui-core/traceability/uic-00-semantic-inventory.md`
3. `contracts/ui-core/drafts/uic-00-unresolved-decisions.md`

No `mouse-ui` implementation, `mouse-core` implementation or frozen UI Layout 1.0 source was modified.

## Documentary/automated validation

~~~text
rule_rows: 88
unique_rule_ids: PASS
allowed_single_ownership: PASS
source_sections_1_to_16_covered: PASS
all_shared_rows_have_rationale: PASS
draft_has_data_actions_results: PASS
unresolved_list_present: PASS
no_c_binding_frozen: PASS
no_private_mui_type_normative: PASS
~~~

## Acceptance checklist

Automated/documentary:

- [x] every frozen business rule has exactly one ownership classification
- [x] no private UI/Core implementation type is made normative
- [x] cross-boundary candidates are traceable to product behavior
- [x] open questions are explicitly enumerated

Human:

- [x] architecture review accepts the ownership split and absence of accidental coupling

## Scope control

Performed:

- semantic inventory/matrix;
- updated contract draft/traceability;
- unresolved-decision list;
- UIC-00 execution evidence.

Not performed:

- C ABI freeze;
- Core implementation;
- UX/layout changes;
- transport-specific API design;
- UIC-01 work.

## Acceptance result

UIC-00 is accepted. UIC-01 is now the next eligible gate.
