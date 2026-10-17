# ContractScope Lite — Data Quality Findings

## Dataset overview
- Source records loaded into PostgreSQL: 5,356
- Unique contract numbers: 3,942
- Extra records beyond one record per contract: 1,414

## Contract value checks
- Contracts with missing reported total values: 0
- Contracts with zero reported total values: 1,114
- Contracts with negative reported total values: 1
- Total reported contract value, counting each contract once: CAD 11,069,228,132.20

## Repeated contract records
- All 3,942 contract numbers have one distinct reported `total_contract_value`.
- Repeated source records can contain different contract amounts or procurement categories.
- Reported total values should not be summed directly across all source records because this would double-count repeated contract totals.

## Additional validation
- Contracts with multiple supplier names: 38
- Contracts with multiple award years: 3
- Contracts with multiple procurement methods: 3
- Contracts with multiple procurement categories: 32
- Among zero-value contracts, 25 have no award date and 16 have multiple supplier names.

## Known exception
Contract `W8482-029D1C/001/USW` has a reported total value of CAD -6,868,536.00, a contract amount of CAD -100,130.00, and no award date. Its reason for having a negative reported total has not yet been established.

## Reporting limitations
- Zero and negative values have been retained pending investigation.
- Supplier and procurement-method rankings currently exclude contracts with multiple distinct suppliers or methods.
- Category analysis sums recorded component amounts; these amounts are not necessarily equivalent to total contract values.
- The reason for zero-value and negative-value records has not been confirmed.

These findings should be revisited if additional source documentation becomes available.