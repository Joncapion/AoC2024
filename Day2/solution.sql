SELECT top 10 *
FROM AoC2024.dbo.day2

DROP TABLE IF EXISTS #star1
SELECT
	CAST(RIGHT(column1, LEN(column1)-5) AS INT) as game,
	CASE
		WHEN PATINDEX('% 1[3-9] red%', column2) = 0 AND PATINDEX('% [2-9][0-9] red%', column2) = 0
		THEN 1
		ELSE 0
	END AS red,
	CASE
		WHEN PATINDEX('% 1[4-9] green%', column2) = 0 AND PATINDEX('% [2-9][0-9] green%', column2) = 0
		THEN 1
		ELSE 0
	END AS green,
	CASE
		WHEN PATINDEX('% 1[5-9] blue%', column2) = 0 AND PATINDEX('% [2-9][0-9] blue%', column2) = 0
		THEN 1
		ELSE 0
	END AS blue
INTO #star1
FROM AoC2024.dbo.day2


SELECT SUM(game) as result
FROM #star1
WHERE red = 1 AND green = 1 AND blue = 1
--------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS #batch_clean
DROP TABLE IF EXISTS #colour_clean
DROP TABLE IF EXISTS #number_colour
DROP TABLE IF EXISTS #max
DROP TABLE IF EXISTS #star2

SELECT 
	CAST(RIGHT(column1, LEN(column1)-5) AS INT) as game,
	REPLACE(column2, ';',',') AS cs
INTO #batch_clean
FROM AoC2024.dbo.day2

SELECT
	game,
	STUFF(value,1,1,'') AS number_colour
INTO #colour_clean
FROM #batch_clean
CROSS APPLY STRING_SPLIT(cs, ',')

SELECT
	game,
	CAST(SUBSTRING(number_colour, 1, CHARINDEX(' ', number_colour)-1) AS INT) AS number,
	SUBSTRING(number_colour, CHARINDEX(' ', number_colour)+1, LEN(number_colour)) AS colour
INTO #number_colour
FROM #colour_clean

SELECT
	game,
	MAX(number) AS max_number,
	colour
INTO #max
FROM #number_colour
GROUP BY game, colour

SELECT game, 
       EXP(SUM(LOG(max_number))) AS multiplied_value
INTO #star2
FROM #max
GROUP BY game

SELECT SUM(multiplied_value) AS result
FROM #star2