# MOV-04 — Vertical Slow DPI | Candidato de testes

**Status:** host CI **51/51 PASS**, Pico 2 W UF2 **PASS**, aceite físico **PENDING**.

Fonte: `remappingbridge/remappingbridge` `feature/movement-options-v1.0`, SHA `036e5bd930b11b3c79ceeac6332dac7c21844d57`.
PR: https://github.com/remappingbridge/remappingbridge/pull/22
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38097344728

Mudanças em relação ao MOV-03 aceito:
- A tela Vertical Slow e sua lógica já pertenciam à branch de implementação integrada anterior. Neste gate foi acrescentado `tests/test_mov04_vertical_slow.c` e registro no CMake para validar especificamente a rota de HOME, apresentação, Up/Down wrap, candidato vs atual, Help e cancelamento, aplicação transacional exclusiva de V e escala fracionária em USB.
- Teste de 0.25× confirma que quatro deslocamentos de um passo geram a quantidade exata de contagens correspondentes, sem descartar frações. Também testa combinação H=2× e rotação 270° sem alterar H/rotação ao mudar V.
- A navegação do produto existente reinicia seleção do menu pai em HORIZONTAL ao voltar, logo testes e roteiro mostram nova seleção da opção VERTICAL.
- Gates MOV-01/02/03 aceitos pelo usuário. MOV-04 ainda não aceito.

Comprovação de build host: 51 de 51 testes CTest aprovados no SHA acima. Build completo: host CI 51/51 PASS; Pico 2 W production build/verify/upload PASS. GitHub Actions artifact `11686156439` (blu2usb-picow-production-pico2w). UF2 extraído `blu2usb_picow.uf2` com **925696 bytes**, **1808 blocos UF2** e SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`. Family IDs RP2350: `0xe48bff57`, `0xe48bff59`.

**Importante:** UF2 MOV-04 resultou binariamente idêntico ao UF2 aceito no MOV-03 (mesmo SHA-256). A funcionalidade Vertical Slow já estava implementada no firmware integrado da branch anterior; neste gate foram acrescentados novos testes/validação do código existente, não modificações de runtime. O artefato foi recompilado pelo CI para o novo commit e está verificado. Ainda requer aceite específico do operador para MOV-04; não alegar firmware diferente.

Roteiro físico: `physical-acceptance.md` nesta pasta.
