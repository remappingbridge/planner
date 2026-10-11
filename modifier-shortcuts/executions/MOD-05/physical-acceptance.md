# MOD-05 — Testes físicos do Modifier: Escape e Copy

**Status: PENDENTE DE ACEITE FÍSICO.** Não iniciar MOD-06. Partir sempre da HOME com Mouse BLE salvo conectado e Pico 2 W em USB de um desktop Linux. O [candidato](candidate.md) está validado: CI **68/68 PASS**, Pico 2 W production **PASS**, SHA256 do UF2 **`8f1015d2081c83707ee33f524478cbef98780dee32e4a0fd46e43af6ebbaa3ad`**, 939008 bytes, [artifact 11704924925](https://github.com/remappingbridge/remappingbridge/actions/runs/38147899079/artifacts/11704924925).

1. [ ] Gravar UF2 MOD-05 em BOOTSEL **sem flash_nuke**; confirmar reconexão do mouse, Saved Devices, H/V DPI e rotação.
2. [ ] HOME → REMAPPING OPTIONS → CUSTOM REMAPPING → LEFT WILL BECOME → MODIFIER → KEY A; voltar a EDIT CUSTOM REMAP, confirmar LEFT IS MODIFIER, e KEY A APPLY CUSTOM.
3. [ ] HOME → REMAPPING OPTIONS → MODIFIER SHORTCUTS → COMBINATIONS 1 OF 6 → MODIFIER RELEASED IS → JOY PRESS; SHORTCUTS 7-12 OF 30 → ESCAPE → KEY A APPLY AND BACK. Verificar ESCAPE salvo.
4. [ ] COMBINATIONS 2 OF 6 → MOD + RIGHT CLICK IS → JOY PRESS → SHORTCUTS 1-6 OF 30 → COPY → KEY A APPLY AND BACK. Confirmar COPY salvo; LEFT ainda UNAVAILABLE.
5. [ ] Com Custom aplicado, abrir um menu/diálogo que Escape fecha. Apertar e soltar LEFT sozinho: emitir **um** ESCAPE real; segurá-lo não repete e não produz clique LEFT.
6. [ ] Num editor Linux, selecionar texto. Manter LEFT pressionado, pressionar e soltar RIGHT uma vez, soltar LEFT. Colar normalmente (Ctrl+V): seleção copiada corretamente. Sem menu de contexto de RIGHT, e sem Escape extra.
7. [ ] Repetir invertendo ordem de liberação: LEFT+RIGHT down → LEFT up → RIGHT up. Sem liberar clique RIGHT residual, sem Escape adicional; Copy único.
8. [ ] Com LEFT mantido, pressionar botão secundário **sem atribuição**: sua ação Custom habitual acontece, mas liberar LEFT **não** dispara Escape.
9. [ ] Aplicar PASSTHROUGH: LEFT/RIGHT click habituais, nenhuma ação sintética; voltar a CUSTOM e testar novamente Escape e Copy.
10. [ ] Reiniciar Pico e reconectar Mouse salvo: atalhos persistem e funcionam. Verificar Saved Devices (só nome ativo ciano), rotation/DPI e lock Y/unlock HOME.
11. [ ] Desconectar/reconectar USB em ambiente controlado, trocar perfil ou desconectar BLE após combinação: nenhuma tecla Ctrl, C ou Escape permanece presa. Registre se não for possível simular USB ocupado.
12. [ ] Configurar outro ID ainda não implementado (ex.: PLAY/PAUSE): não deverá disparar falsamente COPY/Escape. Movimento e wheel sem implementação de atalhos até MOD-06.

**Saída:** decisão do operador, não inferir aceite de CI. MOD-05 contém apenas ação Keyboard ID=1 COPY e ID=7 ESCAPE, com confirmação USB de down/up, sem alterações de descritor ou Consumer HID.
