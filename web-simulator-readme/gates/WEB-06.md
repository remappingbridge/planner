# WEB-06 — Perfis, Custom Modifier e Movement

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge.github.io`. **Dependência:** WEB-05 aceito.

## Escopo fechado

Portar PASSTHROUGH/CUSTOM, alvo MODIFIER exclusivo com identidade correta FORWARD/BACKWARD, draft e applied separados, aplicação/retorno/cancelamento; ganhos H/V (0.25..3)x, rotação 0/90/180/270 e Reset All, perfis por bond.

## Entrega observável

Editar/confirmar remap e Movement a partir HOME 4 rotas; salvar por Mouse, voltar ao último valor aplicado; draft não deve produzir cor CURRENT em opções dependentes.

## Aceite e cenários manuais

Testes editor 5 fontes×6 alvos, não roubar Modifier aplicado durante draft, reload/reconnect de 2 mouses com H/V/rotation diferentes; Reset All não apaga perfil.

## Limites

Não disparar HID teclado/mouse no host; resultado de Apply é apenas mock.

## Protocolo

Antes de qualquer implementação, conferir a release atual do firmware, registrar SHA do alvo, criar branch isolada, documentar preflight e executar exclusivamente este gate. Executar testes automáticos browser sem Node e roteiro manual; registrar evidências e rollback em `../executions/WEB-06/` **somente após autorização**. Não avançar, fazer merge ou declarar ACEITO sem aceite explícito do operador.
