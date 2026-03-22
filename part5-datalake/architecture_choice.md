## Architecture Recommendation

For a fast-growing food delivery startup collecting GPS logs, customer text reviews, payment transactions, and restaurant menu images, I recommend a **Data Lakehouse** architecture.

**Reason 1 — Mixed Data Types in One Place:**
The startup's data is fundamentally varied — structured payments, semi-structured GPS events, unstructured text reviews, and binary menu images. A Data Warehouse only handles structured, pre-schemed data and would require discarding or heavily pre-processing the rest. A pure Data Lake stores everything but offers poor query performance for business reporting. A Lakehouse (e.g., Delta Lake or Apache Iceberg on cloud storage) handles all formats natively while adding ACID transactions and schema enforcement on top, so nothing gets thrown away.

**Reason 2 — Supports Both Real-Time and Analytical Workloads:**
The startup needs real-time answers (is this driver near the customer?) alongside weekly analytics (which city has the worst delivery times?). A Lakehouse can separate hot and cold storage layers — streaming GPS data lands in a fast layer while historical data is available for batch analysis — without duplicating data across two separate systems.

**Reason 3 — Cost-Effective as They Scale:**
Storing millions of GPS pings, menu photos, and review text in a managed Data Warehouse like Redshift or BigQuery would become very expensive very fast. A Lakehouse stores raw data cheaply in object storage (S3/GCS) and only spins up compute when queries are actually run. This decoupling of storage and compute is a critical cost advantage for a startup that needs to move fast without burning cloud budget.
