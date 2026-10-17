
CREATE OR REPLACE VIEW contract_level AS
SELECT
    contract_number,
    MAX(total_contract_value) AS total_contract_value,
    MIN(award_date) AS earliest_award_date,
    COUNT(*) AS source_record_count,
    COUNT(DISTINCT supplier) AS distinct_supplier_count,
    COUNT(DISTINCT procurement_category) AS distinct_category_count,
    COUNT(DISTINCT procurement_method) AS distinct_method_count
FROM contracts
GROUP BY contract_number;
