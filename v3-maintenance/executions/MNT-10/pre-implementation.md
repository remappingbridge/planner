# MNT-10 — preflight de implementação (base v3.1.4)

**Em implementação; sem aceite físico e sem versão/release nova.** Base imutável: tag oficial `v3.1.4` do repositório remappingbridge/remappingbridge, commit `9efaaaa17b5ab94a9b28927460fd5720787a74dc`. Branch exclusiva `maintenance/v3x-mnt-10`; PR draft #40.

## Diagnóstico efetivo

- Até v3.1.4, `src/app/main.c` restaura e grava `blu2usb_profiles_t` no produto **globalmente** pelo `blu2usb_storage_load/store`. Inclui PASSTHROUGH/CUSTOM, mapeamentos, rascunhos, Modifier e 12 shortcuts. Comportamento não discrimina mouse; novo pareamento pode receber perfil de outro mouse, mesmo quando BLE apagou seu vínculo.
- `src/ble_hogp/ble_hogp_pico.c` já contém registro TLV por identidade para Movement e nomes e elimina bonds no caminho `complete_remove_target`, mas não podia remover registro global sem prejudicar outros dispositivos. Além disso, ignorava erro de gravação ao apagar nomes, e só removia uma entrada de Movement que pudesse corresponder à identidade.
- Identidade existente `bond_identity_equal`: IRK não nulo idêntico **ou** par tipo/endereço; ordinais dinâmicos de Saved Devices não devem indexar registros próprios.
- Esquema legado de perfis v3 usa 26 bytes com checksum, decoder seguro e migração v2. O produto grava em slots de flash próprios; não sobrescrever região legada até ser possível auditar conversão.

## Implementação prevista

- TLV novo separado, `B2PF` (`BLE_HOGP_PROFILE_TAG`) com versão e até oito registros com identidade (tipo/endereço/IRK) + payload de perfil v3 (26 bytes). Entrada vazia persistida como marcador de migração concluída, inclusive quando o firmware inicializa sem mouses salvos.
- **Migração uma única vez, antes de iniciar reconexão/scan BTstack:** associar o único perfil global v3 anterior aos bonds que JÁ existiam naquele boot (é a melhor equivalência de estado compartilhado pré-migração); nenhuma nova identidade herda automaticamente o valor global. Não alterar payload flash legado.
- Depois da migração, gravações de perfil se fazem por identidade canônica do mouse corrente e com rollback em falha de TLV. Carregar/ativar perfil correto a cada conexão/promovido, ou aplicar defaults completos a identidades sem perfil. Desconexão neutraliza sessão e volta a defaults em memória até novo mouse.
- Remoção: apagar registro profile por identidade antes de Movement/nomes/bonds, validar resultado de cada escrita, preservar snapshots em RAM quando store falha, só publicar sucesso após todos os passos; outras identidades não mudam.
- **Não prometer erase forense:** os registros lógicos ativos são purgados. Interrupção de energia entre stores independentes requer estratégia de reexecução/recuperação explicitamente testada; inexistência de transação multi-TLV é risco conhecido.

## Contratos de validação

- Regression host CI, compilação Pico 2 W e controle de fontes para migração única, isolamento por IRK, default por novo pareamento, não publicação antecipada, falhas de escrita, 9×21, HID e UX.
- Teste físico com **pelo menos dois mouses com perfis distintos** é obrigatório para demonstrar preservação de B ao apagar A e novo A em defaults; reboot antes/depois.
- A introdução de armazenamento e perfis isolados por mouse é melhoria funcional compatível, cuja próxima versão prevista será **v3.2.0 (MINOR)** caso haja aceite físico; confirmar no release gate, sem v4.

**Status físico: PENDING.** Não publicar nem mesclar antes de aceite explícito.
