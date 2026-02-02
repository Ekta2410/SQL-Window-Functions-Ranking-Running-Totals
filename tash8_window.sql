CREATE DATABASE superstore_db;
USE superstore_db;
DROP TABLE superstore;
CREATE TABLE superstore (
    row_id INT,
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(255),
    segment VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    order_priority VARCHAR(50)
);
SELECT COUNT(*) FROM superstore;
SELECT * FROM superstore LIMIT 5;
-- Total Sales per Customer (GROUP BY)
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC;

-- Rank Customers by Sales per Region
SELECT
    region,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS row_num
FROM superstore
GROUP BY region, customer_name;

-- Compare RANK() vs DENSE_RANK()
SELECT
    region,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS rank_value,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS dense_rank_value
FROM superstore
GROUP BY region, customer_name;

-- Running Total Sales
SELECT
    order_date,
    ROUND(SUM(sales), 2) AS daily_sales,
    ROUND(
        SUM(SUM(sales)) OVER (ORDER BY order_date),
        2
    ) AS running_total_sales
FROM superstore
GROUP BY order_date
ORDER BY order_date;

-- Month-over-Month (MoM) Growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS month,
        ROUND(SUM(sales), 2) AS total_sales
    FROM superstore
    GROUP BY month
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY month))
        / LAG(total_sales) OVER (ORDER BY month) * 100,
        2
    ) AS mom_growth_percent
FROM monthly_sales
ORDER BY month;

-- Top 3 Products per Category
WITH product_sales AS (
    SELECT
        category,
        product_name,
        ROUND(SUM(sales), 2) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS rank_value
    FROM superstore
    GROUP BY category, product_name
)
SELECT *
FROM product_sales
WHERE rank_value <= 3;

-- Export CSV Files
SELECT
    region,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS rank_value
FROM superstore
GROUP BY region, customer_name;