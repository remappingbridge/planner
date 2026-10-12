# MNT-12 — cenários de validação física (LCD Pico 2 W)

**STATUS: CANDIDATO A TESTE / FÍSICO PENDING.** Somente o operador pode aceitar o firmware. Versão interna ainda v3.2.1 até aceite; branch `maintenance/v3x-mnt-12`, PR [#42](https://github.com/remappingbridge/remappingbridge/pull/42).

## Instalação e preparação

- Gravar **UF2 do candidato disponibilizado após CI** por BOOTSEL, **sem `flash_nuke`** para preservar bonds, perfis, Modifier, shortcuts e Movement da v3.2.1. Registrar qual mouse está conectado e guardar o UF2 estável para recuperação se necessário.
- Partir de **HOME CONNECTED → REMAPPING OPTIONS**. Utilizar joystick para seleção, botão de aplicar apropriado e BACK/Help/Lock normalmente.
- Para comparar, usar uma combinação (por exemplo `MODIFIER RELEASED IS → ESCAPE`) e outra (por exemplo `MOD + RIGHT CLICK IS → PASTE`). Também manter alguma **NOT CUSTOMIZED**. Se LEFT for a fonte Modifier, `MOD + LEFT CLICK IS` estará **UNAVAILABLE**; este é o resultado esperado.
- O tom **ciano normal** corresponde a `0x07FF`; o **ciano claro** quando item ciano está selecionado corresponde a `0xD7FF`. Cinza/branco continuam usados para itens não ciano.

## Cenários em sequência

1. **PASSTHROUGH sem Modifier** — em `REMAPPING OPTIONS`, item `MODIFIER SHORTCUTS` **cinza** sem seleção e **branco** selecionado. Em `COMBINATIONS`, valores atribuídos seguem cinza/branco, sem ciano.
2. **PASSTHROUGH com Custom salvo que possui Modifier** — configurar/aplicar CUSTOM com um botão Modifier; depois aplicar PASSTHROUGH, sem apagar Custom. Confirmar **ausência de ciano** em `MODIFIER SHORTCUTS` e valores de combinações, apesar de o Modifier permanecer salvo.
3. **CUSTOM sem Modifier** — editar/aplicar CUSTOM em que nenhum botão seja Modifier. Confirmar **ausência de ciano** em `MODIFIER SHORTCUTS` e valores de combinações.
4. **CUSTOM com Modifier** — configurar/aplicar pelo menos um botão Modifier. Em `REMAPPING OPTIONS`, `MODIFIER SHORTCUTS` deve estar em **ciano normal** se não selecionado e em **ciano clarinho** se selecionado. `PASSTHROUGH DEFAULT` e `CUSTOM REMAPPING` preservam as cores atuais.
5. **COMBINATIONS 1 OF 6** — com CUSTOM+Modifier efetivamente ativos, verificar valor `ESCAPE` (ou outro shortcut atribuído) **ciano normal** não selecionado, **ciano claro** quando selecionado. O texto `MODIFIER RELEASED IS` fica **cinza/branco como antes**. `NOT CUSTOMIZED` mantém seu próprio cinza/branco.
6. **COMBINATIONS 2 OF 6** — se LEFT é Modifier, `UNAVAILABLE` de `MOD + LEFT CLICK IS` **mantém a cor original inclusive selecionado**. `PASTE` (ou outro shortcut atribuído e disponível em `MOD + RIGHT CLICK IS`) fica **ciano normal/claro** conforme foco; seu rótulo permanece cinza/branco.
7. **COMBINATIONS 3..6 OF 6** — navegar todas as páginas. Somente **linha 2/4 do valor de atalho atribuído e disponível** ganha ciano. Linhas 1/3 de `MOD + ... IS`, títulos e hints nunca ganham novo ciano. Foco no par altera só valor de ciano para **ciano claro**; rótulo mantém **branco**, como antes.
8. **Reset de combinação** — selecionar um atalho atribuído, usar KEY A RESET SELECTED e conferir que `NOT CUSTOMIZED` retoma cor atual (branco se selecionado, cinza se não). Atribuir de novo e conferir ciano quando CUSTOM+Modifier ativo.
9. **Aplicação vs. rascunho** — com CUSTOM+Modifier aplicado, editar Custom para retirar Modifier mas **não aplicar**; indicador continua refletindo configuração aplicada. Aplicar alterações: ciano desaparece. Fazer inverso de um draft contendo Modifier e aplicar: ciano aparece **somente após aplicação**.
10. **Mudança de perfil/mouse e reboot** — alternar CUSTOM→PASSTHROUGH→CUSTOM, verificar sumiço/retorno do ciano sem resíduo. Alternar para outro mouse salvo com perfil/Modifier diferente, confirmar indicador correspondente ao **mouse conectado**, sem herança do anterior. Reiniciar sem apagar flash e confirmar persistência do estado.
11. **Regressões** — Help/Back/Lock, telas SHORTCUTS, Saved Devices, Movement DPI/Rotation, 12 combinações/30 atalhos, Mouse/Keyboard/Consumer USB HID e botões continuam funcionais e com a mesma semântica.

## Registro do aceite

- [ ] Cenários 1–3 — ciano ausente em estados inativos
- [ ] Cenário 4 — ciano comum + ciano claro em MODIFIER SHORTCUTS
- [ ] Cenários 5–7 — valores corretos em todas as páginas, rótulos preservados
- [ ] Cenário 8 — NOT CUSTOMIZED e UNAVAILABLE preservados
- [ ] Cenários 9–10 — aplicado vs draft, perfil/mouse/reboot
- [ ] Cenário 11 — regressões sem falha

**ACEITE FÍSICO: PENDING.** Não assumir execução dos cenários antes do relato do operador. Se algo falhar, corrigir **na mesma branch**, refazer CI/UF2 e repetir os cenários; não lançar patch ainda.
