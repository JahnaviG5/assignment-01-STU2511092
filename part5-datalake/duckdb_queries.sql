-- Q1: List all customers along with the total number of orders they have placed
SELECT c.name AS customer_name,
       COUNT(o.order_id) AS total_orders
FROM read_csv_auto('datasets/customers.csv') c
LEFT JOIN read_json_auto('datasets/orders.json') o
       ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;

-- Q2: Find the top 3 customers by total order value
SELECT c.name AS customer_name,
       SUM(o.total_amount) AS total_value
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
  ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT p.product_name
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
  ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
  ON o.product_id = p.product_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files — customer name, order date, product name, quantity
SELECT c.name        AS customer_name,
       o.order_date,
       p.product_name,
       o.num_items   AS quantity
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
  ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
  ON o.product_id = p.product_id
ORDER BY o.order_date;
