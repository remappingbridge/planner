# MNT-10 — candidato funcional para teste físico

**STATUS: IMPLEMENTADO EM BRANCH, CI COMPLETA, UF2 GERADO E SHA CONFERIDO. ACEITE FÍSICO PENDING.** Nenhum merge/release do MNT-10.

- Base oficial: tag **v3.1.4**, SHA `9efaaaa17b5ab94a9b28927460fd5720787a74dc`.
- Branch: `maintenance/v3x-mnt-10`, candidato HEAD **`a4c2bd9e45f08ec748cc40a6281a18b3e11b8ace`**.
- [PR #40 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/40), não mesclado.
- [CI canônica #526](https://github.com/remappingbridge/remappingbridge/actions/runs/38190069355): **host 92/92 testes PASS**, **Pico 2 W produção SUCCESS**.
- Artifact GitHub Actions `11721202666`, `blu2usb-picow-production-pico2w` (digest do ZIP: SHA256 `c60fb656d0fa228d46411c813880aadaf207c133c7ca6a51364b9add1ae75721`).
- Firmware extraído do artefato oficial: **`remappingbridge-mnt10-pico2w.uf2`**, **952.320 bytes**, SHA256 **`3f73e648134eb613b067f25eb34a4f9a21bf0a2abb029919ad73ec0ad7826dc7`**. Hash aferido no arquivo extraído e comparado literalmente com o SHA no log de produção GitHub Actions #526.
- Versão interna do candidato **3.1.4**, não v3.2.0; MINOR **v3.2.0** previsto somente após teste físico e aceite explícito.

## Implementação incluída

1. TLV `B2PF` para até oito perfis associados às identidades BLE canônicas (address/type/IRK, nunca índice/página), payload de perfil v3 de 26 bytes, contendo perfil, remap, rascunho, Modifier, 12 shortcuts.
2. Bootstrap migra **uma única vez** o perfil global legado aos bonds preexistentes antes de scan/reconexão. Mesmo uma tabela vazia grava marcador para impedir um pareamento futuro de herdar perfil legado. O registro global anterior continua preservado em flash **somente para retrocompatibilidade/migração**, mas não é usado para o novo mouse.
3. A cada conexão e handoff de Pair New, o firmware restaura o perfil daquela identidade ou defaults completos de mouse novo, atualizando remap/HID/shortcuts/UI. Ao desconectar, neutraliza sessão e volta ao default em memória.
4. SAVED DEVICES mostra o perfil efetivo de cada mouse salvo, em vez de refletir sempre o perfil ativo global. Movement continua separado por identidade; títulos e cores preservados.
5. Remoção apaga perfis, movimentos, nomes e bonds por identidade, conferindo retorno de escrita TLV e ausência final de bonds equivalentes antes de anunciar `SAVED_MOUSE_REMOVED`; snapshots em RAM são restaurados em falha de store. Nomes/Movement duplicados por mesma identidade são limpos conjuntamente.
6. Mantidas interfaces USB HID, características Bluetooth, 9×21 e atalhos disponíveis; novos contratos host `mnt10_bond_scoped_profile_purge_source` e `mnt10_saved_devices_own_profile_by_bond`.

## Limites do candidato

**CI não comprova comportamento de flash real, reconexão ou resiliência a falha de energia.** Exige teste físico com dois mouses e reboot antes/depois da remoção, roteiro em [physical-acceptance.md](physical-acceptance.md). Como o legado v3.1.4 tem um **único** perfil global, não é possível reconstruir retroativamente diferenças por mouse que jamais foram salvas separadamente; o bootstrap copia o valor global existente para cada bond antigo, que passa a ser independente depois.

O legado global preservado é um registro histórico inativo; **não se afirma apagamento físico forense de bytes antigos em flash**. Tombstones multi-TLV e testes reais de falha de energia devem ser avaliados posteriormente caso o operador requeira garantia de transação multi-tag além do caminho de sucesso/falha reportada.

**Gate MNT-10 não aceito e sem publicação.**
