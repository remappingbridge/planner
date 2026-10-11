# MNT-02 — aceite físico

**ACEITO EXPLICITAMENTE pelo operador em 2026-10-11.**

Mensagem do operador: **"gate aceito. prossiga"** em resposta à entrega do candidato MNT-02.

- HF-02/HF-03 implementados e aceitos juntos: na tela REMOVE THIS `KEY X: HELP` é exibido e abre Help; KEY Y bloqueia (e não abre Help).
- Fonte do candidato aprovado: [commit `9638d60d65caed772cb23d35ad05b7f2e345ca36`](https://github.com/remappingbridge/remappingbridge/commit/9638d60d65caed772cb23d35ad05b7f2e345ca36), [CI #445](https://github.com/remappingbridge/remappingbridge/actions/runs/38180926578), 82/82 host PASS e firmware produção Pico 2 W SUCCESS.
- UF2 candidato SHA256 `04e1dc1f937fb2d5ce3bd82621aab88d2bc3bc8d73e887a74bb988422962891b`; binário de release final conterá versão embarcada `3.0.2` e poderá ter checksum diferente.
- Aceite global relatado não implica marcação fictícia de cenários isolados como PASS. Preservar evidência original; não atribuir resultados individuais.
- Gate liberado para publicação **v3.0.2**, após bump de versão e nova CI. MNT-03 somente iniciará de tag **v3.0.2** publicada/verificada.
