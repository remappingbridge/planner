# MOV-09 — Remove This Mouse | Aceite físico

**Status: PENDING — aguardando teste/aceite do operador.**

**Atenção:** este gate envolve exclusão **real** de pareamento e preferências daquele mouse. É necessário pareá-lo novamente após confirmar exclusão. Não execute `KEY A: REMOVE` se quiser manter esse pareamento.

1. Com dois ou mais mouses pareados, sendo um deles conectado, configure movimentos diferentes para cada um e anote os valores. Na HOME conectada, abra `SAVED DEVICES` e vá até a página de um mouse **inativo**.
2. Pressione `JOY PRESS`: `REMOVE THIS MOUSE` precisa mostrar o **nome correto do mouse inativo** e o aviso `SAVED PAIRING AND / PREFERENCES WILL / BE DELETED.`
3. Abra `KEY Y: HELP`; confirme `REMOVE MOUSE HELP`, `CUSTOM MOVEMENTS` e `ANY KEY: BACK`. Volte com KEY Y sem bloquear e sem modificar o alvo.
4. Pressione **KEY B: CANCEL**. Confirme retorno à mesma página do Saved Devices, sem apagar o mouse nem suas preferências.
5. Entre novamente na confirmação do mesmo mouse e pressione **KEY A: REMOVE** uma única vez. A exclusão só deve ser efetivada depois do processamento BLE. Pressionar KEY A repetidamente enquanto o pedido está pendente **não** pode excluir outro mouse. Não force desligamento durante a gravação.
6. Confirme que o mouse alvo desapareceu do inventário e não se reconecta automaticamente. Os outros mouses e respectivos DPI/Rotation permanecem. Confira cores de Saved Devices (apenas nome do conectado ciano).
7. Pareie novamente o mouse removido como novo dispositivo. Suas preferências de movimento devem estar em **H=1×, V=1×, Rotation=0°**; valores dos outros mouses preservados. Reinicie o Pico e valide novamente.
8. Se possível, repita com o **mouse atualmente conectado** como alvo. Confirme que ele é desconectado, removido e que a interface segue para Saved Devices ou para busca do primeiro mouse se não existir outro bond. Nenhum botão HID deve permanecer pressionado após a remoção.
9. Se algum pedido falhar, conferir que a UI volta a Saved Devices em vez de travar em pending e permite nova tentativa; o outro mouse e suas preferências devem permanecer intactos.

Registrar PASS/FAIL, SHA fonte/UF2, modelos e identities dos mouses, resultados e qualquer anomalia. **MOV-09 ainda não aceito por CI**. MOV-10 permanece não aceito.
