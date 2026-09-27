# HOPE authority, scope and precedence

Status: **FROZEN FOR PROGRAM START**.

## 1. Repositórios envolvidos

| Papel | Repositório | Regra |
|---|---|---|
| produto de destino | `remappingbridge/remappingbridge` | único repositório onde firmware HOPE será implementado |
| baseline funcional | `remappingbridge/blu2usb` | somente leitura; fonte G06 |
| baseline visual/UX | `remappingbridge/mouse-ui` | somente leitura; UI Layout 1.0 |
| planejamento/evidência | `remappingbridge/repo-planner/hope` | autoridade do processo HOPE |

Nenhuma preparação do programa autoriza mudança de código em `blu2usb` ou `mouse-ui`.

## 2. Precedência

Quando um gate for executado:

1. decisões explícitas deste programa em `repo-planner/hope`;
2. para arquitetura, pareamento, Mouse forwarding/remap/persistência já existentes: BLU2USB G06 aceito;
3. para copy, geometria, cores, dicas, navegação e regra observável **da tela que o gate introduz**: Mouse UI Layout 1.0;
4. comportamento do destino já aceito nos gates HOPE anteriores.

Não importar silenciosamente requisitos de UIC/MCORE/MINT, contratos UI↔Core ou estruturas privadas do `mouse-ui`.

## 3. Regra central de adaptação

O projeto começa com a carcaça funcional de BLU2USB G06.

### Regra obrigatória: adaptar = substituir a tela

Quando um gate disser **adaptar**, **reaproveitar**, **preservar a função** ou **usar a tela antiga como base**, isso significa:

- reutilizar internamente a lógica, fluxo, pareamento, estado, renderer ou funções G06 que forem úteis;
- **substituir visualmente a tela antiga pela tela Mouse UI v1 do gate**;
- a tela/layout legado correspondente **não pode continuar como alternativa, fallback, cópia paralela ou rota concorrente**;
- não criar um novo screen-id apenas para manter o antigo intacto ao lado do novo quando ambos representam o mesmo ponto do fluxo;
- depois do gate, toda entrada que antes chegava à tela antiga substituída deve chegar ao novo layout do gate, salvo uma exceção explicitamente documentada pelo próprio gate.

Telas de outros pontos do fluxo que ainda não chegaram ao seu gate podem continuar antigas. A tela especificamente substituída pelo gate atual, não.

Cada gate posterior pode:

- substituir/adaptar a tela indicada;
- conectar essa tela às funções já existentes necessárias para ela funcionar;
- remover somente fluxo antigo explicitamente declarado obsoleto;
- fazer a adaptação mínima exigida para manter o fluxo coerente com telas HOPE já aceitas.

Cada gate não pode:

- reescrever a arquitetura por conveniência;
- importar módulos do `mouse-ui` como arquitetura;
- criar um Core separado;
- criar contrato público UI↔Core;
- habilitar Bluetooth Keyboard/Composite;
- introduzir telas extras “temporárias” fora do inventário;
- antecipar telas/gates futuros.

## 4. Antigo e novo

- **antigo** = comportamento/tela herdado de BLU2USB G06;
- **novo** = comportamento/tela observável especificado pelo Mouse UI Layout 1.0.

## 5. Regra contra interpretação silenciosa

Se a especificação do gate não disser para remover algo, não inferir remoção **fora do ponto de fluxo que o próprio gate substitui**.

A tela/layout legado explicitamente adaptado pelo gate é uma exceção: sua apresentação visual deve desaparecer daquele ponto do fluxo por definição da regra “adaptar = substituir in-place”.

Se houver conflito real entre a função G06 e a regra observável da nova tela, registrar o conflito em `executions/HOPE-XX/pre-implementation.md` antes de alterar código. A solução deve ser a menor adaptação que preserve a função G06 e satisfaça a regra observável da tela.

## 6. Regra de aceitação

Nenhum gate HOPE é aceito apenas porque compila, passa testes host ou produz UF2. **Teste físico pelo operador é obrigatório em todos os gates.**
