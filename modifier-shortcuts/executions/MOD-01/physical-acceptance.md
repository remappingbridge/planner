# MOD-01 — Teste físico do operador

**Status: PENDING PHYSICAL ACCEPTANCE.** A geração do UF2 depende de CI para o SHA final registrado no candidato. Não afirmar nenhum teste manual aprovado antes do retorno do operador.

Origem do roteiro completo: [documento no repositório de firmware](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod01-remapping-options.md).

## Cenários
- [ ] **01 — Atualização sem reset:** gravar `blu2usb_picow.uf2` (Pico 2 W em BOOTSEL) sem `flash_nuke`; reconectar Mouse BLE anteriormente salvo; deve preservar nome/bond/Movement.
- [ ] **02 — Home → menu:** em `home-connected`, `JOY PRESS` sobre o remapping (linha 1), conferir exatamente opções PASSTHROUGH DEFAULT, CUSTOM REMAPPING e MODIFIER SHORTCUTS; Standard/Escape ausentes.
- [ ] **03 — Ciclo de seleção:** `JOY UP` no primeiro item salta ao terceiro e `JOY DOWN` retorna ao primeiro. Destaque selecionado em branco; perfil ativo Passthrough/Custom em ciano, terceira opção nunca em ciano por ser perfil.
- [ ] **04 — Passthrough:** `JOY PRESS` abre confirmação ou estado aplicado, `KEY B` retorna ao menu de três itens, sem alterar Movement.
- [ ] **05 — Custom:** `JOY PRESS` sobre segundo item abre editor de cinco fontes; `KEY B` retorna. Verificar que as cinco entradas editáveis ainda preservam valores.
- [ ] **06 — Modifier Shortcuts:** `JOY PRESS` no terceiro item permanece no mesmo menu **nesse gate**; não abre telas de preset antigo, não emite atalhos. MOD-02 abrirá `COMBINATIONS 1 OF 6`.
- [ ] **07 — Help:** `KEY X` com terceiro item selecionado abre REMAPPING OPTIONS HELP, incluindo os três nomes; qualquer tecla volta à seleção 3 sem efeito colateral.
- [ ] **08 — Lock:** `KEY Y` bloqueia; primeira interação `JOY PRESS` somente desbloqueia e volta à HOME, não abre editor; `KEY B` no menu retorna HOME.
- [ ] **09 — Saved Devices:** perfil é PASSTHROUGH ou CUSTOM, nunca STANDARD/ESCAPE. Só nome do Mouse ativo em ciano; valores DPI H/V e Rotation conservados.
- [ ] **10 — Regressão física:** ponteiro, cliques, scroll, Movement 2 eixos, rotação 90/270, desconectar/reconectar BLE, outros Mouse/bonds continuam funcionando.

## Evidências a preencher após testes físicos
- SHA256 do arquivo instalado: PENDING CI.
- Resultado de cada cenário e regressão: PENDING OPERATOR.
- Aceite explícito do operador: **NÃO RECEBIDO**.
- Liberação para MOD-02: **BLOQUEADA**.
