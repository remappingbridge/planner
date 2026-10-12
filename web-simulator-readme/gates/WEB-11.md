# WEB-11 — README orientado a pessoas e valor de negócio

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge/remappingbridge (README.md e imagens)`. **Dependência:** WEB-10 aceito.

## Escopo fechado

Aprimorar o README raiz com problema/solução, exemplos de produtividade e acessibilidade, fluxo Mouse BLE→Pico→host, diferenciais, casos de uso, compatibilidade e limitações fundamentadas, sem exagerar benefícios.

## Entrega observável

Narrativa que um iniciante entende, desenho de arquitetura de alto nível, funcionalidades atuais, links para site e documentação técnica. Texto claro, headings curtos e imagens com alt.

## Aceite e cenários manuais

Revisão de clareza por leitor leigo e técnico, leitura mobile, links OK, consistência de USB HID e BLE; não perder alertas de compatibilidade das versões anteriores.

## Limites

Não mudar firmware C/CMake/UF2, tags, releases, workflow ou inventar suporte por OS sem evidência.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-11/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
