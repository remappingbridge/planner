# 2026-09-20 — HOME searching Help layout amendment

Status: **CURRENT PRODUCT DECISION / POST-MBR-02 SCREEN AMENDMENT**

This requirement supersedes only the literal layout of `home-searching-help`. It does not change the HOME saved-search behavior, timing, navigation, Help ownership, or any other screen.

## Canonical `home-searching-help`

The screen name remains:

`home-searching-help`

The exact rendered rows are:

```text
HOME SEARCHING HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
```

There are exactly nine semantic rows; row 8 is blank.

## Semantics

- The Help page remains owned by `home-searching`.
- Any HAT input returns to `home-searching` and is consumed.
- The underlying saved-device search remains the automatic 8-second `SEARCH_SAVED` transaction.
- Pair New remains a separate 15-second unsaved-only transaction.
- This amendment changes no transition or search eligibility rule; it only replaces the previous `home-searching-help` wording.

## Scope

No other canonical screen literal is changed by this amendment.