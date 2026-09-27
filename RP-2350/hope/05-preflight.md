# HOPE preflight

Status: **COMPLETE — READY TO START HOPE-00, BUT NOT STARTED**.

Data de preparação: 2026-09-23.

## Verificado

- [x] repositório de destino existe: `remappingbridge/remappingbridge`;
- [x] destino inicial está identificado e ainda sem firmware HOPE;
- [x] BLU2USB G06 normativo está pinado em `7eee024ad4ee726c5a85ffa2f32b9f47187878af`;
- [x] Mouse UI Layout 1.0 está pinado em `release/ui-layout-v1.0@e8adad7919e931c92515bf655ef4050876a8e7a9`;
- [x] branches BLU2USB posteriores foram explicitamente excluídas da baseline;
- [x] escopo negativo (sem contratos/Core/Keyboard/Composite) foi congelado;
- [x] inventário das 30 telas foi congelado;
- [x] ordem oficial de 32 gates foi congelada;
- [x] teste físico obrigatório em todos os gates foi congelado;
- [x] regra de um gate por vez foi congelada;
- [x] formato de evidência e execução foi preparado.

## Deliberadamente não feito

- [ ] nenhuma cópia de código G06 para o destino;
- [ ] nenhuma alteração de firmware;
- [ ] nenhuma tela Mouse UI implementada;
- [ ] nenhum build/UF2 HOPE produzido;
- [ ] nenhum gate marcado IN PROGRESS;
- [ ] nenhum gate marcado ACCEPTED.

## Próximo comando lógico do programa

Quando o operador mandar iniciar:

> implemente o HOPE-00

Nesse momento, e somente nesse momento, deve nascer a branch de implementação HOPE-00 no produto e a cópia exata G06 deve começar.
