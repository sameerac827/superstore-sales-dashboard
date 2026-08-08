--1. Create Table
CREATE TABLE orders(
	row_id INT,
	order_id TEXT,
	order_date TEXT,
	ship_date TEXT,
	ship_mode TEXT,
	customer_id TEXT,
	segment TEXT,
	country TEXT,
	city TEXT,
	state TEXT,
	region TEXT,
	product_id TEXT,
	category TEXT,
	sub_category TEXT,
	product_name TEXT,
	sales NUMERIC,
	quantity INTEGER,
	discount NUMERIC,
	profit NUMERIC
);

--2. Check for Duplicate Values (No Duplicates Found)
SELECT row_id, COUNT(*)
FROM orders
GROUP BY row_id
HAVING COUNT(*) > 1;

--3. Check for Null Values (No Nulls Found)
SELECT
    COUNT(*) FILTER (WHERE row_id IS NULL) AS missing_row_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE product_name IS NULL) AS missing_product_name,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM orders;

--4. Add Calculated Values
ALTER TABLE orders
ADD COLUMN profit_margin NUMERIC,
ADD COLUMN shipping_time INT;

UPDATE orders
SET 
profit_margin = ROUND((profit/NULLIF(sales,0)), 2),
shipping_time = ship_date_clean - order_date_clean;

--5. Verify
SELECT * FROM orders;

