# MNT-06 — First Mouse Connected: KEY Y LOCKS ANYWHERE

**Status: PLANNED / NÃO INICIADO.** Este arquivo altera o planejamento, não o firmware.

- Item original: **MEL-03**; veja [backlog literal](../01-backlog-and-contract.md).
- Dependência: **MNT-05 publicado (lock em todos os Helps já validado)**. Criar branch futura `maintenance/v3x-mnt-06` da última tag estável v3.x publicada.
- Tag-alvo prevista APÓS aceite físico: **v3.1.1 (PATCH)** (recalcular se outras releases surgirem).

## Escopo
Na tela FIRST MOUSE CONNECTED / BLU2USB_SCREEN_MOUSE_SAVED alterar dica KEY Y: LOCK para KEY Y: LOCKS ANYWHERE. Nenhuma lógica adicional: lock universal já implantado no MNT-05.

## Investigação antes de implementar
Atualizar texto e fixture 9×21 do FIRST MOUSE CONNECTED; garantir largura exata, sem truncamento e sem mudança dos demais controles.

## Cenários de teste físico desde HOME CONNECTED
Iniciar conectando primeiro Mouse, observar dica exata KEY Y: LOCKS ANYWHERE, testar Lock em FIRST MOUSE CONNECTED e Help; texto cabe em 21 caracteres.

## Restrição
Antecipar a legenda ao gate de HELP geraria promessa falsa; por isso MEL-03 vem APÓS MEL-04.

## Gate e release (não executados)
Preflight e commit-base; PR draft exclusiva; implementação mínima; CI host e build Pico 2 W produção; UF2 oficial e SHA-256; registro de candidato/roteiro e aceite físico explícito do operador. Só depois do aceite: versionar, gerar CI/UF2 definitivo, publicar Release GitHub com SHA256SUMS, verificar tag e registrar no planner. Falhas impedem publicação e são corrigidas na mesma branch. Nenhum código ou tag foi criado agora.
