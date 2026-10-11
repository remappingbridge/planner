# MOV-04 — Aceite físico

**Status: ACCEPTED — confirmação do operador em 2026-10-10 (horário de São Paulo).**

O operador confirmou neste chat: **“gate aceito. prossiga”**, após receber o candidato MOV-04 e o roteiro de validação Vertical Slow.

Candidato testado:
- Produto: `remappingbridge/remappingbridge`
- Branch: `feature/movement-options-v1.0`
- Commit: `036e5bd930b11b3c79ceeac6332dac7c21844d57`
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38097344728
- Host: **51/51 PASS**; Pico 2 W: firmware compilado e verificado.
- Artefato: `11686156439`
- UF2 SHA-256: `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`.

Escopo aceito: `VERTICAL SLOW DPI` — 1x, 0.75x, 0.5x e 0.25x, fluxo HOME conectada, KEY B cancela, Help e aplicar somente V. O artefato é idêntico, em bytes, ao do gate MOV-03, porque a integração da página Vertical Slow era preexistente na branch; MOV-04 acrescentou testes dedicados, sem modificar runtime.

O operador não forneceu medições ou logs individuais; o aceite é sua confirmação explícita. **MOV-05 a MOV-10 não estão aceitos**.
