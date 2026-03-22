Anomaly Analysis

Insert Anomaly
To add a new product to the catalog, you must first have an order for it.
In `orders_flat.csv`, if no customer has ordered "Product X" yet, there is
no way to insert it without creating a dummy order row. For example, adding
a new product "LED Desk Lamp" with no orders forces NULL values in
order_id, customer_name, and order_date columns, violating NOT NULL intent.

Update Anomaly
The customer address is repeated in every row for that customer.
For example, if customer "Ravi Kumar" appears in rows 3, 7, 12, and 19,
updating his city from "Mumbai" to "Pune" requires updating all 4 rows.
Missing even one row creates inconsistent data for the same customer.

Delete Anomaly
If the only order placed by a sales representative is deleted, all
information about that sales rep (name, region, contact) is permanently
lost. For example, deleting order_id ORD005 (the sole order handled by
rep "Sunita Rao") also deletes Sunita's entire record from the system.

Normalization Justification

At first glance, keeping everything in one flat table seems convenient —
one file, one query, done. But this simplicity is deceptive and costly at scale.

Consider the orders_flat.csv dataset: customer information like name, city,
and phone number is repeated in every single row belonging to that customer.
If a retail company has 500 orders from 80 customers, that's potentially
hundreds of redundant copies of the same data. When a customer changes their
address, every one of those rows must be updated — and missing even one
creates silent data corruption that is extremely hard to debug.

Normalization solves this by storing each fact exactly once. A `customers`
table holds each customer's details in one row. Orders reference that row via
a foreign key. Now an address update is a single-row change, guaranteed consistent.

The same argument applies to products and sales representatives. In the flat
file, the product price appears in every order row for that product. A price
change requires updating dozens of rows. In a normalized schema, `products`
has one row per product — one update, zero inconsistency.

The delete anomaly is perhaps the most dangerous: in a flat file, deleting
an order can silently erase all knowledge of a product or sales rep that had
only one order. Normalized tables prevent this because entity data is stored
independently of transactional data.

The manager's "simplicity" argument holds only for read-once reporting on
small, static datasets. For any system that writes, updates, or grows over
time, normalization is not over-engineering — it is basic data hygiene that
prevents bugs, corruption, and wasted engineering hours down the line.
