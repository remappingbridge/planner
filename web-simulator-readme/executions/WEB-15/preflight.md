# WEB-15 — Preflight

**Execution date: October 13, 2026 (America/Sao_Paulo).** Dependency explicitly satisfied: WEB-14 was accepted by the operator, and its planner evidence [PR #33](https://github.com/remappingbridge/planner/pull/33) was merged as `e7e503e477c36c8f66ded8d82251d989e2a09f82`.

The operator requested a **Table of contents immediately before `Why use it?`**, **to be delivered in the final gate** rather than modifying the accepted WEB-14 package.

## Frozen baselines

- Firmware `remappingbridge/remappingbridge` main before WEB-15: `7ec0d95ce595be82b61509c454d618321084ba72`. Current firmware release v3.2.4 (published October 12, 2026), release source commit `69a640d9767ec7198572eb9b5073ed71f8f3d202`; the release assets are separate from README document commits.
- Simulator `remappingbridge/remappingbridge.github.io` WEB-10 accepted main source: `26aaac5c7939ddc8883aa756c6a575a3d36b808a` (successful GitHub Pages deploy run [#38325202264](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38325202264)). The source-controlled site README erroneously still marked WEB-10 pending, making a one-line correction appropriate in final audit.
- Planner accepted main pre-WEB-15: `e7e503e477c36c8f66ded8d82251d989e2a09f82`.
- Release asset verification via official GitHub API on October 13, 2026: `remappingbridge-v3.2.4-pico2w.uf2` size **953,344**; asset digest **SHA-256 `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`**; separate `SHA256SUMS.txt`, stable latest-release endpoint.

## Authorized changes only

1. Add **concise English, eight-section Markdown Table of contents** directly before `## Why use it?` in firmware **README.md**. Preserve verbatim accepted short visual hero, hardware photos, BLE/security caveats, simulator, BOOTSEL installation, checksum, license and documentation tail. Do not restore the WEB-13 rejected large static simulator preview or its deleted SVG.
2. During cross-repository audit, correct outdated WEB-10 acceptance claim in website **README.md only**, without touching published simulator runtime HTML/CSS/JS/fixtures.
3. Document **all 16 WEB-00..WEB-15 gates**, real PR/SHAs, remaining browser/physical tests, deployments and a future-maintenance chain firmware → simulator → README. Do not invent a live browser session or physical flash.

No firmware source, binaries/UF2, release tags, JS simulator application or GitHub Actions workflow changes authorized. **WEB-15 remains pending explicit operator acceptance**.
