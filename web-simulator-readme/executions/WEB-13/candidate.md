# WEB-13 — Candidate and operator-requested correction

**Status: CORRECTED CANDIDATE PUBLISHED; OPERATOR ACCEPTANCE PENDING. WEB-14 NOT STARTED.**

## Historical first candidate (superseded)

Firmware [PR #49](https://github.com/remappingbridge/remappingbridge/pull/49) originally added a clickable illustrative SVG and redundant CTAs to the README, together with the five-step virtual guide. It merged at `c06c585ecc7411e930d30457795366c4a869a262`; its canonical [CI run #38329323390](https://github.com/remappingbridge/remappingbridge/actions/runs/38329323390) passed. The original static SVG had 12/12 structural/source tests passed, but **operator explicitly rejected that section** as unnecessary. Neither CI nor publication equals operator acceptance.

## Operator correction — current candidate

Operator instruction: **remove** the entire intro block starting **"Curious? Explore the virtual HAT and LCD now"**, including the large linked static preview and redundant **"Open the interactive simulator — click the preview"** CTA. This is a correction **inside WEB-13**, not a gate acceptance or authorization to proceed.

Firmware [PR #50](https://github.com/remappingbridge/remappingbridge/pull/50) implements that request and merged to main **`d4b1e3a822f710907b8b14f80b4f67119d8e8aef`**:
1. Removed precisely the operator-quoted intro content without adding replacement marketing copy, image or second CTA.
2. Deleted **`docs/assets/simulator-preview-v3.2.4.svg`**, now unreferenced. It was an original illustration, never a real browser capture.
3. Rewrote only the stale clause in the later `Try it in your browser` paragraph that referred to the deleted preview. It now links directly to the real GitHub Pages application and truthfully says GitHub README itself is not executable.
4. Kept **existing up-front simulator and direct v3.2.4 firmware-download links**, accepted real Pico/Waveshare photos, benefit bullets, all WEB-12 hardware diagrams and the later **HOME → Pair New → Movement → Modifier/Shortcuts** textual demonstration guide. The simulator disclosure remains in that section.
5. **14/14 remaining relative README Markdown references** valid in final candidate tree; no dead link to deleted preview and no leftover redundant CTA. Only README and deletion of unused SVG changed. No firmware, UF2, release, app code or workflows affected.

The new proposal deliberately **omits** the image-preview deliverable in the original WEB-13 gate definition because the operator expressly chose not to include it. No claim of photographic/captured UI documentation or a live-browser run is made. A live simulator link and test guide remain.

The corrected README is public for operator review; the operator has **not yet explicitly accepted WEB-13**. The planner evidence PR remains draft. **WEB-14 NOT STARTED.**
