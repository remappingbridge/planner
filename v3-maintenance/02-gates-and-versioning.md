# 02 — Gates MNT-01..MNT-11, dependências e Semantic Versioning 3.x

**Situação: MNT-01 implementado em branch isolada, CI 81/81 PASS + UF2 verificado, aceite físico PENDING; MNT-02..11 planejados / último release publicado: [v3.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.0.0).** 2026-10-11. Nenhum gatilho de release é criado agora; aceites futuros habilitam release de cada gate.

## Matriz de execução incremental

| Gate | Itens | Entrega atômica | Versão-alvo condicional | Dependência |
|---|---|---|---|---|
| [MNT-01](gates/MNT-01.md) | HF-01 | Saved Devices: dicas cinza, único REMOVE DEVICE cinza/branco conforme seleção; [candidato CI 81/81 + UF2](executions/MNT-01/candidate.md), físico PENDING | **v3.0.1** (PATCH, NÃO PUBLICADA) | tag v3.0.0 |
| [MNT-02](gates/MNT-02.md) | HF-02 + HF-03 | Remove This: rótulo KEY X: HELP e funcionamento real do Help pelo X no mesmo build | **v3.0.2** (PATCH) | MNT-01 publicado |
| [MNT-03](gates/MNT-03.md) | MEL-01 | Movement Options: números DPI sem `x` apenas no resumo | **v3.0.3** (PATCH) | MNT-02 |
| [MNT-04](gates/MNT-04.md) | MEL-02 | separadores visuais do LCD normalizados para `/` | **v3.0.4** (PATCH) | MNT-03 |
| [MNT-05](gates/MNT-05.md) | MEL-04 | Todo Help: KEY B volta, KEY Y bloqueia, demais entradas não agem | **v3.1.0** (**MINOR**) | MNT-04 publicado |
| [MNT-06](gates/MNT-06.md) | MEL-03 | First Mouse Connected: `KEY Y: LOCKS ANYWHERE` já é verdadeiro após MNT-05 | **v3.1.1** (PATCH) | MNT-05 publicado |
| [MNT-07](gates/MNT-07.md) | MEL-05 | ciano do sistema passa a ciano claro esbranquiçado | **v3.1.2** (PATCH) | MNT-06 |
| [MNT-08](gates/MNT-08.md) | MEL-06 | selecionado ciano claro passa a ciano normal de destaque | **v3.1.3** (PATCH) | MNT-07 |
| [MNT-09](gates/MNT-09.md) | MEL-07 | opção HOME CONNECTED fixa `REMAPPING OPTIONS` | **v3.1.4** (PATCH) | MNT-08 |
| [MNT-10](gates/MNT-10.md) | MEL-08 | diagnóstico + **eventual correção HID genérica** de Zoom In/Out (Obsidian/KDE) | **v3.1.5** (PATCH, **somente se houver correção aprovada**) | MNT-09 |
| [MNT-11](gates/MNT-11.md) | MEL-09 | nome BLE contendo `MOUSE` como substring não recebe sufixo | **v3.1.6** (PATCH, se MNT-10 publicar; caso contrário **v3.1.5**) | MNT-10 decidido |

**Por que 11 gates para 12 itens:** os hotfixes 2 e 3 compõem uma única correção transacional; rótulo que anuncia KEY X sem implementação seria regressão. Cada uma das nove melhorias tem um gate isolado; nenhum release combina melhorias separadas. A numeração dos gates refere-se à **sequência de execução**, a numeração MEL refere-se ao **backlog**.

## Regra de cálculo da versão
1. Usar SemVer `MAJOR.MINOR.PATCH`; apenas versões estáveis 3.x. **Não publicar v4.0.0** neste programa. Nunca editar/ressobrescrever v3.0.0 ou tags existentes.
2. HOTFIX e melhorias de *copy*, apresentação/cores, normalização e mapeamento HID corretivo preservando contrato externo são **PATCH** (incrementa último componente: 3.0.0 → 3.0.1).
3. MEL-04 muda deliberadamente semântica de controles em todos os Help; é uma mudança funcional compatível de UI, portanto **MINOR**: da hipotética 3.0.4 para **3.1.0**, reiniciando PATCH.
4. Versões da matriz **não são reservas irrevogáveis**. Se outra publicação surgir antes do gate, derivar próximo número da última tag estável v3.x realmente publicada (nunca reutilizar/rebaixar).
5. Se um gate for **somente diagnóstico sem alteração executável** (ex.: MEL-08 Zoom se nenhuma solução genérica funcionar), **não criar tag, não gerar release vazio, não pular números por causa de tabela**. Registrar conclusão *DEFERRED / NO RELEASE* e usar a próxima versão disponível no gate seguinte. Se o comportamento modificar contrato incompatível, **reabrir planejamento antes de implementá-lo**, não impor v4 por omissão.
6. Um único release para cada gate aceito, associado a seu commit-fonte exato; nenhuma release antecipada mesmo que CI passe.

## Ciclo obrigatório de cada gate

### A — Preparar
- Confirmar última tag v3.x publicada (commit + release + SHA UF2 anterior), contrato do gate e base exata. Criar branch `maintenance/v3x-mnt-XX` daquela tag. Nunca usar branch antiga de MOD ou cópia de arquivos da v2 como baseline.
- Registrar no planner `executions/MNT-XX/pre-implementation.md` com inventário de telas/código/fixtures e matriz prevista; se encontrar contradições, documentar antes de modificar.
- Criar PR de review em draft da branch, preferencialmente com base `main`, documentando árvore/versão exata e sem merge até aceite.

### B — Implementar/qualificar
- Alterar **somente escopo do gate**, adicionar teste C/host + source-contract + fixture 9×21 para UI, e testar regressões de todos os gates anteriores.
- CI host completa PASS; CI **Pico 2 W produção** PASS; artefato `.uf2` original extraído, **SHA-256 verificado com hash do log**, gravável sem `flash_nuke`. Entregar ao operador o UF2, SHA e roteiro de teste físico **sempre começando na HOME CONNECTED**, com reversão segura.
- Registrar `executions/MNT-XX/candidate.md` e `physical-acceptance.md` com checklist inicialmente PENDING. CI não comprova tela, cor, movimento ou host real.

### C — Gate físico, release e avanço
- Aguardar mensagem explícita **“gate aceito”** do operador; nunca marcar PASS individual não observado. Falhou? corrigir e revalidar **na mesma branch/gate** com novo SHA/UF2; não gerar tag.
- Após aceite (autorização de publicação fornecida neste planejamento): atualizar código de versão/CMake/README/release notes ao número calculado; CI do commit final e, se necessário, UF2 final produzido da mesma fonte/tag; integrar branch conforme estratégia segura do repositório; tag anotada `v3.x.y` **apontando para o commit com versão correta**; GitHub Release oficial com UF2 + `SHA256SUMS`; verificar download/hash e que tag coincide com `main`.
- Registrar `executions/MNT-XX/operator-acceptance.md`, `release.md` com tag/SHA/CI/hashes/publicação, então habilitar o próximo gate a partir da **tag publicada**, não do candidato anterior.
- Se CI do bump falhar ou Release falhar: **gate não publicado**, não prosseguir; corrigir sem gerar release duplicada. Nunca deixar versão README divergente de tag/firmware.
- O pedido atual **não autoriza começar nenhum dos passos A/B/C agora**. Estes são contratos para execução futura, só quando usuário solicitar.

## Invariantes
- Manter Pico 2 W e build Release, 2 USB HID interfaces existentes, Mouse/Keyboard/Consumer, 30 atalhos, 12 combos, movimentação e DPI/rotação por mouse, Saved Devices bond-scoped, Lock/Modifier, BLE pairing, esquema flash v3.
- Operar a UI em **9 linhas × 21 colunas**, com verificação de pixels/cores e contraste no LCD. Não criar dependências de Obsidian/Firefox no firmware; nenhum novo mecanismo USB de debug ou aplicativo no host.
- Não chamar alterações de firmware de "aceitas" antes da mensagem de aceite físico; não publicar etiquetas falsas nem prometer funcionamento que não foi observado.
