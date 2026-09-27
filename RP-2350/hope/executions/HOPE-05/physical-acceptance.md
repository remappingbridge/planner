# HOPE-05 — remove-this physical acceptance

Status: **ACCEPTED BY OPERATOR / READY FOR PROMOTION**.

Candidate:

- branch: `hope/hope-05-remove-this`
- commit: `6359472553df98da57a4fb8af2d28942e9deda67`
- draft PR: `#17`
- accepted base: `a459316fd2c9eefb9fc85e6656cd96134f22d0a0`
- UF2: `HOPE-05-remove-this-6359472-pico2w.uf2`
- size: **911,872 bytes**
- SHA-256: `b2770517744cf6f3d71933c57a963f502e563f0e03bc76b45e73f07012004070`
- CI run: `35993815633` — 39/39 host tests PASS; Pico 2 W production PASS.

## Required physical scenarios

1. Open `saved-devices` on each saved Mouse page and press Joy Press; confirm the exact `REMOVE THIS MOUSE` layout.
2. Confirm line 2 shows the Mouse from the page that opened the screen, using the canonical name formatting.
3. Before removal starts, press `KEY B`; confirm it returns to the same logical Mouse in `saved-devices`.
4. Re-open `remove-this`; press `KEY X`; confirm HOPE-05 does not navigate to Help yet. HOPE-30 owns that screen.
5. With two saved Mice and one connected, remove the **disconnected** Mouse. Confirm the current Mouse remains connected and usable.
6. Confirm the removed disconnected Mouse disappears from `saved-devices`, its name no longer appears, and the count decreases by exactly one.
7. Power-cycle/reboot and confirm the removed Mouse is still absent and does not auto-connect.
8. Pair/save the removed Mouse again only when intentionally using Pair New; confirm it can become a new saved association normally.
9. With two saved Mice, open `remove-this` for the disconnected Mouse, then cause the other Mouse to reconnect/reorder the list before pressing `KEY A`. Confirm the originally selected target is the one removed.
10. Remove the **currently connected** Mouse. Confirm held buttons/remapped Escape output are neutralized, the Mouse disconnects, and its bond/name is removed.
11. If another saved Mouse remains after removing the current Mouse, confirm the UI returns to a valid `saved-devices` page and the remaining Mouse is still represented correctly.
12. Remove the final saved Mouse. Confirm the saved count becomes zero and the UI enters `searching-first` / first-Mouse search.
13. While removal is pending, press `KEY A` repeatedly; confirm it never removes a second Mouse.
14. If an identity has duplicate legacy bond entries, remove that Mouse and confirm all equivalent credentials are gone and it does not reappear as another saved page.
15. Regression: Pair New, normal saved reconnection, Mouse movement, buttons, scroll, PASSTHROUGH/STANDARD/ESCAPE/CUSTOM and global lock behavior remain functional.

## Operator result

**ACCEPTED** by the operator on 2026-09-24.

Accepted exact candidate:
- commit: `6359472553df98da57a4fb8af2d28942e9deda67`
- UF2 SHA-256: `b2770517744cf6f3d71933c57a963f502e563f0e03bc76b45e73f07012004070`

Operator declaration: gate accepted after physical testing.


Promotion:
- merged PR: `#17`
- main commit: `07abebc67d202ad67c52f325d6153b9ed0d90ab6`
