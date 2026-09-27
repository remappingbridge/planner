# UIC-06 — mouse-ui Adapter

Status: **BLOCKED**.

## Objective

Prove frozen mouse-ui can consume/emit the v1 candidate through a thin adapter without changing UI Layout 1.0.

## Dependencies

UIC-05 candidate available.

## Tasks

1. Add contract adapter boundary in mouse-ui without importing Core-private code.
2. Map candidate Snapshot/Event to private Product View.
3. Map navigation semantic intents to candidate commands.
4. Keep deterministic mock behind the same adapter-compatible seam for desktop tests.
5. Run all frozen 1.0 goldens/regressions plus candidate conformance fixtures.
6. Record any contract insufficiency as UIC draft feedback rather than patching UX silently.

## Automated / documentary acceptance

- [ ] UI Layout 1.0 13-test baseline remains green or expands without behavior regression
- [ ] all 30 screen goldens/hashes remain compatible unless purely diagnostic metadata changes
- [ ] adapter has no SDL/projector dependency in public contract mapping
- [ ] candidate fixtures pass

## Human acceptance

- [ ] review confirms no user-visible 1.0 behavior changed

## Deliverables

- real Bluetooth/Core implementation
- contract release before Core-side proof
- UX redesign

## Forbidden scope

- mouse-ui adapter candidate
- adapter tests
- UIC-06 evidence

