# MNT-11 — Nomes BLE: remover sufixo MOUSE se substring já existe

**Status: PLANNED / NÃO INICIADO.** Nenhuma alteração de código, UF2, CI ou release executada neste gate.

- Backlog: **MEL-09 (antigo item 8)** em [01-backlog-and-contract.md](../01-backlog-and-contract.md).
- Base/dependência: **MNT-10 decidido (publicado ou DEFERRED)**; a branch futura `maintenance/v3x-mnt-11` deve nascer do SHA exato da **última tag v3.x realmente publicada**.
- Versão prevista somente após aceite físico: **v3.1.5 PATCH condicional; v3.1.4 se MNT-10 sem release**. A numeração definitiva depende de [02-gates-and-versioning.md](../02-gates-and-versioning.md).

## Escopo exato
Antes de anexar MOUSE, detectar substring MOUSE em qualquer posição sem fronteiras de palavras e case-insensitive. Nome BTS. 0MOUSE2 não recebe sufixo; LIFT recebe MOUSE. Unificar HOME CONNECTED e Saved Devices com normalizador comum e preservar nome capturado de BLE.

## Preparação técnica — para execução futura
Examinar helper de nome em src/renderer/renderer.c, que na v3 verifica limites de palavra com home_word_char; mudar apenas lógica de presença, e nunca payload BLE/bonds. Testar truncamento e nomes vazios.

## Teste físico individual desde HOME CONNECTED
Usar fixtures `BTS. 0MOUSE2`, `mOuSe2`, `MOUSE-123`, `LIFT`, `UNKNOWN MOUSE`, nome 21+ caracteres; comparar HOME/Saved Devices, reconectar BLE e paginar; não duplicar sufixo.

## Riscos/limites
Detectar MOUSE no nome original antes de truncar em 21, preservando UTF-8/buffer e contagem 9×21.

## Contrato de entrega
1. Antes de implementar: registrar fonte imutável, diff mínimo, fixtures 9×21 e baseline de regressão no `executions/MNT-11/pre-implementation.md`.
2. Implementar **apenas este gate**, criar testes host/CI novos e conservar regressões completas. Build de produção Pico 2 W, baixar UF2 oficial, comparar SHA-256 local com log CI, disponibilizar para teste; PR draft.
3. Registrar `executions/MNT-11/candidate.md` e `physical-acceptance.md`. **Somente o usuário testa e aceita fisicamente**; se falhar, corrigir na mesma branch e repetir.
4. Após **aceite explícito**, fazer bump SemVer adequado, build/CI do código versionado, integrar e publicar **um único GitHub Release** com UF2, SHA256SUMS e changelog rastreáveis, registrar release e então habilitar o gate seguinte. Se este for MNT-10 e nenhum patch genérico for validado, **marcar DEFERRED/NO RELEASE** após decisão, não publicar software sem alteração.
5. **Neste momento: não iniciar passo 1, 2, 3 ou 4.** Este arquivo é planejamento, não execução.
