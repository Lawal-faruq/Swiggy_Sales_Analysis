-- CREATING SCHEMA

-- DIMENSION TABLES
-- DATE TABLE
CREATE TABLE dim_date (
	date_id INT IDENTITY(1,1) PRIMARY KEY,
	Full_Date DATE,
	Year INT,
	Month INT,
	month_name VARCHAR(20),
	Quarter INT,
	Day INT,
	Week INT
	);

-- dim_location
CREATE TABLE dim_location (
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	State VARCHAR(100),
	City VARCHAR(100),
	Location VARCHAR(100),
	);

-- dim_restaurant
CREATE TABLE dim_restaurant (
	restaurant_id INT IDENTITY(1,1) PRIMARY KEY,
	Restaurant_Name VARCHAR(200),
	);

-- dim_category
CREATE TABLE dim_category (
	category_id INT IDENTITY(1,1) PRIMARY KEY,
	category VARCHAR(200),
	);

-- dim_dish
CREATE TABLE dim_dish (
	dish_id INT IDENTITY(1,1) PRIMARY KEY,
	Dish_Name VARCHAR(200),
	);

-- FACT TABLE
CREATE TABLE fact_swiggy_orders (
	order_id INT IDENTITY(1,1) PRIMARY KEY,
	
	date_id INT,
	Price_INR DECIMAL(10,2),
	Rating DECIMAL(4,2),
	Rating_Count INT,

	location_id INT,
	restaurant_id INT,
	category_id INT,
	dish_id INT,

	FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
	FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
	FOREIGN KEY (restaurant_id) REFERENCES dim_restaurant(restaurant_id),
	FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
	FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id)
