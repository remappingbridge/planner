# MOD-09 — Pre-implementation and dependencies (2026-10-11)

- **Dependency:** MOD-08 explicitly accepted by operator on 2026-10-11.
- **Exact inherited commit:** `5bfde2c4dc21aef3505ea9884a4878ae8ee8ec6f` (correction to KDE/Android/Obsidian tests).
- **Firmware branch:** [feature/modifier-shortcuts-mod09](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod09), created from that SHA; tag v2.0.0/main untouched.
- **Guardrails:** 30 stable semantic actions, global 12 slots, USB 2-interface keyboard+consumer ABI, source-isolated HID aggregator, flash schema v3, 9×21 screen system and HAT action-on-release. No app-specific Obsidian zoom mapping.

### Main recovery risks
1. On disconnected USB session, old motion accumulators can be replayed into the new host as phantom cursor movement/scroll.
2. An in-flight old shortcut can survive changing that slot after the flash write, causing a stale action on the next USB ACK.
3. A corrupt/future ID in MOVE slot can activate unintended movement suppression despite having no valid HID action.
4. BLE queue overflow/held button lost edges can leave host keys/sticky drag if cancellation is incomplete.
5. Saved Devices color style must not leak to profile, DPI or rotation; only connected name cyan.
6. A disconnected/removal/lock path must not wipe other source-held Keyboard keys or clear valid Movement settings for other bonded mice.

### Implementation and proof sequence
- Harden recovery within existing app and modifier_shortcuts modules; no new transport or independent loop.
- Add CTest host domain and production-path source regressions.
- Build in GitHub CI with pinned Pico SDK/toolchain; retain exact UF2, SHA256 and run ID.
- Perform physical HOME CONNECTED matrix; operator acceptance required for MOD-10.

[Full firmware technical notes](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod09/docs/modifier-shortcuts/mod09-recovery.md)
