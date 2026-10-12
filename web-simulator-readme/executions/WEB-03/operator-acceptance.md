# WEB-03 — Operator acceptance

**Date:** October 12, 2026. **Status: ACCEPTED.**

The operator explicitly stated **"gate aceito. prossiga para o proximo"**. This accepts the WEB-03 production candidate ([site PR #4](https://github.com/remappingbridge/remappingbridge.github.io/pull/4), main commit `d78533cbd274647b5c521cf8132e2a2d148cf3e3`).

Additional requirements were explicitly assigned to **WEB-04**: remove the entire **LCD BACKGROUND** selection panel, keep only the more vivid **Gentle** background (`#300c39`), reduce the LCD's displayed size, and rearrange the virtual HAT so the **joystick is to the left of the LCD** and **A/B/X/Y are in a single vertical column to its right**. The panel should appear closer to the actual physical HAT.

This acceptance does **not** assert that the operator reported an individual `80/80 PASS` result from their production browser. The isolated test harness had passed 80/80 and production Pages was published for review. No firmware release, physical pairing, or other device change resulted from this gate.

English-only text and testing directly through GitHub Pages production remain mandatory. **WEB-04 is explicitly authorized; WEB-05 remains blocked.**
