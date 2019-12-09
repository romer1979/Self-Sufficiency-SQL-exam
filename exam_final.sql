--1

SELECT COLUMN_NAME, DATA_TYPE
FROM
  	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'naep'

--2

SELECT * 
FROM naep
LIMIT 50

--3

SELECT 
	state,
	ROUND(AVG(avg_math_4_score),2) Average_Score,
	COUNT (avg_math_4_score),
	ROUND(MIN(avg_math_4_score),2) Minimum_Score,
	ROUND(MAX(avg_math_4_score),2) Maximum_Score
FROM
	naep
GROUP BY
	state
ORDER BY
	state;

--4

SELECT 
	state,
	ROUND(AVG(avg_math_4_score),2) Average_Score,
	COUNT (avg_math_4_score),
	ROUND(MIN(avg_math_4_score),2) Minimum_Score,
	ROUND(MAX(avg_math_4_score),2) Maximum_Score
FROM
	naep
GROUP BY
	state
HAVING
	(MAX(avg_math_4_score) - MIN(avg_math_4_score)) > 30
ORDER BY
	state;

--5

SELECT 
	state,
	CAST(AVG(avg_math_4_score) as DECIMAL(12,2)) Average_Score

FROM
	naep
WHERE
	year = 2000 
GROUP BY
	state
ORDER BY
	AVG(avg_math_4_score)
LIMIT 10;

--6

SELECT 
	ROUND(AVG(avg_math_4_score),2)
FROM
	naep
WHERE
	year = 2000; 


-- Average math 4 Score for year 2000 = 224.80 --

--7

SELECT   
	state AS below_average_states_y2000, 
	avg_math_4_score
FROM 
	naep
WHERE 
	 year = 2000 and avg_math_4_score < ( SELECT AVG (avg_math_4_score) FROM naep WHERE year = 2000);

--8

SELECT   
	state AS scores_missing_y2000
FROM 
	naep
WHERE 
	year = 2000 AND avg_math_4_score IS NULL;

--9

SELECT
	naep.state, ROUND(naep.avg_math_4_score, 2) Average_Score, finance.total_expenditure
FROM
	naep
LEFT JOIN finance ON naep.id = finance.id
WHERE
	naep.year = 2000 and finance.year = 2000 and naep.avg_math_4_score IS NOT NULL
ORDER BY 
	finance.total_expenditure DESC;
