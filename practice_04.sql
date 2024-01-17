--Bai 1
SELECT 
  COUNT(*) FILTER (WHERE device_type = 'laptop') AS laptop_views,
  COUNT(*) FILTER (WHERE device_type IN ('tablet', 'phone'))  AS mobile_views 
FROM viewership;
--Bai 2
SELECT x, y, z, 
IF(((x+y)>z AND (y+z)>x AND (x+z)>y), "Yes", "No") AS triangle 
FROM Triangle
--Bai 3
SELECT 
  ROUND(100.0 * 
    COUNT(case_id)/
      (SELECT COUNT(*) FROM callers),1) AS uncategorised_call_pct
FROM callers
WHERE call_category IS NULL 
  OR call_category = 'n/a';
--Bai 4
Select name from Customer
Where not referee_id = 2 
or referee_id is Null
--Bai 5
SELECT
    survived,
    SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM
    titanic
GROUP BY
    survived
