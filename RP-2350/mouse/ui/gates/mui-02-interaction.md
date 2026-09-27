# MUI-02 — Interaction Engine

Status: **ACCEPTED**.

Candidate: `remappingbridge/mouse-ui` branch `mui/mui-02-interaction`, commit `8c1051904a95bd74b1f0d833a24c0a29ebcc8b29`.

Evidence: `../executions/mui-02/candidate.md`.

## Objective

Implement platform-independent semantic HAT press/release ownership and interaction primitives needed by baseline UX.

## Dependencies

MUI-00 and MUI-01 are **ACCEPTED**. Candidate is based directly on accepted MUI-01.

## Tasks

1. Define JOY UP/DOWN/LEFT/RIGHT/PRESS and KEY A/B/X/Y semantic controls.
2. Implement distinct press/release events and visible held-state representation.
3. Implement interaction epoch/owner semantics so stale releases cannot act on a new screen.
4. Implement generic consumed interaction primitive for unlock/Help ownership use.
5. Add exhaustive unit tests for duplicate presses, orphan releases, epoch changes, held feedback, and consumed release behavior.

## Deliverables

- pure `mouse_ui_interaction` API;
- semantic control/phase/outcome names for logs/adapters;
- `interaction_contract` regression test;
- `docs/development/interaction.md`.

## Automated acceptance

- [x] actions trigger only on matching release
- [x] stale release after epoch change does not trigger
- [x] duplicate press/release edge cases are deterministic
- [x] no SDL/GPIO dependency

GitHub Actions run `35566653090` passed 5/5 CTest contracts in both `host-debug` and `host-asan-ubsan`, including `interaction_contract`. No sanitizer finding was reported.

## Human acceptance

- [x] review semantic mapping naming for future desktop and embedded adapters

Names to review:

~~~text
Controls:
JOY_UP
JOY_DOWN
JOY_LEFT
JOY_RIGHT
JOY_PRESS
KEY_A
KEY_B
KEY_X
KEY_Y

Phases:
PRESS
RELEASE

Outcomes:
PRESS_ACCEPTED
RELEASE_ACTION
RELEASE_CONSUMED
DUPLICATE_PRESS
ORPHAN_RELEASE
STALE_RELEASE
INVALID
~~~

## Forbidden scope

- GPIO pin mapping
- SDL key mapping beyond test fixtures
- screen navigation rules
- backend operations

Candidate review confirms none of these scopes were introduced.

## Rollback / rebuild point

Interaction tests are the durable asset. If ownership semantics later become entangled with screen-specific behavior, rebuild from accepted MUI-01 `4daa0963e476eebd61cd7049b43cba582413144a` using the MUI-02 interaction tests.

Human semantic acceptance was explicitly reported on 2026-09-21. The candidate was promoted to `mouse-ui/main` before MUI-03 started.
