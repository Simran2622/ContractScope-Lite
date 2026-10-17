
-- 1. Contract-level data for overall KPIs and yearly analysis
-- Existing view: contract_level

-- 2. Supplier analysis: exclude contracts with multiple suppliers
CREATE OR REPLACE VIEW supplier_analytics AS
SELECT
    contract_number,
    MAX(supplier) AS supplier,
    MAX(total_contract_value) AS total_contract_value
FROM contracts
GROUP BY contract_number
HAVING COUNT(DISTINCT supplier) = 1;

-- 3. Procurement method analysis: exclude contracts
-- with multiple distinct procurement methods
CREATE OR REPLACE VIEW method_analytics AS
SELECT
    contract_number,
    MAX(procurement_method) AS procurement_method,
    MAX(total_contract_value) AS total_contract_value
FROM contracts
GROUP BY contract_number
HAVING COUNT(DISTINCT procurement_method) = 1;

-- 4. Procurement category analysis uses source records
-- because a contract can have multiple categories
CREATE OR REPLACE VIEW category_analytics AS
SELECT
    contract_number,
    procurement_category,
    contract_amount,
    total_contract_value
FROM contracts;
