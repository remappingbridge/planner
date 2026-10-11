# MOV-08 — Saved Devices | Testes físicos

**Status: PENDING — aguardando confirmação do operador.**

**Preparação:** deixar dois ou três mouses pareados, com configurações distintas para cada mouse. Testar a partir da `home-connected`. Se houver apenas um mouse, a verificação de paginação e isolamento permanece pendente até existir outro dispositivo.

1. Acessar HOME → `SAVED DEVICES` (terceira opção). O mouse conectado deve aparecer em `1 OF N` com nome próprio e as linhas `PROFILE`, `DPI: H ... - V ...` e `ROTATION: ... DEGREE`.
2. No mouse ativo, somente as letras do **nome** ficam em **ciano**. Contador `1 OF N`, PROFILE, DPI, ROTATION, `REMOVE DEVICE` e as legendas devem ficar em **amarelo padrão do sistema**. Nem mesmo os valores numéricos de DPI/Rotation podem ficar em ciano.
3. Pressionar JOY RIGHT/LEFT e soltar: a página avança/retrocede com wrap, sem alterar as configurações. Nas páginas dos mouses **inativos**, inclusive o nome, **todo o texto é amarelo**. Confirmar que pressionar um controle enquanto a tela está aberta não cria linhas brancas adicionais.
4. Configurar, por exemplo, mouse A com `H=2X / V=0.75X / ROT=270` e mouse B com `H=0.5X / V=3X / ROT=90`; acessar a página de cada um e conferir que os valores não se misturam. O campo `PROFILE` reflete o **perfil global de remap atualmente ativo** (não um histórico específico por mouse).
5. Desligar mouse A, deixar B conectar. A página `1 OF N` deve passar a mostrar B, com **somente o nome de B** ciano, sem apagar os valores salvos de A. Navegar até A e verificar seus valores, todos os textos amarelos.
6. Desligar ambos, verificar que nenhum nome permanece em ciano. Reiniciar Pico 2 W sem apagar bonds, reconectar A e B alternadamente, confirmar os valores persistidos de cada um após reboot.
7. Para um mouse salvo **inativo**, escolher sua página e pressionar JOY PRESS: a tela de confirmação de remoção deve identificar **esse mesmo mouse**, nunca outro. Voltar com KEY B **sem remover** e conferir retorno à página. Exclusão propriamente dita é exclusiva do MOV-09.
8. Verificar nomes muito longos (sem ultrapassar 21 colunas), clique, wheel, pan e remapping funcionando normalmente. Voltar para HOME com KEY B.

Registrar resultado PASS/FAIL, hash UF2, modelo dos mouses, comportamento observado e eventuais problemas. CI automático e testes de renderização não substituem esse aceite. MOV-09 e MOV-10 permanecem pendentes.
