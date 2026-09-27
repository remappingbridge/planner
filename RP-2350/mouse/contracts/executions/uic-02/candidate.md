# UIC-02 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-02 — Intent Model`

Dependency: **UIC-01 ACCEPTED**.

Accepted dependency baselines:

~~~text
remappingbridge/mouse main:
b324fc7733036958005a29b23686c304ea182a07

remappingbridge/repo-planner main:
45fd3f95880a03484eb3bbc6a67dec8a7bb692b9

mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-02-intent-model
rollback base: b324fc7733036958005a29b23686c304ea182a07
candidate head: 568e5fe758f0f4effd83b50f68e5911ed0b517d3
ahead of main: 17 commits
behind main: 0
~~~

## Normative intent vocabulary

`contracts/ui-core/drafts/uic-02-intent-model.md`

Defines exactly seven UI→Core intent kinds:

1. `START_FIRST_SEARCH`
2. `START_SAVED_SEARCH`
3. `START_PAIR_NEW`
4. `CANCEL_ACTIVITY`
5. `APPLY_PROFILE`
6. `APPLY_CUSTOM`
7. `REMOVE_MOUSE`

No intent names a UI screen or navigation command.

## Ownership and identity decisions

UIC-02 establishes:

- caller/UI-generated opaque `intent_id`;
- retry of the same logical request reuses the same ID;
- same ID + same payload => `REPLAY`, no duplicate side effect;
- same ID + different payload => `REJECTED`;
- Mouse-targeting intents always use stable `target_mouse_id`;
- list/page indexes are never contract targets;
- Custom row editing and dirty draft remain UI-local;
- only the complete five-source Custom mapping crosses via `APPLY_CUSTOM`.

Submission semantics are `ACCEPTED | REPLAY | REJECTED`. Acceptance is not asynchronous success.

## Preconditions / invalid cases

The intent model explicitly defines preconditions for search, Pair New, cancellation, profile apply, Custom apply and removal.

Examples of rejected requests include:

- first search while saved records exist;
- saved search while a current Mouse exists;
- Pair New without a current Mouse;
- profile/Custom apply to stale or non-current identity;
- APPLY_PROFILE with CUSTOM;
- incomplete/invalid Custom mapping;
- remove unknown identity;
- cancel unknown/non-current activity;
- intent-ID collision.

Rejected intents create no side effect.

## Language-neutral fixtures

Directory:

`contracts/ui-core/fixtures/uic-02/`

Fixtures:

1. `01-start-first-search.json`
2. `02-start-saved-search.json`
3. `03-start-pair-new.json`
4. `04-cancel-activity.json`
5. `05-apply-profile.json`
6. `06-apply-custom.json`
7. `07-remove-mouse.json`
8. `08-stale-target-rejected.json`
9. `09-safe-replay.json`
10. `10-id-collision-rejected.json`
11. `11-incomplete-custom-rejected.json`

JSON is test notation only, not the final wire format or C ABI.

## Frozen UI action traceability

The candidate maps every shared UI action to exactly one contract intent or proves it UI-local:

- first discovery → START_FIRST_SEARCH;
- saved reconnect retry → START_SAVED_SEARCH;
- Pair New → START_PAIR_NEW;
- abandon shared async work via Back/Help/Lock/leave → CANCEL_ACTIVITY;
- Passthrough/Standard/Escape apply → APPLY_PROFILE;
- Custom row edit → UI-local;
- Apply Custom → APPLY_CUSTOM;
- Remove This confirmation → REMOVE_MOUSE;
- HOME, Help, Lock, Back, pagination, selection, Learn the Keys → UI-local except cancellation of owned shared activity.

## Automated/documentary validation

Validation executed against the candidate branch.

~~~text
fixture_json_count: 11
json_parse: PASS
all_normative_kinds_have_accepted_example: PASS
stable_identity_targeting: PASS
no_UI_navigation_fields_in_intents: PASS
custom_complete_mapping_guard: PASS
safe_replay_fixture: PASS
intent_id_collision_fixture: PASS
explicit_preconditions: PASS
explicit_invalid_behavior: PASS
retry_idempotency_rules: PASS
frozen_UI_action_mapping: PASS
no_screen_intent: PASS
C_ABI_freeze_guard: PASS
validation_errors: 0
~~~

`remappingbridge/mouse` has no repository-native CI workflow, so UIC-02 is validated by language-neutral semantic fixture checks and documentary guards.

## Decision register changes

Resolved by UIC-02:

- OD-004 — caller/UI allocates `intent_id`;
- OD-005 — semantic submission disposition is ACCEPTED/REPLAY/REJECTED;
- OD-015 — Custom draft/editing UI-local; complete mapping only on APPLY_CUSTOM.

Partially resolved:

- OD-003 — identity semantics/allocation fixed; concrete type/width remains deferred.

Still deferred to UIC-03 or later:

- result delivery mechanism;
- hard/best-effort/logical cancellation guarantee;
- stale/late result lifetime;
- exact timer ownership;
- public error taxonomy;
- capabilities/limits;
- C ABI and memory/threading rules.

## Acceptance checklist

Automated/documentary:

- [x] every shared UI action maps to one normative intent or is proven UI-local
- [x] intents reference stable identities rather than list indexes
- [x] preconditions/invalid cases are explicit
- [x] no intent names a UI screen

Human:

- [x] review accepts command vocabulary and Custom ownership decision

## Scope control

Performed:

- normative Intent section;
- intent fixtures/examples;
- precondition/invalid-request semantics;
- retry/idempotency semantics;
- Custom ownership decision;
- UIC-02 evidence.

Not performed:

- result delivery mechanism;
- BLE/USB commands;
- screen navigation API;
- C ABI freeze;
- UIC-03 implementation.

## Planner-spec note

The UIC-02 gate document again appears to have the contents of **Deliverables** and **Forbidden scope** inverted. Execution follows the Objective, Tasks, roadmap and acceptance criteria, which consistently require the normative Intent model, fixtures/examples and evidence.

UIC-02 is accepted. UIC-03 is now the next eligible gate.
