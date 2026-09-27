# UI Layout 1.0 release record

Status: **FROZEN / ACCEPTED**.

Date: **2026-09-22**.

## Repository reference

~~~text
remappingbridge/mouse-ui
application version: 1.0.0
UI Layout: 1.0
main: e8adad7919e931c92515bf655ef4050876a8e7a9
stable ref: release/ui-layout-v1.0
~~~

## Final behavior lineage

- PR #1: global Lock / first-connected UX corrections -> merge `251d6d2efe79e7135491954134ff36bf3f658824`;
- PR #2: final UX bug/multi-Mouse/cancellation/profile/navigation corrections -> squash `65c2040f71dd68bd054fc9c3aa24d47d53e58ead`;
- business/architecture freeze + application version 1.0.0 -> `9e5134a0c53bf95ea4b28b52bbb4e6490a7fd1f9`;
- version-test include correction -> final `e8adad7919e931c92515bf655ef4050876a8e7a9`.

## Final CI

Workflow `35682121924`:

- Debug: 13/13 tests PASS;
- ASan/UBSan: 13/13 tests PASS;
- `baseline_contract`: PASS;
- documentation inventory: PASS;
- SDL smoke: `mouse-ui UI Layout 1.0 SDL smoke PASS: default=200% 480x480 backlight=750%`.

## Contract handoff

This release is the normative UI product input for UIC-00. Private `mouse-ui` C types remain non-contractual.
