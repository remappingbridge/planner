# MOD-00 — Architecture contract candidate for operator acceptance

**Status: CANDIDATE / PENDING OPERATOR ACCEPTANCE.**
This is a document-only candidate built on product v2.0.0; it does **not** claim firmware implementation, flashable UF2, runtime proof, actual keyboard or media compatibility.

## A. Scope and stable semantics (source-derived)
**A1.** Remapping Options has three rows: PASSTHROUGH DEFAULT, CUSTOM REMAPPING and MODIFIER SHORTCUTS; Standard/Escape Remap profiles and obsolete active/status strings are retired. Modifier Shortcuts opens an editor, **not** a third profile. Metadata screen slug renamed `remapper-options` → `remapping-options`.
**A2.** The 12 combination IDs are stable, in attachment page order: 0 Released, 1 Middle, 2 Left, 3 Right, 4 Forward, 5 Backward, 6 Wheel Up, 7 Wheel Down, 8 Move Left, 9 Move Right, 10 Move Up, 11 Move Down. The 30 shortcut IDs are 1..30 as listed in `04-shortcuts-hid-catalog.md`; 0 means NOT CUSTOMIZED.
**A3.** A combo is two consecutive body rows (label then current value). HAT up/down selects **one entire combo**; left/right changes pages with wrap. Joy Press enters the shortcut picker unless combo is UNAVAILABLE; KEY A resets selected slot unless UNAVAILABLE. Shortcuts page KEY A APPLY AND BACK saves then restores the same combinations page/selection; B cancels.
**A4.** Mod button can be absent when shortcuts are being stored. UNAVAILABLE arises for **the one button combination matching the configured Custom Modifier source**; the stored shortcut remains recoverable when source changes. It is not a persisted enum.
**A5.** All new screens inherit 9×21, input on key release, dark palette, selected white, currently applied cyan (saved-device connected-name-only cyan exception), Lock Y/unlock consumes first event, Help does not create side effects.

## B. Explicit source ambiguities: proposed decisions, NOT approved
**ADR-MOD00-COPY — Proposed:** Correct evident English typos in runtime copy to `PASSTHROUGH DEFAULT`, `COMBINATIONS N OF 6`, `MOD + WHEEL UP/DOWN IS`, always `NOT CUSTOMIZED`. The *literal* spelling from attachment remains in `fixtures/mod-00-source-layouts.json` as untouched source evidence. Keep `JOY LEFT\RIGHT: PAGE` and `ENTER\RETURN` / `PLAY\PAUSE` / `HOME SCREEN\PAGE` if user approves; all revised rows remain ≤21 chars. **NEEDS OPERATOR APPROVAL**; none of these source strings were automatically edited into firmware.

**ADR-MOD00-ORDER — Source fix:** The operator's 6 WILL BECOME entries are literally **LEFT, RIGHT, MIDDLE, FORWARD, BACKWARD, MODIFIER**. The previous planning sentence saying "replace ESCAPE in the same position" contradicted the attachment and is superseded. The fifth and sixth body positions are BACKWARD and MODIFIER. This is direct source evidence, not a design choice.

**ADR-MOD00-EXCLUSIVE — Proposed:** Exactly one applied Custom target MODIFIER, chosen among five physical sources. Changing source to MODIFIER in draft atomically reverts any earlier MODIFIER source to its identity action (e.g., LEFT→LEFT), preserving all 12 assignment slots. Modifier is active only in applied CUSTOM profile; PASSTHROUGH keeps original clicks. UI UNAVAILABLE checks the configured *applied Custom template* even while PASSTHROUGH is active so stored settings remain interpretable.

**ADR-MOD00-TAP — Proposed:** `MODIFIER RELEASED` fires only for a clean solo modifier press/release. Any second physical button, wheel event, or intentional MOVE gesture during that press suppresses the tap, even if that combo has no shortcut; disconnect/cancel/profile change never fires it. Edge-triggered (not auto-repeat), held Modifier emits no mouse click. Unmapped secondary buttons can continue their usual remapped behavior, with no tap on final release.

**ADR-MOD00-MOVE — Proposed:** Interpret MOVE after the existing rotation **but before** H/V gain, using a *non-mutating* view of raw deltas. Gesture evaluation must not double-feed or drain the v2 movement accumulator. While MODIFIER held and at least one directional MOVE assignment exists, capture relative motion for classification and **suppress cursor displacement**, including below threshold (avoid a pre-trigger jump); with no MOVE assignments, continue normal cursor behavior unless a shortcut consumes another event. One action per classified directional gesture, re-arm only after neutral/quiet period; no diagonal double-trigger, no auto-repeat while continuously moving. Threshold/dominance/quiet interval are **implementation tuning constants validated physically in MOD-06**, not guessed as proven hardware values. **NEEDS OPERATOR APPROVAL** (suppression vs moving cursor).

**ADR-MOD00-WHEEL — Proposed:** Each signed vertical wheel detent with Modifier can generate one event per detent, queue bounded. No wheel => no action. Pan remains horizontal wheel; any wheel gesture prevents tap on release. A mapped wheel event is consumed; unmapped wheel can retain scroll, explicitly tested in MOD-06.

**ADR-MOD00-HID — Proposed preferred engineering path:** preserve VID/PID and the two USB interfaces; explore a second Consumer collection/report ID within the existing Keyboard interface (TinyUSB has examples), retaining Boot Keyboard behavior if possible. This is only a **candidate**: adding Report IDs changes keyboard report framing and could break boot compatibility and existing host USB behavior. Gate MOD-08 must test actual Pico descriptor, keyboard in OS/BIOS, media, hotplug, endpoint backpressure and keyup. If not compatible, **stop for a separate product decision** before adding a third interface. Never claim all 30 supported from UI alone. **NEEDS OPERATOR APPROVAL**.

**ADR-MOD00-HOST — Proposed support contract:** Linux desktop as the *first real-host acceptance target*, then test Windows/macOS separately; Pico does not know host OS. No extra platform-selection menu in this feature. Keyboard chords for Linux desktop are application-specific; baseline COPY/CUT/PASTE/UNDO/SELECT ALL/FIND/SAVE = Ctrl+letter, REDO = Ctrl+Shift+Z (fallback Ctrl+Y only if explicitly configured), RENAME = F2, FULL SCREEN = F11, REFRESH = Ctrl+R, SCREENSHOT FULL = Print Screen, SCREENSHOT AREA = Shift+Print Screen on verified compositor, ZOOM IN/OUT/RESET = Ctrl+[+/-/0] in a browser, HOME SCREEN\PAGE = HID Home key (**not** Show Desktop). Media = Consumer Usages; brightness Consumer Usages only when host handles them. The 30 labels are semantic; no guarantee they perform exactly these actions across apps. **NEEDS OPERATOR APPROVAL**, especially HOME/ZOOM semantics.

**ADR-MOD00-MIGRATE — Proposed:** Global schema v3 with active PASSTHROUGH or CUSTOM, draft, five targets, twelve shortcut IDs (NONE=0), integrity byte/CRC; old target ESCAPE numeric ID remains reserved for legacy decoding and must **not** be reinterpreted as MODIFIER. New MODIFIER target uses new numeric ID (propose 6). Old active Standard/Escape → PASSTHROUGH; any old Custom/draft target Escape → source identity (never Modifier); preserve BT bonds, saved names, per-mouse Movement untouched. New values effective only after flash commit and verification. If v3 write fails, retain previous safe runtime without saying 'saved'; downgrade to v2 may lose global profile preferences. **NEEDS OPERATOR APPROVAL** for migration behavior.

## C. Precise implementation invariants
1. Identity of the modifier source is from the physical button **before** remapping; no shortcut activates in PASSTHROUGH.
2. Shortcut values stored are global (as Custom profile is); Movement H/V/rotation retains bond-scoped semantics.
3. KEY A RESET SELECTED acts on exactly one slot; UNAVAILABLE cannot be reset or accessed. Removing a mouse does not delete global shortcuts.
4. ESCAPE is offered as Shortcut ID 7, not a Custom target; no stale Standard/Escape profile is displayed.
5. Synthetic key + modifiers press and release must each be accepted by USB before actor completion; pending reports retry safely. Disconnect, overflow, profile change and lock must cancel or neutralize own held state; don't release unrelated sources.
6. No new host utility, BLE stack, event bus, CDC/UART/debug interface, hidden alternate firmware or unrelated Movement changes.
7. No MOD-01 implementation until the operator approves this contract candidate or supplies corrections.

## D. Contract check results (documentary)
- Source screen count: **17 fixtures** = 1 Remapping Options + 6 Combinations + 5 Shortcuts + 5 WILL BECOME.
- Exactly **11 new screens** and **6 modified screens**; retire **4 legacy Standard/Escape** screens; 38−4+11=**45** expected runtime screens.
- 12 unique combination IDs, 30 unique Shortcut IDs, 6 choices on each shortcut page.
- 9 rows per fixture, every row at most 21 characters; examples in dynamic value slots are explicitly not permanent copy.
- Action mapping guarantees are **design proposals** until USB host integration gates, not physical evidence.

## E. Gate boundaries
MOD-00: documents only, no UF2/test on Pico. MOD-01+ firmware branch created from exact v2.0.0 tag only after operator acceptance. Every implementation gate produces host tests, production UF2, SHA and physical acceptance scenarios from `home-connected`. Mark MOD-00 ACCEPTED only after explicit operator contract acceptance, not when documents were committed.
