-- Data Exploration

-- KPIs
-- What is the Total Orders
SELECT COUNT(*) AS Total_Order
FROM fact_swiggy_orders;

-- What is our total revenue?
SELECT SUM(Price_INR) AS Total_Revenue
FROM fact_swiggy_orders;

--What is the average dish price?
SELECT 
	CAST(AVG(Price_INR) AS DECIMAL(10,2)) AS Total_Revenue
FROM fact_swiggy_orders;

-- What is the average rating?
SELECT AVG(Rating) AS Avg_Rating
FROM fact_swiggy_orders;


-- Deep-Dive Business Analysis
-- Monthly order Trends
SELECT
	d.Year,
	d.Month,
	d.month_name,
	COUNT(f.order_id) AS Total_Orders,
	SUM(f.Price_INR) AS Total_Revenue
FROM fact_swiggy_orders f
LEFT JOIN dim_date d
	ON f.date_id = d.Date_Id
GROUP BY d.Year, d.month_name,d.Month
ORDER BY Month;

-- Top 10 cities by order volume
SELECT TOP 10
	l.City,
	COUNT(f.order_id) AS Total_Orders
FROM fact_swiggy_orders f
LEFT JOIN dim_location l
	ON f.location_id = l.location_id
GROUP BY l.City
ORDER BY Total_Orders DESC;

-- Least 10 cities by order volume
SELECT TOP 10
	l.City,
	COUNT(f.order_id) AS Total_Orders
FROM fact_swiggy_orders f
LEFT JOIN dim_location l
	ON f.location_id = l.location_id
GROUP BY l.City
ORDER BY Total_Orders;

-- Revenue contribution by states
SELECT
	l.State,
	SUM(f.Price_INR) AS Total_Revenue
FROM fact_swiggy_orders f
LEFT JOIN dim_location l
	ON f.location_id = l.location_id
GROUP BY l.State
ORDER BY Total_Revenue DESC;

-- Top 10 restaurants by orders
SELECT TOP 10
	r.Restaurant_Name,
	COUNT(f.order_id) AS Total_Orders
FROM fact_swiggy_orders f
LEFT JOIN dim_restaurant r
	ON f.restaurant_id = r.restaurant_id
GROUP BY r.Restaurant_Name
ORDER BY Total_Orders DESC;

-- Top categories by orders volume
SELECT
	c.category,
	COUNT(f.order_id) AS Total_Orders
FROM fact_swiggy_orders f
LEFT JOIN dim_category c
	ON f.category_id = c.category_id
GROUP BY c.category
ORDER BY Total_Orders DESC;


-- What are the Top 10 Ordered Dishes?
SELECT TOP 10
	d.Dish_Name,
	COUNT(f.order_id) AS Total_Order
FROM fact_swiggy_orders f
LEFT JOIN dim_dish d
	ON f.dish_id = d.dish_id
GROUP BY d.Dish_Name
ORDER BY Total_Order DESC;

-- Cuisine Performane (Orders + Avg. Rating)
SELECT
	c.category,
	COUNT(f.order_id) AS Total_Orders,
	AVG(f.rating) AS Avg_Rating
FROM fact_swiggy_orders f
LEFT JOIN dim_category c
	ON f.category_id =c.category_id
GROUP BY c.category
ORDER BY Total_Orders DESC;

-- total Orders by Price Range
SELECT
	CASE
		WHEN Price_INR < 100 THEN 'under 100'
		WHEN Price_INR BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN Price_INR BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN Price_INR BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE '500+'
	END AS Price_Range,
	COUNT(order_id) AS Total_Orders
FROM fact_swiggy_orders
GROUP BY
	CASE
		WHEN Price_INR < 100 THEN 'under 100'
		WHEN Price_INR BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN Price_INR BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN Price_INR BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE '500+'
	END 
ORDER BY Total_Orders DESC;
