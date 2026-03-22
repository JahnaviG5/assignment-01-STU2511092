Anomaly Analysis

Insert Anomaly
To add a new product (e.g., a "Printer") to the catalog, you'd need a dummy order row for it since product data (product_id, product_name, category, unit_price) only exists inside order rows. There's no way to insert a product without a corresponding order, forcing NULLs in order_id, customer fields, etc.

Update Anomaly
Sales rep office addresses are repeated across many rows. For example, `SR01 Deepak Joshi` appears with two slightly different office addresses: "Mumbai HQ, Nariman Point, Mumbai - 400021" (rows 1, 8, 9...) and "Mumbai HQ, Nariman Pt, Mumbai - 400021" (row 37). Updating his address requires finding and changing every row — miss one, and the data is inconsistent.

Delete Anomaly
If all orders handled by `SR03 Ravi Kumar` were deleted, all knowledge of Ravi Kumar — his name, email, and office location (South Zone, MG Road, Bangalore) — disappears from the system entirely, even though he's still an active employee.

Normalization Justification

Keeping everything in one flat table feels simple until the data starts changing. In `orders_flat.csv`, customer details like name, email, and city repeat in every single order row for that customer. Priya Sharma (C002) appears in at least 20+ rows. If she changes her email, every one of those rows needs updating — miss one and queries return inconsistent results silently.

The sales rep data makes this even clearer. Deepak Joshi's office address appears in two slightly different forms across the 186 rows — "Nariman Point" vs "Nariman Pt." This is exactly the update anomaly that normalization prevents. In a normalized schema, his record exists exactly once in a `sales_reps` table. One row, one update, zero inconsistency.

The delete anomaly is arguably the most dangerous. If the only order Ravi Kumar handled was deleted for being a test entry, all record of Ravi — his contact, region, office — vanishes. A normalized `sales_reps` table would preserve that data independently of order history.

The manager's "one table is simpler" argument only holds for static read-only exports, like a monthly spreadsheet someone opens once. For any live system that writes, updates, or grows over time, a flat table is a liability that compounds with every new row added. Normalization isn't over-engineering — it's removing a slow-motion data corruption bug before it starts.
