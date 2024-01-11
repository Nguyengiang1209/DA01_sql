--Bai 1
Select distinct city from station
Where id%2 = 0
--Bai 2
Select Count(city) - count(distinct city)
From station
--Bai 3
--Bai 4
Select
round(cast(sum(item_count * order_occurrences) / sum(order_occurrences) as decimal),1) as mean
From items_per_order
--Bai 5
Select candidate_id From candidates
Where skill in ('Python', 'Tableau', 'PostgreSQL')
Group by candidate_id 
Having count(skill) =3
--Bai 6
Select user_id,
date(max(post_date))-date(min(post_date)) as days_between From posts
Where post_date >= '2021-01-01' and post_date<'2021-01-01'
Group by user_id
Having count(post_id)>=2
--Bai 7
Select card_name,
Max(issue_amount)-Min(issue_amount) AS difference
From monthly_cards_issued
Group by card_name
order by difference Desc
--Bai 8
Select manufacturer,
count(drug) as drug_count,
ABS(SUM(cogs-total_sales)) as total_loss
From pharmacy_sales
Where total_sales<cogs
group by manufacturer
order by total_loss desc
--Bai 9 
Select * From cinema
Where id%2 and description<> 'boring'
order by rating desc
--Bai 10
Select teacher_id,
Count(distinct subject_id) as cnt
from Teacher
Group by Teacher_id
--Bai 11
Select user_id, count(follower_id) as follower_count
From Followers
Group by user_id
order by user_id
--Bai 12
Select class from courses
Group by class
Having count(student)>=5
