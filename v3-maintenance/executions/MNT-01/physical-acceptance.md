# MNT-01 — validação física do operador

**Status: PENDING — AINDA NÃO TESTADO / NÃO ACEITO** (2026-10-11).

Escopo exclusivo HF-01: contraste das dicas e seleção única em `SAVED DEVICES`. Branch [`maintenance/v3x-mnt-01`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-01). PR [#31 draft](https://github.com/remappingbridge/remappingbridge/pull/31). Base publicada: [v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0). Versão futura, **apenas após aceite**: v3.0.1.

## Preparação
1. Baixar o **UF2 do candidato MNT-01** gerado pela CI de produção; comparar SHA-256 com valor publicado no [candidate.md](candidate.md).
2. Atualizar Pico 2 W pelo modo **BOOTSEL**, copiando o UF2 sem `flash_nuke` nem apagar flash/bonds. Confirmar boot normal, reconexão BLE e mouse funcional.
3. Partir da tela **HOME CONNECTED** e acessar a terceira opção `SAVED DEVICES` com o HAT.

## Correção do candidato após relato do operador
- O operador observou que **o título (linha 0) de SAVED DEVICES não estava magenta**, contrariando o design system existente. Não é uma melhoria adicional: é regressão do candidato MNT-01.
- Correção no **mesmo gate e mesma branch**: linha 0 deve preservar `BLU2USB_UI_TONE_TITLE` → `BLU2USB_COLOR_MAGENTA`, além dos requisitos originais (nome conectado CURRENT/ciano, corpo amarelo, remoção branca, dicas cinza).
- O candidato anterior / UF2 anterior foi **substituído**; nenhuma aprovação física foi inferida. Reiniciar validação com o novo UF2 cujo SHA será registrado em [candidate.md](candidate.md).

## Testes — marcar manualmente PASS / FAIL / N/A
- [ ] **01 — Cabeçalho obrigatório:** título `1 OF N` da primeira linha em **MAGENTA padrão do sistema** (mesmo tom dos títulos das demais telas); nome do mouse conectado somente ele em ciano; PROFILE/DPI/ROTATION continuam amarelos padrão.
- [ ] **02 — Única opção selecionada:** `REMOVE DEVICE` aparece toda em **branco**, sem precisar acionar joystick para selecionar.
- [ ] **03 — Dicas cinza:** `JOY RIGHT\\LEFT: PAGE` e `JOY PRESS: ACCESS` aparecem em **cinza padrão**. Texto literal/separador não foi alterado neste gate; o `/` global será MNT-04.
- [ ] **04 — Cor resistente à interação:** pressione/segure JOY LEFT/RIGHT e JOY PRESS, sem pressionar KEY A: dicas continuam cinza e REMOVE DEVICE permanece branco; nenhuma cor cai na linha errada.
- [ ] **05 — Vários mouses:** com 2+ dispositivos salvos, navegue páginas esquerda/direita. A opção continua branca, as dicas cinza, e somente o nome do mouse realmente conectado é ciano — nomes de outros mouses ficam amarelos.
- [ ] **06 — Remove This sem apagar:** JOY PRESS em `REMOVE DEVICE` deve entrar em `REMOVE THIS MOUSE` do **bond que está na página atual**. Pressione `KEY B` para CANCEL e retorne à mesma página de Saved Devices. **Não pressione KEY A: REMOVE** durante o teste.
- [ ] **07 — Lock, saída e entrada:** KEY Y bloqueia conforme v3.0; desbloquear e voltar a Saved Devices não muda cor/paginação; KEY B volta para HOME, reabrir e comparar. Não testar Help KEY X no Remove This neste gate (isso é MNT-02).
- [ ] **08 — Tela vazia quando viável:** em ambiente sem bonds salvos, `0 OF 0` permanece funcional e `REMOVE DEVICE` fica **cinza/inativo**, não selecionado branco, sem entrar em exclusão pelo JOY PRESS. **Não despareie/apague seus mouses somente para realizar esse cenário**; pode marcar N/A por segurança.
- [ ] **09 — Regressão geral:** cursor e botões USB/BLE, Remapping Options, Movimento H/V, rotation, Modifier Shortcuts e reboot não perderam configurações.

## Evidências e decisão
- **Aceite global do operador:** PENDING.
- **Cenários efetivamente validados:** nenhum informado até este momento.
- **Falhas observadas:** não informadas.
- **Bloqueio de release:** não executar bump `v3.0.1`, merge, tag ou publicação até mensagem explícita `gate aceito`.

**Nota:** a CI host confirma somente os testes automatizados; não substitui a inspeção das cores reais no LCD.
