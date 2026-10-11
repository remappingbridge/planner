# MNT-03 — aceite do operador

Em 11/10/2026 o operador comunicou: **"gate MNT-03 aceito. prossiga para o proximo"**.

- Aceite global do gate MEL-01; resultados individuais do roteiro físico não foram fornecidos e não devem ser inventados.
- Candidato validado: commit `4af26e01c2fbc844a48c0483d43298f8ede8a98e`, [CI 38182141370](https://github.com/remappingbridge/remappingbridge/actions/runs/38182141370), 83/83 host PASS e Pico 2 W produção SUCCESS.
- Firmware versionado 3.0.3 e [PR #33](https://github.com/remappingbridge/remappingbridge/pull/33) mesclado na main, commit `bb1fc1443b98744235f3bd14bab68b996e40eed9`.
- Workflow de release v3.0.3 foi integrado; confirmação da tag, UF2 oficial e checksums permanece pendente até publicação verificada.
- Dependência MNT-04: iniciar branch exclusivamente da tag v3.0.3 após publicação confirmada, nunca da main não versionada ou branch candidata.
