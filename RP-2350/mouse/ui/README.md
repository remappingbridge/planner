# UI planning namespace

Planning/execution history for `remappingbridge/mouse-ui`.

## Frozen product baseline

UI Layout 1.0 is frozen and promoted:

~~~text
main @ e8adad7919e931c92515bf655ef4050876a8e7a9
release/ui-layout-v1.0 @ same commit
application version 1.0.0
~~~

Business rules: `mouse-ui/docs/product/ui-layout-v1.0.md`.
Architecture: `mouse-ui/docs/architecture/ui-layout-v1.0.md`.
Planner release record: [`releases/ui-layout-v1.0.md`](releases/ui-layout-v1.0.md).

## Historical program

MUI-00 through MUI-08 reconstructed and validated the initial C11/SDL2 frontend. Those gates are complete and remain under `gates/` and `executions/` for traceability.

## Post-1.0 branch model

- `lab/*` — disposable/version exploration;
- `candidate/*` — clean implementation of an accepted next-layout candidate;
- `rebuild/*` — replacement of unhealthy internals while preserving frozen behavior;
- `release/*` — named immutable product-layout baseline references.

Ordinary contract/Core work must not modify the frozen layout merely to simplify backend implementation. A true UX change requires explicit layout versioning.
