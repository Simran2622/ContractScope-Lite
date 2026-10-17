@'
# ContractScope Lite
### Canadian Government Contract Analytics Dashboard

## Overview
ContractScope Lite analyses public Canadian government contract history data to explore suppliers, procurement categories, procurement methods, award years, and recorded contract values.

The project demonstrates an end-to-end analytics workflow using Python, PostgreSQL, SQL, and Power BI.

## Objectives
- Analyse recorded contract values by supplier.
- Compare recorded values across procurement categories and methods.
- Explore contract values by award year.
- Clean source data and report data-quality issues.
- Build an interactive Power BI dashboard.

## Technology Stack
- **Python:** pandas-based data cleaning and preprocessing.
- **PostgreSQL:** Data storage and querying.
- **SQL:** Analytical queries, views, aggregations, and data-quality checks.
- **Power BI:** Interactive dashboards and visual reporting.

## Workflow
1. Prepare the source dataset using Python.
2. Export cleaned data and a data-quality report.
3. Load the prepared data into PostgreSQL.
4. Create analytical views and SQL queries.
5. Validate data quality and explore contract-level metrics.
6. Visualise findings in Power BI.

## Dashboard
The Power BI report includes:
- Top 10 suppliers by recorded contract value.
- Recorded value by procurement category.
- Recorded value by procurement method.
- Recorded value by award year.
- Unique-contract and source-record KPIs.
- Zero-value contract KPI.
- A contract-level data-quality/detail page.

## Validation Results
Validated against the PostgreSQL `contract_level` view:
- **Unique contracts:** 3,942
- **Zero-value contracts:** 1,114
- **Missing contract values:** 0
- **Total reported contract value:** CAD 11,069,228,132.20

These are dataset-level results and may change if the source data or cleaning logic changes.

## Data Quality Notes
The project includes duplicate checks, missing-value checks, date-range checks, and value validation. Repeated source records may represent different categories or components of the same contract, so they should not automatically be treated as duplicates.

## Project Structure
```text
ContractScope Lite/
├── data/
│   ├── raw/                 # Source dataset (excluded from Git)
│   └── processed/           # Cleaned dataset and quality report
├── reports/                 # Data-quality findings
├── sql/                     # Analytics views and SQL checks
├── src/                     # Python cleaning and loading scripts
├── README.md
├── requirements.txt
└── .gitignore