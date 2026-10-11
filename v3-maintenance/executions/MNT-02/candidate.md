# MNT-02 — candidato corrigido para teste físico

**STATUS: CI 82/82 PASS + Pico 2 W RELEASE UF2 SHA256 VERIFICADO — ACEITE FÍSICO PENDING.** 2026-10-11. **Nenhum merge/tag/release v3.0.2.**

## Fonte / branch / versão
- Baseline imutável: [release oficial v3.0.1](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.1), commit **`b776fec2cf2c89788d1bdfed7aa257aa766f2dc6`**. Inclui MNT-01 fisicamente aceito.
- Branch [`maintenance/v3x-mnt-02`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-02), commit candidato [`9638d60d65caed772cb23d35ad05b7f2e345ca36`](https://github.com/remappingbridge/remappingbridge/commit/9638d60d65caed772cb23d35ad05b7f2e345ca36).
- [PR #32 **draft**](https://github.com/remappingbridge/remappingbridge/pull/32), SEM MERGE.
- Versão `v3.0.2` APENAS planejada após aceite físico explícito; versão embarcada neste UF2 de candidato ainda é `3.0.1`, por partir da última release estável.

## Testes e firmware verificado
- [GitHub Actions CI #445 — run `38180926578`](https://github.com/remappingbridge/remappingbridge/actions/runs/38180926578): jobs `host-architecture` e `pico2-w-production` **SUCCESS**.
- **82/82 host CTests PASS**, preservando MOV-09, HOPE-05, HOPE-30, MOD-09, MNT-01 e teste novo `mnt02_remove_this_key_x_help_and_y_lock`.
- Artifact de produção Pico 2 W [`11717896324`](https://github.com/remappingbridge/remappingbridge/actions/runs/38180926578/artifacts/11717896324), ZIP SHA256 `d015a1b9e206dbf54b18b1e16c6088faf48d958390e8a6045dec93242c6204d5`.
- UF2 oficial do artifact: `blu2usb_picow.uf2`, **945152 bytes**, SHA256 **`04e1dc1f937fb2d5ce3bd82621aab88d2bc3bc8d73e887a74bb988422962891b`**. Download e extração ZIP realizados, SHA256 local coincidente com log do job.
- Arquivo entregue ao operador nesta conversa: **`remappingbridge-mnt02-pico2w.uf2`** (conteúdo idêntico ao UF2 da CI).

## Alterações isoladas deste gate
- `src/ux_model/ux_model.c`: `REMOVE THIS MOUSE` linha 8 agora anuncia `KEY X: HELP`. KEY X abre HELP REMOVE THIS ao soltar, fixando logical bond / return screen. KEY Y deixa de abrir Help e passa à função global de LOCK na tela de origem, como nas outras telas. Enquanto `remove_pending` for true, KEY X e KEY Y não abrem Help/Lock (a exclusão segue como transação indivisível), e KEY B / KEY A preservam a proteção original.
- `HELP REMOVE THIS` continua `ANY KEY: BACK`: mudança global de Helps será no MNT-05 e não deve ser antecipada aqui.
- Testes HOPE-05 e HOPE-30 e MOV-09 adaptados **somente** à nova legenda/chave; nenhum cenário de BLE removido ou relaxado.
- Novo `tests/test_mnt02_remove_this_key_x_help.c` testa desde HOME CONNECTED: navegação até bond diferente do ativo, KEY X down/up, Help, retorno preservando bond, KEY B cancelar sem delete, KEY Y lock e unlock consumido, remove_pending não cria novas operações, outros Helps intactos.
- Nenhuma mudança em renderer/paleta, MNT-01 cores, BLE, schema persistência, identidade HID/USB, Movement, Modifier, firmware versão.

## Gate físico / critérios
Seguir [physical-acceptance.md](physical-acceptance.md) com Pico real, **começando em HOME CONNECTED**. Verificar KEY X: HELP visível e funcional, KEY Y bloqueio global na tela REMOVE THIS, retorno ao mesmo bond e KEY B CANCEL sem apagar mouse. Não remover fisicamente bond para executar o teste. **A aprovação automatizada não substitui inspeção humana do LCD.**

**STATUS FINAL DO GATE: PENDING.** Não publicar `v3.0.2` nem iniciar MNT-03 antes de mensagem explícita `gate aceito`.
