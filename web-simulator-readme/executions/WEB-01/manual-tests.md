# WEB-01 — Production-browser test checklist (operator preference)

**Gate decision:** ACCEPTED by the operator on October 12, 2026. This checklist remains a **separate, not-yet-observed production-browser verification record**; gate acceptance must not be misrepresented as browser testing evidence.

The operator will test the application directly at **https://remappingbridge.github.io/**, using a normal web browser. **Do not require Debian, a local git checkout, or local `file://` tests.** The static site must first be enabled through GitHub Pages if the production URL is not yet served.

## Production test cases

- [ ] **Availability:** the production URL responds with the current application, not GitHub 404 or an unconfigured Pages placeholder.
- [ ] **English interface:** page `lang=en`, headings, preview labels, screen-reader descriptions, buttons and messages all use English.
- [ ] **LCD preview:** SEARCHING FIRST MOUSE and its nine lines remain readable; this is HTML text, not a pixel-perfect ST7789 Canvas.
- [ ] **Virtual controls:** tap/click all nine HAT controls; each control displays correct English feedback and increments the count.
- [ ] **Clear:** after several actions, Clear resets the counter to `00` and restores `Ready for virtual controls.`.
- [ ] **Pointer input:** hold and release/cancel each HAT control; pressed visuals clear correctly.
- [ ] **Keyboard accessibility:** Tab, Enter, and Space activate accessible HTML buttons; focus styling is visible.
- [ ] **Responsive display:** desktop, narrow window and mobile portrait/landscape keep LCD and controls reachable without clipping.
- [ ] **Live browser test suite:** open **https://remappingbridge.github.io/tests/** and inspect the results, including English locale checks. Never claim the suite passed without observing it.
- [ ] **No real hardware claims:** page clearly says BLE, USB, flash and the full firmware renderer/navigation are not yet implemented.
- [ ] **No npm/CDN/author-owned build Actions:** the site is served as static HTML/CSS/JS from the default branch.

**Observed production status:** NOT VERIFIED IN THIS CONVERSATION. The operator explicitly accepted WEB-01 and requested testing on the production URL. Future web gates must present production-browser verification steps, not Debian commands.

Related: [WEB-01 operator acceptance](operator-acceptance.md).
