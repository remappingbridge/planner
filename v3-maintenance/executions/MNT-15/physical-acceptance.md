# MNT-15 — physical acceptance, Ctrl+Equal Zoom In candidate

**STATUS: OPERATOR PHYSICAL GATE ACCEPTED EXPLICITLY ON 12 OCTOBER 2026.** Operator response: **“gate aceito”** to the MNT-15 candidate UF2. This constitutes overall physical acceptance, **not a separate instrumented PASS for each checklist row**. Candidate CI **98/98 host PASS** + Pico 2 W production PASS; UF2 SHA-256 verified. Release version bump to **3.2.4** initiated only after this acceptance. Candidate [PR #45 (draft)](https://github.com/remappingbridge/remappingbridge/pull/45), [CI #38298979787](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787), commit `7177672d109f8f13aea77ba707c614e53d6065f1`, [candidate data](candidate.md), branch `maintenance/v3x-mnt-15`, based on v3.2.3 tag `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.

**Observed before candidate (baseline, operator report):** Mabox, Obsidian accepts physical Ctrl+= but not Ctrl+Shift+=. Browser accepts Ctrl+= without Shift. Terminals differ: some require Ctrl+Shift+= while others use Ctrl+=. This difference is **not fixable universally with a single generic HID chord** without per-host/app policies that are outside MNT-15.

## Installation prerequisites

1. Use only CI-produced **Pico 2 W production `.uf2`** from PR #45 commit; original CI artifact ID **11769092575** was extracted to file **`remappingbridge-mnt15-zoom-ctrl-equal-pico2w.uf2`**, **953344 bytes**, SHA-256 **`4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`**, validated against the [same CI log](https://github.com/remappingbridge/remappingbridge/actions/runs/38298979787). Do not install artifact ZIP; use the `.uf2`.
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

## Acceptance recorded — 12 October 2026

- **Operator statement:** “gate aceito” — unequivocal acceptance of MNT-15, in direct response to the delivered Pico 2 W UF2 and manual test instructions.
- **Approved candidate:** branch `maintenance/v3x-mnt-15`, commit `7177672d109f8f13aea77ba707c614e53d6065f1`, CI #38298979787, artifact ZIP ID 11769092575; actual **UF2 SHA-256 `4ae558f0814607aeda23d1b2e8bd128a6ca03c5f47c11a3c44e83e826796ca8e`**.
- **What is established:** operator accepted the gate as a whole after the UF2 was provided, authorizing a PATCH release. The operator did **not** enumerate individual Obsidian/browser/terminal screenshots/logs in the acceptance message, so detailed checklist cells remain historically **PENDING / NOT ITEMIZED**; do not manufacture observations.
- **Known limitation acknowledged in implementation:** terminals disagree on whether Zoom In requires Shift. The action stays generic Ctrl+=; no app-specific detection or dual-chord emission.
- **Release change:** version metadata + English notes + release workflow only, no further functional HID change. Publish **v3.2.4** only from verified merge commit, CI and production build.

## Acceptance decision

- **PASS + explicit “gate aceito”**: authorize patch SemVer 3.x (next after current official v3.2.3; candidate release target tentatively v3.2.4), re-run final CI, merge, tag and publish official UF2 plus SHA256SUMS. Check that English-only public documentation on main is preserved.
- **FAIL or terminal compatibility unacceptable**: retain PR draft and test candidate; do not publish. If necessary, reopen architecture/design discussion about user-configurable shortcut strategy in a **separate, explicitly approved scope**.
- **No physical report**: remain PENDING. CI and source tests cannot prove Obsidian/terminal compatibility.

**Gate-level approval is recorded above; per-scenario evidence not supplied in the short acceptance message remains unitemized.**
