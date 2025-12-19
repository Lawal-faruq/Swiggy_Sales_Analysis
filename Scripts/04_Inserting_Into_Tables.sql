-- INSERTING DATA INTO TABLES

-- dim_date
INSERT INTO dim_date (Full_Date, Year, Month, month_name, Quarter, Day, Week)
SELECT DISTINCT
	Order_Date,
	YEAR(Order_Date),
	MONTH(Order_Date),
	DATENAME(MONTH, Order_Date),
	DATEPART(QUARTER, Order_Date),
	DAY(Order_Date),
	DATEPART(WEEK, Order_Date)
FROM swiggy_data
WHERE Order_Date IS NOT NULL;

-- Inspecting the Date Table
SELECT *
FROM dim_date;

-- dim_location
INSERT INTO dim_location(State, City, Location)
SELECT DISTINCT
	State,
	City,
	Location
FROM swiggy_data

-- Inspecting the dim_location Table
SELECT *
FROM dim_location;

-- dim_restaurant
INSERT INTO dim_restaurant (Restaurant_Name)
SELECT DISTINCT
	restaurant_name
FROM swiggy_data;

-- Inspecting the dim_restaurant Table
SELECT *
FROM dim_restaurant;

-- dim_category
INSERT INTO dim_category(category)
SELECT DISTINCT
	Category
FROM swiggy_data;

-- Inspecting the dim_category Table
SELECT *
FROM dim_category;

-- dim_dish
INSERT INTO dim_dish(Dish_Name)
SELECT DISTINCT
	Dish_Name
FROM swiggy_data;


-- Inspecting the dim_dish Table
SELECT *
FROM dim_dish;

-- FACT TABLE
INSERT INTO fact_swiggy_orders
(
	date_id,
	Price_INR,
	Rating,
	Rating_Count,
	location_id,
	restaurant_id,
	category_id,
	dish_id
)
SELECT
	dd.date_id,
	s.Price_INR,
	s.Rating,
	s.Rating_Count,
	dl.location_id,
	dr.restaurant_id,
	dc.category_id,
	dsh.dish_id
FROM swiggy_data s
JOIN dim_date dd
	ON dd.Full_Date = s.Order_Date

JOIN dim_location dl
	ON dl.State = s.State
	AND dl.City = s.City
	AND dl.Location = s.Location

JOIN dim_restaurant dr
	ON dr.Restaurant_Name = s.Restaurant_Name

JOIN dim_category dc
	ON	dc.category = s.Category

JOIN dim_dish dsh
	ON dsh.Dish_Name = s.Dish_Name;



-- Inspecting the fact Table
SELECT *
FROM fact_swiggy_orders;

-- Inspecting all the tables in one query
SELECT * FROM fact_swiggy_orders f
LEFT JOIN dim_date d ON f.date_id = d.date_id
LEFT JOIN dim_location l ON f.location_id = l.location_id
LEFT JOIN dim_restaurant r ON f.restaurant_id = r.restaurant_id
LEFT JOIN dim_category c ON f.category_id = c.category_id
LEFT JOIN dim_dish di ON f.dish_id = di.dish_id;
