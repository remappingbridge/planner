# WEB-00 — Autorização do operador e encerramento

**Data:** 12/10/2026. **Decisão:** ACEITO PARA PROSSEGUIR, por manifestação direta do operador neste chat.

## Registro exato da decisão

Após receber o candidato WEB-00 com seus resultados estáticos e a indicação de que WEB-01 dependia do aceite, o operador respondeu **“prossiga”**. Essa mensagem é tomada como **autorização inequívoca para avançar de WEB-00 para WEB-01**; não é apresentada como se o operador tivesse escrito literalmente “gate aceito” nem como prova de revisão manual detalhada das 45 telas.

- Candidato documental: [PR #17](https://github.com/remappingbridge/planner/pull/17).
- Baseline firmware: `v3.2.3` / `f38c5fd15c68ea9a36d3b05912727788d7b98e81`.
- Verificação de parser: 45/45 telas, 27/27 menus, 12 combinações, 30 atalhos e 9 controles.
- `manual-tests.md` permanece **não executado presencialmente**; seus checkpoints são referência para a futura validação de paridade no WEB-10, não aceites retroativos.
- Saída aprovada: merge dos artefatos **documentais do WEB-00** no `planner` e abertura do gate **WEB-01** em branch própria de `remappingbridge.github.io`.

## Limites

WEB-00 não prova comportamento browser, Bluetooth, USB, firmware real, instalação UF2 ou precisão pixel a pixel do LCD. WEB-01 pode começar somente como página e bootstrap estático; demais funcionalidades continuam nos gates seguintes.

**Próxima ação permitida:** abrir WEB-01. Nenhum gate WEB-02 ou posterior é considerado aprovado por esta decisão.
