# 02 — Gates MNT-01..MNT-12, dependências e Semantic Versioning 3.x

**Atualizado em 11/10/2026:** gates MNT-01 a MNT-09 aceitos e publicados, último release **v3.1.4**. Novo MNT-10 passa a ser **limpeza completa de mouse removido** (planejado); MNT-11 continua nome BLE; antigo MNT-10 Zoom foi renumerado **MNT-12**. O aceite do MNT-09 não é aceite do novo MNT-10. Nenhuma implementação do MNT-10 foi autorizada.

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
| [MNT-10](gates/MNT-10.md) | **MEL-10 NOVO** | Remover mouse: eliminar bond, nome, Movement e todo perfil/remap/shortcuts antigos **somente daquele mouse**; novo pareamento inicia em defaults | **CANDIDATO PR #40 / CI 92/92 + Pico PASS / FÍSICO PENDING** — proposta v3.2.0 MINOR por introduzir perfis por mouse | MNT-09 v3.1.4 publicada |
| [MNT-11](gates/MNT-11.md) | MEL-09 | Nomes BLE: sufixo MOUSE só se substring não existe | **PLANEJADO; próximo PATCH disponível** | **MNT-10 publicado** |
| [MNT-12](gates/MNT-12.md) | MEL-08 (antigo MNT-10) | Diagnóstico Zoom Obsidian/KDE e **correção HID genérica apenas se comprovada** | **PLANEJADO; próximo PATCH se correção validada, ou DEFERRED/NO RELEASE** | **MNT-11 publicado** |

**Ordem preservada:** MNT-10 novo (MEL-10) → MNT-11 existente (MEL-09) → MNT-12 Zoom (MEL-08). As referências MEL históricas não foram renumeradas. O Zoom continua existente e não pode ser tratado como resolvido.

**Número definitivo de versão:** verificar tag publicada imediatamente antes de cada gate; nenhuma versão futura é garantida. Uma mudança compatível mas nova na persistência por mouse pode exigir MINOR `v3.2.0`; caso o resultado seja apenas bugfix sem mudança de contrato, pode caber PATCH `v3.1.5`. O MNT-11 deriva o próximo patch (por exemplo v3.2.1 ou v3.1.6) e o MNT-12 somente publica se corrigir o HID genericamente. Nunca criar release vazio.

## Regra de cálculo da versão
1. Usar SemVer `MAJOR.MINOR.PATCH`; apenas versões estáveis 3.x. **Não publicar v4.0.0** neste programa. Nunca editar/ressobrescrever v3.0.0 ou tags existentes.
2. HOTFIX e melhorias de *copy*, apresentação/cores, normalização e mapeamento HID corretivo preservando contrato externo são **PATCH** (incrementa último componente: 3.0.0 → 3.0.1).
3. MEL-04 muda deliberadamente semântica de controles em todos os Help; é uma mudança funcional compatível de UI, portanto **MINOR**: da hipotética 3.0.4 para **3.1.0**, reiniciando PATCH.
4. Versões da matriz **não são reservas irrevogáveis**. Se outra publicação surgir antes do gate, derivar próximo número da última tag estável v3.x realmente publicada (nunca reutilizar/rebaixar).
5. Se um gate for **somente diagnóstico sem alteração executável** (ex.: MNT-12 / MEL-08 Zoom se nenhuma solução genérica funcionar), **não criar tag, não gerar release vazio, não pular números por causa de tabela**. Registrar conclusão *DEFERRED / NO RELEASE* e usar a próxima versão disponível no gate seguinte. Se o comportamento modificar contrato incompatível, **reabrir planejamento antes de implementá-lo**, não impor v4 por omissão.
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
- A atualização de planejamento deste pedido **não autoriza iniciar os passos A/B/C do novo MNT-10 agora**. O aceite do MNT-09 já autorizou sua publicação v3.1.4.

## Invariantes
- Manter Pico 2 W e build Release, 2 USB HID interfaces existentes, Mouse/Keyboard/Consumer, 30 atalhos, 12 combos, movimentação e DPI/rotação por mouse, Saved Devices bond-scoped, Lock/Modifier, BLE pairing, esquema flash v3.
- Operar a UI em **9 linhas × 21 colunas**, com verificação de pixels/cores e contraste no LCD. Não criar dependências de Obsidian/Firefox no firmware; nenhum novo mecanismo USB de debug ou aplicativo no host.
- Não chamar alterações de firmware de "aceitas" antes da mensagem de aceite físico; não publicar etiquetas falsas nem prometer funcionamento que não foi observado.
