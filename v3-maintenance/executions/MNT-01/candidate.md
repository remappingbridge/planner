# MNT-01 — firmware candidato CORRIGIDO para aceite físico

**Status: CANDIDATE CORRECTED — CI 81/81 PASS + Pico 2 W PRODUCTION SUCCESS; ACEITE FÍSICO PENDENTE.** 2026-10-11.

## Motivo da substituição do primeiro candidato
O operador detectou no teste físico do candidato MNT-01 anterior (CI #433) que a **primeira linha/título** de `SAVED DEVICES` não estava com o **magenta obrigatório do sistema**. A rotina final de cores sobrescrevia a tonalidade TITLE e a transformava em STATIC amarelo. **Isto é regressão do gate MNT-01, não melhoria nova.** Corrigido na MESMA branch sem avançar MNT-02. O artefato antigo (UF2 SHA `977ec34ffe16de2f8c16345d4fb13fdd35102488795039b0d14e7729c060bd20`) está substituído e **NÃO deve ser usado para novo aceite**.

## Proveniência do novo candidato
- Base estável imutável: [`v3.0.0`](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0), SHA `d7c7950fe595bd0e14a970cf60a29d085f065db4`.
- Branch: [`maintenance/v3x-mnt-01`](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-01).
- Fonte exata: [`b6df61ffdd1eaa7ba2f78827fb17ec4bfdd79d00`](https://github.com/remappingbridge/remappingbridge/commit/b6df61ffdd1eaa7ba2f78827fb17ec4bfdd79d00).
- [PR #31 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/31), sem merge.
- [CI #435 / run `38179732422`](https://github.com/remappingbridge/remappingbridge/actions/runs/38179732422), JOB host-architecture **SUCCESS 81/81**, JOB pico2-w-production **SUCCESS**.
- [Artifact Pico 2 W `11717193771`](https://github.com/remappingbridge/remappingbridge/actions/runs/38179732422/artifacts/11717193771), ZIP hash `sha256:f6e9f7c9e6736e9ef56ee962dd96fa0c860a435eeb49ef1c844688f466ed1768`.
- UF2 oficial contido no ZIP: `blu2usb_picow.uf2`, **945152 bytes**, SHA256 **`a32f6e0bc374d822f3e2830dbbc787cfd076ff5639f032dd70323d5c7bd27b53`**. Baixado, extraído e hash calculado localmente, coincidindo com `sha256sum` do job oficial da CI.
- Arquivo entregue nesta conversa: **`remappingbridge-mnt01-magenta-fixed-pico2w.uf2`**, mesmo conteúdo do UF2 CI. Sem depuração embarcada e sem mudança de identidade USB.

## Resultado visual esperado após a correção
- **Linha 0** (ex.: `1 OF 3`): `BLU2USB_UI_TONE_TITLE`, cor magenta RGB565 `BLU2USB_COLOR_MAGENTA`, mesmo token dos demais cabeçalhos do sistema.
- **Linha 1**: somente nome do mouse efetivamente conectado em CURRENT/ciano; demais nomes e textos informativos em STATIC/amarelo.
- **Linhas 2–4**: `PROFILE`, `DPI`, `ROTATION` continuam amarelas.
- **Linha 5**: único item `REMOVE DEVICE` em EMPHASIZED/branco se há bond válido; cinza se `0 OF 0`, preservando inativação.
- **Linhas 7–8**: dicas `JOY RIGHT\\LEFT: PAGE`, `JOY PRESS: ACCESS` em ACTIONABLE/cinza, inclusive enquanto controles são pressionados.
- Nenhuma mudança de texto, seleção real UX, lógica de remoção, persistência, HID, BLE, Movement ou Modifier. Melhoria `/ ` em substituição a `\\` continua reservada ao MNT-04.

## Testes
- Regressão MOV-08 preservada: `test_mov08_saved_devices.c`, estendida com assertivas `TITLE → BLU2USB_COLOR_MAGENTA`.
- Novo `test_mnt01_saved_devices_colors.c`: cor de todas as células e enum magenta na linha 0, cor branca da opção, cinza das dicas, Bond ativo/inativo, paginação, pressão mantida, zero bonds e retorno seguro de REMOVE THIS.
- **81/81 CTests PASS** + firmware de produção Pico 2 W SUCCESS. Falta prova física da cor/legibilidade no LCD pelo operador.

## Próximo passo
Regravar o **novo UF2 corrigido** via BOOTSEL, sem `flash_nuke`, e repetir [teste físico MNT-01](physical-acceptance.md): conferir a **primeira linha magenta**, `REMOVE DEVICE` branco e dicas cinzas, navegando páginas e cancelando REMOVE THIS. O MNT-01 fica **PENDING** até aceite explícito do operador.

**Não publicar v3.0.1, merge, tag ou começar MNT-02 antes desse aceite.**
