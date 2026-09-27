# MINT roadmap — product composition and release

| Gate | Name | Result | Depends on |
|---|---|---|---|
| MINT-00 | Composition Foundation | pinned UI/Core/contract revisions and reproducible embedded build | MCORE-08 |
| MINT-01 | Embedded UI Adapters | HAT GPIO + ST7789 adapter for exact UI framebuffer/input | MINT-00 |
| MINT-02 | Contract Binding | real UI adapter ↔ Core v1 end-to-end | MINT-01 |
| MINT-03 | Physical Product Flows | first/saved/Pair/profile/Custom/remove flows on hardware | MINT-02 |
| MINT-04 | Recovery & Safety | disconnect, cancel, stale/late, power and held-output faults | MINT-03 |
| MINT-05 | Product Acceptance Matrix | UI 1.0 + Core behavior + physical evidence complete | MINT-04 |
| MINT-06 | Release Candidate | pinned product release, docs, artifacts and rollback baseline | MINT-05 |
