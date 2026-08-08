--Overall Performance
SELECT 
SUM(sales) AS total_sales, 
SUM(profit) AS total_profit,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(SUM(profit)/SUM(sales), 2) AS profit_margin
FROM orders;

--Sales & Profit Trend Over Time
SELECT
TO_CHAR(DATE_TRUNC('month', order_date_clean), 'YYYY-MM-DD') AS month,
SUM(sales) AS sales,
SUM(profit) AS profit
FROM orders
GROUP BY month
ORDER BY month;

--Category Performance
SELECT category, SUM(sales) AS sales, SUM(profit) AS profit
FROM orders
GROUP BY category
ORDER BY sales DESC;

--Regional Performance
SELECT region, SUM(sales) AS sales, SUM(profit) AS profit
FROM orders
GROUP BY region
ORDER BY sales DESC;

--Top 10 Products
SELECT product_name, SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC LIMIT 10;

--Products Losing Money
SELECT product_name, SUM(sales) AS sales, SUM(profit) AS profit
FROM orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY profit;