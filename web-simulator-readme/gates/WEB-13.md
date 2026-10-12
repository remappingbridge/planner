# WEB-13 — Prévia clicável e demonstração no README

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge/remappingbridge (README.md/assets)`. **Dependência:** WEB-12 aceito.

## Escopo fechado

Criar imagem/GIF/SVG estático de prévia do aplicativo publicado, com link clicável para URL GitHub Pages; incluir CTA textual, roteiro de teste HOME→Movement→Modifier e aviso de simulação.

## Entrega observável

No GitHub README, um clique na prévia ou no link textual abre a página interativa real. Texto alternativo útil, mídia leve, aspecto apropriado para desktop/mobile e versão coerente.

## Aceite e cenários manuais

Testar imagem/link em README GitHub web e mobile, URL funcional da aplicação e fluxo guiado; comprovar ausência de iframe ou script executável no Markdown.

## Limites

GitHub README não executa iframe/script; não prometer embed interativo literal nem burlar sanitização.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-13/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
