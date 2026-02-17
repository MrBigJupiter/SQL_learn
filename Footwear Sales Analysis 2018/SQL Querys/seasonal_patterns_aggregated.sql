-- Seasonal patterns (monthly / quarterly analysis) --

SELECT 
	brand as Brand,
	YEAR(order_date) AS Year,
	DATEPART(QUARTER, order_date) AS Quarter,
	MONTH(order_date) AS Month,
	category AS Category,
	gender AS Gender,
	color AS Color,
	SUM(revenue_usd) AS Total_Revenue,
	SUM(units_sold) AS Total_Sales,
	payment_method AS Method,
	sales_channel AS Sales_Channel,
	country AS Country
FROM
	global_sales_data
GROUP BY
	brand,
	YEAR(order_date),
	DATEPART(QUARTER, order_date),
	MONTH(order_date),
	category,
	gender,
	color,
	payment_method,
	sales_channel,
	country
ORDER BY 
	YEAR(order_date) DESC,
	DATEPART(QUARTER, order_date) DESC,
	MONTH(order_date) DESC;