-- Revenue Breakdown by Brand, Product Category and Gender --

SELECT 
	brand AS Brand,
	category AS Category,
	gender AS Gender,
	YEAR(order_date) AS Year,
	SUM(revenue_usd) AS Total_Revenue,
	SUM(units_sold) AS Total_Sales
FROM 
	global_sales_data
GROUP BY
	brand,
	category,
	gender,
	YEAR(order_date)
ORDER BY 
	YEAR(order_date) DESC,
	SUM(revenue_usd) DESC;
	