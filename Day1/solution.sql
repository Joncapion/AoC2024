DROP TABLE IF EXISTS #star1
SELECT 
	column1,
	SUBSTRING(column1, PATINDEX('%[0-9]%', column1), 1) AS first_value,
	SUBSTRING(REVERSE(column1), PATINDEX('%[0-9]%',REVERSE(column1)), 1) AS last_value
INTO #star1
FROM AoC2024.dbo.day1

SELECT SUM(CAST((first_value+last_value) AS INT)) AS result
FROM #star1
--------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #star2_clean
DROP TABLE IF EXISTS #star2

SELECT
	column1,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(column1, 'one','one1one'), 'two','two2two'), 'three','three3three'), 'four','four4four'), 'five','five5five'), 'six','six6six'), 'seven','seven7seven'), 'eight','eight8eight'), 'nine','nine9nine') AS column1_clean
INTO #star2_clean
FROM AoC2024.dbo.day1


SELECT
	SUBSTRING(column1_clean, PATINDEX('%[0-9]%', column1_clean), 1) AS first_value,
	SUBSTRING(REVERSE(column1_clean), PATINDEX('%[0-9]%',REVERSE(column1_clean)), 1) AS last_value
INTO #star2
FROM #star2_clean

SELECT SUM(CAST((first_value+last_value) AS INT)) AS result
FROM #star2
