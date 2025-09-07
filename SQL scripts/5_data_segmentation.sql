--------------------------------
-- DATA SEGMENTATION
--------------------------------

/*

Group the data based on specific range to analyse
Helps understand correlation between two measures

EX:
Total products by sales range
Total customers by Age


*/

-- Segment products into cost ranges and count how many products fall into each segment

WITH CTE AS 
(
SELECT 
product_key,
product_name,
cost,
CASE
	WHEN cost < 500 THEN 'Below 500'
	WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	WHEN cost BETWEEN 1000 AND 1500 THEN '1000-1500'
	ELSE 'Above 1500'
END AS cost_range
FROM  gold.dim_products
)

SELECT
cost_range,
COUNT(product_key) AS total_products
FROM CTE
GROUP BY cost_range
ORDER by total_products DESC;


/*

Lets group customers into 3 segments based on their spending:

VIP customer - atleast 12 months of history and more than 5000 spending
Regular: atleast 12 months of history and spends atleast 5000
New: lifespan less than 12 months

*/

WITH CTE AS 
(
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spend,
MIN(f.order_date) AS first_order,
MAX(f.order_date) AS last_order,
DATEDIFF(month,MIN(f.order_date),MAX(f.order_date)) AS lifespan
FROM 
gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key
)

SELECT 
customer_segment,
COUNT(customer_key) AS total_customers
FROM
(
SELECT
*,
CASE
	WHEN lifespan <= 12 AND total_spend > 5000 THEN 'New Vip'
	WHEN lifespan <= 12 AND total_spend < 5000 THEN 'New'
	WHEN lifespan >= 12 AND total_spend > 5000 THEN 'VIP'
	WHEN lifespan >=12 AND total_spend <= 5000 THEN 'Regular'
	ELSE 'New'
END AS customer_segment
FROM CTE
) t
GROUP BY customer_segment
ORDER BY total_customers

-- If we notice the above query, we have created a CTE and then we have nested the query to avoid taking the case statement into groupby
-- Sometimes it might get a little tricky to directly understand the query, but doing it part by part gives us the final solution.