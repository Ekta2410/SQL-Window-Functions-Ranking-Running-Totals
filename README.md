# SQL-Window-Functions-Ranking-Running-Totals

Dataset Name: Global Superstore Dataset

Tools & Technologies

MySQL 8.0+

MySQL Workbench

CSV Import using LOAD DATA INFILE

SQL Analysis Performed
1️ Total Sales per Customer

Used GROUP BY to calculate total sales per customer

Identified high-value customers

2️ Customer Ranking by Region

Applied ROW_NUMBER() with PARTITION BY region

Generated unique rankings of customers within each region

3️ Rank vs Dense Rank Comparison

Used RANK() and DENSE_RANK() to analyze tie handling

Demonstrated differences in ranking behavior

Running Total Sales

Calculated cumulative sales over time using:

SUM(sales) OVER (ORDER BY order_date)


Analyzed revenue growth trends

5️ Month-over-Month (MoM) Growth

Aggregated sales at the monthly level

Used LAG() to calculate previous month sales

Computed MoM growth percentage

6️ Top 3 Products per Category

Used a Common Table Expression (CTE)

Applied DENSE_RANK() to identify top products by category

Business Insights

A small number of customers contribute a disproportionately large share of sales within each region.

Month-over-month analysis reveals fluctuating growth patterns, indicating seasonality in demand.

Top three products in each category consistently drive the majority of category-level revenue.
