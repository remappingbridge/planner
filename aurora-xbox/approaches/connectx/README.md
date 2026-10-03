# Abordagem 2 — ConnectX

> **Status: CX-00…CX-07 concluídos. ConnectX e a automação Mac ↔ Aurora estão validados de ponta a ponta com nove jogos, incluindo ingestão idempotente, ContentID automático, metadata seletiva via Content API, geração/upload de capa RXEA, lote multi-jogo e coexistência NetISO + ConnectX.**

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
- [CX-01 — Samba/NetBIOS](CX-01-samba.md) — **CONCLUÍDO**, incluindo autostart pós-reboot.
- [PLAN.md](PLAN.md) — sequência completa CX-01…CX-07.


## Integração atual com XboxMac UI

O baseline funcional validado será incorporado ao monorepo privado `remappingbridge/xboxmac-ui`.

A UI não criará um pipeline concorrente. O backend reutilizará a automação comprovada e manterá a CLI como ferramenta de diagnóstico/recuperação.

As ações que ainda dependem do usuário no Aurora — atualmente Rescan do path ConnectX e, quando necessário, refresh/reload/restart para refletir metadata/capa — serão representadas como estados explícitos da aplicação.

O backend deverá detectar automaticamente quando essas ações foram concluídas e continuar o job sem exigir que o usuário retorne ao terminal.

Consulte:

- [AUTOMATION.md](AUTOMATION.md) — implementação/validação de baixo nível;
- [../../xboxmac-ui/PLAN.md](../../xboxmac-ui/PLAN.md) — arquitetura do monorepo e experiência do usuário.
