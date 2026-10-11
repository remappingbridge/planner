# MOD-00 — Revisão e aceite do contrato (sem teste físico)

**Status: PENDING OPERATOR ACCEPTANCE — 2026-10-11.**
**Firmware:** tag `v2.0.0` mantida intacta. **UF2:** N/A (gate documental). **Testes no Raspberry Pi Pico 2 W:** N/A. **CI/build:** N/A (sem arquivos de firmware alterados). Não interpretar essa ausência como falha, nem inventar execução.

## Revisão de contrato solicitada ao operador
- [ ] **MOD00-R01 — Telas e textos.** Ler `candidate.md` ADR-MOD00-COPY e o fixture exato `../../fixtures/mod-00-source-layouts.json`. Aceitar ou corrigir a normalização das quatro grafias (`PASSTHROUGT`, `0F`, `WHELL`, `NOT CUSTMIZED`) para inglês correto. Confirmar que as cinco páginas WILL BECOME usam a ordem LEFT / RIGHT / MIDDLE / FORWARD / BACKWARD / MODIFIER.
- [ ] **MOD00-R02 — Funcionamento do Modifier.** Confirmar apenas um botão físico como Modifier, mudança atômica do anterior para identidade, tap de `MODIFIER RELEASED` condicionado a não usar outra entrada e slot UNAVAILABLE mascarado (não apagado).
- [ ] **MOD00-R03 — Movimento/scroll.** Confirmar que, durante MODIFIER pressionado e com alguma ação direcional MOVE configurada, o cursor fica parado enquanto a movimentação produz um gesto; no restante não há perda involuntária de input. Os limiares concretos serão aferidos fisicamente no MOD-06, não no MOD-00.
- [ ] **MOD00-R04 — USB e 30 atalhos.** Confirmar a tentativa de Consumer Control na interface Keyboard existente com validação de compatibilidade e fallback sujeito a nova decisão. Compreender que teclas e mídias dependem do host, sobretudo brilho.
- [ ] **MOD00-R05 — Compatibilidade de sistema.** Aceitar Linux desktop como primeira plataforma de teste e as interpretações propostas: HOME SCREEN/PAGE = tecla Home (não Show Desktop), Zoom = zoom no aplicativo/navegador, screenshots conforme o compositor. macOS/Windows não recebem promessa genérica.
- [ ] **MOD00-R06 — Migração.** Aprovar que Standard/Escape Remap ativos na v2 migrem para PASSTHROUGH e que Escape atribuído em Custom/draft antigo passe para ação identidade, **nunca** para Modifier. Bonds e Movement são preservados.
- [ ] **MOD00-R07 — Governança.** Confirmar que MOD-01 só começa depois deste aceite; cada gate de firmware futuro fornece .uf2 e cenários físicos desde home-connected, sem publicação automática.

## Evidência disponível
- Fixture `../../fixtures/mod-00-source-layouts.json` validado com 17 telas × 9 linhas; maior linha = 21 caracteres.
- Inventário: 12 combos, 30 atalhos (5 páginas × 6); 38 telas v2, 4 removidas e 11 novas → 45 esperadas.
- Baseline de firmware inspecionada na tag `v2.0.0`; nenhuma alteração de firmware para MOD-00.
- Decisões detalhadas em `candidate.md` e base em `pre-implementation.md`.

## Resultado
- **Validação documental preparada:** SIM.
- **Decisões bloqueantes aceitas pelo operador:** AINDA NÃO.
- **MOD-00 aceito:** **NÃO**.
- **MOD-01 desbloqueado:** **NÃO**.

O operador pode aceitar o pacote inteiro após revisar, ou solicitar ajustes por ADR. Registrar aqui texto literal e data de aceite quando houver confirmação — jamais presumir aceite por publicação dos documentos.
