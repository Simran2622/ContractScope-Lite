
-- Check how many records and unique contracts we have
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT contract_number) AS unique_contracts,
    COUNT(*) - COUNT(DISTINCT contract_number) AS extra_records
FROM contracts;

-- Find contract numbers that appear more than once
SELECT
    contract_number,
    COUNT(*) AS number_of_records,
    SUM(total_contract_value) AS summed_recorded_value
FROM contracts
GROUP BY contract_number
HAVING COUNT(*) > 1
ORDER BY number_of_records DESC
LIMIT 10;


SELECT
    contract_number,
    supplier,
    award_date,
    contract_amount,
    total_contract_value,
    procurement_category,
    procurement_method
FROM contracts
WHERE contract_number = 'CW2417746'
ORDER BY award_date;


SELECT
    contract_number,
    COUNT(*) AS record_count,
    SUM(contract_amount) AS sum_of_contract_amounts,
    MAX(total_contract_value) AS total_contract_value,
    MIN(total_contract_value) AS minimum_total_value,
    MAX(total_contract_value) AS maximum_total_value
FROM contracts
WHERE contract_number = 'CW2417746'
GROUP BY contract_number;



SELECT
    COUNT(*) AS unique_contracts,
    COUNT(*) FILTER (
        WHERE value_count = 1
    ) AS contracts_with_one_total_value,
    COUNT(*) FILTER (
        WHERE value_count > 1
    ) AS contracts_with_multiple_total_values
FROM (
    SELECT
        contract_number,
        COUNT(DISTINCT total_contract_value) AS value_count
    FROM contracts
    GROUP BY contract_number
) AS contract_values;
