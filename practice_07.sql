--Bai 1
with year_spend_cte as(
SELECT EXTRACT(year from transaction_date) as year,
product_id,
 spend AS curr_year_spend,
 LAG(spend) over (PARTITION BY product_id
 ORDER BY product_id, EXTRACT(year from transaction_date)) as Pre_year_spend
 from user_transactions)
 select year, product_id, curr_year_spend, Pre_year_spend,
 Round(((curr_year_spend - pre_year_spend)/ pre_year_spend)*100,2) as Yoy_rate
 From year_spend_cte
--Bai 2
SELECT DISTINCT card_name,
FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month)
AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC
--Bai 3
with cte_user_id as(
Select user_id, spend, transaction_date,
row_number() Over (PARTITION BY user_id Order By user_id,transaction_date) AS row_num
From transactions)
Select user_id, spend, transaction_date From cte_user_id
Where row_num = 3
--Bai 4
with ranking as 
(SELECT user_id,transaction_date,
RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS rank
FROM user_transactions)
SELECT transaction_date,user_id, COUNT(*) AS purchase_count
FROM  ranking
WHERE rank = 1
GROUP BY transaction_date, user_id;
--Bai 5
SELECT user_id,tweet_date,
round(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY user_id,tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_average
FROM tweets
--Bai 6
with cte as (SELECT merchant_id, credit_card_id, amount, transaction_timestamp,
lag(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp) as prev_transaction
FROM transactions
where EXTRACT(MINUTE from transaction_timestamp) <= 10)
select COUNT(merchant_id) as payment_count 
from cte 
where EXTRACT(MINUTE FROM transaction_timestamp)-EXTRACT(MINUTE FROM prev_transaction) <= 10
--Bai 7
With Ranked_spending as(
SELECT category, product, 
SUM(spend) AS total_spend,
RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking 
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product)
select category, product, total_spend
From Ranked_spending 
where ranking <=2
ORDER BY category, ranking
--Bai 8
WITH CTE AS(SELECT a.artist_id,artist_name,b.song_id,c.rank,c.day FROM artists a 
INNER JOIN songs b ON a.artist_id = b.artist_id 
INNER JOIN global_song_rank AS c ON b.song_id = c.song_id),
CTE1 AS (select artist_name,dense_rank() over(order by artist_rank DESC) as artist_rank 
from( select artist_name,SUM(CASE WHEN rank <=10 THEN 1 ELSE 0 END)  as artist_rank from CTE group by artist_name) F)
select * from CTE1 where artist_rank <=5;
