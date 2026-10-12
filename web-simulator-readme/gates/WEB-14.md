# WEB-14 — UF2 da release mais recente, checksums e BOOTSEL

**Status:** PLANEJADO / NÃO INICIADO. **Destino em futura execução:** `remappingbridge/remappingbridge (README.md)`. **Dependência:** WEB-13 aceito.

## Escopo fechado

Consultar Release mais recente publicada no momento da execução; conferir tag, assets .uf2 e SHA256SUMS; adicionar link direto do UF2 com nome real e link permanente /releases/latest. Documentar BOOTSEL do Pico 2 W e cuidados de upgrade/downgrade.

## Entrega observável

README identifica versão exata e download direto correto, checksum e alternativa estável da página Latest Release; guia curto para iniciante com cabo Micro-USB de dados, RPI-RP2, UF2 e reboot.

## Aceite e cenários manuais

Abrir links, validar tag e asset da release atual e checksum; confirmar via documentação que não se deve fazer flash_nuke em atualização normal; registrar procedimento para atualizar link versionado nas próximas releases.

## Limites

Não criar nova release nem editar firmware/workflow. URL UF2 versionada não é automaticamente futura; não inventar latest/download de nome de arquivo variável.

## Protocolo

Antes de implementar, conferir release atual e commit dos alvos, abrir branch isolada e registrar preflight. Executar testes e roteiro manual documentados; gerar registros sob `web-simulator-readme/executions/WEB-14/` no planner somente ao executar. **Não avançar ou declarar ACEITO sem aceite explícito do usuário**.
