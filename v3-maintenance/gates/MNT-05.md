# MNT-05 — Todos os Helps: KEY B volta, KEY Y bloqueia

**Status: PLANNED / NÃO INICIADO.** Este arquivo altera o planejamento, não o firmware.

- Item original: **MEL-04**; veja [backlog literal](../01-backlog-and-contract.md).
- Dependência: **MNT-04 publicado**. Criar branch futura `maintenance/v3x-mnt-05` da última tag estável v3.x publicada.
- Tag-alvo prevista APÓS aceite físico: **v3.1.0 (MINOR)** (recalcular se outras releases surgirem).

## Escopo
Modificar TODOS os Helps: ANY KEY: BACK passa a KEY B: BACK; só B retorna, Y bloqueia e desbloqueia (preservando Help); outros botões não fazem nada. Preservar foco, fluxo Remove This e sem efeitos colaterais.

## Investigação antes de implementar
Examinar is_help, UX input, lock/unlock e return_screen. Centralizar para todas telas tipo Help, não criar exceções por Help.

## Cenários de teste físico desde HOME CONNECTED
Desde HOME CONNECTED navegar para cada Help. A/B/X/JOY: apenas B sai; Y ativa Lock, primeira interação de unlock consumida, permanece Help e B retorna. Ajuda de Remove This não remove bond.

## Restrição
Alteração de comportamento intencional: liberar como MINOR; não publicar se alguma tela Help continuar ANY KEY BACK.

## Gate e release (não executados)
Preflight e commit-base; PR draft exclusiva; implementação mínima; CI host e build Pico 2 W produção; UF2 oficial e SHA-256; registro de candidato/roteiro e aceite físico explícito do operador. Só depois do aceite: versionar, gerar CI/UF2 definitivo, publicar Release GitHub com SHA256SUMS, verificar tag e registrar no planner. Falhas impedem publicação e são corrigidas na mesma branch. Nenhum código ou tag foi criado agora.
