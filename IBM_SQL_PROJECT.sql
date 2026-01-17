/*                                                        PROJECT- Chicago Socio-Economic, Crime & School Data Analysis

OBJECTIVE:
This project uses real-world Chicago census, crime, and public school datasets to perform practical data analysis using SQL.
Key goals include:
- Practicing core SQL concepts such as: Data filtering, aggregation, sorting, grouping, and subqueries
- Analyzing data from multiple related datasets: Chicago census data, crime records, and public school information
- Deriving meaningful analytical insights such as: Crime-prone community areas, socio-economic hardship patterns, poverty levels, and school safety trends*/


select * from chicagocensusdata; /*Socio-economic data by community area
Income, poverty %, hardship index, etc.*/

select * FROM chicagopublicschools;/*Chicago public school information
School type, safety score, performance indicators*/

select * FROM chicagocrimedata;/*Crime records in Chicago
Crime type, location, description, community area*/


/*Problem 1
Find the total number of crimes recorded in the CRIME table.*/
select count(*) from chicagocensusdata;

/*Problem 2
List community area names and numbers with per capita income less than 11000.*/
SELECT COMMUNITY_AREA_NUMBER,COMMUNITY_AREA_NAME, PER_CAPITA_INCOME
FROM chicagocensusdata
WHERE PER_CAPITA_INCOME <11000;

/* Problem 3
List all case numbers for crimes involving minors?(children are not considered minors for the purposes of crime analysis)*/
SELECT CASE_NUMBER
FROM chicagocrimedata
WHERE DESCRIPTION LIKE '%MINOR%';

/*Problem 4
List all kidnapping crimes involving a child?*/
SELECT *
FROM chicagocrimedata
WHERE PRIMARY_TYPE = 'KIDNAPPING'
AND DESCRIPTION LIKE '%CHILD%';

/*Problem 5
List the kind of crimes that were recorded at schools. (No repetitions)*/
SELECT DISTINCT(PRIMARY_TYPE)	FROM chicagocrimedata WHERE LOCATION_DESCRIPTION
AND DESCRIPTION LIKE '%SCHOOL%';
SELECT * FROM indian_data.chicagocrimedata;

/*Problem 6
List the type of schools along with the average safety score for each type.*/
SELECT "Elementary, Middle, or High School" AS School_Type,
       AVG(SAFETY_SCORE) AS Average_Safety_Score
FROM chicagopublicschools
GROUP BY "Elementary, Middle, or High School";
select AVG(SAFETY_SCORE) AS Average_Safety_Score
FROM chicagopublicschools;

/*Problem 7
List 5 community areas with highest % of households below poverty line*/
SELECT COMMUNITY_AREA_NAME, PERCENT_HOUSEHOLDS_BELOW_POVERTY
FROM chicagocensusdata
ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC
LIMIT 5;

/*Problem 8
Which community area is most crime prone? Display the coumminty area number only.
Double-click here for a hint*/
SELECT COMMUNITY_AREA_NUMBER
FROM chicagocrimedata
GROUP BY COMMUNITY_AREA_NUMBER
ORDER BY COUNT(*) DESC
LIMIT 1;

/*Problem 9
Use a sub-query to find the name of the community area with highest hardship index*/
SELECT COMMUNITY_AREA_NAME
FROM chicagocensusdata
WHERE HARDSHIP_INDEX = (
    SELECT MAX(HARDSHIP_INDEX) FROM chicagocensusdata
);

/*Problem 10
Use a sub-query to determine the Community Area Name with most number of crimes?*/
SELECT COMMUNITY_AREA_NAME
FROM chicagocensusdata
WHERE COMMUNITY_AREA_NUMBER = (
    SELECT COMMUNITY_AREA_NUMBER
    FROM chicagocrimedata
    GROUP BY COMMUNITY_AREA_NUMBER
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
