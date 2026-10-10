# MOV-02 — Pré-implementação

Escopo exclusivo de aceite: `horizontal-slow-dpi` (1x, 0.75x, 0.5x, 0.25x), coluna inicial 16 (base 1), valor confirmado ciano, seleção branca, Up/Down wrap, Key A aplica e volta **após gravação bem-sucedida**, Key B cancela, Key X Help, retorno pela HOME conectada.

Dependência: MOV-01 aceito pelo operador. O código das telas já estava preparado na mesma branch, portanto MOV-02 recebe testes próprios e candidato físico; não altera a arquitetura nem cria fluxos de depuração.

Melhoria adicional requisitada pelo operador: em ROTATION, texto de hint `KEY A: APPLY` -> `KEY A: APPLY AND BACK`, com exatamente 21 colunas. Comportamento já existente preservado.
