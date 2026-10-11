# RemappingBridge v3.0.0 — publication audit

**Operator authorization:** [MOD-10 acceptance](operator-acceptance.md), 2026-10-11. 
**Planned tag:** `v3.0.0` (matches prior v1.0.0/v2.0.0 tag convention).
**State:** awaiting final source merge, pinned production release workflow, tagged release and independent asset verification. Do not mark published until GitHub returns a real release.

- Product PR: https://github.com/remappingbridge/remappingbridge/pull/30
- Release notes source: `docs/releases/v3.0.0.md`.
- Expected assets: `remappingbridge-v3.0.0-pico2w.uf2` and `SHA256SUMS.txt`.
- New release commit: PENDING
- Final production test run: PENDING
- Tag object SHA / release URL / UF2 SHA-256: PENDING

**Risks:** v2 firmware cannot read persisted v3 profile; downgrade can lose global remapping/shortcuts. Normal UF2 update must not erase BLE bonds or Movement per mouse. No claims of individually verified action/host effects.
