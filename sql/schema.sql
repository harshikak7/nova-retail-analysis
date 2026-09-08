-- PROJECT: E-Commerce Sales & Performance Analysis
-- PURPOSE: Create core tables and define data types, primary keys, and constraints.
-- DATABASE: PostgreSQL

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    order_id VARCHAR(50) NOT NULL,
    order_date DATE NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    customer_name VARCHAR(150),
    region VARCHAR(50),
    state VARCHAR(100),
    city VARCHAR(100),
    sales_channel VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product VARCHAR(150) NOT NULL,
    quantity INTEGER CHECK (quantity > 0),
    unit_price NUMERIC(12, 2) CHECK (unit_price >= 0),
    discount_percentage NUMERIC(5, 2) DEFAULT 0.00,
    sales_amount NUMERIC(12, 2) CHECK (sales_amount >= 0),
    cost_amount NUMERIC(12, 2) CHECK (cost_amount >= 0),
    profit NUMERIC(12, 2),
    payment_mode VARCHAR(50),
    order_status VARCHAR(50),
    delivery_days INTEGER CHECK (delivery_days >= 0)
);

-- Optimization Indexes for analytical performance
CREATE INDEX idx_sales_order_date ON sales(order_date);
CREATE INDEX idx_sales_category ON sales(category);
CREATE INDEX idx_sales_region ON sales(region);