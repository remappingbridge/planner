# UIC-06 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human acceptance: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-06 — mouse-ui Adapter`

Dependency: **UIC-05 ACCEPTED**.

Accepted baselines:

~~~text
mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9

remappingbridge/mouse accepted UIC-05 candidate:
af7d037646cd0e2917c81eee6acd1f0eb6592921

remappingbridge/repo-planner accepted through UIC-05:
0095f141c7e9dc41c93f471ae80b11b1bc43468e
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse-ui
branch: uic/uic-06-ui-adapter
rollback base: e8adad7919e931c92515bf655ef4050876a8e7a9
candidate head: f561e09c5562b75971741a0c3764f34e37390c97
ahead of main: 30 commits
behind main: 0
~~~

No UIC-06 implementation change was required in `remappingbridge/mouse`; the accepted
UIC-05 candidate proved sufficient as written.

## Adapter architecture

UIC-06 adds a thin frontend-owned backend seam:

~~~text
real UIC v1 provider --> contract adapter --+
                                            +--> mui_backend_t --> private Product View
deterministic mock -------------------------+
                                                     |
                                                     v
                                            existing navigation
                                                     |
                                                     v
                                            existing projector
                                                     |
                                                     v
                                            existing renderer
~~~

Primary files:

- `include/mouse_ui/adapter/backend.h`
- `src/adapter/backend.c`
- `include/mouse_ui/adapter/contract_adapter.h`
- `src/adapter/contract_adapter.c`
- `include/mouse_ui/contract/uic_v1.h`

The navigation layer no longer needs a concrete mock API for normal product-state access
or semantic command dispatch.

The deterministic desktop mock implements the same backend seam and remains available for
all existing scenarios/fault injection.

## Exact candidate source

The accepted UIC-05 C binding is vendored into:

`include/mouse_ui/contract/uic_v1.h`

CI checks out exactly:

~~~text
remappingbridge/mouse
af7d037646cd0e2917c81eee6acd1f0eb6592921
~~~

and byte-compares:

~~~text
mouse-ui/include/mouse_ui/contract/uic_v1.h

against

mouse/contracts/ui-core/drafts/uic-05-c-binding.h
~~~

Final CI result: **PASS**.

The frontend does not independently redefine or version the shared contract.

## Snapshot -> private Product View mapping

The contract adapter maps:

- 64-bit stable Mouse identity;
- bounded semantic Mouse name;
- saved Mouse records;
- current authoritative Mouse;
- confirmed profile;
- confirmed global Custom mapping;
- search purpose/status/activity identity;
- operation kind/status/activity identity;
- requested profile where applicable.

Atomic Snapshot refresh remains the authoritative source for Product View.

Ordered notifications are drained for correlation/order validation, including monotonic
`notification_seq`, then the adapter refreshes the authoritative Snapshot.

## UI-local state remains UI-local

The adapter does not source the following from Core:

- screen;
- navigation selection/page;
- Help ownership;
- Lock;
- pressed-control ownership;
- framebuffer/projector metadata;
- editable Custom draft/dirty state.

`EDIT_CUSTOM_TARGET` is handled entirely inside the UI adapter/backend layer and emits
no public contract command.

Only the complete mapping crosses the boundary through APPLY_CUSTOM.

## Intent mapping

| Existing UI semantic intent | Candidate command |
|---|---|
| SEARCH_FIRST | START_FIRST_SEARCH |
| SEARCH_SAVED | START_SAVED_SEARCH |
| PAIR_NEW | START_PAIR_NEW |
| CANCEL_SEARCH | CANCEL_ACTIVITY(search activity ID) |
| CANCEL_OPERATION | CANCEL_ACTIVITY(operation activity ID) |
| APPLY_PROFILE | APPLY_PROFILE |
| APPLY_CUSTOM | APPLY_CUSTOM |
| REMOVE_MOUSE | REMOVE_MOUSE |
| EDIT_CUSTOM_TARGET | UI-local only |

The adapter allocates caller-owned 64-bit intent IDs and consumes Core-owned 64-bit
activity IDs without narrowing.

## Private identity compatibility

Private frontend identity/token storage was widened to 64 bits.

Adapter tests explicitly exercise:

~~~text
mouse_id    = 0x100000001
activity_id = 0x200000001
~~~

and verify round-trip mapping without truncation.

The widening is internal and does not change screen content/layout.

## Pair New ordering

The real candidate makes Pair New two-stage:

1. PAIR_NEW search finds an unsaved candidate;
2. HANDOFF atomically changes authority.

UIC-06 adds a regression proving:

~~~text
PAIR_NEW FOUND + HANDOFF PENDING
=> remain on Pair New
=> old Mouse remains current

HANDOFF SUCCEEDED + current Mouse becomes candidate
=> return to HOME_CONNECTED
~~~

The deterministic mock already completed these two semantic stages together, so its
accepted visible behavior is unchanged.

## Timeout ownership

Core remains the semantic owner of FIRST/SAVED 8 s and PAIR_NEW 15 s timeouts.

Frontend adapter time fields are presentation/test metadata only. The contract backend
never changes RUNNING to TIMED_OUT locally.

## Error boundary

Snapshot UNAVAILABLE and stable candidate error semantics are accepted by the adapter.

Provider diagnostic strings remain opaque.

UIC-06 does not invent new screen-specific error copy or change frozen error UX.

## Layering / leakage audit

Adapter architecture guard excludes dependencies on:

- SDL;
- projector;
- desktop shell;
- mock implementation;
- Core-private implementation structures.

The accepted candidate header itself contains only the public contract.

No BTstack/HCI/GATT/HID++/TinyUSB/flash/GPIO/SPI implementation code was imported.

## Layout freeze audit

Final branch comparison against frozen UI Layout 1.0:

~~~text
visual/projector/renderer/golden/screen-definition files changed: 0
~~~

Specifically, no file under the projector or renderer implementation and no screen golden
was modified.

The only desktop source change is formatting a now-64-bit current Mouse ID in the
developer STATE diagnostic.

## Test suite expansion

The frozen suite expanded from 13 to **14 tests** by adding:

`uic06_contract_adapter`

No existing test was removed.

Final debug CTest:

~~~text
14/14 passed
100% tests passed, 0 failed
~~~

Relevant retained tests include:

- screen_projection_contract — PASS
- baseline_contract — PASS
- renderer_contract — PASS
- documentation_inventory — PASS
- architecture_guard — PASS
- architecture_guard_forbidden_fixture — PASS

The new adapter test covers:

- exact Snapshot mapping;
- >32-bit Mouse/activity identities;
- APPLY_PROFILE command mapping;
- no optimistic profile confirmation;
- UI-local Custom edit;
- complete APPLY_CUSTOM mapping/confirmation;
- CANCEL_ACTIVITY correlation;
- ordered connection notification pump;
- Snapshot UNAVAILABLE / PERSISTENCE_FAILURE;
- navigation running through the contract backend;
- missing required capability rejection;
- Pair New FOUND/HANDOFF PENDING ordering.

## Final CI

Workflow:

`.github/workflows/ci.yml`

Final run:

~~~text
run: 35688019104
head: f561e09c5562b75971741a0c3764f34e37390c97
conclusion: SUCCESS
~~~

### host-debug

All passed:

- exact accepted UIC-05 header verification
- accepted UIC-05 conformance validator/vectors
- configure
- build
- 14-test CTest suite
- foundation probe
- screen projection hashes
- navigation trace
- scenario lab trace
- MUI-08 baseline evidence
- evidence artifact upload
- SDL desktop smoke

Desktop smoke result includes:

~~~text
mouse-ui UI Layout 1.0 SDL smoke PASS: default=200% 480x480 backlight=750%
~~~

### host-asan-ubsan

All applicable steps passed:

- exact accepted UIC-05 header verification
- accepted UIC-05 conformance validator/vectors
- sanitized build
- complete CTest suite
- foundation probe
- screen projection hashes
- navigation trace
- scenario lab trace
- SDL desktop smoke

## Candidate fixture conformance

The workflow reruns the accepted UIC-05 validator from the exact source commit before
building mouse-ui.

Therefore UIC-05 candidate schema/C-domain/traceability/conformance vectors remain green
alongside the UI adapter tests.

## Contract insufficiency review

Result: **none identified**.

UIC-06 did not require a semantic patch to the UIC-05 contract.

The observed implementation fixes were frontend-private integration details only:

- widen private IDs/tokens to 64 bits;
- update diagnostic printf formats;
- expose mock through the common backend seam;
- preserve UI-local Custom draft;
- wait for confirmed HANDOFF before leaving Pair New.

No UX/layout workaround was used to hide a contract deficiency.

## Documentation

Added/updated:

- `docs/architecture/uic-06-contract-adapter.md`
- `docs/architecture/system-boundary.md`
- `docs/architecture/development-architecture.md`
- `docs/development/mock-world.md`
- architecture index

## Acceptance checklist

Automated/documentary:

- [x] UI Layout 1.0 baseline expanded from 13 to 14 tests with all green
- [x] all 30-screen projection/golden/hash regression checks remain green
- [x] adapter has no SDL/projector dependency in public contract mapping
- [x] accepted UIC-05 candidate fixtures/conformance validator pass
- [x] exact accepted candidate header is verified in CI
- [x] debug and ASan/UBSan jobs pass
- [x] no visual/layout/golden implementation file changed
- [x] no contract insufficiency discovered

Human:

- [x] review confirms no user-visible UI Layout 1.0 behavior changed

## Scope control

Performed:

- thin contract adapter;
- candidate Snapshot -> private Product View mapping;
- semantic UI intent -> candidate command mapping;
- deterministic mock behind same navigation-facing seam;
- 64-bit private identity compatibility;
- candidate conformance rerun in UI CI;
- Pair New async handoff integration regression;
- architecture/layering documentation;
- UIC-06 evidence.

Not performed:

- Core conformance harness;
- Core implementation changes;
- UI Layout redesign;
- screen/golden modifications;
- immutable v1 release;
- UIC-07 work.

UIC-06 is accepted. UIC-07 is now the next eligible gate under the one-gate-at-a-time execution rule.
