
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW_DIR = ROOT / "data" / "raw"
OUTPUT_DIR = ROOT / "data" / "processed"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

files = list(RAW_DIR.glob("*.csv"))
if not files:
    raise FileNotFoundError("No CSV file found in data/raw")

df = pd.read_csv(files[0], low_memory=False)
df.columns = df.columns.str.strip()

column_map = {
    "contractNumber-numeroContrat": "contract_number",
    "contractAwardDate-dateAttributionContrat": "award_date",
    "contractStartDate-contratDateDebut": "start_date",
    "contractEndDate-dateFinContrat": "end_date",
    "contractAmount-montantContrat": "contract_amount",
    "totalContractValue-valeurTotaleContrat": "total_contract_value",
    "contractCurrency-contratMonnaie": "currency",
    "supplierStandardizedName-nomNormaliseFournisseur-eng": "supplier_standardized",
    "supplierLegalName-nomLegalFournisseur-eng": "supplier_legal",
    "supplierOperatingName-nomCommercialFournisseur-eng": "supplier_operating",
    "procurementCategory-categorieApprovisionnement": "procurement_category",
    "contractingEntityName-nomEntitContractante-eng": "contracting_entity",
    "procurementMethod-methodeApprovisionnement-eng": "procurement_method",
    "gsinDescription-nibsDescription-eng": "item_description",
}

missing_columns = [col for col in column_map if col not in df.columns]
if missing_columns:
    raise ValueError(f"Expected columns not found: {missing_columns}")

clean = df[list(column_map)].rename(columns=column_map).copy()

# Use alternative supplier names when the standardized name is missing.
clean["supplier"] = (
    clean["supplier_standardized"]
    .fillna(clean["supplier_legal"])
    .fillna(clean["supplier_operating"])
    .fillna("Unknown")
)

# Convert dates and amounts to appropriate data types.
for col in ["award_date", "start_date", "end_date"]:
    clean[col] = pd.to_datetime(clean[col], errors="coerce")

for col in ["contract_amount", "total_contract_value"]:
    clean[col] = pd.to_numeric(clean[col], errors="coerce")

# Remove whitespace and standardize empty text values.
text_columns = clean.select_dtypes(include="object").columns
for col in text_columns:
    clean[col] = clean[col].astype("string").str.strip()
    clean[col] = clean[col].replace("", pd.NA)

# Remove exact duplicate rows only.
before = len(clean)
clean = clean.drop_duplicates()
duplicates_removed = before - len(clean)

# Save cleaned data and a simple quality report.
clean.to_csv(OUTPUT_DIR / "contracts_clean.csv", index=False)

quality = pd.DataFrame({
    "column": clean.columns,
    "missing_values": [clean[c].isna().sum() for c in clean.columns],
    "missing_percent": [
        round(clean[c].isna().mean() * 100, 2) for c in clean.columns
    ],
})
quality.to_csv(OUTPUT_DIR / "data_quality_report.csv", index=False)

print("Cleaning completed.")
print(f"Original rows: {len(df):,}")
print(f"Cleaned rows: {len(clean):,}")
print(f"Exact duplicate rows removed: {duplicates_removed:,}")
print(f"Output columns: {len(clean.columns)}")
print(f"Supplier names unavailable: {(clean['supplier'] == 'Unknown').sum():,}")
print(f"Saved cleaned data to: {OUTPUT_DIR}")
print(f"Saved quality report to: {OUTPUT_DIR / 'data_quality_report.csv'}")

