# MNT-01 — aceite físico do operador

**ACEITO EXPLICITAMENTE em 2026-10-11.**

O operador escreveu: **"gate aceito. prossiga para o proximo gate"** após executar testes do firmware candidato corrigido que restaurou a primeira linha magenta do Saved Devices. O candidato precedente, no qual o título não tinha o magenta padrão, foi rejeitado e corrigido no próprio MNT-01.

## Evidência existente e limites
- Firmware candidato aceito: [source `b6df61ffdd1eaa7ba2f78827fb17ec4bfdd79d00`](https://github.com/remappingbridge/remappingbridge/commit/b6df61ffdd1eaa7ba2f78827fb17ec4bfdd79d00), CI [#435](https://github.com/remappingbridge/remappingbridge/actions/runs/38179732422): 81/81 host PASS e build Pico 2 W SUCCESS.
- `.uf2` candidato aceito: SHA256 `a32f6e0bc374d822f3e2830dbbc787cfd076ff5639f032dd70323d5c7bd27b53`; não confundir com UF2 da release final versionada.
- A aprovação geral não equivale a medições individuais de todos cenários; não inventar resultados além de observação explícita e mensagem global.
- Critério MNT-01 encerrado com **ACEITO**; MNT-02 pode iniciar **após** o commit release versionado v3.0.1 e publicação verificada.

## Publicação
A ordem autorizada é atualizar software para `3.0.1`, CI final, merge em `main` e publicação oficial com `.uf2` + `SHA256SUMS.txt` pela automação; registrar tag, SHA e hashes em `release.md` quando concluído. Nenhuma data ou SHA de release deve ser inventada.
