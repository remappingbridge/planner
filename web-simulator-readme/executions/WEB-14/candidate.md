# WEB-14 — Published installation-guide candidate

**Gate state:** README CANDIDATE PUBLISHED, **operator acceptance PENDING**. **WEB-15 NOT STARTED**.

[Firmware PR #51](https://github.com/remappingbridge/remappingbridge/pull/51) merged the docs-only revision into firmware `main` as **`7ec0d95ce595be82b61509c454d618321084ba72`**, source commit `6b68e1c801f7057bbc3267f6470d64bb42a5e6aa`. It changes **only `README.md`**.

## Contents delivered

- Replaced the old generic “Current release and updates” copy with a beginner-focused **“Download and install on a Raspberry Pi Pico 2 W”** guide. The public README's already accepted real component photographs and top two direct-action links were preserved, as was the WEB-13 virtual simulator guided tutorial.
- Direct version-locked UF2 and SHA256SUMS links point to confirmed **v3.2.4** release assets. The table states UF2 size **953,344 bytes**, stable [latest release](https://github.com/remappingbridge/remappingbridge/releases/latest) navigation, and official GitHub release asset SHA-256 **`56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`**. The actual release API digest was read and compared with the README; **the checksum text itself was not independently downloaded or parsed**.
- **Linux:** `sha256sum -c SHA256SUMS.txt`; **macOS:** `shasum -a 256 -c SHA256SUMS.txt`; **Windows PowerShell:** `Get-FileHash -Algorithm SHA256 .\remappingbridge-v3.2.4-pico2w.uf2` and compare against expected hex. Both assets must be from the same release.
- Safe, numbered BOOTSEL procedure: unplug first; hold physical BOOTSEL while inserting a **data-capable Micro-USB** cable; expect **`RP2350`** on Pico 2 W or `RPI-RP2` on older Pico-family references/platforms; copy **only the intended UF2** to the bootloader volume; allow the temporary volume to disappear and device to reboot automatically; proceed to LCD pairing instructions after successful reboot.
- Safety: not a normal general-purpose storage volume to format; do not use `flash_nuke` as an update step, preserve bonds/profiles, avoid incompatible v3→v2 downgrade assumptions; user settings should be noted manually. Diagnosis for missing drive begins with correct board, data cable, BOOTSEL timing and USB host, **not** erasing flash.
- Release-maintainer reminder: future publishing requires review of current tag, filenames/actual asset digest, checksums and version-specific README links; `/releases/latest` remains stable, while direct tag filenames do not.

## Static validation performed

- **15/15 relative README resource paths** exist in the candidate git tree; stable and version-specific URLs agree with official GitHub release metadata, asset bytes and `digest`.
- No executable iframe, firmware source, UF2, release or site code changed. Exact earlier README prefix is unchanged except **one mechanical assembly cross-link** to the new guide; documentation/support/license tail is byte-for-byte preserved.
- All three host checksum instruction strings present, correct target board and Pico 2-series volume nomenclature present, and familiar Linux/macOS/Windows usage documented.
- Canonical firmware [CI run #38384287376](https://github.com/remappingbridge/remappingbridge/actions/runs/38384287376) **completed successfully** for docs-only PR head `6b68e1c801f7057bbc3267f6470d64bb42a5e6aa`: both `host-architecture` and `pico2-w-production` jobs passed. This does **not** imply that a new UF2/release was published.
- [Raspberry Pi manufacturer documentation](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html) confirms power-on BOOTSEL technique, USB mass-storage enumeration and automatic reboot. A **physical flash or actual three-OS host hash test was not performed here**; those are manual operator checks, not inferred from a GitHub PR or CI.

## Acceptance boundary

Release remained **v3.2.4** during gate execution; no newer release or binary was created. The README content is ready for visual and physical/operator review, **not already accepted**. **WEB-15 cannot start without explicit WEB-14 acceptance.**
