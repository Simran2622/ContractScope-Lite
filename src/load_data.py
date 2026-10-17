
from pathlib import Path
import os
import pandas as pd
import psycopg

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "data" / "processed" / "contracts_clean.csv"

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise RuntimeError(
        "DATABASE_URL is not set. Set it in your terminal before running this script."
    )

df = pd.read_csv(CSV_PATH)

with psycopg.connect(DATABASE_URL) as conn:
    with conn.cursor() as cur:
        cur.execute("""
            CREATE TABLE IF NOT EXISTS contracts (
                contract_number TEXT,
                award_date DATE,
                start_date DATE,
                end_date DATE,
                contract_amount NUMERIC(18, 2),
                total_contract_value NUMERIC(18, 2),
                currency TEXT,
                supplier_standardized TEXT,
                supplier_legal TEXT,
                supplier_operating TEXT,
                procurement_category TEXT,
                contracting_entity TEXT,
                procurement_method TEXT,
                item_description TEXT,
                supplier TEXT
            );
        """)

        cur.execute("TRUNCATE TABLE contracts")

        columns = list(df.columns)
        column_names = ", ".join(f'"{col}"' for col in columns)
        placeholders = ", ".join(["%s"] * len(columns))

        insert_sql = (
            f"INSERT INTO contracts ({column_names}) "
            f"VALUES ({placeholders})"
        )

        records = [
            tuple(None if pd.isna(value) else value for value in row)
            for row in df.itertuples(index=False, name=None)
        ]

        cur.executemany(insert_sql, records)

print(f"Loaded {len(df):,} records into PostgreSQL.")


