# HOPE execution rules

Status: **ACTIVE WHEN HOPE-00 STARTS**.

## 1. Um gate por vez

- escolher somente o próximo gate da ordem em `02-gates.md`;
- criar branch explícita `hope/hope-XX-<slug>` no repositório de destino;
- registrar o SHA base antes de editar;
- implementar somente o escopo daquele gate;
- executar verificação automatizada aplicável;
- produzir candidato físico;
- aguardar o operador testar;
- só marcar ACCEPTED após o operador declarar PASS;
- somente então criar/iniciar o gate seguinte.

## 2. Preparação não é execução

Criar documentação, pin de baseline e branch de planejamento não inicia HOPE-00.

HOPE-00 começa apenas quando houver alteração no produto de destino destinada a transferir a árvore G06.

## 3. Branching

Produto:

~~~text
remappingbridge/remappingbridge
main                       <- somente gates aceitos/promovidos
hope/hope-XX-<slug>        <- implementação do gate atual
planning/*                 <- documentação/preparação, nunca baseline de produto
~~~

Planner:

~~~text
remappingbridge/repo-planner/hope
~~~

O planner pode ser atualizado para registrar estado/evidência; isso não substitui aceitação física.

## 4. Registro antes de código

Criar `hope/executions/HOPE-XX/pre-implementation.md` com:

- status;
- objetivo;
- dependência;
- SHA base do destino;
- SHA BLU2USB G06;
- SHA Mouse UI v1;
- tela atual antiga e tela nova;
- arquivos esperados;
- o que será reutilizado;
- o que será removido explicitamente;
- fora de escopo;
- comandos de build/teste;
- cenários físicos;
- riscos de regressão.

## 5. Mínima adaptação

Preferir conexão direta com funções G06 já existentes.

### Substituição visual, não coexistência

“Reaproveitar” uma tela G06 significa construir o novo comportamento/layout Mouse UI v1 **sobre o ponto de fluxo antigo**, reutilizando apenas o que for útil por baixo.

É proibido, para a tela do gate atual:

- manter o layout antigo como fallback;
- deixar a tela antiga alcançável por outra condição do mesmo ponto de fluxo;
- criar uma tela nova paralela e conservar a antiga para decidir em runtime qual mostrar;
- considerar “reuso” como coexistência visual do velho e do novo.

O critério de teste deve procurar explicitamente qualquer rota que ainda revele o layout antigo substituído.


Não introduzir:

- camada genérica de contratos;
- adapter público UI↔Core;
- event bus novo apenas para “arquitetura”;
- Core separado;
- framework de screens diferente do necessário;
- registro Keyboard/Composite;
- abstrações antecipando gates futuros.

## 6. Reuso de Mouse UI

Pode copiar/reexpressar o que for necessário para a tela corrente:

- texto;
- coordenadas;
- cores;
- background;
- região de hint;
- estados visuais;
- navegação;
- reação aos controles;
- regra imediata de entrada/saída da tela.

Não copiar como obrigação arquitetural:

- structs privadas do frontend;
- mock/lab/SDL;
- contrato UIC;
- módulos do mouse-core;
- tokens/epochs se o G06 não precisar deles para satisfazer o comportamento do gate.

## 7. Não antecipar telas

Uma tela futura, em outro ponto do fluxo, pode continuar antiga até seu gate.

Isso **não** autoriza manter a tela antiga que o gate atual está substituindo. A tela corrente deve ser substituída in-place no fluxo.

Exceção adicional: se o gate atual explicitamente manda remover um fluxo antigo inteiro (ex.: Pair Device antigo ou Keyboard/Composite), a remoção é parte do gate atual.

## 8. Promoção

Após aceitação física:

1. registrar `candidate.md`;
2. registrar `physical-acceptance.md` com a declaração do operador;
3. atualizar status do gate;
4. promover para `main` por PR/merge ou método de promoção usado no repositório;
5. registrar SHA final aceito;
6. apontar o próximo gate exato.

## 9. Falha física

Se qualquer cenário falhar:

- gate permanece aberto;
- corrigir na mesma linha de gate;
- produzir novo SHA/UF2;
- invalidar evidência física afetada;
- repetir os cenários afetados e regressões;
- não avançar.

## 10. Sem versão intermediária automática

Nomes de versão/release não são criados apenas por concluir um gate. Versionamento será uma decisão explícita de produto.
