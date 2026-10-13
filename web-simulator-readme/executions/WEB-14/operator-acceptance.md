# WEB-14 — Operator acceptance

**Status: ACCEPTED by operator on October 13, 2026 (America/Sao_Paulo).** After the verified latest-release v3.2.4 download/checksum and Pico 2 W BOOTSEL documentation was published, the operator explicitly said **"gate atual aceito. prossiga"**. The same message requested a **Table of Contents immediately before `## Why use it?` in the final WEB-15 gate**, not in WEB-14.

## Accepted publication and constraints

- Firmware [PR #51](https://github.com/remappingbridge/remappingbridge/pull/51) merged the README-only installation/checksum/BOOTSEL guide at `main` SHA **`7ec0d95ce595be82b61509c454d618321084ba72`**.
- GitHub latest release v3.2.4 metadata verified official UF2 `remappingbridge-v3.2.4-pico2w.uf2` (953,344 bytes), official asset SHA-256 `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`, and sibling `SHA256SUMS.txt`. Versioned direct link and stable `/releases/latest` both remain visible.
- BOOTSEL instructions distinguish RP2350 from older RPI-RP2 bootloader drive labels and warn against charge-only cable, mass erase and `flash_nuke`.
- Canonical [CI run #38384287376](https://github.com/remappingbridge/remappingbridge/actions/runs/38384287376) succeeded in both host and Pico production checks, without publishing another release.
- This human gate approval does not assert undocumented real physical flashing, checksum file parsing, or all OS runtime tests. Original README short visual hero was preserved.

**WEB-15 authorized:** perform final integrated cross-repository audit and insert a clean English **Table of Contents directly before `Why use it?`** in root firmware README; links must work in GitHub, hierarchy and original hero must remain untouched. **WEB-15 not accepted until the operator explicitly approves it.**
