-- PROJECT 2
-- Select Statement
-- 1. Retrieve all columns from the `stolen_vehicles` table.
SELECT *
FROM stolen_vehicles;


SELECT Vehicle_type, COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY Vehicle_type;


-- 2. Select only the `vehicle_type`, `make_id`, and `color` columns from the `stolen_vehicles` table.
SELECT Vehicle_type, Make_Id, Color
FROM stolen_vehicles;

-- From Statement
 -- 1. Write a query to display all records from the `make_details` table.
 SELECT *
 FROM make_details AS M;
 
-- 2. Retrieve all columns from the `locations` table.
SELECT *
FROM location AS L;

-- Where Statement
-- 1. Find all stolen vehicles that are of type "Trailer".
SELECT *
FROM stolen_vehicles
WHERE Vehicle_type = 'Trailer';

-- 2. Retrieve all stolen vehicles that were stolen after January 1, 2022.
SELECT * 
FROM stolen_vehicles
WHERE Date_Stolen > '2022-01-01';

SELECT MONTH(Date_Stolen) AS theft_month, 
       COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY MONTH(Date_Stolen)
ORDER BY total_stolen DESC;


-- 3. Find all stolen vehicles that are of color "Silver".
SELECT *
FROM stolen_vehicles
WHERE Color = "Silver";

-- Group By and Order By
-- 1. Count the number of stolen vehicles for each `vehicle_type` and order the results by the count in descending order.
SELECT Vehicle_type, COUNT(*) AS Total_Stolen
FROM stolen_vehicles AS S
GROUP BY Vehicle_type
ORDER BY Total_Stolen DESC;

-- 2. Find the total number of stolen vehicles for each `make_id` and order the results by `make_id`.
SELECT  Make_Id, COUNT(*) AS Make_Id_Stolen
FROM stolen_vehicles
GROUP BY Make_Id
ORDER BY  Make_Id_Stolen;

-- Using Having vs. Where Statement
-- 1. Find the `make_id` values that have more than 10 stolen vehicles.
SELECT make_id, COUNT(*) as total_stolen
FROM stolen_vehicles
GROUP BY make_id
HAVING total_stolen > 10;

-- 2. Retrieve the `vehicle_type` values that have at least 5 stolen vehicles.
SELECT Vehicle_type, COUNT(*) AS Total_Stolen
FROM stolen_vehicles
GROUP BY Vehicle_type
HAVING Total_Stolen >= 5;

-- Limit and Aliasing
-- 1. Retrieve the first 10 records from the `stolen_vehicles` table and alias the `vehicle_type` column as "Type".
SELECT Vehicle_type AS Type
FROM stolen_vehicles
LIMIT 10;

-- 2. Find the top 5 most common colors of stolen vehicles and alias the count column as "Total".
SELECT Color, count(*) AS Total
FROM stolen_vehicles
GROUP BY Color
ORDER BY Total DESC
LIMIT 5;

SELECT Color,
       COUNT(*) AS Total,
       ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)), 2) AS Percentage
FROM stolen_vehicles
GROUP BY Color
ORDER BY Total DESC
LIMIT 5;

-- Joins in MySQL
-- 1. Join the `stolen_vehicles` table with the `make_details` table to display the `vehicle_type`, `make_name`, and `color` of each stolen vehicle.
SELECT vehicle_id, Vehicle_type, S.Make_Id, Make_Name, Model_Year, Vehicle_Desc, Color, Date_Stolen, Location_Id
FROM stolen_vehicles AS S
INNER JOIN  make_details AS M
ON S.Make_Id = M.Make_Id;

-- 2. Join the `stolen_vehicles` table with the `locations` table to display the `vehicle_type`, `region`, and `country` where the vehicle was stolen.
SELECT Vehicle_type, Region, Country
FROM stolen_vehicles AS S
INNER JOIN location AS L
ON S.Location_Id = L.Location_Id;

SELECT Vehicle_type, COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY Vehicle_type
ORDER BY total_stolen DESC
LIMIT 1;


SELECT Vehicle_Desc, COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY Vehicle_Desc
ORDER BY total_stolen DESC
LIMIT 1;


SELECT Model_Year, COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY Model_Year
ORDER BY total_stolen DESC
LIMIT 1;



-- Unions in MySQL
-- 1. Write a query to combine the `make_name` from the `make_details` table and the `region` from the `locations` table into a single column.
SELECT Make_Name AS Combine_Name
FROM make_details
UNION
SELECT Region
FROM location;




-- 2. Combine the `vehicle_type` from the `stolen_vehicles` table and the `make_type` from the `make_details` table into a single column.
SELECT Vehicle_type
FROM stolen_vehicles
UNION
SELECT Make_Type
FROM make_details;

-- Case Statements
-- 1. Create a new column called "Vehicle_Category" that categorizes vehicles as "Luxury" if the `make_type` is "Luxury" and "Standard" otherwise.
SELECT *,
CASE WHEN Make_Type = 'Luxury' THEN 'Luxury' ELSE 'Standard' END AS Vehicle_Category
FROM stolen_vehicles AS S
INNER JOIN make_details AS M  
ON S.Make_Id = M.Make_Id;

-- 2. Use a CASE statement to categorize stolen vehicles as "Old" if the `model_year` is before 2010, "Mid" if between 2010 and 2019, and "New" if 2020 or later.
SELECT *, 
CASE WHEN model_year < 2010 THEN 'Old'
WHEN model_year BETWEEN 2010 AND 2019 THEN 'Mid'
ELSE 'New'
END AS Vehicle_Age
FROM stolen_vehicles;


SELECT Vehicle_Age,
       COUNT(*) AS total_stolen,
       ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)), 2) AS percentage
FROM (
    SELECT *,
           CASE 
               WHEN model_year < 2010 THEN 'Old'
               WHEN model_year BETWEEN 2010 AND 2019 THEN 'Mid'
               ELSE 'New'
           END AS Vehicle_Age
    FROM stolen_vehicles
) AS sub
GROUP BY Vehicle_Age
ORDER BY total_stolen DESC;


-- Aggregate Functions
-- 1. Calculate the total number of stolen vehicles.
SELECT COUNT(*) AS total_stolen_vehicles
FROM stolen_vehicles;

-- 2. Find the average population of regions where vehicles were stolen.
SELECT ROUND(AVG(Population),2) AS average_population
FROM stolen_vehicles AS S
INNER JOIN location AS L
ON S.location_id = L.location_id;

-- 3. Determine the maximum and minimum `model_year` of stolen vehicles.
SELECT MAX(model_year) AS max_model_year, MIN(model_year) AS min_model_year
FROM stolen_vehicles;

-- String Functions
-- 1. Retrieve the `make_name` from the `make_details` table and convert it to uppercase.
SELECT UPPER(make_name) AS make_name_uppercase
FROM make_details;

-- 2. Find the length of the `vehicle_desc` for each stolen vehicle.
SELECT vehicle_Desc, LENGTH(vehicle_Desc) AS Desc_length
FROM stolen_vehicles;

-- 3. Concatenate the `vehicle_type` and `color` columns from the `stolen_vehicles` table into a single column called "Description".
SELECT CONCAT(vehicle_type, ' - ', color) AS Description
FROM stolen_vehicles;

-- Update Records
-- 1. Update the `color` of all stolen vehicles with `vehicle_type` "Trailer" to "Black".
UPDATE stolen_vehicles
SET color = 'Black'
WHERE vehicle_type = 'Trailer';


-- 2. Change the `make_name` of `make_id` 623 to "New Make Name" in the `make_details` table.
UPDATE make_details
SET make_name = 'New Make Name'
WHERE make_id = 623;

-- Bonus Questions
-- 1. Write a query to find the top 3 regions with the highest number of stolen vehicles.
SELECT Region, COUNT(Vehicle_id) as total_stolen
FROM stolen_vehicles AS S
INNER JOIN location AS L 
ON S.Location_id = l.location_id
GROUP BY l.region
ORDER BY total_stolen DESC
LIMIT 3;


SELECT l.Region,
       COUNT(*) AS total_stolen,
       ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)), 2) AS percentage
FROM stolen_vehicles AS s
JOIN location AS l
  ON s.Location_Id = l.Location_id
GROUP BY l.Region
ORDER BY total_stolen DESC;



-- 2. Retrieve the `make_name` and the total number of stolen vehicles for each make, but only for makes that have more than 5 stolen vehicles.
SELECT Make_Name, COUNT(Vehicle_Id) as total_stolen
FROM stolen_vehicles AS S 
JOIN make_details AS M
ON S.make_id = M.make_id
GROUP BY M.make_name
HAVING total_stolen > 5;

SELECT M.Make_Name,
       S.Vehicle_type,
       AVG(S.Model_Year) AS average_year,
       CASE 
           WHEN COUNT(S.Vehicle_Id) > 50 THEN 'High Risk'
           WHEN COUNT(S.Vehicle_Id) BETWEEN 11 AND 50 THEN 'Medium Risk'
           ELSE 'Low Risk'
       END AS risk_level,
       COUNT(S.Vehicle_Id) AS total_stolen
FROM stolen_vehicles AS S
JOIN make_details AS M
  ON S.make_id = M.make_id
GROUP BY M.Make_Name, S.Vehicle_type
HAVING COUNT(S.Vehicle_Id) = 5
ORDER BY total_stolen DESC;





-- 3. Use a JOIN to find the `region` and `country` where the most vehicles were stolen.
SELECT Region, Country, COUNT(Vehicle_id) as Total_stolen
FROM stolen_vehicles AS S
INNER JOIN location AS L 
ON S.location_id = L.location_id
GROUP BY Region, Country
ORDER BY Total_stolen DESC
LIMIT 1;

-- 4. Write a query to find the percentage of stolen vehicles that are of type "Boat Trailer".
SELECT (COUNT(CASE WHEN Vehicle_type = 'Boat Trailer' THEN Vehicle_id END) * 100.0 / COUNT(Vehicle_id)) as percentage
FROM stolen_vehicles;

-- 5. Use a CASE statement to create a new column called "Density_Category" that categorizes regions as "High Density" if `density` is greater than 500, "Medium Density" if between 200 and 500, and "Low Density" if less than 200.
SELECT Region, Density,
CASE WHEN l.density > 500 THEN 'High Density'
WHEN Density BETWEEN 200 AND 500 THEN 'Medium Density'
ELSE 'Low Density'
END AS Density_Category
FROM location;