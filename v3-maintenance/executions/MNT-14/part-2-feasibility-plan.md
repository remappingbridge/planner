# MNT-14 / Parte 2 — protocolo da decisão de viabilidade

**STATUS: PLANNED / BLOQUEADO PELA PARTE 1.** Renumerado de MNT-13 para MNT-14 em 12/10/2026, sem iniciar a investigação ou decisão. Este documento é **critério de decisão**, não relatório nem autorização para código. A Parte 2 só é executada após o diagnóstico da Parte 1 ser apresentado ao operador. Ver [MNT-14 completo](../../gates/MNT-14.md).

## Entradas obrigatórias

- Relatório `part-1-root-cause.md` com causa confirmada ou limites da evidência, baseline/reprodução, logs anonimizados, estágio causal e critérios de reprovação/hipóteses alternativas.
- Requisito originalmente aceito: A permanece utilizável ao buscar B realmente novo; candidato B é não autoritativo; cancelar/timeout mantém A; depois de qualificar B há handoff seguro. **Não substituir** por desligamento obrigatório de A.
- Efeitos de correção sobre coexistência LE (controller, BTstack, RAM pools, SDK, scan/connection interval/timing), USB HID, segurança, bonds/perfis por mouse, lock/help, Saved Devices e 9×21.

## Quadro comparativo obrigatório

| Alternativa | Causa que resolveria | Invasividade e riscos | Teste que provaria | Veredito |
|---|---|---|---|---|
| Ajuste de estado/event loop/timer | Somente se Parte 1 provar falha de transição | A avaliar | A conectado → B novo, 15 s, cancel/handoff | PENDING |
| Ajuste de coexistência rádio/scan/stack/SDK | Somente se Parte 1 provar bloqueio real BLE | A avaliar RAM, compatibilidade e estabilidade | Traço scan/conn concorrente reproduzível com hardware | PENDING |
| Correção de classificação Saved/IRK/advertising | Somente se Parte 1 provar falso positivo na filtragem de B novo | Alto risco de duplicar bonds, avaliar | B realmente inédito, B salvo intencionalmente ignorado, RPA | PENDING |
| Nenhuma correção viável | Limitação técnica comprovada/risco intolerável | Documentar trade-offs sem alterar contrato | Evidência técnica que justifique impossibilidade | PENDING |

## Opções de decisão

- **GO / FIX:** causa comprovada e correção realista, segura, genérica e testável; propor mudança mínima, compatibilidade, testes e rollback. **Aguardar autorização expressa do operador antes de implementar.**
- **NO-GO / DEFERRED:** causa conhecida, mas correção inviável/desproporcional. Registrar motivo e contorno opcional identificado como **workaround**, jamais converter o contorno em arquitetura sem novo requisito.
- **BLOCKED / INCONCLUSIVE:** investigação não isolou causa ou disponibilidade de hardware/logs insuficiente. Pedir experimento específico, não lançar patch no escuro.
- **NOT A BUG:** comprovar que cenário real era saved-only, B sem modo pareamento, fora de 15 s, ou que o contrato opera corretamente. Registrar prova.

## Aprovação, implementação e versão

- [ ] Relatório e decisão fundamentados apresentados ao operador.
- [ ] Operador aprova a decisão **específica** da Parte 2.
- [ ] **Se GO**, operador decide separadamente **se autoriza codificar**. Sem essa autorização, parar.
- [ ] Se implementação for autorizada, criar branch do último release oficial, teste que reproduz bug antes/depois, CI completa + UF2 Pico 2 W + checksum, aceite físico do candidato e release v3.x somente depois disso.
- [ ] **Se NO-GO, BLOCKED ou NOT A BUG**, concluir documentalmente **NO RELEASE**; não criar tag ou versão fictícia.

**A Parte 2 não foi executada. Todos os itens estão PENDING.**
