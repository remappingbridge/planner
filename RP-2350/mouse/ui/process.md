# Execution process

## Gate branches

For the reconstruction program, prefer one focused branch per gate, for example `mui/mui-00-foundation`. A gate branch starts from the latest accepted dependency baseline.

## Candidate evidence

Each executed gate should create an evidence directory under `executions/<gate>/` containing at least:

- candidate branch and exact commit;
- implemented task checklist;
- automated test/build commands and results;
- artifacts/hashes where relevant;
- known limitations;
- human test scenarios/results where required;
- rollback base.

## Cleanliness rule

If a gate implementation accumulates architecture violations or extensive workaround conditionals, do not preserve it merely because behavior appears correct. Keep specifications/tests, abandon the implementation branch, and use a `rebuild/*` or fresh gate candidate.

## Stable baseline references

After major accepted checkpoints, preserve a named immutable baseline reference so later `lab/*` experiments branch from a known clean frontend.

For MUI-08 the available GitHub connector did not expose tag creation, so the accepted commit is preserved as:

~~~text
baseline/mui-08-accepted
537b0f6fdd188b283cf10648b1cc6dbdacbfe20d
~~~

Treat this baseline branch as immutable.

## No backend claims

Mock results and frontend test PASS never imply BLE/USB/flash/backend functionality. Those belong to separate Core/integration programs.
