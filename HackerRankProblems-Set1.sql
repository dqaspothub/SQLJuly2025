-- HACKER RANK PROBLEMS --

-- Revising the Select Query I

SELECT
    id          AS city_id,
    name        AS city_name,
    countrycode AS country_code,
    district    AS city_district,
    population  AS city_population 
FROM city
WHERE population > 100000
    AND countrycode = 'USA';
	
-- Revising the Select Query II

SELECT Name FROM CITY WHERE POPULATION >120000 and CountryCode = "USA";

-- Select All

SELECT * FROM CITY;

Select By ID

SELECT * FROM CITY WHERE ID = 1661;

-- Japanese Cities' Attributes

SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Japanese Cities' Names

SELECT name FROM CITY WHERE COUNTRYCODE ='JPN';

-- Weather Observation Station 1

SELECT CITY,STATE FROM STATION;

-- Weather Observation Station 3

SELECT DISTINCT
    city AS station_city
FROM station
WHERE id % 2 = 0;

-- Weather Observation Station 4

SELECT
    -- diff := difference between the number of total and distinct city entries in station. 
    COUNT(city) - COUNT(DISTINCT city) AS diff
FROM station;

-- Revising Aggregations - The Count Function

SELECT COUNT(ID) FROM CITY
WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function

SELECT SUM(POPULATION) FROM CITY
WHERE DISTRICT='California';

-- Revising Aggregations - Averages

SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT='California';

-- Average Population

SELECT ROUND(AVG(POPULATION))
FROM CITY;

-- Population Density Difference

SELECT (MAX(POPULATION) - MIN(POPULATION)) as difference_value FROM CITY