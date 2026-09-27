# UIC-01 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-01 — Snapshot Model`

Dependency: **UIC-00 ACCEPTED**.

Accepted dependency baselines:

~~~text
remappingbridge/mouse main:
39bad92c8b83e9728ebbaea101e80f2119987e9a

remappingbridge/repo-planner main:
a5458cc316de9d9b1580300dea22a931b00414d3

mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-01-snapshot-model
rollback base: 39bad92c8b83e9728ebbaea101e80f2119987e9a
candidate head: 6bbb96698a10548b58ad405824a7cceac2e20b9a
ahead of main: 12 commits
behind main: 0
~~~

## Implemented artifacts

### Normative Snapshot draft

`contracts/ui-core/drafts/uic-01-snapshot-model.md`

Defines language-neutral semantics for:

- monotonic Snapshot revision within one producer lifetime;
- saved Mouse stable identity/name/confirmed profile;
- zero/one authoritative current Mouse;
- confirmed global Custom mapping;
- observable search state;
- observable operation state;
- atomic publication;
- confirmed vs requested/pending separation;
- removal and handoff consistency;
- immutable value/lifetime semantics independent of callbacks.

It explicitly forbids screen/navigation/pixel/SDL/Inspector and backend transport internals.

### Boundary integration

`contracts/ui-core/drafts/ui-layout-v1.0-semantic-boundary.md`

UIC-01 promotes the Snapshot portion from candidate inventory to normative working semantics and points to the dedicated model.

### Decision resolution

`contracts/ui-core/drafts/uic-00-unresolved-decisions.md`

Resolved:

- OD-001 — language-neutral Snapshot schema;
- OD-002 — Snapshot atomicity/revision semantics.

No C ABI or async transport decision was pulled forward.

### Language-neutral fixtures

Directory:

`contracts/ui-core/fixtures/uic-01/`

Required scenarios:

1. `01-first-use.json`
2. `02-connected.json`
3. `03-offline.json`
4. `04-pending-profile-apply.json`
5. `05-dirty-custom-ui-local.json`
6. `06-removal-pending.json`
7. `07-handoff-pending.json`

The JSON files are fixture notation, not a released wire format.

## Snapshot invariants

The candidate establishes:

1. saved Mouse IDs are unique;
2. current Mouse is null or exactly one saved identity;
3. saved records expose only confirmed profile;
4. requested/pending profile is carried separately in operation state;
5. Custom confirmed state has exactly five sources;
6. dirty/editable Custom draft remains UI-local;
7. at most one observable search and one observable operation exist in a Snapshot;
8. Pair New handoff may target an unsaved candidate while old current remains authoritative;
9. Snapshot publication is atomic;
10. Snapshot revisions are immutable semantic values once observed.

## Automated/documentary validation

Validation was executed directly against the candidate branch fixture contents.

Results:

~~~text
fixture_count: 7
json_parse: PASS
unique_saved_ids: PASS
current_is_null_or_saved: PASS
confirmed_profile_domain: PASS
custom_source_count_and_domain: PASS
snapshot_forbidden_UI_fields: PASS
pending_confirmed_vs_requested_separation: PASS
dirty_custom_does_not_leak_into_snapshot: PASS
remove_target_identity_consistency: PASS
handoff_preserves_old_authority: PASS
handoff_candidate_not_prematurely_saved: PASS
snapshot_atomicity_rule_present: PASS
single-authority_rule_present: PASS
revision_semantics_present: PASS
C-binding-freeze guard: PASS
~~~

`remappingbridge/mouse` still has no repository-native CI workflow, so this gate is validated by language-neutral fixture/invariant checks rather than a code build.

## Cross-boundary UI 1.0 representability

The Snapshot model can represent the frozen cross-boundary product families:

| UI/product family | Snapshot representation |
|---|---|
| first use | empty saved set + null current + FIRST search |
| connected HOME | saved record + current identity + confirmed profile |
| saved/offline HOME | saved records + null current + SAVED search |
| Pair New | PAIR_NEW search candidate + HANDOFF operation |
| profile apply | confirmed profile remains on saved record; requested profile exists only in operation |
| Custom editor | confirmed mapping in Snapshot; dirty draft remains UI-local |
| removal | REMOVE target by stable identity |
| disconnect | current becomes null without changing saved confirmed profile |
| timeout/failure/cancel | search/operation status domains represent terminal states |
| stale/late correlation | activity identity is represented; exact lifecycle rules remain UIC-03 |

## Acceptance checklist

Automated/documentary:

- [x] fixtures can reproduce all cross-boundary UI 1.0 state families
- [x] Snapshot contains no screen/navigation/pixel fields
- [x] Snapshot invariant forbids more than one current authoritative Mouse
- [x] confirmed profile cannot be confused with requested/pending profile

Human:

- [x] review accepts Snapshot as sufficient for all frozen UI screens/flows

## Scope control

Performed:

- normative Snapshot semantics;
- language-neutral fixtures;
- Snapshot traceability/compatibility analysis;
- UIC-01 execution evidence.

Not performed:

- final event transport API;
- backend driver objects;
- frontend-private Product View changes;
- C ABI freeze;
- UIC-02 intent implementation.

## Planner-spec note

As in UIC-00, the UIC-01 gate document appears to have the contents of **Deliverables** and **Forbidden scope** inverted. The candidate follows the Objective, Tasks, roadmap and acceptance criteria, which consistently require Snapshot semantics, fixtures and evidence while excluding final event transport/backend/frontend-private implementation.

## Review focus

Human review should confirm:

- `current_mouse_id` being a single nullable identity is sufficient to encode all live-authority truth;
- saved collection order is correctly non-normative;
- `custom_confirmed` is sufficient while draft/dirty remain UI-local;
- operation-requested profile/custom data are sufficient to distinguish pending from confirmed state;
- revision semantics are sufficient without freezing callback/event delivery;
- Pair New pending handoff correctly leaves the new candidate outside saved records until success.

UIC-01 is accepted. UIC-02 is now the next eligible gate.
