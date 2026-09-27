# UIC-00 — Semantic Inventory

Status: **NOT STARTED / ACTIVE NEXT**.

## Objective

Turn frozen UI Layout 1.0 business behavior into an ownership matrix that says exactly what is UI-local, shared-contract semantic, or Core-local.

## Dependencies

`mouse-ui release/ui-layout-v1.0` frozen and CI green.

## Tasks

1. Trace every business rule in `mouse-ui/docs/product/ui-layout-v1.0.md` to UI-local/shared/Core-local ownership.
2. Include first/saved/Pair searches, single-live authority, profiles, Custom, removal, disconnect, cancellation/stale/late and output safety.
3. List every candidate shared datum/action/result without assigning final C layout.
4. Prove that screen IDs, Help, Lock, pixels, SDL, Inspector and lab controls are UI-local.
5. Prove that BTstack/HCI/GATT/HID++/TinyUSB/flash/GPIO details are Core-local.
6. Create a traceability table in the `mouse` contract draft and unresolved-decision list.

## Automated / documentary acceptance

- [ ] every frozen business rule has exactly one ownership classification
- [ ] no private UI/Core implementation type is made normative
- [ ] cross-boundary candidates are traceable to product behavior
- [ ] open questions are explicitly enumerated

## Human acceptance

- [ ] architecture review accepts the ownership split and absence of accidental coupling

## Deliverables

- C ABI freeze
- Core implementation
- UX/layout changes
- transport-specific API design

## Forbidden scope

- semantic inventory/matrix
- updated contract draft/traceability
- UIC-00 execution evidence

