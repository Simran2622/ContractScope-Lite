# ContractScope Lite
### Government Contract Analytics Dashboard

## Overview
ContractScope Lite is a data analytics project that analyses public Canadian government contract records to identify suppliers, procurement categories, procurement methods, and award years associated with the highest recorded contract values.

The project demonstrates a complete data analytics workflow using Python, PostgreSQL, SQL, and Power BI.

## Objectives
- Analyse recorded contract values by supplier.
- Identify procurement categories with the highest recorded values.
- Compare recorded contract values across award years.
- Analyse contract values by procurement method.
- Perform data cleaning and data quality checks.

## Technology Stack
- **Python:** Data cleaning and preprocessing using pandas.
- **PostgreSQL:** Data storage and querying.
- **SQL:** Aggregation, analytical queries, and views.
- **Power BI:** Interactive data visualisation and dashboard reporting.

## Project Workflow
1. Collected public Canadian government contract history data.
2. Cleaned and prepared the dataset using Python.
3. Loaded the cleaned data into PostgreSQL.
4. Created SQL queries and analytical views.
5. Built a Power BI dashboard to present the findings.

## Dashboard Insights
The dashboard includes:
- Top 10 suppliers by recorded contract value.
- Recorded contract value by procurement category.
- Recorded contract value by procurement method.
- Recorded contract value by award year.
- Zero-value contract count.

## Data Quality
The project includes data cleaning, missing-value handling, standardisation of supplier names, and data quality reporting.

## Important Note
The values shown represent recorded contract values in the source dataset. They should not automatically be interpreted as actual cash expenditure. Contract history records may include multiple records for the same contract.

## Project Structure
```text
ContractScope Lite/
├── data/
│   ├── raw/
│   └── processed/
├── reports/
├── sql/
├── src/
├── README.md
├── requirements.txt
└── ContractScope_Lite.pbix
```

## How to Run
1. Install the required Python packages listed in `requirements.txt`.
2. Run the data cleaning script in `src/clean_data.py`.
3. Configure PostgreSQL and the database connection.
4. Run `src/load_data.py` to load the prepared data.
5. Execute the SQL scripts in the `sql/` directory.
6. Open `ContractScope_Lite.pbix` in Power BI Desktop.

## Disclaimer
This project is intended for educational and portfolio purposes. Findings depend on the completeness and definitions of the source data.