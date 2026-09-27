# MCORE-00 — Foundation & Contract Adapter

Status: **ACCEPTED**.

## Objective

Create a clean C backend skeleton that implements released UI↔Core v1 at its boundary while all platform drivers remain replaceable seams.

## Dependencies

UIC-08 ACCEPTED.

## Tasks

1. CMake/C11 strict warnings, CI, sanitizer host tests.
2. Vendor/import the released contract exactly as governed; do not fork semantics.
3. Create Core state context and contract dispatcher/publisher adapters.
4. Define abstract platform seams for clock, persistence, Bluetooth input and USB output.
5. Run released conformance vectors against fake platform implementations.

## Automated / documentary acceptance

- [x] build/tests green
- [x] released v1 vectors pass
- [x] no dependency on mouse-ui headers
- [x] platform seams have no product UI concepts

## Human acceptance

- [x] architecture/module-boundary review

## Deliverables

- Core foundation
- contract adapter
- MCORE-00 evidence

## Forbidden scope

- real BLE/USB implementation
- changing released contract locally
- screen/navigation logic

