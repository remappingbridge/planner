# MNT-04 — preflight técnico / MEL-02

**Status: PREPARAÇÃO CONCLUÍDA; IMPLEMENTAÇÃO BLOQUEADA ATÉ A TAG v3.0.3 SER PUBLICADA E VERIFICADA.**

## Dependência imutável
- Operador aceitou MNT-03 em 11/10/2026.
- PR #33 integrado à main no commit `bb1fc1443b98744235f3bd14bab68b996e40eed9`, com versão fonte 3.0.3 e workflow de release.
- No momento deste registro, `v3.0.3` ainda não era resolvível como ref/tag na API. **Não criar branch com main ou branch MNT-03** para substituir a tag.
- Após tag verificável, criar `maintenance/v3x-mnt-04` precisamente da tag publicada; congelar commit SHA.

## Inventário preliminar no código main
- `src/ux_model/ux_model.c`: 16 trechos de UI (15 templates e 1 legenda de catálogo) com backslash visual nas dicas JOY UP/DOWN, RIGHT/LEFT, LEFT/RIGHT; e rótulos ENTER/RETURN, PLAY/PAUSE, HOME SCREEN/PAGE.
- `src/renderer/renderer.c` contém detector de foco/realce que usa `strstr(row, "RIGHT\\LEFT")`. Atualizar conjuntamente o detector para a nova legenda, preservando foco, navegação e cor.
- Não substituir backslash de escapes C (`\\n`, `\\0`, `\\"`), caminhos ou conteúdo de controle. A alteração é de **caracteres visuais exibidos**.
- Investigar todas as strings compostas/dinâmicas e help antes de fechar a lista. Exigir largura máxima 21 e altura 9 por tela; testes de snapshots e não truncamento.

## Implementação/validação
1. Mapear todos os textos efetivamente mostrados no LCD e suas dependências de renderer.
2. Substituir separadores visuais `\\` por `/` somente em literais pertinentes, sem regex global sobre fonte.
3. Atualizar testes existentes e criar teste MNT-04 auditando telas e helpers, linhas 9×21, sem regressão visual ou de navegação.
4. CI host e build produção Pico 2 W, UF2 candidato com SHA validado; PR draft; cenários físicos desde HOME CONNECTED.
5. **Somente após aceite físico** atualizar versão para v3.0.4, mesclar e publicar release único.

Nenhuma implementação do MNT-04 foi iniciada neste preflight.
