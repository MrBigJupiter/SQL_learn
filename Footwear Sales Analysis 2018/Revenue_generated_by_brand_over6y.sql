-- Overview of the table -- 
SELECT * FROM sales_behavior_data;

-- Check the number or rows importad from the csv into the database -- 
SELECT 
	COUNT(id) AS TotalRows
FROM sales_behavior_data;

-- Select the distinct brands and their total revenue generated over 6 years --
SELECT 
	DISTINCT brand,
    SUM(revenue_usd) as Revenue_Generate_Over6years
FROM sales_behavior_data
GROUP BY brand
ORDER BY SUM(revenue_usd) DESC;