# MINT-01 — Embedded UI Adapters

Status: **BLOCKED**.

## Objective

Replace desktop presentation/input with real HAT and ST7789 adapters while preserving frozen UI semantics.

## Dependencies

MINT-00 ACCEPTED.

## Tasks

1. Map Pico-LCD-1.3 HAT GPIO controls to semantic PRESS/RELEASE.
2. Present exact 240×240 RGB565 framebuffer to ST7789.
3. Implement physical backlight behavior required by product Lock separately from desktop inspection gain.
4. Verify no SDL dependency in embedded build.
5. Pixel/input timing tests.

## Automated / documentary acceptance

- [ ] framebuffer comparison with desktop logical output
- [ ] HAT semantic event tests
- [ ] embedded build contains no SDL

## Human acceptance

- [ ] physical screen/input review against UI Layout 1.0

## Deliverables

- layout redesign
- desktop shell on device

## Forbidden scope

- GPIO/HAT adapter
- ST7789 adapter
- MINT-01 evidence

