# Abordagem 2 — ConnectX

> **Status: CX-00 concluído; CX-01 funcionalmente validado; CX-02 concluído para o PES 2018; CX-03 concluído. Próximo gate: CX-04 — execução remota do PES 2018 via ConnectX.**

Objetivo: manter jogos no Mac, mas permitir que o Aurora trate a biblioteca remota como um caminho escaneável e coloque os títulos no CoverFlow/carrossel principal.

Documentação de referência usada no planejamento:

- https://consolemods.org/wiki/Xbox_360:ConnectX
- https://consolemods.org/wiki/Xbox_360:Aurora

## Resultado esperado

```text
MacBook
└── biblioteca extraída SMB
        |
        | rede privada 192.168.50.0/24
        v
ConnectX:
        |
        +--> default.xex dos jogos
        |
        v
Aurora Manage Paths
        |
        v
CoverFlow + capas/metadados
```

ConnectX exige jogos em formato extraído; ISO não é suportada diretamente. A biblioteca ISO do NetISO será preservada.

ConnectX é um módulo/plugin do Aurora. O planejamento não reserva outro slot DashLaunch para ele; o `plugin1` do NetISO permanece como está.

Consulte [PLAN.md](PLAN.md).

## Gates

- [CX-00 — baseline e rollback](CX-00-baseline.md) — **CONCLUÍDO**.
- [CX-01 — Samba/NetBIOS](CX-01-samba.md) — **FUNCIONAL VALIDADO; autostart pendente**.
- [PLAN.md](PLAN.md) — sequência completa CX-01…CX-07.
