# HOPE — Remapping Bridge incremental UI migration

Status: **HOPE-00/01/02/08/24/09/25/06/26/07/27/03/28 ACCEPTED / REMAPPER FLOW (HOPE-10/29/11/14/12/13/15/16/17/18/19/20/21/22) BUNDLED CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Este namespace é a fonte de planejamento do programa HOPE do repositório `remappingbridge/remappingbridge`.

## Intenção

1. começar do firmware funcional de `remappingbridge/blu2usb` no G06 aceito;
2. no HOPE-00, transferir essa baseline para `remappingbridge/remappingbridge` sem alterar comportamento;
3. depois substituir **uma tela por gate**, preservando a arquitetura funcional de BLU2USB;
4. usar `remappingbridge/mouse-ui` UI Layout 1.0 apenas como autoridade para regras observáveis das telas/fluxos que forem sendo introduzidos;
5. manter pareamento, movimento e cliques do Mouse funcionando a cada etapa;
6. exigir teste físico em **todo gate** antes de aceitação.

## O que HOPE deliberadamente não é

HOPE não replica:

- contratos UI↔Core;
- arquitetura de `mouse-core`;
- arquitetura interna de `mouse-ui`;
- pareamento Bluetooth Keyboard;
- pareamento Bluetooth Composite;
- processo MUX/UIC/MCORE;
- integração sofisticada criada apenas por abstração/precisão arquitetural.

A integração deve ser a menor adaptação necessária entre funções que já funcionam no BLU2USB G06 e as regras visuais/de interação da tela sendo migrada.

## Estado

- preparação documental: **COMPLETE**;
- código migrado para `remappingbridge/remappingbridge`: **sim; HOPE-00 promovido para `main@16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`**;
- HOPE-00: **ACCEPTED — physical PASS and promoted to main**;
- HOPE-01: **ACCEPTED — corrected in-place replacement physically passed and promoted to main**;
- HOPE-02: **ACCEPTED — physically passed and promoted to main**;
- HOPE-08: **ACCEPTED — physically passed and promoted to main**;
- HOPE-24: **ACCEPTED — physically passed and promoted to main**;
- HOPE-09: **ACCEPTED — physically passed and promoted to main**;
- HOPE-25: **ACCEPTED — physically passed and promoted to main**;
- HOPE-06: **ACCEPTED — corrected rework physically passed and promoted to main**;
- HOPE-26: **ACCEPTED — corrected layout physically passed and promoted to main**;
- HOPE-07: **ACCEPTED — title-improved candidate physically passed and promoted to main**;
- HOPE-27: **ACCEPTED — physically passed and promoted to main**;
- HOPE-03: **ACCEPTED — home-connected + `MOUSE NOT FOUND HELP`, physically passed and promoted to main**;
- HOPE-28: **ACCEPTED — current-v1 copy physically passed and promoted to main**;
- REMAPPER OPTIONS flow — HOPE-10/29/11/14/12/13/15/16/17/18/19/20/21/22: **BUNDLED CANDIDATE READY — 35/35 host tests + Pico 2 W CI green; physical acceptance pending**;
- gates aceitos: **HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25, HOPE-06, HOPE-26, HOPE-07, HOPE-27, HOPE-03, HOPE-28**.

Leia na ordem:

1. `00-authority-scope-and-precedence.md`;
2. `01-baselines-and-provenance.md`;
3. `02-gates.md`;
4. `03-execution-rules.md`;
5. `04-physical-acceptance.md`;
6. `05-preflight.md`.
