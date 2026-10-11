# MOD-10 — pre-implementation, qualification boundaries (2026-10-11)

**Dependency accepted:** MOD-09 on SHA `dcc85dfc86ef140bf8acb2be54488f0ce07b3000`.
**Work branch:** [MOD-10](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod10). Baseline v2.0.0 and main remain unchanged.

## Qualification requirements
1. Validate the complete 45-screen/9×21 UX, including HOME-connected→REMAPPING OPTIONS→COMBINATIONS 1..6→SHORTCUTS 1..5→APPLY AND BACK, RESET and UNAVAILABLE masking.
2. Test all 12 stable global combination slots, 30 semantic Keyboard/Consumer actions, press/release acknowledgment and overflow recovery. Host tests prove protocol encoding, not actual app outcomes.
3. Verify v2→v3 migration, CRC-failed v3 preservation, reboot, persisted global profile/slots, per-Mouse movement identity, fail-safe remove, lock/Help and reconnect.
4. Preserve fixed VID/PID, 2 HID interfaces and Report/Boot Keyboard behavior; no CDC/UART/debug firmware path.
5. Produce a production `.uf2`, SHA256, CI logs, physical HOME-connected matrix and separately approved release candidate.
6. Non-destructively rehearse upgrade and downgrade; v2.0.0 cannot read v3 and may restore global profile defaults. Do not erase flash or bonds. Capture all 12 assignments before any downgrade and record actual outcome.
7. Operator's MOD-10 acceptance qualifies a candidate only. **Publishing/merging/tagging require another explicit instruction.**

## Deliberate hold
Obsidian KDE ZOOM IN/OUT mismatch has not been demonstrated fixed; this RC does not introduce an application-specific HID mapping. Media/volume/brightness and Android HOME remain host-dependent and must be tested as host behavior.
