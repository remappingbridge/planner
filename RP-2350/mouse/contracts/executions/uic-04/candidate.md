# UIC-04 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human review: **ACCEPTED by user on 2026-09-22**.

## Gate

`UIC-04 — Capabilities, Limits & Errors`

Dependency: **UIC-03 ACCEPTED**.

Accepted dependency baselines:

~~~text
remappingbridge/mouse main:
9283913112b46676ba466a1fd862a6fd03cfcadb

remappingbridge/repo-planner main:
404b48cfcf147aca299b6e8f8554f7a0b9626380

mouse-ui UI Layout 1.0:
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

## Implementation repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-04-capabilities-limits-errors
rollback base: 9283913112b46676ba466a1fd862a6fd03cfcadb
candidate head: f367056983405750a2a32016de6e672a49fdc16a
ahead of main: 22 commits
behind main: 0
~~~

## Primary artifact

`contracts/ui-core/drafts/uic-04-capabilities-limits-errors.md`

It defines the candidate public semantic descriptor, limits, capability discovery,
name encoding/sanitation, error taxonomy, retryability, visibility, persistence boundary,
search deadline ownership and version compatibility rules.

## Public limit decisions

### Saved Mouse count

Contract major 1 public maximum:

~~~text
max_saved_mice = 16
~~~

Consequences:

- valid Snapshot count is 0..16;
- Pair New at 16 is rejected with LIMIT_REACHED;
- Core may not publish a 17th record through contract major 1;
- raising this capacity requires a future contract major.

This deliberately promotes the accepted UI 1.0 capacity into a public product limit
instead of relying on a private constant.

### Mouse name

Public semantic name:

~~~text
encoding: valid UTF-8
encoded length: 0..63 bytes
U+0000: forbidden
~~~

Core sanitizes malformed input, removes/replaces U+0000 and truncates at a Unicode scalar
boundary. UI remains responsible for frozen 15-character visual formatting, trailing-space
handling, MOUSE suffix and UNKNOWN MOUSE fallback.

Unicode NFC/NFKC normalization is explicitly not required.

## ContractDescriptor / capability discovery

Candidate semantic descriptor:

~~~text
contract.major = 1
contract.minor = 0
limits.max_saved_mice = 16
limits.max_mouse_name_utf8_bytes = 63
~~~

Required v1.0 semantic capabilities:

- FIRST_DISCOVERY
- SAVED_RECONNECT
- PAIR_NEW
- PROFILE_PASSTHROUGH
- PROFILE_STANDARD
- PROFILE_ESCAPE
- PROFILE_CUSTOM
- REMOVE_MOUSE
- ESCAPE_OUTPUT

ESCAPE_OUTPUT describes the user-visible semantic capability, not TinyUSB/USB internals.

HID++ is intentionally not a public capability because frozen UI 1.0 never branches on
vendor-protocol availability.

## Version compatibility

Compatibility requires:

- same contract major;
- provider minor >= consumer minimum minor;
- every required semantic capability present;
- major-1 public limits compatible with the frozen consumer.

A later minor may add ignorable optional capabilities but cannot silently increase the
major-1 saved/name bounds or repurpose existing semantics.

`contracts/ui-core/versioning.md` was updated with these rules while still explicitly
stating that no released ABI/API exists yet.

## Stable error taxonomy

Public error object:

~~~text
category
retryability
visibility
optional diagnostic_code
optional diagnostic_message
~~~

Stable categories:

- INVALID_REQUEST
- CONFLICT
- STALE_STATE
- LIMIT_REACHED
- UNSUPPORTED
- INCOMPATIBLE_CONTRACT
- AUTHORITY_LOST
- TEMPORARY_UNAVAILABLE
- PERSISTENCE_FAILURE
- INTERNAL_FAILURE

Retryability:

- NOT_RETRYABLE
- AFTER_REFRESH
- AFTER_STATE_CHANGE
- LATER

Visibility:

- DIAGNOSTIC_ONLY
- GENERIC_USER_FAILURE
- USER_ACTIONABLE

Provider diagnostic code/message are opaque and non-normative. UI logic must not branch
on HCI/GATT/HID++/USB/vendor codes.

Exact screen copy remains UI-local.

## Error attachment

Submission REJECTED carries one stable public error.

ACTIVITY_RESULT rules:

- SUCCEEDED: no error
- CANCELLED: no error
- TIMED_OUT: no error
- FAILED: exactly one public error

FAILED terminal state in Snapshot carries the same stable public error semantics.

## Search deadline ownership

Core owns semantic deadlines:

- FIRST: 8 s
- SAVED: 8 s
- PAIR_NEW: 15 s

They begin at accepted activity start and use a Core monotonic time source.

UI may display progress but does not decide the terminal timeout.

Success-vs-timeout races continue to use UIC-03 semantic commit ordering.

## Persistence/schema compatibility

Physical persistence schema is explicitly Core-local.

No public exposure of:

- flash addresses/sectors;
- private record structs;
- on-flash schema number;
- bonding format;
- migration journal.

Core must migrate/load persisted state before publishing normal compatible semantics.

Migration/load/commit failure maps to PERSISTENCE_FAILURE; private storage diagnostics
remain opaque.

## Fixtures

Directory:

`contracts/ui-core/fixtures/uic-04/`

Fixtures:

1. `01-compatible-descriptor.json`
2. `02-missing-escape-capability.json`
3. `03-major-mismatch.json`
4. `04-pair-new-limit-reached.json`
5. `05-name-boundaries.json`
6. `06-stale-target-rejected.json`
7. `07-authority-lost-result.json`
8. `08-persistence-failure-diagnostic-private.json`
9. `09-timeout-has-no-error.json`
10. `10-vendor-code-non-normative.json`
11. `11-descriptor-limit-mismatch.json`

## Automated/documentary validation

Final validation against the candidate branch:

~~~text
fixture_count: 11
all_fixture_json_parse: PASS
descriptor_1_0_and_required_caps: PASS
no_backend_capability_leak: PASS
public_saved_limit_16: PASS
utf8_63_byte_boundary: PASS
multibyte_scalar_boundary: PASS
stable_error_shape_and_domains: PASS
timeout_distinct_from_error: PASS
vendor_diagnostics_non_normative: PASS
descriptor_limit_mismatch_rejected: PASS
versioning_rules_present: PASS
persistence_schema_private: PASS
core_owns_timeouts: PASS
no_public_backend_error_categories: PASS
C_ABI_freeze_guard: PASS
UIC-04_decisions_resolved: PASS
validation_errors: 0
~~~

`remappingbridge/mouse` has no repository-native CI workflow for this documentary
contract program, so acceptance is based on language-neutral fixture/invariant validation.

## Decision register changes

Resolved by UIC-04:

- OD-009 — Core owns semantic search deadlines;
- OD-010 — stable errors/retryability/visibility;
- OD-011 — ContractDescriptor capability/limit representation;
- OD-012 — 16 is public contract-major-1 saved maximum;
- OD-013 — valid UTF-8 name, max 63 encoded bytes, Core sanitation/UI display split;
- OD-014 — ESCAPE_OUTPUT required semantic capability, raw USB private;
- discovery portion of OD-020 — major/minor/capability compatibility rules.

Still deferred:

- concrete identity/version/descriptor representation;
- final C structs/enums/function signatures;
- memory ownership/thread-safety;
- internal Custom persistence layout;
- immutable release packaging/tag.

## Acceptance checklist

Automated/documentary:

- [x] limits are explicit or explicitly non-contractual
- [x] error taxonomy supports user-visible failure paths without transport leakage
- [x] capabilities do not expose raw backend technology structures
- [x] fixtures include unsupported/limit/error cases

Human:

- [x] review accepts limits, encoding and error/capability decisions

## Scope control

Performed:

- limits/capabilities/errors section;
- semantic ContractDescriptor;
- name encoding/normalization responsibility;
- stable error/retry/visibility taxonomy;
- persistence-schema boundary;
- version/capability discovery rules;
- error/unsupported/limit fixtures;
- UIC-04 evidence.

Not performed:

- vendor packet error codes as public API;
- screen-specific error copy;
- C ABI freeze;
- concrete enum integer values;
- UIC-05 candidate implementation.

## Planner-spec note

The UIC-04 gate document continues the apparent Deliverables/Forbidden-scope inversion
present in earlier UIC gate files. Execution follows Objective, Tasks, roadmap and
acceptance criteria: normative limits/capabilities/errors plus fixtures/evidence, while
vendor packet errors and screen-specific copy remain excluded.

UIC-04 is accepted. UIC-05 is now the next eligible gate.
