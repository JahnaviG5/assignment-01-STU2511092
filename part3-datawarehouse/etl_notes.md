ETL Decisions

Decision 1 — Standardizing Mixed Date Formats
Problem: The `date` column in retail_transactions.csv had three different formats across rows: `29/08/2023`, `12-12-2023`, and `2023-02-05`. Loading these directly into a DATE column would either fail or silently store wrong values depending on the DB.
Resolution: All dates were parsed and converted to ISO 8601 format (YYYY-MM-DD) before insertion into dim_date. The dim_date table then pre-computes day, month, month_name, quarter, and year columns so analytical queries never need to parse dates at runtime.

Decision 2 — Imputing NULL Store Cities
Problem: 19 rows had NULL in the `store_city` column even though `store_name` was present (e.g., "Mumbai Central" with no city). This would cause city-based filters to silently drop valid transactions.
Resolution: Store city was derived from store name using a lookup mapping (Chennai Anna → Chennai, Delhi South → Delhi, etc.). Since each store name maps to exactly one city, this imputation is safe and lossless. The corrected city is stored in dim_store, so the fact table never needs to carry city directly.

Decision 3 — Normalizing Inconsistent Category Casing
Problem: The `category` column had five distinct values for what should be three: `electronics`, `Electronics`, `Grocery`, `Groceries`, and `Groceries`. This caused GROUP BY on category to split Electronics into two buckets and Grocery into two others, breaking any revenue-by-category report.
Resolution: All categories were standardized to title case and a single canonical name — `electronics`/`Electronics` → `Electronics`, `Grocery`/`Groceries` → `Groceries`. This normalization was applied in dim_product, ensuring every fact row joins to a clean, consistent category label.
