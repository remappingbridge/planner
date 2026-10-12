# WEB-02 — Canvas LCD e paleta fiel

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-01 aceito.

## Escopo fechado

Portar glyph 5×7, geometria ST7789 240×240, 9×21, 6 tons, rótulos e backdrop. Definir explicitamente o único desvio web: clarear/suavizar apenas fundo magenta escuro sem clarear texto de título.

## Entrega observável

Canvas pixelado sem blur sob scale/HiDPI; 9 linhas legíveis em página escura; fixtures para cores/posições e snapshot de apresentação.

## Aceite e cenários manuais

Comparar tela estática e variantes de magenta com referência v3.2.3 do mouse-ui; testar 100/200/300/400% via CSS e Firefox HiDPI; operador escolhe tom.

## Limites

Não implementar brilho acima de 100% nem alterar firmware paleta.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-02/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
