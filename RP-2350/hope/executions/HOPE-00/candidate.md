# HOPE-00 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- branch: `hope/hope-00-exact-g06-baseline`
- commit: `94036f5342889701b6c970cec05ae687fbf05a0d`
- parent/main base: `4a562da54eed22f4987b9b869209dcf44e1e0023`
- draft PR: `#1` (must not be merged before physical acceptance)

## Provenance

- BLU2USB G06 source commit: `7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- pinned G06 tree: `3a92348b25112abf67a879307c2273a9b018bedd`
- Mouse UI v1 provenance pin: `e8adad7919e931c92515bf655ef4050876a8e7a9`
- Mouse UI v1 content introduced in this gate: **none**

## Exact-tree proof

The source G06 recursive tree contains:

- 81 blobs;
- 123 entries including directories;
- 399,156 total blob bytes;
- modes `100644` and `100755` for files.

Every source blob was recreated in the destination and every recreated blob SHA matched the source blob SHA.

The destination tree created from those exact blobs is:

~~~text
3a92348b25112abf67a879307c2273a9b018bedd
~~~

This exactly equals the pinned G06 tree SHA.

The destination commit was then re-read through the Git data API and reports the same tree SHA.

## Automated verification

GitHub Actions run: `35814020093` — **SUCCESS**.

Jobs:

- `host-architecture`: **SUCCESS**
  - configure host build: PASS
  - build host tests: PASS
  - host/architecture tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - configure Pico 2 W: PASS
  - production build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10730932296`
- artifact name: `blu2usb-picow-production-pico2w`
- ZIP size: 323,653 bytes
- ZIP digest reported by GitHub: `sha256:ad2e710085db8b32976ea3ff8ce9ea87a82a23759e78a21cded4566d4c4ad84c`

Extracted firmware:

- file: `blu2usb_picow.uf2`
- size: **879,104 bytes**
- SHA-256: `da0b0d4cfce77cd0922f1c1573672dc48ee3b8f3f0ddc08f206892407023cb63`

## Comparison with historical accepted G06 artifact

The historical G06 workflow run `35206602803` also passed and produced an 879,104-byte UF2.

Historical G06 UF2 SHA-256:

~~~text
d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88
~~~

The new HOPE-00 UF2 is not byte-identical to that historical artifact despite the exact source tree match.

Direct comparison found exactly **2 differing bytes**, both in one UF2 payload block. The differing bytes are part of an embedded ASCII build-date string:

~~~text
historical: Sep 17 2026
HOPE-00:    Sep 23 2026
~~~

No source/blob/tree mismatch exists. Therefore the candidate satisfies source-tree equivalence and successful reproducible build, while the final behavioral equivalence remains intentionally delegated to the mandatory physical test.

## Gate state

HOPE-00 is **not ACCEPTED**.

It may be accepted only after the operator flashes this candidate and explicitly reports physical PASS for the required G06 regression matrix.
