# MNT-13 — roteiro de aceite físico (Pico 2 W, LCD 9×21)

**STATUS: PENDING** — implementação candidata na branch `maintenance/v3x-mnt-13`, [PR #43 DRAFT](https://github.com/remappingbridge/remappingbridge/pull/43). O operador ainda não executou/aceitou os cenários. Versão interna permanece `v3.2.2` até aceite.

## Preparação segura

- Separar o UF2 candidato da execução oficial de CI e conferir o hash SHA-256 indicado em `candidate.md`; guardar também um UF2 estável de `v3.2.2` para reversão.
- Ligar/desconectar Pico 2 W pelo procedimento normal BOOTSEL, copiar o UF2 novo. **Não executar `flash_nuke` nem factory reset**: preservar dados de mouse, bonds, atalhos e Movement.
- Iniciar o ensaio **em HOME CONNECTED**, com o mouse conectado. O marcador é o caractere **`|` na coluna 1 física** (índice 0 do frame). Deve aparecer **exatamente uma vez** quando a tela oferece opções navegáveis, no tom da opção focada, sem retirar/cortar letras.

## Cenários sequenciais

1. **HOME CONNECTED** — navegar JOY UP/DOWN entre as quatro entradas. Verificar que o pipe se desloca entre linhas 2..5 visuais (índices 1..4) e só a opção em foco tem `|`. Voltar do Help e conferir posição restaurada.
2. **REMAPPING OPTIONS** — navegar pelas três opções. O pipe segue foco, mesmo quando `CUSTOM REMAPPING` é CURRENT em ciano ou `MODIFIER SHORTCUTS` está ciano por CUSTOM+Modifier aplicado. Verificar ciano claro do pipe apenas quando a opção focada é CURRENT; fora de foco, CURRENT permanece ciano sem pipe.
3. **EDIT CUSTOM REMAP** — percorrer cinco botões LEFT/RIGHT/MIDDLE/FORWARD/BACKWARD. Depois abrir cada uma das cinco telas `WILL BECOME` e percorrer os seis destinos. O pipe não significa destino salvo; textos e cores do destino salvo devem permanecer.
4. **MOVEMENT OPTIONS** — percorrer HORIZONTAL (linha índice 1), VERTICAL (índice 2), ROTATION (índice **4**). Confirmar **nenhum pipe em COUNTERCLOCKWISE** (índice 3). Navegar HORIZONTAL/VERTICAL SLOW e FAST DPI (quatro opções por página) e ROTATION (0, 90, 180, 270), sempre com um único pipe acompanhando foco e sem afetar CURRENT.
5. **COMBINATIONS 1..6** — em cada página, percorrer os dois pares. O pipe aparece **somente na segunda linha da opção (valor/status, índice 2 ou 4)**, jamais nos rótulos 1/3. Confirmar `|NOT CUSTOMIZED`, `|PASTE` (ou atalho atribuído) e `|UNAVAILABLE` conforme foco. O rótulo selecionado continua branco; valores atribuídos seguem os tons de MNT-12, e `UNAVAILABLE` permanece STATIC com pipe de foco branco.
6. **SHORTCUTS 1..5** — percorrer todos os 30 atalhos. Para um já aplicado, conferir que o pipe acompanha o **foco**, não a linha ciano da atribuição salva. Navegar entre páginas, usar BACK e retornar sem pipe fantasma.
7. **SAVED DEVICES** — com pelo menos um mouse salvo, deve haver `|REMOVE DEVICE` na sexta linha visual (índice 5), independentemente de nome do mouse e paginação LEFT/RIGHT. Nome, PROFILE, DPI e ROTATION não têm pipe. Com nenhum bond salvo (somente caso o dispositivo de teste esteja sem bonds), `REMOVE DEVICE` fica cinza, **sem pipe**. **Não apagar bonds reais apenas para testar o caso vazio.**
8. **Telas sem lista** — entrar em Help, PAIR NEW, RETRY PAIR NEW, REMOVE THIS, APPLY PASSTHROUGH, PASSTHROUGH APPLIED, FIRST MOUSE/SEARCHING FIRST quando disponíveis. Confirmar ausência de pipe nos títulos, status, instruções e dicas KEY/JOY; KEY A/B/X/Y continuam as ações normais.
9. **Troca de estado** — JOY UP/DOWN, páginas, Help/BACK, bloquear/desbloquear, troca de mouse/perfil e reboot. Em cada novo frame deve haver só o pipe correspondente à tela/foco atual, sem resíduo na linha anterior.
10. **Regressões** — confirmar USB HID Mouse/Keyboard/Consumer, navegação, duas interfaces USB, 12 combinações, 30 atalhos, Movement, perfis/bonds por mouse e estados ciano de MNT-08 e MNT-12 sem regressão.

## Evidência e aceite

- [ ] C1 HOME e Help/Back
- [ ] C2 REMAPPING e foco versus CURRENT
- [ ] C3 EDIT e cinco WILL BECOME
- [ ] C4 MOVEMENT, quatro DPI e ROTATION
- [ ] C5 seis páginas COMBINATIONS
- [ ] C6 cinco páginas SHORTCUTS
- [ ] C7 SAVED DEVICES com bond; sem bond quando disponível
- [ ] C8 ausência de pipe nas telas sem lista
- [ ] C9 sem ghosting após navegação/troca/reboot
- [ ] C10 regressões físicas e cores

**ACEITE FÍSICO: PENDING.** Registrar PASS/FAIL por cenário apenas após observação. Qualquer falha requer correção na mesma branch e revalidação do novo UF2. **Sem merge, tag ou release antes de `gate aceito`.**
