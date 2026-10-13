# WEB-15 — Operator acceptance

**Status: PENDING — FINAL WEB GATE NOT YET ACCEPTED.**

Operator had already accepted **WEB-14** and asked that a Table of contents be delivered in final **WEB-15** immediately before “Why use it?”. This request **authorized** WEB-15 work but is **not** a statement of WEB-15 acceptance.

Published WEB-15 candidate:
- Firmware [PR #52](https://github.com/remappingbridge/remappingbridge/pull/52), merged `dd401996f6ab72ef1babb475dc0575fdd89e0052`, adds requested 8-section ToC in its exact location.
- Simulator [PR #14](https://github.com/remappingbridge/remappingbridge.github.io/pull/14), merged `4b9b4892b52dc2005f73c7d0594ac512bc96f668`, corrects the stale WEB-10 status line in site README with **no app-code changes**.
- [Gate traceability matrix](gate-matrix.md), [integrated audit](candidate.md), [manual acceptance scenarios](manual-tests.md) and [maintenance process](maintenance.md) document the final verification.

After initial final publication, the operator requested removal of development chronology and detailed internal processes from all public README prose. The revised public-facing candidate is now:
- Firmware [PR #53](https://github.com/remappingbridge/remappingbridge/pull/53) merged `35b9e81ce142532d0c34da847d09079eef8ad099`.
- Website [PR #15](https://github.com/remappingbridge/remappingbridge.github.io/pull/15) merged `905dbf86deb7fc0f7dc26601ed3714a7bb28acba`.
This is **correction feedback within WEB-15**, **not an acceptance decision**. Internal planner documentation deliberately retains all detailed gate and revision records.

Wait for explicit user approval of **WEB-15**. Only then set status **ACCEPTED**, finalize and merge this planner evidence PR. Do not claim the whole program closed before that decision. 
