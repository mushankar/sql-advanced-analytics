-- Our view can be used for further Business Analysis as follows

SELECT * FROM gold.customer_report;

SELECT 
age_group,
COUNT(customer_number) AS total_customers,
SUM(total_sales) AS total_sales
FROM gold.customer_report
GROUP BY age_group;

SELECT 
customer_segment,
age_group,
COUNT(customer_number) AS total_customers,
SUM(total_sales) AS total_sales
FROM gold.customer_report
GROUP BY customer_segment, age_group;

