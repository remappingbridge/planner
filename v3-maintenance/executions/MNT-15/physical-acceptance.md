# MNT-15 — physical acceptance, Ctrl+Equal Zoom In candidate

**STATUS: PENDING OPERATOR PHYSICAL TEST AND ACCEPTANCE.** Version still `3.2.3` internally until official release bump. Candidate [PR #45 (draft)](https://github.com/remappingbridge/remappingbridge/pull/45), branch `maintenance/v3x-mnt-15`, based on v3.2.3 tag `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.

**Observed before candidate (baseline, operator report):** Mabox, Obsidian accepts physical Ctrl+= but not Ctrl+Shift+=. Browser accepts Ctrl+= without Shift. Terminals differ: some require Ctrl+Shift+= while others use Ctrl+=. This difference is **not fixable universally with a single generic HID chord** without per-host/app policies that are outside MNT-15.

## Installation prerequisites

1. Use only CI-produced **Pico 2 W production `.uf2`** downloaded for PR #45 commit; SHA-256 must match same CI log. Do not use a source ZIP, guess link or compile v3.2.3 release instead.
2. Preserve existing firmware v3.2.3 UF2 for rollback, [official release](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.3) with SHA-256 `29597c0f69fb8acdc05f849ebd828853a65824513a6e8e02424e007022761fe4`.
3. Enter BOOTSEL and copy UF2 as usual. **Do not run `flash_nuke`, remove bonds, reset profiles/shortcuts or reinstall an OS**; the source does not change storage schema.
4. Start all app checks from **HOME CONNECTED** with a mouse connected, CUSTOM REMAPPING applied and a working Modifier mapping to action `ZOOM IN`.

## Required physical scenarios

| # | From HOME CONNECTED | Expected | Operator observation |
|---|---|---|---|
| 1 | Trigger modifier action **ZOOM IN** in focused **Obsidian** | Zoom increases on each discrete trigger without sticky Ctrl, Shift, or multi-trigger | PENDING |
| 2 | Trigger **ZOOM OUT** and **RESET ZOOM** in Obsidian | Zoom decreases and resets exactly as before | PENDING |
| 3 | Repeat ZOOM IN/OUT/RESET in **browser** | All three work as before; no inadvertent accelerated double Zoom In | PENDING |
| 4 | Trigger ZOOM IN in **terminal that accepts Ctrl+=** without Shift | Zoom increases normally | PENDING |
| 5 | Trigger ZOOM IN in **terminal that requires Ctrl+Shift+=** | Possible **known limitation**: this app may not zoom. Record its name and result honestly; **not a firmware HID corruption if terminal rejects generic Ctrl+=** | PENDING |
| 6 | Run **REDO** (Ctrl+Shift+Z) and **SCREENSHOT AREA** (Shift+Meta+PrintScreen) | Required Shift chords still contain Shift and act as in previous version | PENDING |
| 7 | Trigger Ctrl+= repeatedly, cancel/lock/unlock, disconnect/reconnect Bluetooth | No stuck Ctrl/Shift/Equal, no duplicate input, no lost bond | PENDING |
| 8 | Switch PASSTHROUGH/CUSTOM, reboot, check a second saved mouse | Applied profiles, modifier/shortcuts, bond-specific Movement unaffected | PENDING |
| 9 | Navigate HOME/COMBINATIONS/SAVED DEVICES | Visual pipe `|`, colors, menus, 9×21 unaffected by HID-only change | PENDING |

## Acceptance decision

- **PASS + explicit “gate aceito”**: authorize patch SemVer 3.x (next after current official v3.2.3; candidate release target tentatively v3.2.4), re-run final CI, merge, tag and publish official UF2 plus SHA256SUMS. Check that English-only public documentation on main is preserved.
- **FAIL or terminal compatibility unacceptable**: retain PR draft and test candidate; do not publish. If necessary, reopen architecture/design discussion about user-configurable shortcut strategy in a **separate, explicitly approved scope**.
- **No physical report**: remain PENDING. CI and source tests cannot prove Obsidian/terminal compatibility.

**No scenario here is claimed PASS before the operator reports its observation.**
