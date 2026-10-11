# MOV-07 — HOME Connected | Aceite físico

**Status: ACCEPTED — declaração do operador em 2026-10-10 (horário de São Paulo).**

O operador informou: **“gate aceito. prossiga”**, após receber e validar o candidato MOV-07. A confirmação autoriza iniciar o MOV-08, mas não aceita gates subsequentes.

Candidato aceito:
- Produto: `remappingbridge/remappingbridge` | branch: `feature/movement-options-v1.0`
- Commit: `23657734a172f4bd9dc61665ff57acf5230b3568`
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098381892
- Host: **55/55 PASS**; Pico 2 W: build e UF2 **PASS**.
- Artefato: `11686122817`; UF2 SHA-256: `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`.
- Firmware binário idêntico ao do MOV-06 (tela HOME já integrada no início do trabalho; gate adicionou testes próprios, sem alterar runtime).

Escopo: tela HOME CONNECTED com quatro destinos Remapping/Movement/Saved Devices/Pair New, Help/Back, bloqueio sem interromper HID, estados Searching/Retry quando offline e restauração de configurações após reconexão.

O operador não forneceu resultados individuais nem medições físicas; este registro preserva a declaração explícita sem inventar evidências. **MOV-08–MOV-10 continuam pendentes de aceite próprio.**
