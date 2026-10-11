# MOV-06 — Rotation | Candidato para teste físico

**Status:** host CI **53/53 PASS**, Pico 2 W **UF2 PASS**, aceite físico **PENDING**.

Código: `remappingbridge/remappingbridge`, branch `feature/movement-options-v1.0`.
Commit: `e6834c3bc1a28b3ce20f0e6c192d15ba65daf5f5`.
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098014017
PR Draft: https://github.com/remappingbridge/remappingbridge/pull/22

## Escopo do gate
ROTATION era uma das telas já integradas no firmware validado anteriormente; neste gate foi produzido o teste dedicado `tests/test_mov06_rotation.c`, com registro no CMake, preservando a semântica de `KEY A: APPLY AND BACK` aprovada pelo operador. Testa:
- Fluxo real HOME CONNECTED → MOVEMENT OPTIONS → ROTATION (terceira opção);
- 9×21 caracteres e dicas corretas, 0/90/180/270, wrap e interação no release;
- Ciano do ângulo aplicado e branco da seleção; KEY B cancela e Help KEY X/KEY Y preserva seleção sem bloquear;
- KEY A emite intenção, porém não atualiza estado antes do ACK persistente; RESET ALL atômico;
- Transformação vetorial no espaço USB: 0 (x,y); 90 (y,-x); 180 (-x,-y); 270 (-y,x);
- H=2×, V=1×, rotação 270° => (-2y,x), elipse horizontal; H/V independentes de ângulo; passos fracionários e drenagem de deltas > signed int8;
- Confirma que outros gates continuam testados na suíte existente.

Host CTest: **53/53 PASS**, source SHA acima. Pico 2 W production build/UF2 verification PASS. Artifact `11686117401` (`blu2usb-picow-production-pico2w`), UF2 de **925.696 bytes**, 1.808 blocos, SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`. O ZIP do GitHub Actions foi extraído e os blocos UF2 verificados. O binário é **idêntico byte por byte** ao UF2 MOV-05 aceito; nenhuma gravação adicional é necessária se o dispositivo permanece com MOV-05.

O operador **ainda não aceitou MOV-06 fisicamente**. Cenários em `physical-acceptance.md`; gates MOV-07–MOV-10 não aprovados.
