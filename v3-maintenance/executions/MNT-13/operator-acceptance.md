# MNT-13 — aceite físico explícito do operador

Em **12/10/2026**, após receber e testar o candidato atualizado com pipe, o operador declarou literalmente:

> **"gate aceito. implemente o proximo"**

- **Decisão:** MNT-13 **ACEITO** fisicamente; a ordem autoriza encerrar/publicar a versão PATCH estável 3.x e depois iniciar o gate seguinte (**MNT-14**, diagnóstico de PAIR NEW em duas partes).
- **Versão de base:** tag `v3.2.2`, commit `0d35397e6a1619f2a5dc314d0f2659206912d177`.
- **Firmware fisicamente aceito:** candidato atualizado com caractere pipe `|` na primeira coluna; se a opção ocupa duas linhas, o pipe fica sempre na **segunda**, inclusive no valor/status das seis telas COMBINATIONS. Commit fonte `c1d20493c208651ddac1a433de96d5fc44eedfae`.
- **Evidência objetiva de CI do candidato:** [run #38257166557](https://github.com/remappingbridge/remappingbridge/actions/runs/38257166557), 96/96 testes host e produção Pico 2 W SUCCESS.
- **Hash SHA-256 do UF2 candidato:** `1bac0b9f63dee762ad63e63cdf9b1b6db1193877b3d8e18d92bffc9ce32d93c7` (953344 bytes). O hash da release 3.2.3 **precisa ser recalculado** porque a versão interna muda.
- **Escopo aceito:** indicador visual exclusivamente da opção focada; preservadas cores aplicadas, menus informativos, 9×21, per-mouse, BLE, USB HID e Movement.
- O aceite geral **não** implica que foram enviados logs/fotos individuais de cada cenário físico. Não marcar checklists detalhados como observados sem evidência.
- **MNT-14** é investigação de causa raiz e decisão de viabilidade: a autorização para **iniciar o gate** não é autorização para aplicar correção especulativa de firmware. **MNT-15** continua suspenso.

**ESTADO: ACEITO.** Publicação versão `v3.2.3` registrada separadamente em `release.md` quando verificada.
