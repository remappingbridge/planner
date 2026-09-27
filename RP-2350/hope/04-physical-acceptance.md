# HOPE physical acceptance policy

Status: **MANDATORY FOR EVERY GATE**.

## Matriz universal

Todo candidato físico precisa validar, no hardware-alvo:

1. firmware inicia normalmente;
2. LCD/ST7789 renderiza sem corrupção;
3. tela do gate tem copy, geometria, background e hint corretos;
4. cores de seleção/status/dica são corretas;
5. HAT/teclas respondem conforme regra da tela;
6. Mouse pode parear/reconectar conforme o estado suportado naquele ponto do programa;
7. movimento X/Y chega ao host;
8. Left/Right/Middle e botões suportados continuam funcionando;
9. scroll/Forward/Backward, quando suportados pela baseline e dispositivo de teste, não regrediram;
10. não há Bluetooth Keyboard/Composite novo;
11. telas HOPE já aceitas continuam alcançáveis e coerentes;
12. não existe nova tela escondida ou fluxo não documentado criado pelo gate;
13. a tela/layout legado substituído pelo gate não aparece em nenhuma condição, fallback ou rota equivalente ao ponto substituído.

## Teste específico do gate

Além da matriz universal, o candidato deve demonstrar:

- entrada na nova tela pela condição correta;
- todas as ações visíveis;
- retorno/cancelamento correto;
- transição para a próxima tela já existente;
- integração com estado de Mouse conectado/salvo quando aplicável;
- perfil/remap real quando aplicável;
- remoção/persistência quando aplicável.

## Evidência mínima

Registrar:

- SHA do código candidato;
- branch;
- UF2;
- tamanho;
- SHA-256;
- placa;
- SDK/toolchain;
- Mouse usado;
- lista numerada de cenários;
- resultado informado pelo operador.

## Autoridade de PASS

Somente o operador pode declarar o teste físico PASS.

CI, testes host, screenshot, framebuffer golden e compilação podem bloquear um candidato ruim, mas não aceitam o gate.

## HOPE-00

HOPE-00 deve primeiro provar que a cópia do G06 continua fisicamente equivalente antes de qualquer tela nova ser introduzida.

## HOPE-31

HOPE-31 deve incluir a matriz das 30 telas e uma varredura de alcançabilidade para confirmar que não restou tela antiga solta/oculta.
