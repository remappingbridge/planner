# Movement Options — UX / screen / navigation contract

Status: PLANNED ONLY. 9x21 semantic grid, 240x240 ST7789, inherited RemappingBridge v1.0 pixel offsets, fonts and semantic colors. Paren annotations in the operator's attachment are comments, NEVER literal LCD copy. Each template below has exactly nine semantic rows (0–8); blank rows remain blank.

## Screen inventory and count
Existing v1.0 = 29 canonical screens.
Existing screens modified in-place (3): home-connected, saved-devices, remove-this.
Existing Help screen modified in-place (1): help-remove-this.
Brand new non-Help (6): movement-options, horizontal-slow-dpi, horizontal-fast-dpi, vertical-slow-dpi, vertical-fast-dpi, rotation.
Brand new Help (3): help-slow-dpi, help-fast-dpi, rotation-help.
Total after full integration = **38 canonical screens** (29 + 6 + 3); zero legacy duplicates. Gate count = **9 non-Help screens + 1 all-Help gate**.

## Main user journey

    home-connected
      ├── [existing] current remap summary  -> REMAPPING OPTIONS
      ├── MOVEMENT OPTIONS                    -> movement-options
      │    ├── HORIZONTAL DPI -> horizontal-slow-dpi <-> horizontal-fast-dpi
      │    │                      └── shared help-slow-dpi / help-fast-dpi
      │    ├── VERTICAL DPI   -> vertical-slow-dpi   <-> vertical-fast-dpi
      │    │                      └── shared help-slow-dpi / help-fast-dpi
      │    ├── ROTATION       -> rotation -> rotation-help
      │    └── KEY A RESET ALL -> H=1x V=1x ROT=0°, remain on movement-options
      ├── SAVED DEVICES -> saved-devices (H/V/rotation summary)
      │    └── REMOVE DEVICE -> remove-this -> help-remove-this
      └── PAIR NEW MOUSE [existing]

When no connected Mouse: unchanged existing home-searching/home-retry and pair/reconnect. No blank Movement Options route there.

## Input table (on complete key RELEASE)
- Connected HOME: Joy Up/Down select with wrap; Joy Press access selected; Key X existing removal help; hidden Key B Home no-op; Key Y inherited Lock.
- Movement Options: Joy Up/Down chooses H, V or Rotation with wrap; Joy Press access; Key A RESET ALL atomic commit for current identity; Key B Back to connected HOME; hidden Key Y Lock if allowed.
- Any Slow/Fast page: Joy Up/Down choose one of four options with wrap; Joy Left/Right switch Slow/Fast pages within the SAME AXIS preserving a staged candidate across paging; Key A APPLY AND BACK, commit selected value only; Key B cancel pending and return to Movement Options; Key X opens page-specific Help; hidden Key Y Lock.
- Rotation: Joy Up/Down selects 0,90,180,270 with wrap; KEY A applies and returns to Movement Options; KEY B CANCEL discards draft and returns; KEY X opens Help; hidden Key Y Lock.
- Help: any full HAT interaction, including Key Y, returns to OWN originating page and restores candidate/selection/page. No Help key causes Lock, Apply or Reset.
- Saved Devices: Joy Right/Left pages through actual saved Mice with wrap; Joy Press accesses REMOVE DEVICE. Key B hidden Back; global Lock as before.
- Remove This: Key A removes pinned saved identity; Key B cancels back to prior saved page; KEY Y opens Help (explicit operator override of old KEY X: HELP / Y Lock). No double removal while pending.
- Actions do not fire on DOWN. Press highlighting follows inherited HAT feedback, with white overriding cyan.

## Layouts (each line below = one semantic grid row)

### Existing HOME-CONNECTED, modified in place [MOV-01]

    MOUSE GENERIC NAME
     NO REMAP PASSTHROUGH
     MOVEMENT OPTIONS
     SAVED DEVICES
     PAIR NEW MOUSE

    JOY UP\DOWN: SELECT
    JOY PRESS: ACCESS
    JOY X: HELP TO REMOVE

Runtime row 0 dynamically derives truncated current Mouse name; row 1 dynamically shows selected active remapping profile summary as before. NOTE: operator sample says 'JOY X', while HAT has KEY X. Preserve existing canonical 'KEY X: HELP TO REMOVE' literal in runtime (minimal correction to hardware vocabulary); document that original 'JOY X' was non-existent. Current remap profile retains existing cyan if active/appropriate; selected option always white.
Index map: 0 Remapping Options (row1), 1 Movement Options (row2), 2 Saved Devices (row3), 3 Pair New Mouse (row4). Count moves 3->4 and Help selection modulo 4, not 3. Height/hint rows unchanged.

### New MOVEMENT-OPTIONS [MOV-02]

    MOVEMENT OPTIONS
     HORIZONTAL DPI 0.75X
     VERTICAL DPI 3X
     COUNTERCLOCKWISE
     ROTATION 270-DEGREE

    JOY PRESS: ACCESS
    KEY A: RESET ALL
    KEY B: BACK

Menu has **three selectable logical items** at visual row 1, row 2, and two-line item at rows 3+4. Highlight BOTH rotation lines white when selected. Current H/V multiplier suffix and current rotation angle cyan when not selected, normal prefix/action text gray. Value text in this mock is example only: always read the connected saved Mouse's confirmed settings. Row 3 'COUNTERCLOCKWISE' is static companion to selectable row 4, not a fourth option. The requested 'KEY PRESS: ACCESS' is corrected to JOY PRESS, the actual HAT control. Reset default: H 1x; V 1x; Rotation 0°. On reset commit success repaint current values and remain here; on failure keep prior applied values, no false success.

### New HORIZONTAL-SLOW-DPI [MOV-03]

    HORIZONTAL SLOW DPI
     NORMAL        1x
     SLIGHTLY SLOW 0.75x
     SLOW          0.5x
     VERY SLOW     0.25x

    JOY LEFT\RIGHT: PAGE
    KEY A: APPLY AND BACK
    KEY X: HELP SLOW DPI

The values MUST start at one-based column 16 (zero-based column 15). Generate suffix spans with formatted 21-char rows, not free spacing based on variable lengths. Selected candidate row white; confirmed value row cyan if on this page and not selected. Initial current value 1x selected. Hidden KEY B cancels/Back.

### New HORIZONTAL-FAST-DPI [MOV-04]

    HORIZONTAL FAST DPI
     SLIGHTLY FAST  1.25x
     FAST           1.5x
     VERY FAST      2x
     EXTREMELY FAST 3x

    JOY LEFT\RIGHT: PAGE
    KEY A: APPLY AND BACK
    KEY X: HELP FAST DPI

Values MUST start at one-based column 17 (zero-based column 16). No accidental 22nd char. First line can be selected when paging from Slow with no staged Fast choice; return direction restores/retains draft appropriately.

### New VERTICAL-SLOW-DPI [MOV-05]
Same rows/control colors/col16 as Horizontal Slow, but title 'VERTICAL SLOW DPI' and only V multiplier is changed. Paging never modifies H.

### New VERTICAL-FAST-DPI [MOV-06]
Same rows/control colors/col17 as Horizontal Fast, title 'VERTICAL FAST DPI' and only V multiplier is changed.

### New ROTATION [MOV-07]

    ROTATION
     0-DEGREE
     90-DEGREE
     180-DEGREE
     270-DEGREE

    KEY A: APPLY
    KEY B: CANCEL
    KEY X: HELP

Four options, Joy Up/Down implicit, wrap. Selected angle white. Actual persisted angle cyan when not selected. Rotation is counterclockwise in mathematical convention (with screen-space Y downward, see math document). KEY A returns Movement Options on confirmed save, B cancels.

### Existing SAVED-DEVICES, modified in place [MOV-08]

    1 OF 3
    GENERIC MOUSE NAME
    PROFILE: PASSTHROUGH
    DPI: H 0.75 - V 1.25
    ROTATION: 180 DEGREE
     REMOVE DEVICE

    JOY RIGHT\LEFT: PAGE
    JOY PRESS: ACCESS

Current saved Mouse page is by logical bond identity, never used as persistent settings key. Display per-device H/V and rotation for connected OR disconnected page. Profile retains 1.0 existing behavior and provenance (currently globally active profile); do not claim a historical per-device profile has been restored. Numeric settings use cyan as requested; connected Mouse title cyan, disconnected name inherits old static convention. Hidden KEY B Back; Key Y Lock if allowed. Pinned target survives reorder/removal confirmation.

### Existing REMOVE-THIS, modified in place [MOV-09]

    REMOVE THIS MOUSE
    GENERIC MOUSE NAME
    SAVED PAIRING AND
    PREFERENCES WILL
    BE DELETED.

    KEY A: REMOVE
    KEY B: CANCEL
    KEY Y: HELP

Remove both bond and Mouse settings, not those of another Mouse; keep associated name removal. Disallow repeat KEY A while pending; return remains consistent with pre-existing removal flow. Any settings cleanup failure must be reported/retriable via product policy and must not silently reattach old settings to a different identity.

### All Help screens [MOV-10: ONE combined gate]
Shared SLOW help, opened from either Slow axis:

    SLOW DPI HELP
    SLOWER DPI POINTER
    ARE RECOMMENDED
    FOR MOVEMENTS THAT
    REQUIRE GREATER
    SENSITIVITY AND
    PRECISION

    ANY KEY: BACK

Shared FAST help, from either Fast axis:

    FAST DPI HELP
    FASTER DPI POINTER
    IS RECOMMENDED FOR
    HIGH-RESOLUTION
    DESKTOP AND
    WIDESCREEN
    ENVIRONMENTS

    ANY KEY: BACK

ROTATION Help:

    ROTATION HELP
    MOUSE MOVEMENT
    CHANGES DIRECTION
    EVERY 90 DEGREES
    FROM THE PREVIOUS
    DIRECTION
    ANTICLOCKWISE

    ANY KEY: BACK

Existing REMOVE MOUSE Help updated in place:

    REMOVE MOUSE HELP
    COMPLETELY REMOVE THE
    AUTOMATIC CONNECTION
    WHEN TURNING ON THE
    DEVICE AND DELETE ITS
    BUTTON REMAPPING AND
    CUSTOM MOVEMENTS

    ANY KEY: BACK

The help copy deliberately remains close to the operator's wording; only typo BUTTOM->BUTTON and surrounding whitespace are normalized. All rows <=21 chars. 'ANY KEY' owner restoration is local to caller and never routes to an unrelated page.

## Renderer/design invariants and acceptance
- 9 rows, 21 columns maximum; x=7 + column*11; established nonuniform vertical pixel relocation retained. Source words in parentheses NEVER displayed.
- Title magenta, ordinary options gray, static prose off-white yellow, current values cyan, selected/pressed white, hint area dark magenta. No new theme.
- Current value spans colored by semantic state, not by string lookup; rotate two-line selection handled as one logical option.
- Do not add bogus arrow cursor or dynamic > marker; indented options have exactly one leading space.
- Current per-Mouse settings should update when active Mouse identity changes, without repainting a different peer's values.
- All page help and Back are reachable; no new Help creates or requires a dedicated release gate beyond MOV-10.
- Host snapshot tests must validate exact row lengths, columns, colors, Page/Back wrap and every control's release semantics.
