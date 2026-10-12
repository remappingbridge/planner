# MNT-09 — candidato HOME CONNECTED para teste físico

**STATUS: CI COMPLETA; 90/90 testes host aprovados e Pico 2 W produção aprovado. ACEITE FÍSICO PENDENTE.**

## Proveniência
- Fonte oficial: release/tag [v3.1.3](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.1.3), commit `93077730ef447351b354b8994b620fcfc0a1963a`, tag verificada.
- Branch [maintenance/v3x-mnt-09](https://github.com/remappingbridge/remappingbridge/tree/maintenance/v3x-mnt-09), commit candidato `98b773c992b8c1d2e83a41c33f8c59d1b9461410`.
- [PR #39 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/39), não mesclado.
- [CI #505](https://github.com/remappingbridge/remappingbridge/actions/runs/38188443137): **host-architecture 90/90 PASS**, **pico2-w-production SUCCESS**.
- Artefato GitHub Actions id `11720294005`, zip digest `sha256:cd2d01fe4ed56ea3b9a95ba4a8707a0745aaff48eeb2114689fab709c2497bf5`.
- Binário extraído: `remappingbridge-mnt09-pico2w.uf2` **944.640 bytes**, SHA-256 **`7c5c4b5b52e7f7c74b23f4468ac5a21df686ccef8cc6fc07d306b0ad9bc658ba`**, conferido localmente e igual ao log do build GitHub Actions.
- Versão interna do candidato: **3.1.3**; versão prevista após aceite físico: **v3.1.4**.

## Alteração mínima
A HOME CONNECTED mostra **` REMAPPING OPTIONS`** sempre em sua primeira opção, com CUSTOM ou PASSTHROUGH. O template fixo usa somente DYN(0) para o nome do mouse, removendo DYN(1) para perfil. Eliminados `home_profile_summary` e `home_summary_text` do renderer, sem alterar o perfil interno ou o destino da opção. Todas as outras linhas, controles, status de perfil, BLE, HID/USB, cores e persistência mantidos.

## Roteiro e bloqueio
Usar [physical-acceptance.md](physical-acceptance.md). Somente após o operador aceitar o MNT-09, versionar para v3.1.4, executar CI do código versionado, mesclar PR e publicar release. Não presumir testes físicos individuais como PASS.
