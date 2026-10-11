# 05 — Dados persistentes, migração v2→proposta e rollback

## Contexto real
- v2.0.0 mantém **um perfil de remapeamento GLOBAL** em armazenamento de produto de dois slots; `src/profiles/profiles.c` usa 14 bytes de payload, `PROFILE_SCHEMA_VERSION=2`, com ativo + 5 custom targets + 5 draft targets + checksum.
- `BLU2USB_STORAGE_MAX_PAYLOAD_SIZE=64`, record de 80 bytes, com geração/seleção/validação de dois slots e confirmação após flash write.
- Bond BLE, nome salvo e movimento por Mouse vivem em persistência distinta. Atualização por UF2 deve preservar TODOS eles.

## Modelo proposto
Persistir globalmente, na mesma transação:
`active_profile (PASSTHROUGH|CUSTOM), custom_targets[5], draft_targets[5], draft_valid, shortcuts[12], schema_version, checksum`.
Cada `shortcuts[i]` é ID 0..30 (0=NOT CUSTOMIZED). Os 12 slots ficam válidos com ModifierSource=NONE e não mudam quando se alterna Passthrough/Custom. Um só Custom target poderá ser MODIFIER. Nenhum `UNAVAILABLE` é escrito: é `slot==modifierSource` derivado no snapshot/renderização.

**Exemplo de envelope lógico v3**: 1 byte version + 1 ativo + 1 draftValid + 5 targets + 5 draftTargets + 12 shortcutIds + 1 checksum = **26 bytes**, dentro de 64. Definir layout binário real com offsets estáveis, versão e CRC, teste de roundtrip/corruptela antes de implementar. Não confundir ID interno antigo `ESCAPE=5` com o novo target MODIFIER; valor serial novo e explícito (por exemplo, 6) para impedir conversão silenciosa.

## Migração in-place (antes de emitir outputs)
1. Ler record mais recente válido dos dois slots. Reconhecer v2, v3 ou falta/corrupção; ler 14 bytes v2 **sem exigir** comprimento v3.
2. v3 válido: restaurar, validar IDs, target exclusivo e hashes; se inválido, adotar estratégia de recuperação segura documentada sem gravar defaults por cima de record potencialmente recuperável.
3. v2 válido: copiar custom/draft/mapeamentos não aposentados, criar 12 slots NONE, remover do domínio **Standard** e **Escape**. Política proposta para ativo removido: fallback para **PASSTHROUGH** (nunca manter perfil inacessível); ativo Custom continua Custom se válido.
4. Para targets Custom/draft antigos `ESCAPE`, **não convertê-los automaticamente para MODIFIER**, pois isso mudaria a função física sem consentimento. Fallback proposto: target identidade do source (LEFT→LEFT etc.). Registrar esse comportamento como **migração com mudança visível** a ser aprovado em MOD-00.
5. Serializar **uma só vez** v3 e persistir pelo mecanismo atômico existente (slot secundário + leitura de verificação). Só depois atualizar estado ativo de runtime/UI. Se write falhar, manter interpretação v2 apenas em RAM com funções seguras; não declarar migração concluída.
6. Snapshot de UI não deve mostrar shortcut aplicado em flash quando escrita falhou. `KEY A APPLY/RESET` confirma sucesso antes de navegar/alterar o valor.
7. Não tocar nas credenciais BLE, no saved-name registry ou no Movement Settings TLV. Remover Mouse não apaga assignments globais, porque se referem ao produto/perfil global.

## Rollback / downgrade
- A tag v2.0.0 não entende schema v3: **downgrade pode restaurar os defaults do perfil global**, ainda que bonds e movement estejam intactos. Declarar o risco e ensaiar downgrade controlado antes de distribuição.
- Não apagar flash para instalar `.uf2`. Não usar `flash_nuke` como caminho normal. Uma eventual rota de exportação/backup de configuração deve respeitar a regra sem USB debug.
- Migrar do formato antigo não deve reativar Standard/Escape escondidos, reutilizar números de enum sem auditoria ou transformar slot lógico de Mouse em índice persistente.
- Persistir profile edit, assignment, reset, source MODIFIER e dados v3 com integridade de geração/CRC; injetar falha de write, queda de energia entre slots, dado truncado, versão desconhecida e reboot.

## Cenários obrigatórios
A. Dispositivo v2 com active=PASSTHROUGH, Custom normal, nenhum Escape no Custom → v3 equivalente e 12 NONE.
B. Dispositivo v2 com active=STANDARD ou ESCAPE → fallback documentado e HOME/PROFILE coerentes.
C. Dispositivo v2 Custom/draft com target ESCAPE → fallback identidade aprovado, sem MODIFIER involuntário.
D. v3 Custom com Modifier LEFT e atalho COPY em `MOD+LEFT`: valor guardado, aparece UNAVAILABLE e não dispara; trocar Modifier para RIGHT libera COPY em LEFT sem perda do slot; ao resetar LEFT, guarda NONE.
E. Sem botão Modifier ativo: configurar, rebootar, reler 12 slots, ativar Modifier e verificar disparo.
F. Falha de gravação em `APPLY AND BACK` ou `RESET SELECTED`: UI e runtime mantêm último commit aceito.
G. Repetição de reboot, reconexão, troca de Mouse, remoção de bond: assignments e profile globais preservados; Movement per-Mouse não é sobrescrito.
