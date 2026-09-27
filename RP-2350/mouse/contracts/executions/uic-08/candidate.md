# UIC-08 release evidence

Status: **ACCEPTED — UI↔CORE CONTRACT v1.0.0 RELEASE APPROVED**.

Date: 2026-09-22.
Human release acceptance: **ACCEPTED by user on 2026-09-22**.

## Gate

UIC-08 — UI↔Core Contract v1.0.0 Release

Dependencies:

- UIC-06 ACCEPTED
- UIC-07 ACCEPTED

## Planner correction

The original UIC-08 gate file had the contents of Deliverables and Forbidden scope
inverted relative to its objective, tasks and acceptance criteria.

UIC-08 corrects that documentary inversion.

Deliverables:

- immutable UI↔Core v1.0.0;
- component compatibility pins;
- UIC-08 evidence.

Forbidden scope:

- full product integration claim;
- hardware acceptance claim;
- post-release semantic edits in place.

No semantic requirement was changed.

## Neutral release repository

~~~text
repository: remappingbridge/mouse
branch: uic/uic-08-release-v1
release candidate head:
41c43d3e6714523a76940de8ad2b38435533ff8c
~~~

Release package:

~~~text
contracts/ui-core/releases/v1.0.0/
~~~

The package contains the normative language, schema, released C binding, schema/C
equivalence, BR-001..BR-088 coverage, compatibility metadata, release validator,
compile smoke and all 11 neutral conformance vectors.

## Release identity

~~~text
release = v1.0.0
descriptor major = 1
descriptor minor = 0
max_saved_mice = 16
max_mouse_name_utf8_bytes = 63
~~~

Required capabilities:

- FIRST_DISCOVERY
- SAVED_RECONNECT
- PAIR_NEW
- PROFILE_PASSTHROUGH
- PROFILE_STANDARD
- PROFILE_ESCAPE
- PROFILE_CUSTOM
- REMOVE_MOUSE
- ESCAPE_OUTPUT

## Proven component revisions

Consumer/UI proof:

~~~text
remappingbridge/mouse-ui
7d1f0246ca4b70a2a7134de040b02db13e3bd540
~~~

Provider/Core proof:

~~~text
remappingbridge/mouse-core
f5b7384156a42543505b93dd7609e715c4cd3542
~~~

These pins identify the revisions that proved the boundary before release packaging.

## Content stability

manifest.json records the Git blob SHA for every packaged release artifact except the
manifest itself.

~~~text
content-addressed artifacts = 23
~~~

validate_release.py computes git hash-object for every listed path and fails on drift.

After UIC-08 acceptance and promotion, v1.0.0 must not be edited in place. Any semantic,
schema or ABI change requires a new version.

## Normative closure

The release validator rejects TODO, TBD, FIXME and NOT RELEASED markers in normative
release artifacts.

The UIC decision register now closes OD-020 through OD-023. No UIC-00 open decision
remains unresolved.

## Neutral release CI

~~~text
repository: remappingbridge/mouse
workflow: UI-Core v1.0.0 release validation
run: 35689429328
conclusion: SUCCESS
~~~

Results:

~~~text
UI-Core v1.0.0 release validation PASS
vectors=11
traceability_rules=88
content_addressed_artifacts=23
C11 binding smoke: PASS
C++17 include smoke: PASS
release JSON parsing: PASS
~~~

## mouse-ui declaration and CI

~~~text
repository: remappingbridge/mouse-ui
branch: uic/uic-08-release-v1
head:
cdf1a39e83de3b69150e601882628094b2a946b0

ui-core-contract.json:
role = consumer
contract_release = v1.0.0
required_major = 1
minimum_minor = 0
~~~

The vendored header is byte-identical to the release header in
remappingbridge/mouse@41c43d3e6714523a76940de8ad2b38435533ff8c.

Final CI:

~~~text
run: 35689596925
conclusion: SUCCESS

UI-Core v1.0.0 release validation PASS
vectors=11
traceability_rules=88
content_addressed_artifacts=23
mouse-ui UI-Core contract declaration PASS: v1.0.0 consumer
14/14 CTest tests passed
MUI-08 baseline probe PASS
mouse-ui UI Layout 1.0 SDL smoke PASS:
default=200% 480x480 backlight=750%
~~~

Both debug and ASan/UBSan jobs pass.

## mouse-core declaration and CI

~~~text
repository: remappingbridge/mouse-core
branch: uic/uic-08-release-v1
head:
87c7e08c93c43990feb623b214b201aa4e20b791

ui-core-contract.json:
role = provider
contract_release = v1.0.0
provided_major = 1
provided_minor = 0
~~~

The vendored header is byte-identical to the same release header.

Final CI:

~~~text
run: 35689654252
conclusion: SUCCESS

UI-Core v1.0.0 release validation PASS
vectors=11
traceability_rules=88
content_addressed_artifacts=23
mouse-core UI-Core contract declaration PASS: v1.0.0 provider
2/2 CTest tests passed
UIC-07 probe PASS: rev=201 current=2 saved=2 notifications=3
~~~

Both debug and ASan/UBSan jobs pass. The architecture guard still rejects mouse-ui
private dependencies and transport leakage.

## Compatibility declaration mechanism

Both components now have a machine-readable ui-core-contract.json plus an executable
validator in tools/validate_ui_core_contract.py.

The consumer declares release, required major/minor, capabilities, limits, canonical
source, proof commit and local binding path.

The provider declares release, provided major/minor, capabilities, limits, canonical
source, proof commit and local binding path.

Both declarations are checked by CI against the release compatibility.json and header.

## Documentation updates

remappingbridge/mouse now points to releases/v1.0.0 as the canonical integration target
and defines immutable release/versioning governance.

mouse-ui documentation now identifies v1.0.0 as the adapter target.

mouse-core documentation now identifies v1.0.0 as the provider boundary.

repo-planner records the corrected UIC-08 scope and this release evidence.

## Contract feedback

Result: **no semantic change required**.

UIC-06 and UIC-07 both found the candidate implementable as written. UIC-08 changes only
release packaging, immutable metadata, component declarations and candidate-to-release
wording. No public enum, field, limit, capability, ordering rule or ABI shape changed.

## Acceptance checklist

Automated/documentary:

- [x] neutral conformance suite green on mouse
- [x] neutral release suite green on mouse-ui
- [x] neutral release suite green on mouse-core
- [x] release tree contains no unresolved normative marker
- [x] version/compatibility declarations are machine-readable and testable
- [x] released header is byte-identical in both components
- [x] release artifacts are content-addressed and drift-checked
- [x] UI Layout 1.0 baseline remains green
- [x] Core conformance and architecture guards remain green
- [x] no full product integration claim
- [x] no hardware acceptance claim

Human:

- [x] explicit human acceptance of the v1 boundary and release readiness

## Promotion result

Human release acceptance was granted.

UIC-08 is eligible for promotion to main. The immutable v1.0.0 package contents are not
changed during promotion. MCORE-00 becomes the next eligible gate after promotion.
