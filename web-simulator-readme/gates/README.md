# Gates WEB-00..WEB-15 — índice operacional

**WEB-00: encerrado com autorização do operador em 12/10/2026. WEB-01: ACEITO pelo operador, PR #1 integrado. WEB-02..WEB-15: não iniciados; English-only e validação futura apenas em navegador de produção.**

Os contratos globais estão em [README](../README.md), [arquitetura](../01-contract-and-architecture.md), [matriz](../02-gates-and-dependencies.md), [testes](../03-acceptance-and-tests.md) e [README/hardware/UF2](../04-readme-hardware-and-download.md).

| Fase | Gates | Resultado esperado |
|---|---|---|
| Contrato/infra | [WEB-00](WEB-00.md), [WEB-01](WEB-01.md) | baseline do firmware mais recente e site estático sem Node |
| Renderer/UX | [WEB-02](WEB-02.md), [WEB-03](WEB-03.md), [WEB-04](WEB-04.md) | Canvas 240×240 + HAT + 45 telas |
| Estado/funcionalidade | [WEB-05](WEB-05.md), [WEB-06](WEB-06.md), [WEB-07](WEB-07.md) | dispositivos salvos, Movement, Modifier, 12 combos, 30 atalhos, MNT-12/13 |
| Apresentação/QA | [WEB-08](WEB-08.md), [WEB-09](WEB-09.md), [WEB-10](WEB-10.md) | controles arredondados, brilho até 100%, Inspector, navegador e GitHub Pages |
| README didático | [WEB-11](WEB-11.md), [WEB-12](WEB-12.md), [WEB-13](WEB-13.md), [WEB-14](WEB-14.md) | argumento de valor, hardware correto ilustrado, prévia com link, UF2 latest |
| Auditoria/encerramento | [WEB-15](WEB-15.md) | validação cruzada site, README, último firmware e aprovação do operador |

## Regra de execução

Implementar **somente um gate após autorização explícita**. Cada gate implementado recebe branch separada no repo de destino, testes/roteiro manual e evidências em `../executions/WEB-XX/`. Falhas ficam no próprio gate; sem avanço silencioso. **O WEB-00 foi iniciado em branch isolada; só prosseguir após seu aceite.**

Não alterar o firmware nem produzir UF2 neste programa. A URL da página web não é substituta do download UF2. No README do GitHub haverá uma prévia **clicável** que abre a aplicação no Pages; o GitHub não executa o app dentro de Markdown.
