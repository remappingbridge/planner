# MOV-01 — Pré-implementação

Escopo: tela MOVEMENT OPTIONS no firmware v1.0, com entrada direta pela HOME conectada antecipada a pedido do operador.
Referência: `movement-options/01-screen-contracts-and-navigation.md`.
Base: release/v1.0.0 @ `30c4dd87922bb566248832ba4716774c0cb29755`.
Branch de trabalho: `feature/movement-options-v1.0`.

Invariantes: preservar perfis e bondings v1.0, navegação por release, sem merge em main; seletor exibirá valor confirmado e reset será transacional.
Este registro é retroativo à implementação já realizada no histórico do PR #22.
