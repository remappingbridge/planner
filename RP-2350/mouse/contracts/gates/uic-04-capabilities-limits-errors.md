# UIC-04 — Capabilities, Limits & Errors

Status: **BLOCKED**.

## Objective

Decide which implementation limits/capabilities/errors are public product semantics.

## Dependencies

UIC-03 ACCEPTED.

## Tasks

1. Decide public maximum saved Mouse count versus UI implementation capacity 16.
2. Define display-name encoding/maximum and normalization responsibility.
3. Define capability representation for Escape output and optional HID++ behavior if UI needs to know any of it.
4. Define stable error categories, retryability and user-visible versus diagnostic-only errors.
5. Define persistence/schema compatibility information needed across components.
6. Define contract version/capability discovery rules.

## Automated / documentary acceptance

- [ ] limits are explicit or explicitly non-contractual
- [ ] error taxonomy supports all user-visible failure paths without transport leakage
- [ ] capabilities do not expose raw backend technology structures
- [ ] fixtures include unsupported/limit/error cases

## Human acceptance

- [ ] review accepts limits, encoding and error/capability decisions

## Deliverables

- vendor packet error codes as public API
- screen-specific error copy
- silent reliance on private constants

## Forbidden scope

- limits/capabilities/errors section
- error fixtures
- UIC-04 evidence

