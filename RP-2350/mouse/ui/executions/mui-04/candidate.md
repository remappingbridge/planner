# MUI-04 candidate evidence

Date: **2026-09-21**.

Status: **ACCEPTED**.

## Candidate

- repository: `remappingbridge/mouse-ui`;
- branch: `mui/mui-04-screen-projection`;
- base: accepted MUI-03 `fe7acaa5059dcc8e489e031082c57f938dff59ec`;
- implementation commit: `6d9af74497b37acb9ebeba0f2ad7febe4941a791`;
- locked-hash candidate commit: `8aed51e00eaadff351e77778f92646ec155bae9d`.

## Architecture

~~~text
Product View + manual projection state
              ↓
      mouse_ui_projector
              ↓
       semantic elements
              +----> inspector metadata
              ↓
      mui_render_frame_t
              ↓
      mouse_ui_renderer
              ↓
       RGB565 240×240
~~~

`mouse_ui_projector` depends on domain + renderer frame types only. It does not depend on interaction policy, app/navigation, mock implementation, SDL, or backend transports.

## Screen inventory

Exactly 30 canonical screen IDs are implemented, from `searching-first` through `learn-the-keys`, matching the active MBR-08-derived specification. Behavior is grouped into didactic, HOME, Help, Pair, profile, Custom, and Saved/Remove families.

## Semantic golden coverage

`tests/goldens/mui-04/screens.txt` contains exactly 9 canonical text rows for every one of the 30 screens. The test loads this file independently and compares every projected row.

Dynamic canonical fixtures include:

- `home-connected` current name `LIFT` -> `LIFT MOUSE` and profile Escape summary;
- `saved-devices` page `2 OF 2`, disconnected `OFFICE MOUSE`, Standard profile;
- `remove-this` uses the same page Mouse;
- Custom draft identity rows.

Additional name-rule tests cover standalone `MOUSE`, a `MOUSE` word beyond HOME's first 15 characters, unsupported/empty fallback, uppercase conversion, HOME suffixing, and Saved Devices first-21-character behavior.

## Element metadata

Every non-empty semantic row emits an inspectable element; didactic controls additionally emit token-specific elements. Validation rejects duplicate IDs, zero-sized/out-of-bounds logical bounds, and over-capacity projections.

Stable high-value IDs include:

~~~text
title
menu.pair-new
menu.remap-summary
menu.saved-devices
menu.learn-keys
profile.passthrough
profile.standard
profile.escape
profile.custom
custom.row.left/right/middle/forward/backward
saved.name
saved.status
saved.profile
saved.remove
remove.name
target.left/right/middle/escape/forward/backward
didactic.joy-up/down/left/right/press
didactic.key-a/b/x/y
~~~

Generic body/hint lines use structural IDs such as `body.3` and `hint.8`. Element IDs are tested stable across selection and pressed-state changes.

## Tone/state tests

Automated tests verify:

- selected rows become white;
- active profile is cyan when unselected;
- selected active profile is white while retaining ACTIVE metadata;
- connected Saved Devices name is cyan + CONNECTED state;
- disconnected name is BODY tone;
- didactic pressed control is white + PRESSED state;
- pressed contextual hint becomes white;
- didactic screens have full dark-magenta renderer field.

## Hash capture and lock

First green capture run: `35567838662`. It emitted one hash for each of 30 canonical projections. Those hashes were committed in `tests/goldens/mui-04/hashes.txt`.

Second verification run: `35567930111`, head `8aed51e00eaadff351e77778f92646ec155bae9d`.

- `host-debug` job `106233364543`: **success**;
- `host-asan-ubsan` job `106233364382`: **success**.

Both reported:

~~~text
screen_projection_contract              Passed
100% tests passed, 0 tests failed out of 7
~~~

The locked manifest includes all screens, including:

~~~text
searching-first       a04a97c7396beae5
home-connected        fffe50588461a355
remapper-options      c660f41a6227535d
custom-edit           bb50f4ef35723c45
saved-devices         c72eea3ce6372435
learn-the-keys        7f9297c7748aec05
~~~

Complete values live in the committed hash manifest rather than being duplicated here.

## Human visual/ID review — PASS

On Debian:

~~~bash
git fetch origin
git switch mui/mui-04-screen-projection
rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
ctest --test-dir build --output-on-failure

mkdir -p build/mui04
./build/mouse-ui-screen-probe build/mui04
xdg-open build/mui04/mui-04-matrix.ppm
~~~

The directory will contain:

- `00-searching-first.ppm` through `29-learn-the-keys.ppm`;
- `mui-04-matrix.ppm` with all 30 frames in enum order, 5 columns × 6 rows;
- `screens.semantic.txt`;
- `elements.txt`;
- `hashes.txt`.

Visual review should check clipping, text geometry/colors, cyan/white priority examples, hint regions, and full dark-magenta backgrounds on `searching-first`, `first-mouse-connected`, and `learn-the-keys`.

ID review should confirm that examples such as `screen=home-connected element=menu.remap-summary` and `screen=saved-devices element=saved.status` are understandable and useful for future bug reports.

## Out of scope / not claimed

- no screen-to-screen navigation transitions;
- no Help/Lock policy execution;
- no SDL shell/interactive inspector;
- no real backend/hardware.

## Rollback

If rejected, abandon `mui/mui-04-screen-projection` and return to accepted MUI-03 `fe7acaa5059dcc8e489e031082c57f938dff59ec`. Preserve the accepted semantic goldens/ID feedback separately if only the implementation is rejected.

Acceptance record: the Debian probe generated the complete MUI-04 evidence set and reported all 30 framebuffer hashes. The values matched `tests/goldens/mui-04/hashes.txt` exactly, from `searching-first a04a97c7396beae5` through `learn-the-keys 7f9297c7748aec05`. The operator authorized advancing to the next gate if correct, and MUI-04 was promoted to `mouse-ui/main` at `8aed51e00eaadff351e77778f92646ec155bae9d`.
