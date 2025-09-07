--------------------------------
-- Change Over Time Analysis
--------------------------------

/*

Has trends related to date & Time Analysis
Ex:
Total sales by Year
Average cost by Month

*/

SELECT 
YEAR(order_date) AS order_year, 
MONTH(order_date) AS order_Month,
SUM(sales_amount) as total_sales_amount,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL -- AND order_date = '2014'
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)

-- Can use Datetrunc function as well DATETRUNCT(month, order_date) - date is sorted well
-- or FORMAT(order_date,'YYYY-MMM') - But data sorting becomes tougher