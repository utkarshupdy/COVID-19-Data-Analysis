use coronaAnalysis;
SELECT * FROM corona;

-- Q1. write a code to check NULL values
select * from corona
where Province is NULL or Country_Region is NULL or Latitude is NULL or Longitude is NULL or Date is NULL
or Confirmed is NULL or Deaths is NULL or Recovered is NULL;
-- Answer :- No Null value are present

-- Q2. If NULL values are present, update them with zeros for all columns.
UPDATE corona
SET
Province=COALESCE(Province,'0'),
Country_Region=COALESCE(Country_Region,'0'),
Latitude=COALESCE(Latitude,0.0),
Longitude=COALESCE(Longitude,0.0),
Date=COALESCE(Date,'0'),
Confirmed=COALESCE(Confirmed,0),
Deaths=COALESCE(Deaths,0),
Recovered=COALESCE(Recovered,0);
-- Answer :- no need to update 

-- Q3. check total number of rows
select count(*) from corona;
-- Output:- 78386

-- Q4. Check what is start_date and end_date

ALTER TABLE corona
MODIFY Date DATE;

SELECT 
    MIN(date) AS start_date, MAX(date) AS end_date
FROM
    corona;


CREATE VIEW monthly_data AS
SELECT 
    Province, 
    Country_Region, 
    Latitude, 
    Longitude, 
    Date, 
    Confirmed, 
    Deaths, 
    Recovered,
    EXTRACT(YEAR FROM Date) AS Year,
    EXTRACT(MONTH FROM Date) AS Month
FROM corona;

-- Q5. Number of month present in dataset
select  count(distinct month) as no_of_month
from monthly_data;

-- Q6. Find monthly average for confirmed, deaths, recovered
select month, avg(confirmed) as avg_confirmed, avg(deaths) as avg_deaths, avg(recovered) as avg_recovered
from monthly_data
group by month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
select month, confirmed from (select month, confirmed, count(confirmed) as freq_con,
row_number() over(partition by month order by count(confirmed) desc) as rn
from monthly_data
group by month,confirmed) as s
where rn = 1;

select month, deaths from (select month, deaths, count(deaths) as freq_con,
row_number() over(partition by month order by count(deaths) desc) as rn
from monthly_data
group by month,deaths) as s
where rn = 1;

select month, recovered from (select month, recovered, count(recovered) as freq_con,
row_number() over(partition by month order by count(recovered) desc) as rn
from monthly_data
group by month,recovered) as s
where rn = 1;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    Year,
    MIN(Confirmed) AS Min_Confirmed,
    MIN(Deaths) AS Min_Deaths,
    MIN(Recovered) AS Min_Recovered
FROM monthly_data
GROUP BY Year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    Year,
    MAX(Confirmed) AS Max_Confirmed,
    MAX(Deaths) AS Max_Deaths,
    MAX(Recovered) AS Max_Recovered
FROM monthly_data
GROUP BY Year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
select month, sum(confirmed) as total_confirmed, sum(deaths) as total_deaths, sum(recovered) as total_recovered
from monthly_data
group by month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Confirmed) AS confirmed_total,AVG(Confirmed) AS confirmed_average,VARIANCE(Confirmed) AS confirmed_variance,
STDDEV(Confirmed) AS confirmed_STANDARD_dev
FROM corona
GROUP BY year,month


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Deaths) AS Deaths_total,AVG(Deaths) AS Deaths_average,VARIANCE(Deaths) AS Deaths_variance,
STDDEV(Deaths) AS Deaths_STANDARD_dev
FROM corona
GROUP BY year,month


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Recovered) AS Recovered_total,AVG(Recovered) AS Recovered_average,VARIANCE(Recovered) AS Recovered_variance,
STDDEV(Recovered) AS Recovered_STANDARD_dev
FROM corona
GROUP BY year,month

-- Q14. Find Country having highest number of the Confirmed case

SELECT Country_Region,SUM(Confirmed) AS total_confirm
FROM corona
GROUP BY Country_Region
ORDER BY total_confirm DESC
LIMIT 1


-- Q15. Find Country having lowest number of the death case

SELECT Country_Region,SUM(Deaths) AS total_death
FROM corona
GROUP BY Country_Region
ORDER BY total_death 
LIMIT 4


-- Q16. Find top 5 countries having highest recovered case

SELECT Country_Region,SUM(Recovered) AS total_recovered
FROM corona
GROUP BY Country_Region
ORDER BY total_recovered DESC
LIMIT 5

