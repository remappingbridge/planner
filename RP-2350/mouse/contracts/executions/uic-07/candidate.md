# UIC-07 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human Core architecture review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-07 — Core Conformance Harness`

Dependency: **UIC-06 ACCEPTED**.

Accepted contract source:

~~~text
repository: remappingbridge/mouse
UIC-05 candidate commit:
af7d037646cd0e2917c81eee6acd1f0eb6592921
~~~

Accepted UI-side proof:

~~~text
repository: remappingbridge/mouse-ui
UIC-06 main commit:
7d1f0246ca4b70a2a7134de040b02db13e3bd540
~~~

## Planner correction

The original UIC-07 gate file had the contents of `Deliverables` and
`Forbidden scope` inverted relative to its objective, tasks and acceptance criteria.

UIC-07 corrects that documentary inversion:

Deliverables:

- mouse-core conformance harness;
- candidate fixture results;
- UIC-07 evidence.

Forbidden scope:

- BTstack/TinyUSB production stack;
- physical acceptance claims;
- copying frontend Product View.

No semantic gate requirement was changed.

## Implementation repository

~~~text
repository: remappingbridge/mouse-core
branch: uic/uic-07-core-conformance
rollback base: 4320e3f7351551e3997cf6d5940df460a9a98f7f
candidate head: fe0bd4f77ebc909c9502952ec74630bf2513cd8b
ahead of main: 12 commits
behind main: 0
~~~

## Candidate call surface

The host semantic provider implements the accepted candidate API directly:

~~~text
mouse_uic_v1_get_descriptor()
mouse_uic_v1_read_snapshot()
mouse_uic_v1_submit_intent()
mouse_uic_v1_poll_notification()
~~~

The provider object remains Core-owned.

No frontend Product View or UI navigation type is copied into mouse-core.

## Exact public contract binding

The accepted candidate header is vendored at:

~~~text
include/mouse_core/contract/uic_v1.h
~~~

CI checks out exactly:

~~~text
remappingbridge/mouse
af7d037646cd0e2917c81eee6acd1f0eb6592921
~~~

and byte-compares against:

~~~text
contracts/ui-core/drafts/uic-05-c-binding.h
~~~

Final result: **PASS**.

## Semantic harness scope

The provider models only public v1 semantics:

- descriptor/version/capabilities/limits;
- Snapshot revision;
- stable saved Mouse identities;
- zero-or-one current authority;
- confirmed profiles;
- global confirmed Custom mapping;
- one search slot;
- one mutation operation slot;
- caller-owned intent IDs;
- Core-owned activity IDs;
- Core-owned ordered notification sequence;
- replay and intent-ID collision behavior;
- stable public errors;
- Snapshot UNAVAILABLE.

Fixture/backend-completion controls are test-only and are not proposed public API.

## Shared UIC-05 vectors

CI reruns the exact accepted shared validator:

~~~text
python3 .uic-contract-source/contracts/ui-core/tools/validate_uic05.py
~~~

Result: **PASS**.

The C semantic suite covers the same candidate vector areas:

- descriptor;
- connected Snapshot;
- profile apply success;
- Pair New limit rejection;
- cancellation and late-success protection;
- Pair New handoff sequence;
- live remove release/delete sequence;
- Snapshot unavailable / persistence failure;
- Custom atomic apply;
- saved-search timeout;
- authority-lost error.

Additional Core-side conformance checks cover:

- intent replay;
- intent-ID collision rejection;
- stale correlation rejection;
- FIRST commit point;
- SAVED reconnect commit point;
- failed profile non-commit;
- invalid/incomplete Custom rejection.

## Single-live invariant

Pair New is proven in two semantic stages.

Candidate qualification:

~~~text
search = FOUND
handoff = PENDING
saved_count unchanged
current_mouse_id = old current
~~~

Handoff success:

~~~text
candidate becomes saved
current_mouse_id = candidate
old current is no longer authoritative
~~~

Snapshot contains only one current Mouse ID; no dual-authority state is representable.

## Pair New notification ordering

For HANDOFF success at one commit revision:

1. `CONNECTION_CHANGED`;
2. `ACTIVITY_RESULT(SUCCEEDED)`.

The conformance vector uses:

~~~text
revision: 201
CONNECTION_CHANGED seq: 7100
ACTIVITY_RESULT seq: 7101
~~~

and the final probe confirms:

~~~text
rev=201 current=2 saved=2 notifications=3
~~~

The third notification is the earlier Pair New search-result notification.

## Profile / Custom commit points

APPLY_PROFILE and APPLY_CUSTOM first publish PENDING operation state while confirmed state
remains unchanged.

Success changes confirmed state only at the semantic commit revision.

Failure/cancellation leaves prior confirmed state authoritative.

Custom success atomically updates:

- global confirmed mapping;
- target Mouse profile to CUSTOM.

## Live remove commit points

Live REMOVE is proven as two commits:

1. release current authority while record remains saved and operation stays PENDING;
2. delete saved record and publish REMOVE SUCCEEDED.

This reproduces the accepted UIC-05 release-before-delete invariant.

## Cancellation / late work

CANCEL_ACTIVITY targets a concrete non-terminal activity ID.

Accepted cancellation:

- marks activity terminal CANCELLED;
- publishes one correlated ACTIVITY_RESULT;
- carries the cancel intent ID.

A later completion attempt for the cancelled activity is rejected by the harness and
does not change confirmed state or revision.

## Replay and correlation

Proven:

~~~text
same intent_id + same semantics
=> REPLAY
=> original activity_id
=> no second state transition

same intent_id + different semantics
=> REJECTED / INVALID_REQUEST

cancel unknown/stale activity_id
=> REJECTED / STALE_STATE
~~~

## Search timeout ownership

Core semantic virtual deadlines are implemented as accepted:

- FIRST: 8000 ms;
- SAVED: 8000 ms;
- PAIR_NEW: 15000 ms.

Timeout commits exactly once.

TIMED_OUT does not fabricate a public Error object.

## Authority loss

A semantic physical disconnect removes current authority.

When PROFILE_APPLY/CUSTOM_APPLY for that authority is PENDING, the same commit:

- publishes CONNECTION_CHANGED first;
- marks operation FAILED / AUTHORITY_LOST;
- publishes ACTIVITY_RESULT second;
- leaves previous confirmed profile/Custom state unchanged.

The authority-lost vector is reproduced at commit revision 601.

## Snapshot unavailable

Descriptor remains readable.

When coherent product truth is unavailable, read_snapshot returns:

~~~text
UNAVAILABLE
PERSISTENCE_FAILURE
RETRY_LATER
GENERIC_USER_FAILURE
~~~

rather than fabricating an empty confirmed registry.

Opaque diagnostics cross only as diagnostics.

## No mouse-ui private dependency

CI contains an explicit private-dependency grep and the CMake architecture guard.

Final result: **PASS**.

The source/test tree is rejected if it references frontend-private layers/types or
presentation dependencies.

No mouse-ui header is included.

## No transport leakage

The architecture guard forbids production technology dependencies including:

- SDL;
- BTstack;
- TinyUSB;
- CYW43/Pico SDK;
- GPIO/SPI/flash platform headers;
- HCI/GATT/HID++ implementation symbols.

Final result: **PASS**.

The harness does not claim hardware support.

## C test suite

CTest contains two top-level tests:

~~~text
uic07_core_conformance
uic07_architecture_guard
~~~

The conformance executable contains 14 deterministic semantic cases.

Final debug result:

~~~text
2/2 passed
100% tests passed, 0 failed
~~~

Final probe:

~~~text
UIC-07 probe PASS: rev=201 current=2 saved=2 notifications=3
~~~

## Final CI

Workflow:

~~~text
.github/workflows/ci.yml
~~~

Final run:

~~~text
run: 35688819955
head: fe0bd4f77ebc909c9502952ec74630bf2513cd8b
conclusion: SUCCESS
~~~

### host-debug

All passed:

- exact accepted UIC-05 header verification;
- shared UIC-05 conformance validator;
- no-mouse-ui dependency check;
- configure;
- build;
- CTest;
- architecture guard;
- deterministic conformance probe.

### host-asan-ubsan

All equivalent sanitized steps passed.

## Changed source surface

UIC-07 adds only host conformance/build/test/documentation material:

- `include/mouse_core/contract/uic_v1.h`;
- `include/mouse_core/conformance/harness.h`;
- `src/conformance/provider.c`;
- `tests/test_uic07.c`;
- `tools/uic07_probe.c`;
- CMake/CI/architecture guard;
- Core boundary documentation.

No production radio, USB, persistence or platform-driver source was introduced.

## Contract insufficiency review

Result: **none identified**.

The Core-side semantic provider was implementable against the accepted UIC-05 candidate
without changing the public contract.

No candidate defect was hidden with a frontend type or transport-specific workaround.

## Acceptance checklist

Automated/documentary:

- [x] shared conformance vectors pass
- [x] exact accepted candidate header verified
- [x] no mouse-ui private header/type dependency
- [x] single-live invariant passes
- [x] correlation/replay/cancel/late-work invariants pass
- [x] commit-point invariants pass
- [x] Pair New and live-remove ordering pass
- [x] debug CI passes
- [x] ASan/UBSan CI passes
- [x] harness makes no physical hardware-support claim
- [x] no contract insufficiency discovered

Human:

- [x] Core architecture review confirms candidate boundary is implementable without transport leakage

## Scope control

Performed:

- minimal C mouse-core candidate provider;
- deterministic semantic state transitions;
- exact public candidate binding;
- shared-vector validation;
- Core-side conformance tests;
- single-live/correlation/commit ordering tests;
- no-UI/no-transport architecture guards;
- documentation and UIC-07 evidence.

Not performed:

- Bluetooth implementation;
- BTstack/HOGP/GATT implementation;
- TinyUSB implementation;
- flash/persistence driver implementation;
- RP2350 firmware;
- physical acceptance;
- immutable v1 release;
- UIC-08 work.

UIC-07 is accepted. UIC-08 is now the next eligible gate.
