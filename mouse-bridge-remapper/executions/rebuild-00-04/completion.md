# Clean batch execution: MBR-00 through MBR-04

This record supersedes historical implementation evidence for this new candidate only. The reset remains the starting baseline.

## Authorization

On 2026-09-20 the user explicitly authorized implementing MBR-00..04 sequentially from zero, bypassing physical tests until UF2 delivery. Physical acceptance is deferred, never claimed PASS. Work stops before MBR-05.

## Candidate

- Product base: 2f305838f7ab10a2d6affd63e5b359cd9a464543 (documentation-only).
- Planner base: 1b4d8ad1398343659c4bc6cde0bcd2bc6b207867.
- G06 layout reference: blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af.
- Product head: 8bebe26ff7554ffa811a58ea024cae5fe80a4a84.
- Source tree: a3e23fda6b84367360b501965d736840dc716769.
- Product PR: https://github.com/tiagooliveirajs/mouse-bridge-remapper/pull/6
- Product branch: mbr/rebuild-00-through-04.

## Gate outcome

| Gate | Implementation/automated result | Physical result |
|---|---|---|
| MBR-00 | Contract revalidated; provenance and current amendments recorded | Not required |
| MBR-01 | Clean host/Pico bootstrap and module/ownership guards | Not required |
| MBR-02 | 30 canonical screens, release/Help/lock/search/confirmation model and tests | Not required |
| MBR-03 | G06 geometry/palette, C618 hints, exact didactic columns, ST7789 and HAT | Deferred by user |
| MBR-04 | Fixed Mouse + Escape USB, bounded queue/backpressure, separate qualification UF2 | Deferred by user |

Seven local CTest suites PASS; both Pico 2 W RP2350 ARM-S Release builds PASS; UF2 structure and family verification PASS. Compiler ARM GCC 13.2.1; Pico SDK 2.2.0 at a1438dff1d38bd9c65dbd693f0e5db4b9ae91779; TinyUSB 86ad6e56c1700e85f1c5678607a762cfe3aa2f47.

Production UF2: 89088 bytes, SHA-256 c0be7d34dc977bd53ce5a4544f4e585653b26cfdae52140aebb4a2a2ef197e99.
Qualification UF2: 94720 bytes, SHA-256 7bb4b73315f6bb0eda0b6891e7ceb395ea18a5f9660c22a1fdec93dd98665a79.

Complete evidence: product docs/implementation/04-rebuild-00-04.md.
22 numbered physical scenarios: product docs/implementation/05-testes-manuais-mbr04.md.

Qualification uses explicitly labeled RAM fixtures and deliberate USB output tests. Production does not fabricate a Mouse connection. No BLE transport, persistent profile/remap implementation, credential cleanup or HID++ is claimed. These remain MBR-05 onward.

The next implementation gate is MBR-05. Operator feedback on the delivered MBR-03/04 physical candidate remains pending. Neither the existing historical acceptance records nor this batch authorization constitute physical PASS for this new candidate.
