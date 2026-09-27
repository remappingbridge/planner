# UIC-02 — Intent Model

Status: **BLOCKED**.

## Objective

Define semantic commands UI may ask Core to perform, with preconditions and no navigation leakage.

## Dependencies

UIC-01 ACCEPTED.

## Tasks

1. Define start-first-search, start-saved-search and Pair-New intents.
2. Define search cancellation semantics at command level.
3. Define Apply Profile, Custom edit/persist ownership, Apply Custom and Remove Mouse intents.
4. Define target identity/preconditions and invalid-request behavior.
5. Define retry/idempotency expectations and whether duplicate submission is legal.
6. Map frozen UI actions to contract intents while excluding HOME/Help/Lock/Back/menu navigation.

## Automated / documentary acceptance

- [ ] every shared UI action maps to one normative intent or is proven UI-local
- [ ] intents reference stable identities rather than list indexes
- [ ] preconditions/invalid cases are explicit
- [ ] no intent names a UI screen

## Human acceptance

- [ ] review accepts command vocabulary and Custom ownership decision

## Deliverables

- result delivery mechanism
- BLE/USB commands
- screen navigation API

## Forbidden scope

- normative Intent section
- intent fixtures/examples
- UIC-02 evidence

