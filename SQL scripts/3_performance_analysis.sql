--------------------------------
-- Performance Analysis
--------------------------------

/*

Compare current value with target value.
Helps measure success and compare to know performance.

Ex: 
Current sales - avg sale comparision
Current year sales - previous year sales comparision (YOY analysis)
Current month sales - previous month sales (MOM analysis)
Current sales - lowest sales OR Current sales - highest sales

*/


-- Lets compare yearly performance of products through product sales by avg and previous years sales


WITH CTE AS
(
SELECT
YEAR(f.order_date) AS order_year,
p.product_name AS product_name,
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(f.order_date), p.product_name 
)
SELECT
*,
AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER(PARTITION BY product_name) as diff,
CASE
	WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
	WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
	WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) = 0 THEN 'At Avg'
	ELSE 'Not valid'
END AS sales_performance,
LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) As previous_year_sales,
current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS year_diff,
CASE
	WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
	WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
	WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) = 0 THEN 'Equal'
	ELSE 'No previous year sales'
END AS yoy_performance
FROM CTE;

