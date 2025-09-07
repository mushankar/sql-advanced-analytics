/*

=========================================================
-- CUSTOMER REPORT
=========================================================

Purpose:
	-- This report consolidates key customer metrics and behaviours

Highlights:
	1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New, New VIP) and age groups.
	3. Aggregates customer-level metrics:
		- Total orders
		- Total sales
		- Total quantity purchased
		- Total products
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- Recency 
		- Average order value
		- Average monthly spend

*/

CREATE VIEW gold.customer_report AS
WITH base_table AS
/*------------------------------------------
1. Base table: Retrieves necessary information by joining tables
--------------------------------------------*/

(
SELECT
	f.product_key,
	f.order_date,
	f.order_number,
	f.quantity,
	c.customer_key,
	c.customer_number,
	c.first_name,
	c.last_name,
	f.sales_amount,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	DATEDIFF(YEAR,c.birthdate,GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
WHERE f.order_date IS NOT NULL
)
, customer_aggregation AS (
/*-------------------------------------------
2. Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------*/
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT product_key) AS total_products,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month,MIN(order_date),MAX(order_date))	AS lifespan
FROM base_table
GROUP BY 
customer_key,
customer_number,
customer_name,
age
)


SELECT
	*,
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 and above'
	END as age_group,
	CASE
		WHEN lifespan <= 12 AND total_sales > 5000 THEN 'New Vip'
		WHEN lifespan <= 12 AND total_sales < 5000 THEN 'New'
		WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan >=12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	CONCAT(
	DATEDIFF(month,last_order_date,GETDATE()),' ', 'months'
	)AS recency,
	-- average order value
	CASE 
		WHEN total_orders = 0 THEN 0
		ELSE	total_sales/total_orders
	END AS avg_order_value,
	-- average monthly spemd
	CASE
		WHEN lifespan = 0 THEN total_sales
	ELSE total_sales/lifespan
	END AS avg_monthly_spend
	
FROM customer_aggregation