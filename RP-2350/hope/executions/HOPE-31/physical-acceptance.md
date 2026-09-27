# HOPE-31 — final physical acceptance

Status: **ACCEPTED BY OPERATOR / READY FOR PROMOTION**.

Candidate:

- branch: `hope/hope-31-final-inventory`
- commit: `15a3ec9f8b20c96e41cb7e04610191b2853378bf`
- draft PR: `#20`
- accepted base: `8aa50611bcaf1a0091de6b111de0c6b7e4a67646`
- UF2: `HOPE-31-final-inventory-15a3ec9-pico2w.uf2`
- size: **910,848 bytes**
- SHA-256: `6ff7b6e5d8d171e65184b16298b0559105793ac838ee1d2a0f13ecf2f8a7d4ef`
- CI run: `36272898711` — 45/45 host tests PASS; Pico 2 W production PASS.

## Final screen matrix

Verify the canonical 29-screen set as applicable through normal flows:

1. SEARCHING FIRST MOUSE
2. FIRST MOUSE CONNECTED
3. home-connected
4. saved-devices
5. remove-this
6. pair-new
7. retry-pair-new
8. home-searching
9. home-retry
10. REMAPPING OPTIONS
11. PASSTHROUGH ACTIVE
12. APPLY STANDARD REMAP
13. STANDARD REMAP ACTIVE
14. APPLY PASSTHROUGH
15. APPLY ESCAPE REMAP
16. ESCAPE APPLIED ACTIVE
17. EDIT CUSTOM REMAP
18. LEFT WILL BECOME
19. RIGHT WILL BECOME
20. MIDDLE WILL BECOME
21. FORWARD WILL BECOME
22. BACKWARD WILL BECOME
23. HOME SEARCHING HELP
24. HOME RETRY HELP
25. PAIR NEW DEVICE HELP
26. MOUSE NOT FOUND HELP
27. REMOVE CONNECTED HELP
28. REMAPPER OPTIONS HELP
29. REMOVE MOUSE HELP

## Final regression scenarios

1. Confirm no HOME contains a Learn The Keys option.
2. With zero saved Mice, confirm SEARCHING FIRST MOUSE still appears automatically and first pairing still succeeds.
3. Confirm there is no reachable MOUSE STATUS, OTHER DEVICES STATUS, MOUSE HELP or DEVICES HELP page.
4. Confirm Custom apply remains in EDIT CUSTOM REMAP and no separate Custom Applied page appears.
5. Connected HOME has exactly 3 routes; searching/retry HOME has exactly 2.
6. Verify HOME resolver for connected, saved-offline and zero-saved states.
7. Verify global Lock/unlock on applicable screens and Any Key Back on every Help page.
8. Verify Saved Devices names/order, connected-first behavior and persistence after disconnect/reboot.
9. Verify removal of disconnected and connected saved Mice, including duplicate identity cleanup.
10. Verify Pair New and retry/help flows.
11. Verify Passthrough, Standard, Escape and Custom remapping, including all five WILL BECOME screens.
12. Verify Mouse movement, buttons, wheel/scroll and synthetic Escape output.
13. Verify Logitech Lift handling remains functional.
14. Power-cycle and confirm persisted product state and saved-name behavior remain consistent.
15. Confirm no Keyboard/Composite pairing UI or legacy status page is reachable.

## Operator result

**ACCEPTED** by the operator on 2026-09-26.

Accepted exact candidate:
- commit: `15a3ec9f8b20c96e41cb7e04610191b2853378bf`
- UF2 SHA-256: `6ff7b6e5d8d171e65184b16298b0559105793ac838ee1d2a0f13ecf2f8a7d4ef`

Operator declaration: HOPE-31 accepted after final physical testing.

Upon acceptance of this exact candidate, merge PR #20. That promotion completes the HOPE gate series; no further gate exists in this series.


Promotion:
- merged PR: `#20`
- main commit: `5a8f3d39e37e9b5a17ccdee0af5531c6d3423087`
- HOPE series: **COMPLETE**
- next action authorized by operator: publish RemappingBridge 1.0
