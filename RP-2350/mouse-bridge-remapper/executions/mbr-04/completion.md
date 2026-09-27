# MBR-04 completion

Gate: `mbr-04 — Fixed USB Mouse + synthetic Escape identity`

Status: **COMPLETE / ACCEPTED**

The operator explicitly reported that the MBR-04 physical portion was accepted after verifying the qualification firmware's USB enumeration and HID behavior.

## Candidate

- repository: `tiagooliveirajs/mouse-bridge-remapper`
- branch: `mbr/mbr-04-usb-hid`
- candidate SHA: `98cef435b44125ddf6d2cec7c9864d30790ee181`
- PR: #4
- integrated main after merge: `1062974972ab11c6500489e181e2e7f6488c9ccc`

## Automated evidence

- CI run: `35482107144` — SUCCESS
- qualification UF2: 38912 bytes, SHA-256 `9a046193cad84d8ef146eebd92e4f78da5553c8d041a963b2a1580907df02dd7`
- production UF2: 98304 bytes, SHA-256 `9b88eedea157a981e61eb52610d11ef9b182cc857402708addaa6d6512c83f0e`
- artifact: `mbr-04-pico2w-usb-hid-uf2`, ID `10595949171`

## Physical evidence

Operator statement: physical acceptance confirmed for the MBR-04 gate.

The qualification test established the frozen USB identity/interface boundary; the acceptance record does not invent additional observations beyond the operator declaration.

## Integration

PR #4 was merged after MBR-03 physical closure and MBR-04 physical acceptance.

## Next gate

MBR-05 is now the active implementation candidate.
