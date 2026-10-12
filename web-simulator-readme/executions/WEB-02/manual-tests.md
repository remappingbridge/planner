# WEB-02 — Operator testing in the production browser

**Status:** PENDING. The operator explicitly requested **only production-browser tests**, not a local Debian clone.

When the WEB-02 build is published, use the production URLs:

- **Application:** https://remappingbridge.github.io/
- **Browser tests:** https://remappingbridge.github.io/tests/

**Do not assume the candidate PR is deployed to Pages.** Check which git commit production serves. GitHub Pages administrator may need to configure **Settings → Pages → Deploy from a branch → main / (root)**. No authored build/Actions workflow is allowed for this website.

## Manual scenarios

- [ ] Open the **production** URL in Firefox. Confirm the badge reads **WEB-02**, the display is actually drawn as 240×240 Canvas (not the old text `pre`) and has nine text rows in English.
- [ ] Compare the glyph shape, column spacing, colors and positions to the physically approved v3 LCD. The pink title is vivid, the first two didactic body rows are pale yellow, the other input labels gray; the default LCD background is soft dark magenta.
- [ ] Click **Original**, then **Soft**, then **Gentle**. Confirm only the LCD background lightens between #080008, #190b1d and #28142c; magenta title and all text colors do **not** change. **Report which tone to adopt as the final default.**
- [ ] Press and hold each of the nine controls (five joystick gestures and A/B/X/Y). The matching LCD labels turn white while held, return to gray on release/cancel; counter/feedback still work.
- [ ] Confirm the main UI and the test page use **only English**, including buttons, accessible labels and feedback.
- [ ] At normal, 200%, 300% and 400% browser zoom (and HiDPI where available), confirm the LCD remains a crisp, square **pixel grid** without blurred font pixels. On mobile/narrow layouts, all control buttons remain reachable.
- [ ] Open **https://remappingbridge.github.io/tests/** and verify that the new suite reports **39/39 PASS**. If any fail, supply its name, browser and visual behavior. Simulated local tests do not substitute this real-browser run.
- [ ] Confirm the control clicks **do not yet navigate** HOME/Menu/Help, connect BLE or change real host zoom/brightness. Those later features do not belong to WEB-02.
- [ ] If production URL is absent/404, report this Pages Settings blocker rather than accepting based on a local clone.

**Operator result:** PENDING. If the operator requests a different dark-magenta preset, update the same WEB-02 gate without modifying semantic foreground colors. **WEB-03 must wait for operator acceptance.**
