# 02 — Série unificada WEB-00..WEB-15

**Updated October 12, 2026:** WEB-00 and WEB-01 completed/accepted; WEB-02..WEB-15 not started. Product text must be English-only. Web manual acceptance must be in the production browser, not via Debian testing. Firmware source/UF2 unchanged by WEB-00/01.

## Matriz sequencial

| Gate | Repositório(s) alvo(s) em futura execução | Entrega testável | Depende |
|---|---|---|---|
| [WEB-00](gates/WEB-00.md) | planner (baseline; preparo de execução) | fonte v3.x congelada por SHA, inventário 45 telas/fluxos, fixtures, contratos, permissões; sem site | plano |
| [WEB-01](gates/WEB-01.md) | remappingbridge.github.io | `index.html` único, assets relativos, bootstrap do app e GitHub Pages branch publishing, tela mínima funcional | WEB-00 |
| [WEB-02](gates/WEB-02.md) | remappingbridge.github.io | renderer Canvas 240×240/9×21, bitmap, RGB565 e delta de magenta de fundo | WEB-01 |
| [WEB-03](gates/WEB-03.md) | remappingbridge.github.io | teclado/HAT virtual com eventos press/release, Help/Lock, foco e desbloqueio | WEB-02 |
| [WEB-04](gates/WEB-04.md) | remappingbridge.github.io | 45 telas v3 canônicas e árvore de navegação/regras de seleção, com paridade textual | WEB-03 |
| [WEB-05](gates/WEB-05.md) | remappingbridge.github.io | mundo virtual BLE/salvos/Pair New/reconnect/remove/perfil por Mouse, persistência e tempo determinístico | WEB-04 |
| [WEB-06](gates/WEB-06.md) | remappingbridge.github.io | Passthrough/Custom, editor de alvos/Modifier, H/V DPI, rotação e Reset All | WEB-05 |
| [WEB-07](gates/WEB-07.md) | remappingbridge.github.io | 12 combos, 30 shortcuts, disponibilidade, MNT-12 ciano e MNT-13 `|` (segunda linha) | WEB-06 |
| [WEB-08](gates/WEB-08.md) | remappingbridge.github.io | visual CSS arredondado, painel HAT/LCD, HiDPI, mobile, acessibilidade e brilho 0–100% | WEB-07 |
| [WEB-09](gates/WEB-09.md) | remappingbridge.github.io | Inspector/Evidence/Log, cenários v3, injeção de falhas reproduzível, botão COPY REF | WEB-08 |
| [WEB-10](gates/WEB-10.md) | remappingbridge.github.io | auditoria completa de paridade com desktop/firmware, smoke navegador, publicação estática e URL validada | WEB-09 |
| [WEB-11](gates/WEB-11.md) | remappingbridge (README e docs visuais) | narrativa didática e de negócios: problema, solução, aplicações, diferenciais e limites | WEB-10 |
| [WEB-12](gates/WEB-12.md) | remappingbridge (README/assets) | hardware: Pico 2 W/RP2350, Waveshare Pico-LCD-1.3, fotos/diagramas originais/licenciados, montagem | WEB-11 |
| [WEB-13](gates/WEB-13.md) | remappingbridge (README/assets) | prévia ilustrada clicável → app Pages, roteiro da demo e FAQ; sem iframe fictício | WEB-12 |
| [WEB-14](gates/WEB-14.md) | remappingbridge (README) | instalação BOOTSEL/UF2, link release latest + link direto UF2 da release conferida, SHA256 e versionamento | WEB-13 |
| [WEB-15](gates/WEB-15.md) | planner (aceite) e auditoria somente leitura dos dois repos | aceite integrado web+README, links, manutenção de sincronização e fechamento; sem firmware alterado | WEB-14 |

## Ordem e integridade

- GATE = incremento isolável. A cada gate autorizado criar branch no **repositório afetado**, nunca misturar alterações executáveis no `planner`. Verificar `main` e release corrente antes da branch.
- **WEB-00** em execução futura congela as fixtures da *última release válida*, podendo ser mais nova que v3.2.3. Se versão mudar durante WEB-01..WEB-15, registrar primeiro um delta de sincronização e decidir com o operador se é bloqueante; não misturar reimplementação silenciosa no gate atual.
- WEB-01 deve deixar uma página estática navegável/testável no browser antes de seguir. WEB-02 deve mostrar Canvas, WEB-03 deve aceitar HAT, WEB-04 deve permitir HOME→telas, etc.; **todo gate gera cenários manuais executáveis** e nenhum fica refém de funcionalidades de gates posteriores.
- **WEB-10** encerra o candidato do site; **WEB-11..14** fazem o README, sempre ligado à URL funcional. Se o operador decidir não publicar o site até o aceite, usar URL de preview/arquivo estático declarado sem afirmar que Pages já está no ar.
- Não alterar firmware, não gerar UF2 neste programa, não disparar lançamento de novo firmware e não rotular o site como "release oficial do firmware".
- Toda aprovação exige a expressão explícita do operador (“gate aceito” ou inequívoca); CI/Test PASS, link funcional, merge de PR ou documentação preenchida **não equivalem automaticamente a aceite humano**. Não adiantar o próximo gate por iniciativa própria.
- Se GitHub Pages só puder ser configurado via Settings pelo usuário, deixar instrução, status PENDING e validação de publicação como critério de WEB-10; não inventar Deploy/URL válida.
- No README, a versão apresentada deve vir da **release real** verificável, nunca ficar hardcoded como a última para sempre; a URL de release latest permanece estável, enquanto UF2 com nome versionado precisa conferência/atualização editorial em releases posteriores.

## Regra de evidência por gate

Em `web-simulator-readme/executions/WEB-XX/` criar `preflight.md`, `candidate.md`, `manual-tests.md` e `operator-acceptance.md` **somente quando o gate for de fato executado**. Registrar SHA inicial/final, branch, diff, matrizes automáticas e navegador, screenshots de LCD, URL Pages se publicada, conhecido risco, reversão e aceite humano pendente/confirmado. No site, testes são executados diretamente no navegador; sem `npm test` ou GitHub Actions próprias. Nos gates de README, validar Markdown/copy, links e autorizações de imagem, sem flash físico.
