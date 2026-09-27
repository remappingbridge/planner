# 2026-09-20 — Pair New help and replacement-handoff clarification

Status: **CURRENT PRODUCT DECISION / HIGHER PRIORITY THAN EARLIER CONFLICTING PAIR-NEW INTERPRETATIONS**.

This record preserves the user-supplied screen text and its required lifecycle consequence.

## HELP PAIR NEW DEVICE

- Screen ID: `help-pair-new`
- Literal screen:

```text
PAIR NEW DEVICE HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

## help retry pair new

- Screen ID: `help-retry-pair-new`
- Literal screen:

```text
DEVICE NOT FOUND HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

## Lifecycle consequence

The phrases `CURRENTLY CONNECTED MOUSE` and `FIRST UNPLUG` mean Pair New must not disconnect a healthy current Mouse merely because the Pair New search begins.

Frozen behavior:

1. Pair New remains a new-only search.
2. If a Mouse is already authoritative/live, it remains connected and usable while Pair New searches and qualifies an unsaved candidate.
3. An already-saved candidate is not a Pair New winner; it is ignored for Pair New acceptance while the same search window continues.
4. A fully qualified unsaved candidate becomes a non-authoritative replacement-ready candidate.
5. Only at replacement handoff does the product stop old input, release held Mouse/Escape state, disconnect/clear the old session, preserve its saved record/bond, persist/confirm the new Mouse, and promote the new candidate as the sole authoritative Mouse.
6. At no time may two Mice be product-ready/authoritative.
7. If Pair New expires or is canceled before handoff, the original Mouse remains connected.
8. To reconnect a saved Mouse instead, the user follows the Help: turn off/unplug the current Mouse and navigate Back until HOME is reached. HOME then sees saved mice + no live Mouse and enters `home-searching` automatically.
9. If the current Mouse is manually unplugged while Pair New/help is visible, the runtime updates connection truth immediately, but Pair New does not silently change purpose. Saved search begins when HOME is accessed.

This clarification supersedes the earlier disconnect-at-Pair-New-entry interpretation in `2026-09-20-single-connected-mouse.md` wherever they conflict.
