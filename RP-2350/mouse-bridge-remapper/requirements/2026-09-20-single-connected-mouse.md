# 2026-09-20 — Single connected Mouse simplification

Status: **CURRENT PRODUCT DECISION**, as clarified by `2026-09-20-pair-new-help-and-handoff.md` for Pair New sequencing.

This requirement supersedes earlier simultaneous-mouse rules wherever they conflict.

## 1. Live connection capacity

- The product may keep multiple mice saved.
- Only **one Mouse may be authoritative/connected at a time**.
- There is no multi-connected HOME state, connected-device count or simultaneous-Mouse capacity target.

## 2. Pair New replacement rule — clarified handoff

Pair New is new-only and replaces the current live Mouse only after an unsaved replacement candidate has been qualified.

When Pair New starts while a Mouse is connected:

1. current Mouse remains live/usable during discovery;
2. saved candidates are not Pair New winners;
3. first valid unsaved candidate may reach a non-authoritative replacement-ready state;
4. handoff then stops old input, releases held output, disconnects/clears old live session while keeping its saved record/bond, confirms new state, and promotes the candidate as the only authoritative Mouse;
5. Pair New stops after that one success.

If Pair New fails or is canceled before handoff, the former/current Mouse remains connected.

This section supersedes the earlier disconnect-at-entry interpretation. The exact Help text and rationale are preserved in `2026-09-20-pair-new-help-and-handoff.md`.

## 3. HOME resolver

```text
no saved Mouse
  -> searching-first

saved Mouse exists + one connected Mouse
  -> home-connected

saved Mouse exists + no connected Mouse
  -> home-searching + start bounded saved-device search automatically
```

The first saved Mouse reaching ready state wins and search stops. If none is found before timeout, HOME transitions to `home-retry` / `DEVICE NOT FOUND`.

## 4. Connected-Mouse power-off/disconnect

If the connected Mouse is powered off, leaves range or otherwise disconnects:

- release held Mouse/Escape output;
- clear live connection;
- update connection truth immediately;
- if HOME is visible, enter `home-searching` and start bounded saved search;
- if another page is visible, HOME starts that search when HOME is next accessed;
- if no saved Mouse reconnects before timeout, finish at `DEVICE NOT FOUND`.

The disconnect path uses the same HOME resolver rather than a separate reconnect policy.

## 5. Saved Devices color/status

- one saved Mouse per page;
- only the authoritative connected Mouse may show `STATUS: CONNECTED`;
- only that Mouse name may be cyan;
- at most one Saved Devices page is cyan at a time.

## 6. HOME connected screen

`home-connected` always shows the authoritative connected Mouse name on line 2 and its confirmed profile summary.

The former `N DEVICES CONNECTED` rule is removed. No UI focus selector is needed.

## 7. Architectural consequence

Do not carry unnecessary simultaneous-mouse machinery:

- no set of authoritative live HOGP sessions;
- no cross-Mouse button ownership aggregation;
- no simultaneous-HIDS capacity qualification;
- no multi-connected UI focus model;
- no per-live-Mouse concurrent HID++ set;
- no `N DEVICES CONNECTED` limit such as 999.

Retain only correctness-required complexity:

- multiple persistent saved Mouse records;
- one optional authoritative live session with generation identity;
- optional non-authoritative replacement-candidate state during explicit Pair New;
- held-state safety within current authoritative session;
- safe handoff/removal cleanup;
- bounded saved/new search transactions;
- synthetic USB Escape exception;
- applicable G06 persistence/reconnect/HID++ regressions.

## 8. Scope unchanged

- Bluetooth Keyboard pairing/input excluded.
- Bluetooth Composite pairing excluded.
- Escape remains synthetic USB Keyboard output produced only by Mouse remapping.
