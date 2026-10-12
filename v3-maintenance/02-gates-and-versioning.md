# 02 — Gates MNT-01..MNT-15, dependências e Semantic Versioning 3.x

**Atualizado em 12/10/2026:** MNT-01..MNT-13 **aceitos e publicados até v3.2.3**. **MNT-14 CANCELADO PELO OPERADOR** após testes físicos amplos relatados como bem-sucedidos; não houve patch nem release e a causa raiz não foi estabelecida. Parte 2 não será executada. **MNT-15 Zoom: ACEITO E PUBLICADO COMO v3.2.4**; Ctrl+Shift+Equal → Ctrl+Equal somente na ação 26, PR #45, CI de release #38300896801 (98/98 + Pico 2 W PASS), UF2 oficial e SHA256SUMS conferidos. Terminais que exigem Shift possuem limitação documentada; MNT-14 cancelado.

## Matriz de execução incremental

| Gate | Itens | Entrega atômica | Estado / versão | Dependência |
|---|---|---|---|---|
| [MNT-01](gates/MNT-01.md) | HF-01 | Saved Devices: seleção e cores | **ACEITO v3.0.1** | v3.0.0 |
| [MNT-02](gates/MNT-02.md) | HF-02 + HF-03 | Remove This: KEY X Help + KEY Y Lock | **ACEITO v3.0.2** | MNT-01 |
| [MNT-03](gates/MNT-03.md) | MEL-01 | Movement resumo sem x | **ACEITO v3.0.3** | MNT-02 |
| [MNT-04](gates/MNT-04.md) | MEL-02 | Barra visual normal | **ACEITO v3.0.4** | MNT-03 |
| [MNT-05](gates/MNT-05.md) | MEL-04 | Help: B retorna, Y bloqueia; unlock global HOME | **ACEITO v3.1.0** | MNT-04 |
| [MNT-06](gates/MNT-06.md) | MEL-03 | First Mouse Connected: LOCKS ANYWHERE | **ACEITO v3.1.1** | MNT-05 |
| [MNT-07](gates/MNT-07.md) | MEL-05 | Paleta com novo ciano clarinho `0xD7FF` | **ACEITO v3.1.2** (avaliação conjunta encerrada com MNT-08) | MNT-06 |
| [MNT-08](gates/MNT-08.md) | MEL-06 | Inversão final: sem foco ciano `0x07FF`, selecionado clarinho `0xD7FF` | **ACEITO v3.1.3** | MNT-07 |
| [MNT-09](gates/MNT-09.md) | MEL-07 | HOME CONNECTED: primeira opção `REMAPPING OPTIONS` fixa | **ACEITO v3.1.4** | MNT-08 |
| [MNT-10](gates/MNT-10.md) | **MEL-10 NOVO** | Remover mouse: eliminar bond, nome, Movement e todo perfil/remap/shortcuts antigos **somente daquele mouse**; novo pareamento inicia em defaults | **ACEITO E PUBLICADO v3.2.0 (MINOR)** — perfis por mouse | MNT-09 v3.1.4 publicada |
| [MNT-11](gates/MNT-11.md) | MEL-09 | Nomes BLE: sufixo MOUSE só se substring não existe | **ACEITO E PUBLICADO v3.2.1 (PATCH)** — título BLE sem MOUSE duplicado | **MNT-10 publicado v3.2.0** |
| [MNT-12](gates/MNT-12.md) | MEL-12 | Ciano condicional de MODIFIER SHORTCUTS e valores de COMBINATIONS, somente CUSTOM aplicado + botão Modifier; exceções UNAVAILABLE e NOT CUSTOMIZED | **ACEITO E PUBLICADO v3.2.2 (PATCH)** — CI 94/94 + Pico 2 W PASS, PR #42 | v3.2.1 |
| [MNT-13](gates/MNT-13.md) | **MEL-13 NOVO** | Caractere &#124; na **primeira coluna física** somente da opção focada; em opções de duas linhas, na segunda linha; nenhum marcador nas demais | **ACEITO/PUBLICADO v3.2.3 / PR #43 / CI 96/96 + PICO PASS** | **v3.2.2 publicada**; aceite físico antes de release |
| [MNT-14](gates/MNT-14.md) | **MEL-11** (antigo MNT-13) | PAIR NEW com A conectado: investigação historicamente dividida em duas partes | **CANCELADO pelo operador em 12/10/2026 após testes físicos positivos; sem correção/release** | encerrado, não executar Parte 2 |
| [MNT-15](gates/MNT-15.md) | **MEL-08** (Zoom, antigo MNT-14) | Diagnóstico de Zoom Obsidian/KDE e correção HID genérica somente se comprovada | **ACEITO E PUBLICADO v3.2.4 / PR #45 / CI 98/98 + PICO PASS / SHA VERIFICADO** | independente de MNT-13/14; retomada somente com autorização |

**Ordem atual:** MNT-10/11/12/13 concluídos e publicados. O **novo MNT-13 (MEL-13)** documenta o pipe `|` de foco em listas, na segunda linha dos itens de duas linhas. O antigo **MNT-13 (MEL-11) virou MNT-14** sem mudar suas duas partes de diagnóstico/viabilidade; o antigo **MNT-14 (MEL-08) virou MNT-15** e recebeu autorização de implementação em 12/10/2026, com trade-off explícito para terminais, aceite físico do operador e publicação v3.2.4 via PR #45. As numerações MEL históricas e o aceite MNT-12 não são alterados.

**Versões:** a mudança visual implementada em candidato no MNT-13 só produzirá PATCH após aceite físico. O MNT-14 nas duas partes de diagnóstico/decisão (sem código) e o MNT-15 caso apenas investigativo não geram release; nenhum número futuro está reservado. MNT-13 publicado em v3.2.3; MNT-14 cancelado por decisão do operador após testes físicos reportados como positivos; Parte 2 não será executada; MNT-15 foi aceito fisicamente e publicado em v3.2.4.


## Regra de cálculo da versão
1. Usar SemVer `MAJOR.MINOR.PATCH`; apenas versões estáveis 3.x. **Não publicar v4.0.0** neste programa. Nunca editar/ressobrescrever v3.0.0 ou tags existentes.
2. HOTFIX e melhorias de *copy*, apresentação/cores, normalização e mapeamento HID corretivo preservando contrato externo são **PATCH** (incrementa último componente: 3.0.0 → 3.0.1).
3. MEL-04 muda deliberadamente semântica de controles em todos os Help; é uma mudança funcional compatível de UI, portanto **MINOR**: da hipotética 3.0.4 para **3.1.0**, reiniciando PATCH.
4. Versões da matriz **não são reservas irrevogáveis**. Se outra publicação surgir antes do gate, derivar próximo número da última tag estável v3.x realmente publicada (nunca reutilizar/rebaixar).
5. Se um gate for **somente diagnóstico sem alteração executável** (ex.: MNT-15 Zoom ou MNT-14 Pair New com conclusão sem código), **não criar tag, não gerar release vazio, não pular números por causa de tabela**. Registrar conclusão *DEFERRED / NO RELEASE* e usar a próxima versão disponível no gate seguinte. Se o comportamento modificar contrato incompatível, **reabrir planejamento antes de implementá-lo**, não impor v4 por omissão.
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
- **Exceção MNT-14, em duas partes:** a Parte 1 produz evidências e relatório de causa raiz **sem patch**; a Parte 2 compara viabilidade, riscos e alternativas, resultando em decisão GO/NO-GO/BLOCKED/NOT A BUG. Somente se houver GO **e autorização expressa posterior** aplica-se o ciclo A/B/C para código, testes, UF2, aceite físico e publicação. Após o planejamento inicial, MNT-13 foi autorizado, fisicamente aceito e publicado como v3.2.3. Parte 1 do MNT-14 foi auditada estaticamente; depois o operador relatou sucesso em testes físicos amplos e cancelou o gate. Sem logs/matriz anexados, não há prova de causa raiz, Parte 2 ou autorização de correção. MNT-15 Zoom foi posteriormente autorizado e implementado na PR #45; aceite físico ainda pendente.

## Invariantes
- Manter Pico 2 W e build Release, 2 USB HID interfaces existentes, Mouse/Keyboard/Consumer, 30 atalhos, 12 combos, movimentação e DPI/rotação por mouse, Saved Devices bond-scoped, Lock/Modifier, BLE pairing, esquema flash v3.
- Operar a UI em **9 linhas × 21 colunas**, com verificação de pixels/cores e contraste no LCD. Não criar dependências de Obsidian/Firefox no firmware; nenhum novo mecanismo USB de debug ou aplicativo no host.
- Não chamar alterações de firmware de "aceitas" antes da mensagem de aceite físico; não publicar etiquetas falsas nem prometer funcionamento que não foi observado.
