# MNT-12 — aceite físico do operador

Em **12/10/2026**, após testar o UF2 candidato, o operador declarou: **"gate aceito. não implemente mais nada ainda. apenas empurre os gates que restam um gate para a frente cada, e no lugar do gate 13 coloque esta melhoria..."**.

- **Decisão:** MNT-12 aprovado fisicamente; autoriza apenas finalizar seu release PATCH dentro de v3.x (**v3.2.2**) e o planejamento de reordenação dos gates. **Não implementar** qualquer gate seguinte.
- Fonte: tag oficial v3.2.1 (`3846e8f4ee5fba40421c0db1f51387de6c51e953`), branch `maintenance/v3x-mnt-12`, candidato `2b3180810bd939ef7c3863e01c903fea7b700d26`.
- [CI candidata #541](https://github.com/remappingbridge/remappingbridge/actions/runs/38249366464): **94/94 testes host PASS**, Pico 2 W produção SUCCESS.
- UF2 candidato aceito: SHA-256 `f1eb915180809f52d0e4bfde6a9b8a41a45e037664a7d282f5c97b0be5166c76`.
- Escopo aceito: CUSTOM REMAPPING aplicado **E** Modifier efetivo colore item MODIFIER SHORTCUTS e somente valores de atalhos disponíveis e atribuídos de COMBINATIONS; exceções NOT CUSTOMIZED/UNAVAILABLE, rótulos e outras telas preservados.
- O aceite global não fornece resultado individual de cada cenário; **não inventar logs de teste físico**.

**Reordenação autorizada sem implementação:** antigo MNT-13 PAIR NEW → **MNT-14** (duas partes preservadas); antigo MNT-14 Zoom → **MNT-15** (suspenso). O novo **MNT-13** ficará reservado à melhoria visual de **indicador `>` na primeira coluna para a opção atualmente selecionada** em todas as telas de listas acionáveis. Nenhum código, UF2, PR ou CI desses gates está autorizado por esta solicitação.
