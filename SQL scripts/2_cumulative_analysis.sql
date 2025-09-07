--------------------------------
-- Cumulative Analysis
--------------------------------

/*

Aggregate data progressively over time.
Helps to understand the business growth and decline.

Ex: Running total by year, Moving average of sales by month

*/

-- Total sales per month and running total of sales over time for all years.

WITH CTE AS 
(
SELECT 
DATETRUNC(month,order_date) AS order_date,
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date),YEAR(order_date),MONTH(order_date)
)

SELECT
*,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales
FROM CTE

--  Total sales per year, avg_sales per year, running total of sales over years and running avg of sales over years


WITH CTE2 AS 
(
SELECT 
DATETRUNC(YEAR,order_date) AS order_date,
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
AVG(sales_amount) AS avg_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date),YEAR(order_date)
)

SELECT
*,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales,
AVG(avg_sales) OVER(ORDER BY order_date) AS running_avg_sales
FROM CTE2
