# MOV-02 — Aceite físico

**Status: ACCEPTED — confirmação do operador em 2026-10-10.**

O operador confirmou: “gate aceito. prossiga para o proximo. faça uma melhoria: na tela de saved devices apenas o nome do mouse ativo fica em ciano. qualquer outro texto de qualquer página fica em amarelo padrao do sistema, inclusive as linhas de profile, dpi e rotation”.

Escopo aceito: MOV-02 — horizontal-slow-dpi, com a melhoria textual anterior de ROTATION `KEY A: APPLY AND BACK` incluída no candidato.

Candidato aceito: commit `f13425c2c1ec8642803fa2398cd3f67606d440e6`, `49/49` host CI e UF2 Pico 2 W gerado no run https://github.com/remappingbridge/remappingbridge/actions/runs/38095384245.

Não foram fornecidos logs físicos adicionais; o aceite é o relato expresso do operador. Não se estende aos gates MOV-03 a MOV-10.

**Solicitação adicional para MOV-03:** em SAVED DEVICES, todas as páginas exibem apenas o nome do mouse *atualmente conectado* em ciano; os demais textos (incluindo título, perfil, DPI, rotação, remover e hints) ficam no tom amarelo padrão do sistema. Nas páginas de mouses não conectados, inclusive seus nomes, não há destaque ciano. Na desconexão, o antigo nome ativo perde o ciano.
