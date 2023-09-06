--creation of a table called breweries--
CREATE TABLE breweries(
	sales_id int primary key,
	sales_rep text,
	emails varchar,
	brands text,
	plant_cost int,
	unit_price int,
	quantity int,
	cost int,
	profit int,
	countries text,
	region text,
	months text,
	year varchar
);


--now to view the created table--
SELECT * FROM breweries


--copying the dataset csv file into my empty table breweries--
copy breweries
FROM 'C:\Users\Delani\Documents\cortouch project\International_Breweries.csv'
DELIMITER ',' csv
HEADER;


--on to view the table after copying the csv file into it--
SELECT * FROM breweries

--to view distinct countries from the table--
SELECT DISTINCT countries FROM breweries

SELECT * FROM breweries


--PROFIT ANALYSIS--

--1. Within the space of the last three years, what was the profit worth of the breweries, inclusive of the anglophone and the francophone territories?--

SELECT SUM(profit) AS total_profit_in_3_years
FROM breweries

--2. Compare the total profit between these two territories in order for the territory manager, Mr. Stone made a strategic decision that will aid profit maximization in 2020--
--ANGLOPHONE COUNTRIES--
SELECT  countries, SUM(profit) AS total_profit
FROM breweries
WHERE countries IN('Nigeria', 'Ghana')
GROUP BY 1

--FRANCOPHONE COUNTRIES--
SELECT countries, SUM(profit) AS total_profit 
FROM breweries
WHERE countries IN('Senegal','Togo', 'Benin')
GROUP BY 1


--3. Country that generated the highest profit in 2019--
SELECT countries, SUM(profit) AS profit_2019 
FROM breweries
WHERE year = '2019'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1


-- 4. Help him find the year with the highest profit.--
SELECT year, SUM(profit) AS highest_profit 
FROM breweries
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1


--5. What was the minimum profit in the month of December 2018?--
SELECT year, months, (MIN(profit)) AS minimum_profit
FROM breweries 
WHERE months = 'December' AND year = '2018'
GROUP BY 1,2


--BRAND ANALYSIS--

--1. Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries--
SELECT brands, SUM(quantity) AS quantity_consumed, SUM(profit) AS profit
FROM breweries
WHERE countries NOT IN('Nigeria', 'Ghana') AND year NOT IN('2017')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3


--2. Find out the top two choice of consumer brands in Ghana--
SELECT brands, SUM(quantity) AS consumer_choice, SUM(profit) AS profit
FROM breweries
WHERE countries = ('Ghana')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2


--3. Favorites malt brand in Anglophone region between 2018 and 2019--
SELECT brands, SUM(quantity) AS quantity_sold, SUM(profit) AS profit
FROM breweries
WHERE countries IN('Nigeria', 'Ghana') AND year IN('2018', '2019') AND brands IN('beta malt','grand malt' )
GROUP BY 1
ORDER BY 2 DESC


--4. Which brands sold the highest in 2019 in Nigeria?--
SELECT brands, SUM(quantity) AS sales_made
FROM breweries
WHERE countries = ('Nigeria') AND year = ('2019')
GROUP BY 1
ORDER BY 2 DESC


--5. Beer consumption in Nigeria--
SELECT brands, SUM(quantity) AS consumption_rate
FROM breweries
WHERE countries = ('Nigeria') AND brands NOT IN('beta malt', 'grand malt')
GROUP BY 1
ORDER BY 2 ASC


--COUNTRY ANALYSIS--

--1. Country with the highest consumption of beer.--
SELECT countries, SUM(quantity) AS consumption
FROM breweries
WHERE brands NOT IN('grand malt', 'beta malt')
GROUP BY 1
ORDER BY 2 DESC


--2. Country with the highest consumption of malt.--
SELECT countries, SUM(quantity) AS consumption
FROM breweries
WHERE brands IN('beta malt', 'grand malt')
GROUP BY 1
ORDER BY 2 DESC





