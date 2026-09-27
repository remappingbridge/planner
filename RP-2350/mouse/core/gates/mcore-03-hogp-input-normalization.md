# MCORE-03 — HOGP Input Normalization

Status: **BLOCKED**.

## Objective

Normalize Mouse reports into transport-independent physical button/movement events, with optional Logitech HID++ support isolated.

## Dependencies

MCORE-02 ACCEPTED.

## Tasks

1. Parse HOGP report maps safely.
2. Normalize movement/wheel/pan and five target buttons.
3. Preserve down/hold/up semantics.
4. Implement optional HID++ REPROG_CONTROLS_V4 path behind capability module.
5. Disconnect/report-map malformed input tests.

## Automated / documentary acceptance

- [ ] normalized vectors pass
- [ ] unsupported mice remain safe HOGP
- [ ] vendor path cannot corrupt generic path
- [ ] held source state clears on session loss

## Human acceptance

- [ ] physical representative generic and Logitech Mouse tests

## Deliverables

- remap policy in parser
- raw reports in public contract

## Forbidden scope

- normalized input layer
- HID++ optional module
- MCORE-03 evidence

