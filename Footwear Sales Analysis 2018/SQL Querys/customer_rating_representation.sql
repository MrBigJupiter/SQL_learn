USE FootwearSales;

SELECT * FROM global_sales_data;

-- Easier interpretation of customer_rating --

SELECT 
	order_id,
	customer_rating,
	CASE 
		WHEN customer_rating BETWEEN 0.0 AND 2.2 THEN 'Low'
		WHEN customer_rating BETWEEN 2.3 AND 3.6 THEN 'High'
		ELSE 'Very High'
	END AS rated_rating
FROM 
	global_sales_data;

-- Count the rated_ratings to get a better view of the data --

WITH Ratings AS (
SELECT 
	order_id,
	customer_rating,
	CASE 
		WHEN customer_rating BETWEEN 0.0 AND 2.2 THEN 'Low'
		WHEN customer_rating BETWEEN 2.3 AND 3.6 THEN 'High'
		ELSE 'Very High'
	END AS rated_rating
FROM 
	global_sales_data
)

SELECT 
	Ratings.rated_rating,
	COUNT(Ratings.rated_rating) AS number_of_ratings
FROM 
	Ratings
GROUP BY 
	Ratings.rated_rating;