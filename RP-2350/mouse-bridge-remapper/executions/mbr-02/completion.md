# MBR-02 completion report

Gate: `mbr-02 — Interaction engine, UI projector and golden screen model`

Status: **COMPLETE / ACCEPTED**

## 1. Predecessor and base

Accepted predecessor product main:

`tiagooliveirajs/mouse-bridge-remapper@cee10ee157ce0d7f6655df203327422c3c40e6b3`

Planner main at amendment planning:

`tiagooliveirajs/repo-planner@993f9ff6e7ad0480314b70477bd94a74a2086ad6`

Historical MBR-02 implementation head before amendment:

`13cad3fec43eeed0353b0271a018012d115f2845`

## 2. Product amendment

The gate discovered that the previous frozen `home-connected` control map had no visible path into Pair New while a Mouse was already live.

The explicit 2026-09-20 product amendment resolved this without hidden controls:

- connected Mouse name is the dynamic `home-connected` title;
- `PAIR NEW MOUSE` is option 1;
- current confirmed remap summary is option 2 and opens `remapper-options`;
- `SAVED DEVICES` is option 3;
- `LEARN THE KEYS` is option 4;
- selecting Pair New starts the existing 15-second new-only search;
- the current Mouse remains authoritative and usable during discovery.

The one-authoritative-Mouse invariant, Pair New handoff semantics and the exact Pair New Help text remain unchanged.

Product authority: `requirements/2026-09-20-connected-home-pair-new.md`.

## 3. Implementation

Amended implementation head:

`ec21f11685e3e80cbb119560a4e8d5cd4e8a6ff0`

Integrated product main at merge:

`34f5806763503c79aa98e54923a3ec854b11d270`

Final product main after documentation-only acceptance-status commit:

`643278c0ec94ab0c64ad88bcba2a770b2d368f61`

PR #2:

`MBR-02: host UX model and connected HOME Pair New flow`

Implemented:

- host-pure interaction and release semantics;
- Help ownership and Lock semantics;
- unified HOME resolver;
- FIRST_MOUSE / SEARCH_SAVED / PAIR_NEW transaction effects;
- stale transaction/session filtering;
- one authoritative Mouse plus non-authoritative Pair New candidate;
- exact 30-screen semantic projector;
- dynamic 21-character Mouse-name projection;
- connected HOME amended layout;
- all four connected HOME destinations;
- Pair New connected entry with live Mouse preserved;
- Saved Devices status/color projection;
- Custom draft projection;
- confirmation-only profile/removal success;
- exact Pair New Help screens;
- golden and behavior tests;
- architecture guard compatibility.

## 4. Automated evidence

Exact amended-head CI:

Run `35480099428`

- host-architecture: SUCCESS
- Pico 2 W production: SUCCESS
- host configure/build/tests: SUCCESS
- Pico SDK/toolchain build: SUCCESS
- structural UF2 verification: SUCCESS

Structural Pico regression artifact:

- artifact: `mbr-01-pico2w-scaffold-uf2`
- artifact ID: `10595591576`
- artifact archive digest: `sha256:fd64a7d875beeb1633dbcc7118ced97489a53258fcb66cd6c14eac10227d38c8`

The artifact is structural build evidence only; no physical behavior is claimed.

## 5. Integration evidence

PR #2 merged with integrated SHA:

`34f5806763503c79aa98e54923a3ec854b11d270`

Post-merge CI on merge SHA:

Run `35480184381`

- host-architecture: SUCCESS
- Pico 2 W production: SUCCESS

Final-main revalidation after the documentation-only README status commit:

Run `35480324704`

- host-architecture: SUCCESS
- Pico 2 W production: SUCCESS

Post-merge structural artifact:

- artifact: `mbr-01-pico2w-scaffold-uf2`
- artifact ID: `10594988821`
- artifact archive digest: `sha256:d7a71a2c7add6fd54c52a754d34a82d10ea6cd0d70dc85e816927ed1ccd4dea3`

## 6. Physical acceptance

**Not required for mbr-02.**

mbr-02 is host-pure UX/state/projector work. Physical ST7789/HAT behavior is owned by mbr-03.

## 7. No-silent-change record

The former connected-HOME blocker was not solved by a hidden key, reinterpretation or implementation-only workaround. The product contract, planner, architecture, canonical screen reference, implementation and golden tests were all updated before acceptance.

The historical blocker remains at `executions/mbr-02/blocker.md` with status RESOLVED.

## 8. Next gate

Next executable gate:

**mbr-03 — Waveshare renderer and HAT physical acceptance**

Entry conditions:

- MBR-02 accepted;
- use integrated product main `34f5806763503c79aa98e54923a3ec854b11d270`;
- preserve the amended connected HOME layout and direct Pair New entry;
- provide exact UF2 and numbered physical scenarios for renderer/HAT acceptance.
