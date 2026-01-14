SELECT * FROM Hospital_Patients_2

-- Age of death
-- How many patients that are still alive and how many die
-- Number of Gender
-- most birth Year and month
-- Highest birth  by city, country, County
-- Number of  death by gender
-- hightest birth by Ethnicity



-- Age of death

SELECT * FROM Hospital_Patients_2

SELECT BIRTHDATE, DEATHDATE,
DATEDIFF(YEAR,BIRTHDATE , DEATHDATE) AS DEATH_AGE
FROM Hospital_Patients_2 
WHERE DATEDIFF(YEAR,BIRTHDATE , DEATHDATE) IS NOT NULL
ORDER BY DEATH_AGE
 



-- How many patients that are still alive and how many die


--Patients still alive (820)
 SELECT
 CONCAT( FIRST_NAME,' ', LAST_NAME) AS FULL_NAME,
 BIRTHDATE AS Patients_Alive ,DEATHDATE
FROM Hospital_Patients_2
WHERE DEATHDATE IS NULL
ORDER BY BIRTHDATE

--Patients not alive (154)
SELECT
CONCAT( FIRST_NAME,' ', LAST_NAME) AS FULL_NAME,
	DEATHDATE AS Patients_not_alive
FROM Hospital_Patients_2
WHERE DEATHDATE IS NOT NULL
ORDER BY BIRTHDATE

SELECT * FROM Hospital_Patients_2
-- Number of Gender

SELECT GENDER,
COUNT(GENDER) AS No_of_Gender
FROM Hospital_Patients_2
GROUP BY GENDER

-- Number of death patients by Gender

SELECT GENDER, 
COUNT(GENDER) AS DEATH_BY_GENDER
FROM Hospital_Patients_2
WHERE DEATHDATE IS NOT NULL
GROUP BY GENDER


-- Count of death by city

SELECT CITY,RACE, ETHNICITY,
COUNT(CITY) AS No_of_death_by_City
FROM Hospital_Patients_2
WHERE DEATHDATE IS NOT NULL
GROUP BY CITY, RACE, ETHNICITY
ORDER BY  No_of_death_by_City DESC

-- Count of Ethnicity

SELECT ETHNICITY,
COUNT(ETHNICITY) AS Birth_by_Ethicity
FROM Hospital_Patients_2
WHERE BIRTHDATE IS NOT NULL
GROUP BY ETHNICITY
ORDER BY ETHNICITY

-- Count of Race

SELECT RACE,
COUNT(RACE) AS Birth_by_RACE
FROM Hospital_Patients_2
WHERE BIRTHDATE IS NOT NULL
GROUP BY RACE
ORDER BY Birth_by_RACE DESC



SELECT DISTINCT COUNTY
FROM Hospital_Patients_2

-- Number of birth each country.

SELECT BIRTH_COUNTRY,
COUNT (BIRTH_COUNTRY) AS NUM_OF_BIRTH_BY_COUNTRY
FROM Hospital_Patients_2
GROUP BY BIRTH_COUNTRY
ORDER BY NUM_OF_BIRTH_BY_COUNTRY DESC


SELECT* FROM Hospital_Patients_2








