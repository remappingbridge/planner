# MOD-06 — Candidato CI aprovado e UF2 Pico 2 W

**Status: CI 70/70 PASS + UF2 de produção verificado / ACEITO FISICAMENTE pelo operador em 2026-10-11.** Data: 2026-10-11.

## Proveniência

- MOD-05 aceito explicitamente pelo operador em 2026-10-11, conforme [registro](../MOD-05/physical-acceptance.md). Firmware base exato: commit `ee11c4dedad7e1699912982d6469f3675cae2e88`; UF2 aprovado SHA256 `8f1015d2081c83707ee33f524478cbef98780dee32e4a0fd46e43af6ebbaa3ad`.
- Branch de implementação [`feature/modifier-shortcuts-mod06`](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod06) criada exatamente dessa base. [PR #26 draft](https://github.com/remappingbridge/remappingbridge/pull/26), não mergeado. Tag v2.0.0 e main permanecem intactas.
- Commit exato de candidato: [`751b24f6c2a22fe0f4130dc57b8073c774faceee`](https://github.com/remappingbridge/remappingbridge/commit/751b24f6c2a22fe0f4130dc57b8073c774faceee).
- [CI run #354](https://github.com/remappingbridge/remappingbridge/actions/runs/38148853433): host-architecture **SUCCESS, 70/70 CTests PASS**, incluindo 2 suítes novas MOD-06 com asserts habilitados em Release. pico2-w-production **SUCCESS** usando toolchain/SDK pinados.
- [Artifact oficial ZIP ID 11706560759](https://github.com/remappingbridge/remappingbridge/actions/runs/38148853433/artifacts/11706560759), digest do ZIP `3cfaad8177e1ee0262c51117b4cbccc41ce983ff4f5a93ec3a47e6de81bcd6d8` (não confundir com hash do firmware).
- Arquivo do ZIP: `blu2usb_picow.uf2`, **941568 bytes**, SHA256 **`6b9cbcd09a2aa3f66dba36498547e56e44e2cb07439150ade1bf584b6228837c`**. Baixado e extraído do artifact CI; `sha256sum` independente concorda com saída exata do job Pico. Arquivo entregue como `remappingbridge-mod06-pico2w.uf2`, idêntico ao firmware oficial.

## Implementação e limites

- `src/movement/movement.c` expõe helper **puro** de rotação; o pipeline v2 usa o mesmo helper, evitando divergência ou transformação duplicada. Interpretação dos 4 gestos MOVE ocorre após rotação 0/90/180/270, mas antes de aplicar ganhos independentes H/V.
- `src/modifier_shortcuts/modifier_shortcuts.c` captura MOVE durante Custom+Modifier com ao menos uma atribuição MOVE. Suprime desde o primeiro delta, **sem alimentar** aggregator/pipeline do cursor. Classifica um eixo dominante (≥24 raw counts; dominância ≥2:1), não dispara ambos em diagonal, resiste à inversão rápida, requer **160ms sem movimento** para rearmar e cancela ao soltar Modifier/desconectar/trocar perfil.
- Com Modifier+Wheel vertical, consome por unidade de sentido somente a componente atribuída que possui ação HID já suportada; pan horizontal é preservado. Mensagem multirrotação e fila USB de oito eventos são limitadas para evitar bloqueio ou vazamento Mouse. Rolagem sem atribuição ou com ação ainda não suportada continua normal e não emite atalhos falsos.
- Apenas ações USB Keyboard **COPY=1** e **ESCAPE=7** são atualmente executáveis. Mesmo que outras ações da lista de 30 estejam persistidas para Wheel/MOVE, a execução delas fica reservada aos próximos gates. MOVE configurado para ação ainda não suportada **captura e paralisa o ponteiro** nessa sessão, sem falsamente executar a ação.
- Retém v3 profiles/12 slots, 45 telas, bonds BLE, nome em Saved Devices, Movimento por Mouse, H/V DPI, rotação, Logitech HID++, duas interfaces HID/VID/PID e ACK USB do MOD-05. No new Consumer HID or new menus.
- Os parâmetros 24 / 2:1 / 160ms são **candidato experimental** para calibração física com o Mouse do operador e não equivalem a validação de hardware.

## Gate

[12 testes físicos desde HOME](physical-acceptance.md) aguardam operador. CI e compilação não comprovam comportamento real do Linux nem ergonomia das direções. **MOD-06 ACEITO por mensagem explícita do operador; MOD-07 autorizado.** Sem merge, tag ou release.
