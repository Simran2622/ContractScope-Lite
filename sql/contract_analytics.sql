
SELECT
    COUNT(*) AS unique_contracts,
    SUM(source_record_count) AS total_source_records,
    ROUND(SUM(total_contract_value), 2) AS total_reported_contract_value,
    ROUND(AVG(total_contract_value), 2) AS average_reported_value_per_contract
FROM contract_level;




-- 2. Top 10 suppliers by reported contract value
-- Include only contracts with one distinct supplier
WITH single_supplier_contracts AS (
    SELECT
        contract_number,
        MAX(supplier) AS supplier,
        MAX(total_contract_value) AS total_contract_value
    FROM contracts
    GROUP BY contract_number
    HAVING COUNT(DISTINCT supplier) = 1
)
SELECT
    supplier,
    COUNT(*) AS unique_contracts,
    ROUND(SUM(total_contract_value), 2) AS total_reported_value
FROM single_supplier_contracts
GROUP BY supplier
ORDER BY total_reported_value DESC
LIMIT 10;




-- 3. Recorded contract amounts by procurement category
-- Component amounts, not allocated total contract values
SELECT
    procurement_category,
    COUNT(*) AS source_records,
    ROUND(SUM(contract_amount), 2) AS sum_of_recorded_component_amounts
FROM contracts
GROUP BY procurement_category
ORDER BY sum_of_recorded_component_amounts DESC;



-- 4. Reported contract value by earliest award year
-- Each contract is counted once
SELECT
    EXTRACT(YEAR FROM earliest_award_date)::INT AS award_year,
    COUNT(*) AS unique_contracts,
    ROUND(SUM(total_contract_value), 2) AS total_reported_value
FROM contract_level
WHERE earliest_award_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM earliest_award_date)
ORDER BY award_year;





-- 5. Reported contract value by procurement method
-- Include only contracts with one distinct method
WITH single_method_contracts AS (
    SELECT
        contract_number,
        MAX(procurement_method) AS procurement_method,
        MAX(total_contract_value) AS total_contract_value
    FROM contracts
    GROUP BY contract_number
    HAVING COUNT(DISTINCT procurement_method) = 1
)
SELECT
    COALESCE(procurement_method, 'Unknown') AS procurement_method,
    COUNT(*) AS unique_contracts,
    ROUND(SUM(total_contract_value), 2) AS total_reported_value
FROM single_method_contracts
GROUP BY procurement_method
ORDER BY total_reported_value DESC;
