# MCORE roadmap — real backend/Core

| Gate | Name | Result | Depends on |
|---|---|---|---|
| MCORE-00 | Foundation & Contract Adapter | C project/CI + v1 adapter + fake platform seams | UIC-08 |
| MCORE-01 | Registry & Persistence | stable saved IDs, names, profiles, global Custom persistence/recovery | MCORE-00 |
| MCORE-02 | BLE Session Lifecycle | FIRST/SAVED/PAIR_NEW discovery, bonding/reconnect, single live authority | MCORE-01 |
| MCORE-03 | HOGP Input Normalization | normalized Mouse input + optional Logitech HID++ path | MCORE-02 |
| MCORE-04 | Remap & Held-output Safety | profile engine, Custom, Escape state, cleanup policy | MCORE-03 |
| MCORE-05 | USB HID Output | TinyUSB Mouse + output-only Keyboard Escape delivery | MCORE-04 |
| MCORE-06 | Transactional Apply | runtime+persistence profile/Custom commit and contract results | MCORE-05 |
| MCORE-07 | Handoff, Remove & Recovery | Pair handoff, remove transaction, reboot/power/cancel/stale recovery | MCORE-06 |
| MCORE-08 | Core Hardware Baseline | v1 conformance + physical backend evidence + accepted Core baseline | MCORE-07 |
