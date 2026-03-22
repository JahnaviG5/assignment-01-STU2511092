## Storage Systems

The hospital system has four distinct goals, and each one needs a different storage tool chosen for specific technical reasons.

For **patient readmission prediction**, historical treatment data lives in a Data Warehouse (e.g., Amazon Redshift). This data is structured and used for batch ML training — columnar storage and fast aggregations make feature engineering pipelines efficient here.

For **plain-English doctor queries** ("Has this patient had a cardiac event before?"), a Vector Database (e.g., Pinecone or Weaviate) is used alongside an LLM. Patient history documents are chunked, embedded, and stored as vectors. When a doctor asks a question in natural language, the vector DB retrieves the semantically closest records. SQL alone cannot do this — doctors won't phrase queries as structured filters.

For **monthly management reports** (bed occupancy, department costs), the same Data Warehouse serves an OLAP layer. Pre-aggregated views and BI tools like Apache Superset or Tableau connect directly to it for fast, consistent reporting.

For **real-time ICU vitals streaming**, Apache Kafka ingests device streams and writes to a time-series database (InfluxDB or TimescaleDB). This gives sub-second latency for live dashboards and threshold-based alerts — something a general-purpose warehouse cannot provide.

## OLTP vs OLAP Boundary

The OLTP boundary covers the source systems: the EHR (Electronic Health Records) system, ICU monitoring devices, and billing software. These handle live writes — creating patient records, logging vitals, recording payments. The OLAP boundary starts at the ETL pipeline that extracts from these systems into the Data Warehouse. The warehouse is strictly read-optimized and never written to by operational systems. Kafka sits at the seam for streaming data, acting as the handoff point between real-time ingestion (OLTP side) and analytical storage (OLAP side).

## Trade-offs

The biggest trade-off is **data freshness vs. complexity**. Batch ETL into the warehouse means management reports are only as current as the last pipeline run — typically hourly or daily. For a sudden spike in ICU readmissions, a 24-hour-old report is useless.

To mitigate this, the architecture adopts a thin streaming aggregation layer using Apache Flink alongside the batch pipeline. Flink reads from Kafka and maintains real-time running totals (active ICU patients, hourly admissions) that feed a live operations dashboard, while the warehouse continues to serve deep historical analysis. This adds engineering complexity but ensures critical operational metrics are always current without replacing the warehouse entirely.
