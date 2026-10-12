# MNT-10 — cenários de teste físico do candidato (v3.1.4 base)

**Status: PENDING, não aceito.** Este gate altera a persistência do firmware e tem risco funcional; **não faça `flash_nuke`**, pois apagaria artificialmente os vínculos e invalidaria o teste de migração. O teste real de dois mouses distintos é obrigatório; a CI não substitui validação Bluetooth e flash física.

## Preparação
Antes de instalar, registre os perfis, shortcuts, remaps, DPI e Rotation atuais de cada mouse (A e B), preferencialmente num checklist pessoal. Mantenha a possibilidade de recuperar o UF2 estável v3.1.4; instalar o firmware anterior após alterar esquema novo pode voltar a usar o perfil global legado — não presumir rollback de dados automático.

## Passos físicos (somente operador)

1. Pelo menos dois mouses A/B já associados. Antes do update, personalize A e confirme as configurações; B deve ter ajustes reconhecíveis, se já existiam. Instale UF2 candidato via BOOTSEL, sem reset de flash.
2. Com A e B ainda salvos, conectar A, abrir REMAPPING OPTIONS e verificar seu perfil migrado da v3.1.4. Desconectar A e conectar B, confirmar que ambos conservaram o estado que estava no registro global antes da migração. O legado era compartilhado, portanto não esperar configurações individuais diferentes antes de MNT-10.
3. Com A conectado, aplicar CUSTOM com algum botão remapeado e Modifier/shortcut; em MOVEMENT OPTIONS aplicar Horizontal/Vertical DPI e Rotation não padrão. Desconectar e conectar B, configurar **outro** perfil e movimentos. Voltar a A: configurações de A devem ser restauradas, sem vazar estado de B.
4. Abrir SAVED DEVICES, paginar até A e conferir nome, PROFILE e ajustes próprios de A. Paginar até B, conferir informações próprias de B. Não confundir mouse conectado com mouse mostrado na página.
5. Em SAVED DEVICES → REMOVE DEVICE → REMOVE THIS, selecionar A e confirmar remoção. A deve desaparecer da lista; B permanece. Não apagar B. Confirmar que os perfis/shortcuts e movimentos de B ainda funcionam.
6. Reiniciar o Pico 2 W. A não deve reconectar automaticamente como salvo; B deve manter suas personalizações e reestabelecer conexão como antes.
7. Parear **A novamente como novo dispositivo**. Deve iniciar **PASSTHROUGH DEFAULT**, botões originais, Custom/draft em defaults, Modifier desativado, nenhum dos 12 shortcuts herdado, DPI H/V 1x e Rotation 0°. Saved Devices deve mostrar seu novo registro, sem qualquer dado anterior do mouse A.
8. Reiniciar mais uma vez e reconectar A/B: A continua em defaults, B conserva suas configurações próprias. Alterar A agora não modifica B.
9. Repetir exclusão de B desconectado e de A conectado, inclusive casos com apenas um mouse salvo; conferir retorno da UI e ausência de cliques/atalhos HID presos. KEY B/Help/Y Lock antes da confirmação não devem apagar dados.

## Evidências e riscos

- Se surgir perfil velho após reparear, falha de vínculo/nome/movimento persistente, falha no boot ou perda de configuração de B, **não aceite** o gate: registre tela, mouse e sequência realizada, para correção na mesma branch.
- Falha deliberada de gravação e interrupção de energia no meio de operações são cenários automatizados/engenharia, **não recomendados manualmente** sem procedimento seguro. No estado candidato a confirmação requer que o BTstack complete perfil → Movement → nomes → remoção de bonds; falhas em TLV devem produzir evento de falha, não sucesso.
- Excluir lógica ativa não equivale a zerar fisicamente bytes antigos de setores de flash/wear leveling; secure erase forense não está declarado nem comprovado.

**Aceite global MNT-10:** PENDING. Versão de release proposta se aprovar **v3.2.0 (MINOR)** devido à nova arquitetura de perfis por mouse, sujeita ao commit/release efetivo.
