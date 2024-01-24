--Bai 1
with total_same_company
as(
SELECT 
  company_id, 
  title, 
  description, 
  COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)
Select COUNT(DISTINCT company_id) as so_luong
From total_same_company
where job_count>1
--Bai 2
With Ranked_spending as(
SELECT 
  category, 
  product, 
  SUM(spend) AS total_spend,
  RANK() OVER (
    PARTITION BY category 
    ORDER BY SUM(spend) DESC) AS ranking 
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product)
select
  category, 
  product,
  total_spend
From Ranked_spending 
where ranking <=2
ORDER BY category, ranking
--Bai 3
SELECT policy_holder_id, COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3;
--Bai 4
SELECT DISTINCT P.page_id
FROM pages P LEFT JOIN page_likes L
ON P.page_id = L.page_id
WHERE L.liked_date IS NULL
ORDER BY P.page_id ASC;
--Bai 5
SELECT 
EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
SELECT last_month.user_id 
FROM user_actions AS last_month
WHERE last_month.user_id = curr_month.user_id
AND EXTRACT(MONTH FROM last_month.event_date) =
EXTRACT(MONTH FROM curr_month.event_date - interval '1 month'))
AND EXTRACT(MONTH FROM curr_month.event_date) = 7
AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date)
--Bai 6
select DATE_FORMAT(trans_Date, '%Y-%m') AS month,
country,
count(id) as trans_count,
sum(case when state = "approved" then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = "approved" then amount else 0 end) as approved_total_amount
from
Transactions
group by DATE_FORMAT(trans_Date, '%Y-%m'), country
--Bai 7
select product_id, year as first_year, quantity, price
from Sales
where (product_id, year) 
in (select product_id, min(year)
from Sales group by 1)
--Bai 8
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING SUM(DISTINCT product_key) = (SELECT SUM(product_key)
FROM Product)
--Bai 9
SELECT employee_id 
FROM employees
WHERE salary < 30000 AND manager_id NOT IN (
    SELECT employee_id FROM employees
) ORDER BY employee_id;
--Bai 10
with total_same_company
as(
SELECT 
  company_id, 
  title, 
  description, 
  COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)
Select COUNT(DISTINCT company_id) as so_luong
From total_same_company
where job_count>1
--Bai 11
(SELECT name AS results FROM movieRating 
 INNER JOIN users USING(user_id)
 GROUP BY user_id
 ORDER BY COUNT(movie_id) DESC, name ASC LIMIT 1)
UNION ALL
(SELECT title
 FROM movieRating
 INNER JOIN movies USING(movie_id)
 WHERE EXTRACT(YEAR_MONTH FROM created_at) = 202002
 GROUP BY movie_id
 ORDER BY AVG(rating) DESC, title ASC
 LIMIT 1)
--Bai 12
select id, count(*) as num 
from ( select requester_id as id from RequestAccepted
union all
select accepter_id FROM RequestAccepted) as friends_count
group by id
order by num desc limit 1
