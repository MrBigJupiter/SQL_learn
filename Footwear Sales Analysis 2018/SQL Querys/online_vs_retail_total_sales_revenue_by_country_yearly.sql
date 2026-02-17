-- Online vs. Retail Stores sales contribution by Country --

SELECT 
	sales_channel AS Channel,
	YEAR(order_date) AS Year,
	brand AS Brand,
	SUM(revenue_usd) AS Total_Revenue,
	SUM(units_sold) AS Total_Sales,
	country AS Country
FROM
	global_sales_data
GROUP BY
	sales_channel,
	brand,
	country,
	YEAR(order_date)
ORDER BY 
	YEAR(order_date) DESC,
	sales_channel DESC;