-- Q1: Total sales revenue by product category for each month
SELECT dp.category,
       dd.month_name,
       dd.year,
       SUM(fs.revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date    dd ON fs.date_id    = dd.date_id
GROUP BY dp.category, dd.year, dd.month, dd.month_name
ORDER BY dd.year, dd.month, dp.category;

-- Q2: Top 2 performing stores by total revenue
SELECT ds.store_name,
       SUM(fs.revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT dd.year,
       dd.month,
       dd.month_name,
       SUM(fs.revenue) AS monthly_revenue,
       SUM(fs.revenue) - LAG(SUM(fs.revenue)) OVER (ORDER BY dd.year, dd.month) AS mom_change
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year, dd.month, dd.month_name
ORDER BY dd.year, dd.month;
