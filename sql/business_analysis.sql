-- PURPOSE: Executive KPIs, performance metrics, and strategic business queries.

-- 1. EXECUTIVE OVERVIEW KPIs
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    SUM(profit) AS total_profit,
    ROUND(SUM(sales_amount) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS avg_order_value
FROM sales;

-- ------------------------------------------------------------------------------
-- 2. CATEGORY & REGIONAL PERFORMANCE
-- ------------------------------------------------------------------------------
-- Regional Sales & Profitability Breakdown
SELECT 
    region, 
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- Top Performing Categories
SELECT 
    category,
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- ------------------------------------------------------------------------------
-- 3. TRENDS & CHANNEL ANALYSIS
-- ------------------------------------------------------------------------------
-- Monthly Sales & Profit Trend
SELECT 
    DATE_TRUNC('month', order_date)::DATE AS month,
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month ASC;

-- Performance by Sales Channel
SELECT 
    sales_channel,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY sales_channel
ORDER BY total_sales DESC;

-- ------------------------------------------------------------------------------
-- 4. PRODUCT MARGINS & LOGISTICS EFFICIENCY
-- ------------------------------------------------------------------------------
-- Top 10 Products by Profit Margin (%)
SELECT 
    product, 
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit, 
    ROUND((SUM(profit) / NULLIF(SUM(sales_amount), 0)) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY product
ORDER BY profit_margin_pct DESC
LIMIT 10;

-- Average Delivery Time by Region (Delivered Orders Only)
SELECT 
    region,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM sales
WHERE order_status = 'Delivered' AND delivery_days IS NOT NULL
GROUP BY region
ORDER BY avg_delivery_days DESC;

-- Order Status Breakdown
SELECT 
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales_amount) AS total_sales
FROM sales
GROUP BY order_status
ORDER BY total_orders DESC;