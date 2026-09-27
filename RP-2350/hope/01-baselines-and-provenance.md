# HOPE baselines and provenance

Status: **PINNED BEFORE HOPE-00**.

## BLU2USB baseline

Repositório: `remappingbridge/blu2usb`

Ref normativa:

~~~text
gate/g06-profiles-remap-logitech-hidpp
7eee024ad4ee726c5a85ffa2f32b9f47187878af
tree 3a92348b25112abf67a879307c2273a9b018bedd
~~~

Essa é a origem do “BLU2USB v0.6 / G06 aceito” usada pelo HOPE.

Não usar como baseline HOPE:

- `release/v0.6.1-first-start-ux`;
- `release/v0.6.2-home-state-ux`;
- `experimental/g06-mouse-ux-v1`;
- qualquer G07+;
- branches MUX;
- branches experimentais posteriores.

A existência dessas branches não altera o pin do programa.

## Mouse UI baseline

Repositório: `remappingbridge/mouse-ui`

Ref estável:

~~~text
release/ui-layout-v1.0
e8adad7919e931c92515bf655ef4050876a8e7a9
~~~

O release documenta como commit principal de comportamento:

~~~text
65c2040f71dd68bd054fc9c3aa24d47d53e58ead
Finalize mouse-ui layout and UX for v1.0
~~~

Documentos normativos para HOPE:

- `docs/product/ui-layout-v1.0.md`;
- `docs/architecture/ui-layout-v1.0.md` somente para entender a origem das regras, nunca para importar arquitetura;
- `docs/spec/` para detalhe tela a tela;
- goldens/testes apenas como evidência para copy/geometria/comportamento observável.

## Destino antes do HOPE-00

Repositório: `remappingbridge/remappingbridge`

Estado inicial:

~~~text
main
4a562da54eed22f4987b9b869209dcf44e1e0023
tree 4d334a6e3bcb0e565317415c3e455dec187970fe
~~~

O repositório contém somente o commit inicial/licença. A preparação não deve colocar firmware na `main` antes do HOPE-00.

## Planner antes da preparação HOPE

`remappingbridge/repo-planner` main observado em:

~~~text
956f600011305dadb8ca8d1724b6d83caa9011d9
~~~

## Regra de proveniência por gate

Cada execução deve registrar:

- SHA base do destino;
- SHA exato G06 consultado;
- SHA exato Mouse UI v1 consultado;
- arquivos G06 reutilizados/adaptados;
- documento/tela Mouse UI usado como referência;
- arquivos realmente alterados;
- UF2/hash quando houver;
- evidência física do operador.
