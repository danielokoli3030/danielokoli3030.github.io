USE ProjectData

SELECT * FROM Hospital_Patients

-- 1. Remove duplicates
  -- 2. Standardize the data
  --.3. Null values or black values
  -- 4. Remove any  unwanted columns

  -- Creating a duplicate from the main table

  SELECT *
  INTO Hospital_Patients_2
  FROM Hospital_Patients 

  SELECT * FROM Hospital_Patients_2

-- 1.Check and  Remove duplicates if any

SELECT 
ROW_NUMBER() OVER(PARTITION BY FIRST, LAST,ADDRESS ORDER BY(FIRST) ) AS ROW_NUM, 
 FIRST, LAST,ADDRESS
FROM Hospital_Patients_2



;WITH CTE_ROW_NUM AS (
	SELECT 
		ROW_NUMBER() OVER(PARTITION BY FIRST, LAST,ADDRESS ORDER BY(FIRST) ) AS ROW_NUM, 
		FIRST, LAST,ADDRESS
	FROM Hospital_Patients_2
)
SELECT FIRST, LAST,ADDRESS
FROM CTE_ROW_NUM
WHERE ROW_NUM > 1



-- 2. STANDARDIZE THE DATA
SELECT * FROM Hospital_Patients_2

--Remove on wanted columns

ALTER TABLE Hospital_Patients_2
DROP COLUMN PREFIX,SUFFIX,MAIDEN,LAT,LON

-- Name Cleaning

SELECT FIRST AS Original_Name,
SUBSTRING(FIRST,1,PATINDEX('%[1-9]%',FIRST)-1) AS NEW_Name
FROM Hospital_Patients_2

;WITH CTE_UPDATE_NAME AS (

SELECT FIRST AS Original_Name,
SUBSTRING(FIRST,1,PATINDEX('%[1-9]%',FIRST)-1) AS NEW_Name
FROM Hospital_Patients_2
)
UPDATE CTE_UPDATE_NAME
SET Original_Name = NEW_Name


SELECT LAST AS Original_Name,
SUBSTRING(LAST,1,PATINDEX('%[1-9]%',LAST)-1) AS NEW_Name
FROM Hospital_Patients_2

;WITH CTE_UPDATE_NAME AS (

SELECT LAST AS Original_Name,
SUBSTRING(LAST, 1,PATINDEX('%[1-9]%',LAST)-1) AS NEW_Name
FROM Hospital_Patients_2
)
UPDATE CTE_UPDATE_NAME
SET Original_Name = NEW_Name

-- Corrupted Name

SELECT FIRST
FROM Hospital_Patients_2
WHERE FIRST LIKE '%[^A-Za-z]%' 


SELECT DISTINCT LAST
FROM Hospital_Patients_2
WHERE LAST LIKE '%?%' 


UPDATE Hospital_Patients_2
SET FIRST =
    REPLACE(
       REPLACE(
			REPLACE(
				REPLACE(
					REPLACE(
						REPLACE(
							REPLACE(
								REPLACE(
									REPLACE(FIRST, '??a', 'á'),
								'??e', 'é'),
							'??i', 'í'),
						 '??o', 'ó'),
					'??u','ú'),
				'??', 'í' ),
			'?°', 'ó' ),
		'?©', 'é' ),
	'?±', 'ñ')

   
WHERE FIRST LIKE '%?%';

-- Change the Column name

SELECT * FROM Hospital_Patients_2

--FIRST
ALTER TABLE Hospital_Patients_2
ADD FIRST_NAME VARCHAR(100)


UPDATE Hospital_Patients_2
SET FIRST_NAME = FIRST

ALTER TABLE Hospital_Patients_2
DROP COLUMN FIRST

--LAST
ALTER TABLE Hospital_Patients_2
ADD LAST_NAME VARCHAR(100)


UPDATE Hospital_Patients_2
SET LAST_NAME = LAST

ALTER TABLE Hospital_Patients_2
DROP COLUMN LAST


SELECT BIRTHPLACE,
RIGHT (BIRTHPLACE, CHARINDEX(' ',REVERSE ( BIRTHPLACE))) AS BIRTH_COUNTRY
FROM Hospital_Patients_2


ALTER TABLE Hospital_Patients_2
ADD BIRTH_COUNTRY VARCHAR(100)

UPDATE Hospital_Patients_2
SET BIRTH_COUNTRY = RIGHT (BIRTHPLACE, CHARINDEX(' ',REVERSE ( BIRTHPLACE)))



SELECT BIRTHPLACE,
LEFT(BIRTHPLACE, LEN(BIRTHPLACE)-CHARINDEX(' ',REVERSE(BIRTHPLACE))) AS BIRTHPLACE
FROM Hospital_Patients_2

UPDATE Hospital_Patients_2
SET BIRTHPLACE = LEFT(BIRTHPLACE, LEN(BIRTHPLACE)-CHARINDEX(' ',REVERSE(BIRTHPLACE)))
WHERE BIRTHPLACE LIKE '% %'

-- This table is ready for visualiztion 

SELECT *
FROM Hospital_Patients_2

