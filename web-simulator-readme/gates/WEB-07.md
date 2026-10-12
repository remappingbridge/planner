# WEB-07 — Combinations, Shortcuts e MNT-12/MNT-13

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-06 aceito.

## Escopo fechado

Portar 6 páginas×2 slots de COMBINATIONS, 5 páginas×6 atalhos (30), slot UNAVAILABLE, atribuição/reset e persistência por Mouse, junto aos 2 últimos overlays de renderer na ordem do firmware.

## Entrega observável

MODIFIER SHORTCUTS ciano apenas sob CUSTOM efetivamente aplicado + MODIFIER; valores atribuídos disponíveis ciano; NOT CUSTOMIZED/UNAVAILABLE normais; pipe | único na primeira coluna e segunda linha de slots de 2 linhas.

## Aceite e cenários manuais

Portar matriz semântica dos testes C MNT-12/MNT-13 para navegador; varrer cada opção de cada lista, paginação circular, REFRESH/REBOOT; comparar pixel/tons com screenshots nativos.

## Limites

Não reinventar o componente de selecionado com glyph >, não copiar perfil draft como ativo, não editar slots mascarados.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-07/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
