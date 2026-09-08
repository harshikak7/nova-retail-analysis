-- PURPOSE: Data validation, handling missing values, and text standardization.

-- 1. Data Integrity Check (Verify row counts and date boundary ranges)
SELECT 
    COUNT(*) AS total_records,
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM sales;

-- 2. Null Value Audit
SELECT 
    COUNT(*) - COUNT(customer_name) AS missing_cust_names,
    COUNT(*) - COUNT(delivery_days) AS missing_delivery_days
FROM sales;

-- 3. Standardize Categorical Text Fields (TRIM spaces & Title Case formatting)
UPDATE sales
SET region = INITCAP(LOWER(TRIM(region)))
WHERE region <> INITCAP(LOWER(TRIM(region)));

UPDATE sales
SET order_status = INITCAP(LOWER(TRIM(order_status)))
WHERE order_status <> INITCAP(LOWER(TRIM(order_status)));

UPDATE sales
SET product = TRIM(product)
WHERE product LIKE ' %' OR product <> TRIM(product);

-- 4. Financial Integrity Verification
SELECT 
    SUM(sales_amount) AS total_sales,
    SUM(cost_amount) AS total_cost,
    SUM(profit) AS total_profit
FROM sales;