# MNT-10 — Remover mouse sem deixar vínculo nem configuração residual

**Status: CANDIDATO IMPLEMENTADO / AGUARDANDO TESTE FÍSICO.** PR draft [#40](https://github.com/remappingbridge/remappingbridge/pull/40), [CI #526](https://github.com/remappingbridge/remappingbridge/actions/runs/38190069355) com **92/92 testes host e build Pico 2 W aprovados**, UF2/checksum documentados em [candidate.md](../executions/MNT-10/candidate.md). **Não há aceite físico nem nova release.** O restante preserva os critérios e riscos do planejamento original.

- Backlog: **MEL-10**, nova melhoria de exclusão integral de dispositivo.
- Base: **v3.1.4 oficialmente publicada**, após MNT-09; futura branch `maintenance/v3x-mnt-10` deve nascer da tag/SHA exatos da última release oficial.
- Precede: MNT-11 (nome BLE). O gate de Zoom anteriormente chamado MNT-10 foi deslocado para **MNT-12**.
- Versão prevista: **a decidir no preflight** com SemVer 3.x. Se correção interna compatível PATCH, próxima disponível `v3.1.5`; se a solução exigir introduzir persistência e perfil por dispositivo, avaliar **v3.2.0 MINOR**. Não publicar v4.0.0 nem reservar números imutáveis.

## Defeito observado e resultado esperado

O operador removeu um mouse por SAVED DEVICES → REMOVE DEVICE / REMOVE THIS e, ao pareá-lo novamente como dispositivo novo, o firmware restaurou o perfil anterior.

**Contrato:** remover deve apagar o vínculo e os dados associados **somente àquele mouse**, incluindo credenciais/bonds Bluetooth LE, nome/identidade salva, configuração e histórico de Movement (horizontal/vertical DPI, Rotation), perfil ativo PASSTHROUGH/CUSTOM, botões remapeados, rascunhos, Modifier, combinações, atalhos e demais dados específicos desse mouse. Um novo pareamento com a mesma identidade física deve começar com **configurações padrão**, sem reaproveitar registros anteriores. O nome identificado pelo BLE no novo pareamento pode voltar a aparecer como **novo dado**, não por cache antigo.

Excluir um mouse **não deve apagar os perfis, atalhos, bonds ou movimentos de outros mouses salvos** e não deve resetar configurações globais independentes do dispositivo. Remoção não é `factory reset` nem `flash_nuke`.

## Diagnóstico de arquitetura já identificado no código v3.1.3

1. `src/app/main.c`: `BLU2USB_UX_COMMAND_REMOVE_MOUSE` chama `blu2usb_ble_hogp_pico_request_remove_saved_mouse()`; evento `SAVED_MOUSE_REMOVED` reconta bonds e reconstitui a UI.
2. `src/ble_hogp/ble_hogp_pico.c`: `complete_remove_target()` já tenta limpar Movement TLV (`movements_remove_identity`), registro de nomes (`saved_names_remove_identity`) e bonds LE (`remove_bonds_for_identity`), recarregando a resolving list. Essa limpeza não basta para a regra nova.
3. `src/app/main.c`: perfis/remapping/Modifier/Shortcuts são mantidos em `blu2usb_profiles_t profiles`, carregados no boot por `restore_profiles()` e salvos por `persist_profiles()` **em armazenamento global**, sem vínculo ao bond do mouse; `synchronize_saved_mice()` ajusta Movement por bond, mas não reatribui perfis/atalhos. Isso explica uma hipótese forte para o perfil antigo voltar após reparear, **a confirmar com testes**, sem inventar que o vínculo BLE necessariamente sobreviveu.
4. Examinar ainda o gerenciamento de IRK/RPA, índices lógicos de bond, TLV de nomes/movement, persistência de profiles em `src/storage/storage.c`, `src/profiles/profiles.c`, conexões Pair New/Promoted e os caminhos de falha de flash.

## Desenho obrigatório a decidir no preflight

- **Identidade estável:** associar quaisquer dados por mouse à identidade BLE canônica (endereço/tipo/IRK ou outro identificador robusto já usado pelo BTstack), não a índices de tela, ordinais dinâmicos ou slots recicláveis. Garantir comportamento correto com resolvable private address, duplicatas, mudanças de índices e várias identidades.
- **Perfis e shortcuts por mouse:** determinar como evitar que o `profiles` global sobreviva ao REMOVE e seja automaticamente reaplicado ao mouse reemparelhado, sem destruir a personalização de outros dispositivos. Se a correção requer persistência bond-scoped, planejar esquema de registros e carregamento/ativação por conexão, troca de mouse e reconexão. Não zerar o registro global compartilhado indiscriminadamente.
- **Migração segura:** registros v3.x existentes precisam continuar legíveis. Definir política explícita de conversão de perfis antigos globais para dispositivos já salvos, sem vazar configurações para futuros bonds; preservar as configurações existentes sempre que possível. Em caso de falta de capacidade ou dado desconhecido/corrupto, não sobrescrever registros indiscriminadamente. Planejar eventual rollback e atualização de schema só após aprovação técnica.
- **Exclusão lógica completa e confiável:** coordenar exclusão de perfis/atalhos/drafts por identidade, movimentos, nomes, credenciais, resolving list e cache em RAM. Mensagem `SAVED_MOUSE_REMOVED` só pode sinalizar conclusão comprovada; se alguma gravação falhar, retornar `SAVED_MOUSE_REMOVE_FAILED`, preservar/reconciliar estado e permitir retry idempotente. Considerar tombstone/fase de commit para queda de energia entre operações, sem perder outros bonds.
- **Sessão ativa:** se remover o mouse conectado, desconectar primeiro, neutralizar Mouse/Keyboard/Consumer, Modifier e movimentos pendentes, atualizar UX e recomeçar descoberta conforme fluxo; nunca reproduzir eventos da sessão excluída.
- **Recadastro do mesmo mouse:** um Pair New efetivo após remoção precisa receber defaults de perfil, remap, shortcuts e Movement. A troca para outro mouse previamente salvo deve restaurar os dados **dele**, não os do excluído.
- **Sem rastros funcionais:** nenhum registro ativo, cache, identidade resolvível ou perfil anterior pode ser recuperado por reconectar/reparear/reboot. Apagamento físico forense de bytes residuais em flash (wear-leveling/BTstack TLV) não é requisito implícito nem deve ser prometido sem análise separada.

## Matriz mínima de testes host e físicos (iniciar desde HOME CONNECTED)

| Cenário | Resultado obrigatório |
|---|---|
| Um mouse CUSTOM com atalhos, Modifier, DPI/Rotation personalizados é removido, desligado, reemparelhado | Emparelha como novo; PASSTHROUGH + botões originais, atalhos/Modifier inativos ou em defaults, DPI/Rotation padrão |
| Reboot após remover, antes de reparear | Nenhum bond/nome/perfil/Movement acessível do excluído |
| Reboot após reparear | Defaults persistem até o operador modificar, sem ressurreição de configuração antiga |
| Dois ou mais mouses, personalizações distintas | Remover A não altera B nem C; reconectar B recupera seu próprio perfil e movimento; reparear A recebe defaults |
| Remover mouse ativo / remover mouse inativo | Fluxos seguros; HID neutralizado quando necessário; UI e página corretas |
| Falha de gravação TLV/flash, reset no meio da exclusão e retry | Não publicar exclusão falsa, nunca reaplicar perfil eliminado; estado recuperável/idempotente |
| IRK/RPA, bond duplicado e ordinais reciclados | Apagar somente identidade selecionada, inclusive equivalentes, sem tocar outros |
| Voltar com KEY B/Help/Lock antes de confirmar REMOVE | Nenhum dado apagado; a exclusão ocorre apenas após confirmação |
| Operações de perfil sem remoção | 30 shortcuts/12 combinações, remap, Modifier, defaults, migração v2/v3 e UX 9×21 preservados |

## Gates de execução e publicação

1. Registrar evidências e baseline em `executions/MNT-10/pre-implementation.md`; confirmar causa reproduzível e inventariar exatamente quais registros são globais ou bond-scoped. Fechar decisão de arquitetura e SemVer antes de mudar persistência.
2. Implementar **somente MNT-10** numa branch derivada da tag oficial; acrescentar testes de exclusão, isolamento de bonds, migração e recuperação de falhas, além de manter todas as regressões host existentes. PR draft.
3. Build de produção Pico 2 W; extrair UF2 de GitHub Actions, conferir SHA-256 com o log e disponibilizar candidato para testes físicos desde HOME CONNECTED; documentar `candidate.md` e `physical-acceptance.md`.
4. **Somente após aceite físico explícito do operador**, atualizar a versão 3.x, executar CI versionada, mesclar e publicar release único com UF2 + SHA256SUMS. Se testes falharem, corrigir na mesma branch e refazer candidato. MNT-11 só começa após publicação verificada.

**Implementação candidata concluída**, pendente dos cenários em [physical-acceptance.md](../executions/MNT-10/physical-acceptance.md). A CI valida código e compilação, mas **não prova o funcionamento físico de flash/LE**; não publicar ou mesclar sem aceite.
