# Mouse project planning namespaces

This directory separates planning/execution history for the three implementation responsibilities and their shared boundary.

| Path | Responsibility | Repository | Program status |
|---|---|---|---|
| `ui/` | frontend/UX | `remappingbridge/mouse-ui` | UI Layout 1.0 FROZEN |
| `contracts/` | UI↔Core neutral contract | `remappingbridge/mouse/contracts` | **UIC-00 ACTIVE NEXT** |
| `core/` | backend/Core | `remappingbridge/mouse-core` | planned / BLOCKED by UIC-08 |
| `integration/` | final composition/release | `remappingbridge/mouse` | planned / BLOCKED by MCORE-08 |

## Current product baseline

~~~text
mouse-ui application: 1.0.0
UI Layout: 1.0 FROZEN
main: e8adad7919e931c92515bf655ef4050876a8e7a9
stable ref: release/ui-layout-v1.0
~~~

The earlier MUI-00..08 reconstruction program remains accepted historical execution evidence. The product-level layout freeze supersedes the older MUI-08 commit as the contract-analysis source.

## Next execution order

~~~text
UI Layout 1.0 frozen
        |
        v
UIC-00..08  UI↔Core Contract v1
        |
        v
MCORE-00..08  real Core/backend
        |
        v
MINT-00..06  final embedded integration/release
~~~

Only a gate whose dependencies are accepted may become an implementation candidate. Frontend simulation never counts as physical/Core acceptance.
