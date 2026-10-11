# MOV-04 — Vertical Slow DPI | Candidato de testes

**Status:** host CI **51/51 PASS**, firmware Pico 2 W no CI, aceite físico **PENDING**.

Fonte: `remappingbridge/remappingbridge` `feature/movement-options-v1.0`, SHA `036e5bd930b11b3c79ceeac6332dac7c21844d57`.
PR: https://github.com/remappingbridge/remappingbridge/pull/22
CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38097344728

Mudanças em relação ao MOV-03 aceito:
- A tela Vertical Slow e sua lógica já pertenciam à branch de implementação integrada anterior. Neste gate foi acrescentado `tests/test_mov04_vertical_slow.c` e registro no CMake para validar especificamente a rota de HOME, apresentação, Up/Down wrap, candidato vs atual, Help e cancelamento, aplicação transacional exclusiva de V e escala fracionária em USB.
- Teste de 0.25× confirma que quatro deslocamentos de um passo geram a quantidade exata de contagens correspondentes, sem descartar frações. Também testa combinação H=2× e rotação 270° sem alterar H/rotação ao mudar V.
- A navegação do produto existente reinicia seleção do menu pai em HORIZONTAL ao voltar, logo testes e roteiro mostram nova seleção da opção VERTICAL.
- Gates MOV-01/02/03 aceitos pelo usuário. MOV-04 ainda não aceito.

Comprovação de build host: 51 de 51 testes CTest aprovados no SHA acima. Registrar artefato, tamanho e hash UF2 após sucesso do job `pico2-w-production` para o mesmo SHA; o firmware antigo não serve de candidato para este gate.

Roteiro físico: `physical-acceptance.md` nesta pasta.
