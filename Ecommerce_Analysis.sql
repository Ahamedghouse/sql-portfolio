-- ================================================
-- E-Commerce Sales Analysis
-- Author: Ahamed Ghouse
-- GitHub: Ahamedghouse
-- Description: SQL queries analyzing e-commerce
-- sales performance for business insights
-- ================================================

-- Query 1: Product Revenue Ranking
-- Business Question: Which products generate the most revenue?
SELECT p.product_name, p.category,
SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY revenue DESC;

-- Query 2: Regional Performance vs Target
-- Business Question: Which regions are underperforming?
SELECT c.region,
SUM(o.quantity * p.price) AS total_revenue,
r.target_revenue,
CASE
    WHEN SUM(o.quantity * p.price) >= r.target_revenue THEN 'Hit Target'
    ELSE 'Underperforming'
END AS status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
JOIN regions r ON c.region = r.region
GROUP BY c.region, r.target_revenue
ORDER BY total_revenue DESC;

-- Query 3: Top 5 Customers by Spending
-- Business Question: Who are our most valuable customers?
SELECT c.name,
SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- Query 4: Average Order Value per Region
-- Business Question: What is the average spending per order by region?
SELECT c.region,
AVG(o.quantity * p.price) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.region
ORDER BY avg_order_value DESC;

-- Query 5: Month over Month Sales Trend
-- Business Question: Are sales growing or declining?
SELECT month,
SUM(o.quantity * p.price) AS monthly_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY MIN(order_date);

-- Query 6: Executive Summary Report
-- Business Question: Full regional performance overview for CEO
SELECT c.region,
SUM(o.quantity * p.price) AS total_revenue,
r.target_revenue,
CASE
    WHEN SUM(o.quantity * p.price) >= r.target_revenue THEN 'Hit Target'
    ELSE 'Underperforming'
END AS status,
AVG(o.quantity * p.price) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
JOIN regions r ON c.region = r.region
GROUP BY c.region, r.target_revenue
ORDER BY total_revenue DESC;
