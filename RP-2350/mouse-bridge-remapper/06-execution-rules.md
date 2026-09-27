# Gate execution and evidence rules

Status: **ACTIVE AFTER MBR-00**.

These rules govern mbr-01 onward.

## 1. One gate at a time

- Select the first incomplete dependency-complete gate.
- Do not skip a blocked gate.
- Re-read current planner, current product documentation, predecessor acceptance record and destination repository before editing.
- Record exact base SHA.
- Use an explicit `mbr/...` implementation branch; never use destination `main` as scratch space.

MBR-00 and MBR-01 are accepted. MBR-02 is now accepted after its connected-HOME amendment; the next executable gate is mbr-03.

## 2. Authority order

At every gate revalidate:

1. current product docs in `tiagooliveirajs/mouse-bridge-remapper`, including later accepted amendments;
2. current `repo-planner/mouse-bridge-remapper` frozen contract/gate plan and active product amendments;
3. accepted predecessor MBR evidence;
4. immutable BLU2USB G06 SHA `7eee024ad4ee726c5a85ffa2f32b9f47187878af` for inherited behavior;
5. destination current code/toolchain/CI truth.

Latest explicit MBR product decisions override older conflicting MBR requirements. G07+ BLU2USB Keyboard work is research evidence only.

## 3. Pre-implementation gate record

Before code changes record:

- objective/dependencies;
- exact base SHA;
- files/modules expected to change;
- frozen product decisions used;
- inherited regressions at risk;
- out-of-scope work;
- verification commands;
- physical scenarios where applicable;
- rollback/recovery strategy for descriptor/persistence changes.

If a true contradiction is discovered, stop dependent work and update documentation/planning first.

## 4. G06 migration discipline

- inspect exact accepted G06 source before porting;
- use behavior-preserving adaptation, not blind copy;
- preserve release safety, persistence, bonded reconnect, HID++, interaction and renderer lessons;
- keep a migration manifest from exact G06 source/module to destination adaptation;
- never import Bluetooth Keyboard/Composite product scope;
- never use rejected G07 runtime architecture as shortcut;
- do not introduce simultaneous-authoritative-Mouse machinery as speculative future-proofing.

## 5. Frozen live-Mouse invariant

```text
saved_mice = 0..N
live_authoritative_mouse = None | one MouseSession
```

During Pair New, one non-authoritative candidate context is allowed only for replacement qualification. It cannot forward authoritative product Mouse input before promotion.

Forbidden without product change:

- two authoritative ready mice;
- multi-connected HOME/focus/count state;
- cross-Mouse held aggregation;
- simultaneous-Mouse capacity qualification.

## 6. Frozen HOME/search policy

```text
no saved -> searching-first + repeated 8s FIRST_MOUSE cycles
saved + live -> home-connected
saved + no live -> home-searching + 8s SEARCH_SAVED
SEARCH_SAVED expiry/cancel -> home-retry / DEVICE NOT FOUND
```

A disconnect while HOME is visible invokes this resolver immediately. A disconnect on another page updates connection truth; resolver runs on next HOME access.

## 7. Frozen Pair New policy

PAIR_NEW is a 15-second new-only search.

If current Mouse is healthy:

1. keep it authoritative/usable during search;
2. ignore already-saved candidates as Pair New winners;
3. qualify first valid unsaved candidate to non-authoritative replacement-ready;
4. handoff by freezing old input, releasing old held state, disconnecting/clearing old session while preserving saved record/bond, confirming new product state, then promoting candidate;
5. never have two authoritative ready mice.

Timeout/cancel before handoff leaves old Mouse connected.

If user manually unplugs old Mouse while Pair New/help is visible, Pair New remains new-only. HOME later starts saved search.

## 8. Frozen UI literals/policy

- canonical screen/control table: destination `docs/manual/06-screen-reference.md`;
- exact Pair New Help text is immutable unless product docs change;
- canonical profile word `STANDARD`;
- disconnected status `STATUS: DISCONNECTED`;
- names: first 21 supported characters, fallback `UNKNOWN MOUSE`;
- no hidden Lock controls;
- instructional First Connected/Learn B/X/Y behavior as frozen;
- `escape-active` GO TO HOME is intentional;
- actions execute on release;
- white selection/press overrides cyan current/connected.

## 9. Frozen USB identity

- VID `0xCAFE`, PID `0x4011`, bcdDevice `0x0100`;
- manufacturer `tiagooliveirajs`;
- product `Mouse Bridge Remapper`;
- no serial;
- HID Mouse interface 0;
- minimal synthetic-Escape HID Keyboard interface 1;
- no CDC/debug interface;
- no Bluetooth-driven re-enumeration.

Any later identity change requires planning/documentation change and revalidation from mbr-04 onward.

## 10. Automated evidence

Every implementation gate records:

- source commit/tree and clean state;
- board target;
- Pico SDK/compiler/toolchain versions;
- configure/build commands/results;
- host tests;
- architecture/static checks;
- produced artifact path/name;
- UF2 size/SHA-256 where applicable;
- CI workflow/run/job/artifact identifiers where used.

Build success alone is not behavioral acceptance.

## 11. Physical evidence

For gates marked physical:

- exact candidate source SHA;
- exact UF2;
- UF2 SHA-256 and size;
- board/SDK/toolchain metadata;
- numbered scenarios with expected observable result;
- predecessor regressions included.

Only the operator may report a physical PASS.

Failure keeps the same gate open; fix, create a new candidate, invalidate affected evidence and rerun impacted scenarios before advancing.

## 12. High-risk regression triggers

Focused predecessor regression is mandatory when changing:

- BTstack/CYW43 ownership/timing;
- HOGP live/candidate session management;
- Report Map/framing;
- held Mouse/Escape output state;
- Pair New handoff;
- HOME/search coordinator;
- USB descriptors/report submission;
- profiles/remap/HID++;
- product storage/credentials;
- UI navigation/Help/Lock;
- renderer geometry/color priority;
- removal/reconnect policy.

## 13. Held-state safety

Tests include:

- duplicate Down/Up idempotence;
- two physical current-Mouse buttons mapped to same target;
- release one while other stays held;
- disconnect while held;
- Pair New handoff while held;
- profile transition while held;
- synthetic Escape hold/release;
- parser/queue failure cleanup;
- stale old-session callback after handoff.

## 14. Persistence safety

- product state separate from BT credentials;
- schema version/integrity checks;
- previous valid generation preserved until new one verified;
- corrupt/torn newest fallback tested;
- removal with power cycle tested;
- Pair New never deletes old saved Mouse/bond as side effect;
- removing disconnected saved Mouse does not disturb current live Mouse.

## 15. Release safety

Production candidates require:

- committed clean revision;
- no debug CDC/UART dependency;
- no hidden debug USB identity;
- no Bluetooth Keyboard/Composite product module;
- only documented synthetic-Escape Keyboard output;
- <=1 authoritative ready Mouse;
- no unresolved relevant contract contradiction;
- all predecessor regressions green;
- physical evidence where required.

## 16. No silent scope expansion

Requires documentation/planning change before implementation:

- Bluetooth Keyboard/Composite support;
- Bluetooth Classic Mouse;
- >1 authoritative live Mouse;
- multi-connected UI/focus/capacity behavior;
- USB Keyboard output beyond synthetic Escape;
- per-Mouse private Custom templates;
- accepted USB identity changes;
- profile mapping changes;
- incompatible persistence schema changes without migration/reset policy;
- timing changes to FIRST_MOUSE/SEARCH_SAVED/PAIR_NEW.

## 17. Gate completion report

Every completed gate leaves durable documentation with:

- gate/status/objective;
- predecessor/base SHA;
- implementation SHA;
- changed files/modules;
- product decisions used;
- migration/reuse provenance;
- automated evidence;
- physical evidence or `not required`;
- limitations/deviations;
- exact next gate and entry conditions.
