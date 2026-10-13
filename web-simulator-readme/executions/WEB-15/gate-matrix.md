# WEB-15 — Verified sixteen-gate traceability matrix

**Status: 15 historical gates processed (WEB-00 authorized; WEB-01 through WEB-14 explicitly ACCEPTED); WEB-15 CANDIDATE PUBLISHED, PENDING OPERATOR ACCEPTANCE.** Distinguish operator statements from automated checks and from real physical/browser testing.

This table is grounded in **existing accepted planner execution records**, verified GitHub PR merge commits in the website (#1, #3–#14) and firmware (#46–#52), and current GitHub branches. Exact gate coverage **WEB-00 through WEB-15 = 16 gates**.

| Gate | Operator status | PR evidence | Actual main commit and delivered scope |
| --- | --- | --- | --- |
| **WEB-00** | AUTHORIZED | Planning [#17](https://github.com/remappingbridge/planner/pull/17) | Firmware v3.2.3 baseline `f38c5fd15c68ea9a36d3b05912727788d7b98e81`; authorization to proceed, not claimed as detailed manual acceptance |
| **WEB-01** | ACCEPTED | Site [#1](https://github.com/remappingbridge/remappingbridge.github.io/pull/1) | `7b4e7e7d60412abc86c2a727d72f66b67984dffb` · HTML/CSS/JS simulator foundation |
| **WEB-02** | ACCEPTED | Site [#3](https://github.com/remappingbridge/remappingbridge.github.io/pull/3) | `50c0fbfc8f6ea5852a572818ea89d3e74e6c2738` · 240×240 Canvas glyphs |
| **WEB-03** | ACCEPTED | Site [#4](https://github.com/remappingbridge/remappingbridge.github.io/pull/4) | `d78533cbd274647b5c521cf8132e2a2d148cf3e3` · HAT events/Help/Lock and Gentle LCD |
| **WEB-04** | ACCEPTED | Site [#5](https://github.com/remappingbridge/remappingbridge.github.io/pull/5) | `19a5b7dd24c917ecc2810ad8230963f13e33d00e` · 45 firmware screens, compact HAT |
| **WEB-05** | ACCEPTED | Site [#6](https://github.com/remappingbridge/remappingbridge.github.io/pull/6) | `0ee2238faeb6942f9edc99b8320f65b785feec0d` · local virtual mice and key legend |
| **WEB-06** | ACCEPTED | Site [#7](https://github.com/remappingbridge/remappingbridge.github.io/pull/7) | `7b8449dd233016698d089015b28a811ddd643478` · sticky HAT, per-mouse Custom/Movement |
| **WEB-07** | ACCEPTED | Site [#8](https://github.com/remappingbridge/remappingbridge.github.io/pull/8) | `5f2597946c1af04ceb08c9eec301dc867675c248` · Modifier + 12 combinations + 30 actions; corner branding |
| **WEB-08** | ACCEPTED (part later retired) | Site [#9](https://github.com/remappingbridge/remappingbridge.github.io/pull/9) | `9ba5732b31601ed4b92300fce8b29f87a21fab9c` · mobile/zoom; **brightness/density controls subsequently removed in WEB-09** |
| **WEB-09** | ACCEPTED | Site [#10](https://github.com/remappingbridge/remappingbridge.github.io/pull/10) + [#11](https://github.com/remappingbridge/remappingbridge.github.io/pull/11) | Final `dae055bc097887d5e217081fd235989406945ebd` · no display controls, isolated Inspector, corrected scenarios/Lab |
| **WEB-10** | ACCEPTED | Site [#12](https://github.com/remappingbridge/remappingbridge.github.io/pull/12) + [#13](https://github.com/remappingbridge/remappingbridge.github.io/pull/13) | Final simulator `26aaac5c7939ddc8883aa756c6a575a3d36b808a` · 45/45 C-fixture screens, isolated test storage; Pages run #38325202264 success |
| **WEB-11** | ACCEPTED | Firmware [#46](https://github.com/remappingbridge/remappingbridge/pull/46) + [#47](https://github.com/remappingbridge/remappingbridge/pull/47) | Final `ba21e0ef3228adf6e083c134f0a01053942308bc` · visual-first README, product photographs, links and architecture SVG |
| **WEB-12** | ACCEPTED | Firmware [#48](https://github.com/remappingbridge/remappingbridge/pull/48) | `131b30758e4f5993f64480e2eadafff28699a570` · BOM, safe mechanical assembly, 9 GPIO controls and 2 original SVGs |
| **WEB-13** | ACCEPTED (revised) | Firmware [#49](https://github.com/remappingbridge/remappingbridge/pull/49) (superseded) + [#50](https://github.com/remappingbridge/remappingbridge/pull/50) | Final `d4b1e3a822f710907b8b14f80b4f67119d8e8aef` · operator removed redundant preview/media; retained simulator guide |
| **WEB-14** | ACCEPTED | Firmware [#51](https://github.com/remappingbridge/remappingbridge/pull/51) | `7ec0d95ce595be82b61509c454d618321084ba72` · source-verified v3.2.4 UF2, SHA-256 and Pico BOOTSEL |
| **WEB-15** | CANDIDATE — PENDING ACCEPTANCE | Firmware [#52](https://github.com/remappingbridge/remappingbridge/pull/52); Site [#14](https://github.com/remappingbridge/remappingbridge.github.io/pull/14) | Firmware `dd401996f6ab72ef1babb475dc0575fdd89e0052` · ToC; Site `4b9b4892b52dc2005f73c7d0594ac512bc96f668` · WEB-10 acceptance status corrected; planner evidence PR pending |

### Planner decisions and acceptance distinction

- WEB-00 planner [#17](https://github.com/remappingbridge/planner/pull/17) records **"prossiga"** as authorization rather than misquoting explicit gate-acceptance words. WEB-01 planner [#18](https://github.com/remappingbridge/planner/pull/18) contains explicit acceptance and test policy.
- WEB-10 acceptance consolidated via planner [#29](https://github.com/remappingbridge/planner/pull/29). Subsequent approvals: WEB-11 [#30](https://github.com/remappingbridge/planner/pull/30), WEB-12 [#31](https://github.com/remappingbridge/planner/pull/31), WEB-13 [#32](https://github.com/remappingbridge/planner/pull/32), WEB-14 [#33](https://github.com/remappingbridge/planner/pull/33). All those gates have recorded express operator acceptance.
- WEB-15 traceability, audit and this README ToC live only in **new WEB-15 evidence**; do **not** mark the last gate accepted until the operator says so.
- Each prior manual-test checklist documents proposed visual/physical/browser checks. A gate acceptance message **does not prove** all test rows were measured under physical conditions, on all host OS versions or in a separately instrumented Chrome/Firefox session.
- Website [PR #14](https://github.com/remappingbridge/remappingbridge.github.io/pull/14) is a **docs-only WEB-15 correction**: its `main` differs from accepted WEB-10 runtime source only in the site `README.md`, not in the HTML, CSS, JavaScript or fixtures. It accurately marks WEB-01–WEB-10 accepted.
