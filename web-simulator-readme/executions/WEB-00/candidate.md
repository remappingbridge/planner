# WEB-00 — Candidato documental

**Estado:** MATERIAL PRODUZIDO, VERIFICAÇÃO ESTÁTICA PASS, **ACEITE DO OPERADOR PENDENTE**. Não equivale a um gate aceito.

## Entregáveis concretos desta branch

1. [Preflight](preflight.md) com HEAD/tag/release/UF2, licenças, origem e riscos.
2. [screen-templates.json](../../fixtures/v3.2.3/screen-templates.json) — 45 IDs C em ordem canônica 0..44, 9 template rows por tela, máscara das linhas `DYN` e campo `hintStartRow`, `optionCount`, `focus` com linha real de pipe e ocorrências de truncamento 21-colunas. Este JSON é **fonte original pré-render**, não captura de pixel/estado dinâmico.
3. [interaction-contract.json](../../fixtures/v3.2.3/interaction-contract.json) — 9 controles HAT, ordem e compatibilidade de enums, palette RGB565, pipeline, 12 combos e 30 shortcuts, Movement, páginas/route e casos MNT-12/MNT-13.
4. [Matriz completa das 45 telas e suas interações](screen-matrix.md), com índice por ordinal e eventos de entrada de referência.
5. [Roteiro de inspeção e aceite](manual-tests.md).

## Verificações realizadas agora

Validação **estática por parser JavaScript isolado**, sem Node/npm nem criação de site:
- **PASS**: os 45 membros do enum C têm entrada no array `screens`, sem ordinal perdido/duplicado.
- **PASS**: todas as telas têm exatamente nove strings de template; dinâmicas dentro da grade.
- **PASS**: há exatamente **27 telas com opções UX**; todas casam no identificador/contagem com os 27 casos do teste original `test_mnt13_selection_marker.c`.
- **PASS**: o inventário de Modifier contém 12 combinações, 30 nomes de shortcuts acionáveis (ID 1..30; zero não atribuído), 9 controles HAT, 5 fontes Mouse e 7 valores enum de alvo (inclui ESCAPE antigo).
- **PASS**: o renderer físico usa largura 21, e duas strings template com 22 colunas (HELP_REMAPPER_OPTIONS linhas 0/2) foram explicitamente capturadas, sem adulteração.
- **PASS**: documentação de MNT-12 contém casos que refletem as duas funções originais de testes; modelo segue Custom aplicado + Modifier aplicado e focos/cores.
- **PASS**: os SHAs dos blobs de fonte C vendorizados no `mouse-ui` para os módulos centrais conferem com o firmware no mesmo commit.

**Não realizados:** CTest do firmware, execução compilada do mouse-ui, browser/Canvas, teste visual do operador, download/instalação de UF2 e publicação GitHub Pages. Nenhum destes é prometido como PASS por este gate puramente documental.

## Achados a preservar

- A grade 9×21 refere-se ao **frame exibido**, não a comprimento ilimitado de string na tabela C; firmware trunca dois títulos/linhas longas.
- `SAVED_DEVICES` retorna `optionCount=0`, mas projeta `|` em row 5 com bond válido — exceção MNT-13 indispensável.
- `MOVEMENT_OPTIONS` seleciona linha 4 quando foco é rotation; linha 3 não é opção.
- `COMBINATIONS` põe `|` somente na segunda linha (2/4), mesmo se `UNAVAILABLE` preserva cor amarelo estático do valor.
- Enums legados para perfil e target ainda existem em C, mas não devem ser adicionados à interface pública v3.
- Não tomar a string do SHA no README antigo do mouse-ui como baseline, pois não foi atualizada junto com o título.

## Rollback / continuidade

Branch WEB-00 sem merge até aceite. Caso revisões apontem erro nos fixtures, corrigir **nesta branch e no mesmo gate**, com novo SHA e nova validação; nunca pular para WEB-01 com baseline incompleta. Após aceite explícito, integrar o PR documental, registrar `operator-acceptance.md`, e **só então** habilitar WEB-01 do repositório do site.
