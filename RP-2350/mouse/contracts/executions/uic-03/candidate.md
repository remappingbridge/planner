# UIC-03 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human architecture review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-03 — Async Results & Ownership`

Dependency: **UIC-02 ACCEPTED**.

Accepted dependency baselines:

~~~text
remappingbridge/mouse main:
c5a199271eb58c40c527a26926e3eab23e4be5ee

remappingbridge/repo-planner main:
2485ae2add2b0425f8157efb1811d540274a70c2

mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-03-async-results
rollback base: c5a199271eb58c40c527a26926e3eab23e4be5ee
candidate head: 190a235e1990b2adb9a995dee1fd03d8b2d7b759
ahead of main: 16 commits
behind main: 0
~~~

## Normative async model

Primary artifact:

`contracts/ui-core/drafts/uic-03-async-results.md`

UIC-03 defines:

- caller-owned `intent_id`;
- Core-owned unique non-reused `activity_id`;
- one `origin_intent_id` per activity;
- exactly one terminal transition per activity;
- search terminals: SUCCEEDED / TIMED_OUT / FAILED / CANCELLED;
- operation terminals: SUCCEEDED / FAILED / CANCELLED;
- Core-owned monotonic `notification_seq`;
- logical notifications `ACTIVITY_RESULT` and `CONNECTION_CHANGED`;
- `commit_revision` correlation to the atomic Snapshot transition.

## Cancellation decision

Cancellation is frozen as:

**logical invalidation + best-effort physical cancellation**

If cancellation commits first:

- activity becomes terminal CANCELLED;
- confirmed product truth remains uncommitted/unchanged;
- any later physical/backend success is late and cannot mutate confirmed truth.

If success commits first:

- activity is already terminal SUCCEEDED;
- later cancellation is rejected.

CANCELLED is reserved for accepted logical cancellation. Environmental loss produces FAILED; search deadline produces TIMED_OUT.

## Commit points

### Profile

Confirmed profile changes only in the correlated successful PROFILE_APPLY commit.

### Custom

`custom_confirmed` and the target Mouse's confirmed CUSTOM profile change together in one successful commit.

### Pair New

Search qualification does not change authority. HANDOFF success atomically promotes the candidate and changes current authority. No Snapshot may expose two authoritative Mice.

For an authority-changing success commit the logical notification order is:

1. CONNECTION_CHANGED
2. ACTIVITY_RESULT(SUCCEEDED)

### Remove

Offline target: delete at successful removal commit.

Live target:

1. release current authority while record is still saved and REMOVE remains pending;
2. only afterward delete saved record in successful removal commit.

This matches the frozen rule that a live session ends before logical removal commit.

## Physical connection truth

Connection changes are independent of UI screen state.

Physical disconnect of the current Mouse:

- immediately commits `current_mouse_id = null`;
- keeps the saved record and confirmed profile;
- emits CONNECTION_CHANGED;
- leaves screen projection entirely UI-local.

Pending PROFILE_APPLY/CUSTOM_APPLY/HANDOFF that lose required authority cannot later commit as success.

## Race fixtures

Directory:

`contracts/ui-core/fixtures/uic-03/`

Fixtures:

1. `01-cancel-late-profile-success.json`
2. `02-stale-old-operation-after-newer-work.json`
3. `03-disconnect-during-active-profile.json`
4. `04-pair-handoff-success-order.json`
5. `05-live-remove-release-before-delete.json`
6. `06-profile-apply-success-commit.json`
7. `07-custom-apply-success-commit.json`
8. `08-search-timeout-correlated.json`
9. `09-cancel-pair-handoff-late-success.json`

## Automated/documentary validation

Validation executed against the candidate branch.

~~~text
fixture_count: 9
cancel_plus_late_success: PASS
stale_old_operation: PASS
disconnect_during_active_profile: PASS
pair_handoff_order: PASS
single_authority_during_handoff: PASS
live_remove_release_before_delete: PASS
profile_commit_point: PASS
custom_commit_point: PASS
search_timeout_correlated: PASS
cancelled_pair_late_success_no_promotion: PASS
all_terminal_results_correlated: PASS
notification_sequence_monotonic: PASS
snapshot_identity_invariants: PASS
terminal_classification_present: PASS
logical_invalidation_present: PASS
thread/event-loop freeze guard: PASS
validation_errors: 0
~~~

`remappingbridge/mouse` has no repository-native CI workflow, so this documentary/semantic gate is validated through language-neutral sequence fixtures and invariant guards.

## Decision register changes

Resolved by UIC-03:

- OD-006 — ordered logical notification stream independent of concrete callback/poll/queue binding;
- OD-007 — logical invalidation + best-effort physical cancellation;
- OD-008 — unique terminal transition and late/stale completion may not mutate confirmed truth;
- activity side of OD-003 — Core allocates unique non-reused `activity_id` and links it to `origin_intent_id`.

Still open:

- concrete ID widths/encodings;
- exact clock/timer representation;
- public error taxonomy;
- capabilities/limits;
- C ABI, memory ownership and thread-safety.

## Acceptance checklist

Automated/documentary:

- [x] race fixtures cover cancel+late result, stale operation, disconnect during active profile and Pair handoff
- [x] all terminal states are unambiguous and correlated
- [x] ordering prevents dual authoritative Mouse state
- [x] commit points match frozen business rules

Human:

- [x] architecture review accepts cancellation and ordering semantics

## Scope control

Performed:

- normative async/ordering section;
- race sequence fixtures;
- correlation and terminal lifecycle;
- cancellation semantics;
- Pair New ordering;
- profile/Custom/remove commit points;
- screen-independent connection-change semantics;
- UIC-03 evidence.

Not performed:

- threading implementation;
- specific event loop;
- hardware timing proof;
- BLE/USB implementation;
- C ABI;
- UIC-04 work.

## Planner-spec note

As with previous UIC gates, the UIC-03 gate document appears to have the contents of
**Deliverables** and **Forbidden scope** inverted. Execution follows Objective, Tasks,
roadmap and acceptance criteria, which consistently require the normative async/ordering
section, race fixtures and evidence while excluding threading/event-loop/hardware proof.

UIC-03 is accepted. UIC-04 is now the next eligible gate.
