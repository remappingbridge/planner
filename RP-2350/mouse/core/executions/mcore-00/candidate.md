# MCORE-00 candidate evidence

Status: **ACCEPTED**.

Date: 2026-09-22.
Human architecture acceptance: **ACCEPTED by user on 2026-09-22**.

## Gate

MCORE-00 — Foundation & Contract Adapter

Dependency: **UIC-08 ACCEPTED**.

Released contract baseline:

~~~text
repository: remappingbridge/mouse
main release commit:
b26f77e27372bfcd7aa54235354b163394484a67
stable ref:
release/ui-core-v1.0.0
package:
contracts/ui-core/releases/v1.0.0/
~~~

## Planner correction

The original MCORE-00 gate had Deliverables and Forbidden scope inverted relative to its
objective/tasks/acceptance criteria.

Corrected deliverables:

- Core foundation
- contract adapter
- MCORE-00 evidence

Corrected forbidden scope:

- real BLE/USB implementation
- changing released contract locally
- screen/navigation logic

No semantic requirement changed.

## Implementation repository

~~~text
repository: remappingbridge/mouse-core
branch: mcore/mcore-00-foundation-contract-adapter
rollback base:
6c1cec92dddf4b6ddbc7d9c681d55d9cd8ce7d24
candidate head:
441472d8987d6c4e5bdad6420cf438a59d1c89f5
ahead of main: 27 commits
behind main: 0
~~~

## Released contract integrity

The local binding remains:

~~~text
include/mouse_core/contract/uic_v1.h
~~~

CI byte-compares it against the immutable v1.0.0 release header.

The provider declaration now records the promoted canonical release commit and stable
release ref.

No contract enum, structure, limit, capability, ordering rule or public function was
changed locally.

## Core foundation

MCORE-00 introduces a real Core module boundary:

~~~text
UI↔Core v1.0.0
      |
contract adapter
      |
Core state context
      |
replaceable platform seams
      |
      +-- clock
      +-- persistence
      +-- Bluetooth input
      +-- USB output
~~~

### Core state context

Implemented in:

~~~text
include/mouse_core/core/context.h
src/core/context.c
~~~

The released opaque provider is concretized internally as the Core state context.

The context owns:

- contract descriptor
- atomic Snapshot state
- notification queue
- replay/correlation state
- activity/notification counters
- platform interface bundle

The internal struct is not part of the public v1.0.0 contract.

### Contract adapter

Implemented in:

~~~text
include/mouse_core/contract/adapter.h
src/contract/adapter.c
~~~

Explicit adapter operations:

- descriptor publisher
- Snapshot publisher
- intent dispatcher
- notification publisher

The adapter invokes the released v1.0.0 call surface and does not introduce frontend
screen/navigation concepts.

## Platform seams

Implemented under:

~~~text
include/mouse_core/platform/
src/platform/platform.c
~~~

### Clock

Exposes monotonic milliseconds only.

### Persistence

Exposes opaque byte load/store/erase operations.

MCORE-00 intentionally does not define the registry serialization or physical flash
layout; those remain later gates.

### Bluetooth input

Exposes scan start/stop plus backend event polling.

There are no screen, menu, Help/Lock, Product View or frontend types in this seam.

### USB output

Exposes low-level mouse report, key report and release-all delivery.

It does not own remap/profile/UI policy.

## Fake platform implementation

Host-only deterministic fakes are implemented in:

~~~text
tests/fakes/fake_platform.h
tests/fakes/fake_platform.c
~~~

They provide:

- controlled monotonic time
- in-memory persistence
- deterministic Bluetooth scan/event state
- captured USB mouse/key output
- release-all observation

No fake API is exposed in production headers.

## Released semantic suite now uses fake platform bundle

The accepted UIC-07 semantic conformance executable was changed only at its initialization
seam: each semantic case now initializes the real Core state context with a complete fake
platform bundle.

Therefore the existing semantic cases for the released v1 behavior continue to exercise:

- descriptor/Snapshot
- profile apply
- Custom apply
- Pair New
- limit rejection
- cancellation/late work
- handoff ordering
- live remove
- Snapshot unavailable
- search timeout
- authority loss
- replay/correlation
- FIRST/SAVED commit points
- failed/non-commit behavior

while running through the new Core foundation boundary.

## MCORE-00 foundation tests

New test:

~~~text
mcore00_foundation
~~~

It verifies:

- complete platform bundle validation
- clock replacement
- persistence round-trip/erase
- Bluetooth scan and event polling
- USB mouse/key delivery
- USB release-all
- contract adapter initialization
- descriptor/Snapshot publication
- FIRST intent dispatch
- semantic success publication
- incomplete platform rejection

## Architecture guards

Existing UIC-07 guard remains enabled.

New MCORE-00 guard:

~~~text
cmake/Mcore00ArchitectureGuard.cmake
~~~

It rejects mouse-ui/SDL dependencies from Core source and rejects UI/product-contract
concept leakage from platform seam headers.

An initial guard false positive interpreted the substring "lock" inside "clock" as the
UI Lock concept. The guard was corrected to match actual Lock-state identifiers instead;
the implementation itself was unchanged.

Final architecture guard result: **PASS**.

## Build and CI

Build remains C11 with strict warnings-as-errors.

Sanitizer matrix:

- debug
- ASan + UBSan

Final workflow:

~~~text
repository: remappingbridge/mouse-core
run: 35690581028
head: 441472d8987d6c4e5bdad6420cf438a59d1c89f5
conclusion: SUCCESS
~~~

Both jobs passed:

- released v1.0.0 checkout
- exact header comparison
- immutable release validator
- provider compatibility declaration validator
- no mouse-ui private dependency check
- MCORE-00 platform architecture guard
- configure
- build
- CTest
- conformance probe

CTest:

~~~text
1/4 uic07_core_conformance       PASS
2/4 mcore00_foundation           PASS
3/4 uic07_architecture_guard     PASS
4/4 mcore00_architecture_guard   PASS

100% tests passed, 0 failed out of 4
~~~

Conformance probe:

~~~text
UIC-07 probe PASS: rev=201 current=2 saved=2 notifications=3
~~~

Release/declaration verification:

~~~text
UI-Core v1.0.0 release validation PASS
mouse-core UI-Core contract declaration PASS: v1.0.0 provider
MCORE-00 architecture guard PASS
~~~

## Scope control

Implemented:

- real Core C foundation/module skeleton
- released v1 contract adapter
- Core state context
- replaceable clock seam
- replaceable persistence seam
- replaceable Bluetooth-input seam
- replaceable USB-output seam
- deterministic fake platform
- released semantic conformance through fake platform initialization
- strict C11/sanitized host CI
- architecture documentation and evidence

Not implemented:

- real BTstack/HOGP/GATT
- real flash persistence schema/driver
- HID input normalization
- remap/held-output engine
- TinyUSB/physical USB output
- transactional apply
- handoff/remove recovery implementation
- hardware baseline/physical acceptance
- MCORE-01 work

## Contract feedback

No v1.0.0 contract insufficiency was discovered.

No released contract artifact was edited.

## Acceptance checklist

Automated/documentary:

- [x] build/tests green
- [x] released v1 vectors/semantic suite pass
- [x] exact released header verified
- [x] no dependency on mouse-ui headers
- [x] platform seams have no product UI concepts
- [x] debug CI green
- [x] ASan/UBSan CI green
- [x] foundation uses replaceable fake platform implementations
- [x] no real BLE/USB implementation claimed
- [x] no released contract semantic change

Human:

- [x] architecture/module-boundary review

MCORE-00 is accepted. MCORE-01 is now the next eligible gate.
