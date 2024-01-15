--Bai 1
Select name 
from STUDENTS
where marks>75
order by right(Name,3), id
--Bai 2
select user_id,
concat(Upper(left(name,1)),Lower(right(name,length(name)-1))) as Name
From Users
order by user_id
--Bai 3
SELECT manufacturer, 
'$'||ROUND(sum(total_sales)/1000000,0)||' '||'milion'as sale
FROM pharmacy_sales
GROUP BY manufacturer
order by sum(total_sales) DESC, manufacturer
--Bai 4
SELECT EXTRACT(month from submit_date) as mth,
product_id,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY mth, product_id
order by mth ,product_id
--Bai 5
Select sender_id,
count(message_id) as message_count
from messages
Where extract(month from sent_date)=8
and extract(year from sent_date)=2022
group by sender_id
order by message_count desc
limit 2
--Bai 6
Select tweet_id from Tweets
where length(conten)>15
--Bai 7
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE (activity_date > "2019-06-27" AND activity_date <= "2019-07-27")
GROUP BY activity_date
--Bai 8
Select count(employee_id) as number_employee
from employees
where extract(month from joining_date) between 1 and 7
abd extract(year from joining_date)=2022
--Bai 9
select position('a'in first_name) as position
from worker
where first_name='Amitah'
--Bai 10
Select substring(title, length(winery)+2,4)
from winemag_p2
where country='Macedonia'
