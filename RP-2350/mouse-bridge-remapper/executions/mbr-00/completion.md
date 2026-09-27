# MBR-00 completion report

Gate: `mbr-00` — Provenance, decisions and contract freeze  
Status: **COMPLETE / ACCEPTED**

## Objective achieved

Converted the product/planning definition into an implementation-ready frozen contract, revalidated the accepted BLU2USB G06 provenance, incorporated the latest Pair New Help screens, resolved all decisions required by mbr-01 through mbr-07, aligned successor gates, performed a final contradiction search, and integrated the documentation by fast-forward to `main`.

## Entry subjects

- Planner base: `tiagooliveirajs/repo-planner@bc5d6913dfdb26eda89689fb2b1cfbb878070022`
- Product base: `tiagooliveirajs/mouse-bridge-remapper@db2f96606240ffc7a2a4f3bac24773d34aec0e59`
- Historical accepted baseline: `tiagooliveirajs/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- Historical accepted G06 UF2 SHA-256: `d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88`

## Integrated product subject

Final MBR-00 product-documentation `main` after consistency fixes:

`tiagooliveirajs/mouse-bridge-remapper@efe3660eece4a2866615ec19270a04e498d485e9`

The planner completion record itself is part of the current `repo-planner/main`; successor gates must always re-read current `main` before execution.

## Provenance observed

Accepted G06 tree/docs were re-inspected at the exact accepted SHA. Relevant source/build areas include:

- `src/app`
- `src/ble_hogp`
- `src/bt_runtime`
- `src/domain`
- `src/hat`
- `src/hid_aggregator`
- `src/interaction`
- `src/logitech_hidpp`
- `src/profiles`
- `src/remap`
- `src/renderer`
- `src/storage`
- related headers/USB/build composition
- G04/G05/G06 validation docs
- product/architecture/UX contracts
- CI/toolchain files.

Detailed migration classification is `08-mbr-00-migration-manifest.md`.

## Frozen product decisions

1. Multiple mice may be saved; at most one Mouse is authoritative/connected.
2. BLE HOGP is the only Mouse transport.
3. FIRST_MOUSE uses repeated 8-second cycles until first success.
4. HOME with saved mice + no live Mouse starts 8-second SEARCH_SAVED automatically.
5. Saved-search expiry/cancel -> `DEVICE NOT FOUND`.
6. Pair New is a 15-second unsaved-only replacement search.
7. A healthy current Mouse remains connected/usable while Pair New searches.
8. Already-saved candidates are ignored for Pair New acceptance.
9. First qualified unsaved candidate becomes non-authoritative replacement-ready.
10. Handoff freezes old input, releases held Mouse/Escape state, disconnects/clears old live session while preserving its saved record/bond, confirms new state, then promotes the candidate.
11. Timeout/cancel before handoff leaves the current Mouse connected.
12. Exact `help-pair-new` and `help-retry-pair-new` text supplied by the user is canonical.
13. To reconnect saved from Pair New flow, user unplugs current Mouse and Backs until HOME reaches SEARCHING.
14. `STANDARD` is canonical profile vocabulary; historical `DEFAULT` is alias only.
15. Saved Devices disconnected status is `DISCONNECTED`.
16. Long names render first 21 supported characters; fallback `UNKNOWN MOUSE`.
17. Escape remains synthetic USB Keyboard output only.
18. No hidden Lock controls; didactic B/X/Y semantics are explicit.
19. `JOY LEFT: GO TO HOME` on Escape Active is intentional.
20. New didactic token columns are frozen.

## Frozen USB identity

- VID `0xCAFE`
- PID `0x4011`
- bcdDevice `0x0100`
- manufacturer `tiagooliveirajs`
- product `Mouse Bridge Remapper`
- no serial string
- interface 0 HID Mouse
- interface 1 minimal HID Keyboard for synthetic Escape
- no CDC/debug interface
- fixed from boot/no Bluetooth-driven re-enumeration

`0xCAFE` is documented as a project/local development convention, not a commercial USB-IF allocation claim.

## Architecture conclusion

Frozen conceptual modules:

- `domain`
- `mouse_registry`
- `mouse_session`
- `output_state`
- `profiles`
- `remap`
- `pairing_coordinator`
- `bt_runtime`
- `ble_hogp`
- `logitech_hidpp`
- `product_storage`
- `usb_hid`
- `interaction`
- `ui_projector`
- `renderer`
- `hat`
- `app`

Forbidden speculative architecture includes >1 authoritative Mouse, cross-Mouse aggregation, multi-live focus/count/capacity state, Bluetooth Keyboard/Composite product modules and diagnostic CDC product identity.

## Product documentation updated

- `README.md`
- `docs/manual/01-first-start-and-pairing.md`
- `docs/manual/02-home-and-connection.md`
- `docs/manual/03-remapping.md`
- `docs/manual/04-saved-devices.md`
- `docs/manual/05-controls-lock-and-help.md`
- `docs/manual/06-screen-reference.md`
- `docs/architecture/00-documentation-authority.md`
- `docs/architecture/01-product-contract.md`
- `docs/architecture/02-system-architecture.md`
- `docs/architecture/03-mouse-session-domain.md`
- `docs/architecture/04-bluetooth-lifecycle.md`
- `docs/architecture/05-remap-escape-usb.md`
- `docs/architecture/06-persistence-and-removal.md`
- `docs/architecture/07-ui-renderer.md`
- `docs/architecture/08-verification-invariants.md`
- `docs/architecture/09-open-decisions.md`

## Planner updated/created

- `00-authority-scope-and-precedence.md`
- `01-g06-migration-ledger.md`
- `02-ambiguity-register.md`
- `03-target-architecture.md`
- `04-ux-state-model.md`
- `05-gates.md`
- `06-execution-rules.md`
- `07-mbr-00-frozen-contract.md`
- `08-mbr-00-migration-manifest.md`
- `README.md`
- `requirements/2026-09-20-single-connected-mouse.md`
- `requirements/2026-09-20-pair-new-help-and-handoff.md`
- this completion report.

`requirements/2026-09-19-user-rules.md` remains preserved as original provenance.

## Verification/evidence

Documentary/repository evidence performed:

- exact accepted G06 commit revalidated;
- accepted G06 tree/docs/build areas re-inspected;
- entry SHAs revalidated;
- product and planner changes made on dedicated `mbr/mbr-00-contract-freeze` branches;
- branch diffs confirmed linear/ahead of `main` with no divergence;
- product consistency review found and corrected residual disconnect-first wording in session-domain/persistence docs;
- default-branch code-search checks after integration found no canonical `Pair New disconnects`, `disconnect first`, `DEFAULT REMAP`, or stale `NO MBR GATE EXECUTED` residue in the checked active repositories;
- both repositories integrated by non-forced fast-forward to `main`.

Not applicable / intentionally not performed:

- firmware implementation;
- host/Pico build;
- UF2 generation;
- hardware flashing;
- new physical acceptance.

## Non-claims

- Frozen documentation does not mean firmware is implemented.
- Historical G06 UF2 is baseline evidence, not an MBR artifact.
- Physical timeout/pairing/handoff behavior remains to be validated in later physical gates.

## Gate conclusion

**MBR-00 acceptance criteria are satisfied.** No product decision required for mbr-01 through mbr-07 remains unresolved.

## Next executable point

`mbr-01 — Clean bootstrap and architecture enforcement`.

Before executing it, re-read current `main` of both repositories, this completion report, `07-mbr-00-frozen-contract.md`, `08-mbr-00-migration-manifest.md`, `05-gates.md`, `06-execution-rules.md`, and exact G06 accepted source.
