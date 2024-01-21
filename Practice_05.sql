--Bai 1
SELECT c.CONTINENT, floor(AVG(e.POPULATION))
FROM CITY e JOIN COUNTRY c 
ON c.CODE = e.COUNTRYCODE
GROUP BY CONTINENT;
--Bai 2
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
--bai 3
SELECT age_bucket,
round(100*sum(case when activity_type ='send' then time_spent else 0 end)/sum (case when activity_type = 'chat' then 0 else time_spent end),2) as send_perc,
round(100*sum(case when activity_type ='open' then time_spent else 0 end)/sum (case when activity_type = 'chat' then 0 else time_spent end),2) as open_perc
from activities 
join age_breakdown using(user_id)
group by 1
--Bai 4
SELECT cc.customer_id 
from customer_contracts as cc 
LEFT JOIN products as p  
on cc.product_id = p.product_id
group by cc.customer_id
having COUNT(DISTINCT(p.product_category)) = (select COUNT(Distinct(product_category)) 
from products)
--Bai 5
Select e1.employee_id, e1.name, 
count(e2.reports_to) as reports_count, 
round(avg(e2.age)) as average_age 
from Employees e1 
left join Employees e2 on e1.employee_id=e2.reports_to 
where e2.reports_to is not null
group by e2.reports_to 
order by e1.employee_id
--Bai 6
Select a.product_name as product_name, sum(b.unit) as unit from Products a
Join Orders b using (product_id)
Where year(b.order_date)='2020' and MONTH(b.order_date)='02'
Group by a.product_id
Having SUM(b.unit)>=100
--Bai 7
SELECT DISTINCT P.page_id
FROM pages P LEFT JOIN page_likes L
ON P.page_id = L.page_id
WHERE L.liked_date IS NULL
ORDER BY P.page_id ASC;

--Course test
--Question 1:
Select distinct min(replacement_cost )
from film
--Question 2
Select 
case
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20 and 24.99 then 'medium'
else 'hight'
end as category,
count(*) as So_luong
from film
group by category
--Question 3
select a.film_id, a.category_id, b.title, b.length, c.name
from public.film_category as a
inner join film as b on a.film_id=b.film_id
inner join public.category as c on a.category_id= c.category_id
where name='Sports' or name='Drama'
order by length desc
--Question 4
select a.name, count(a.category_id)
from public.category as a
left join public.film_category as b on a.category_id=b.category_id
group by a.name 
order by count desc
--Question 5
select a.first_name ||' '|| a.last_name as full_name, count(b.film_id)
from public.actor as a
left join public.film_actor as b on a.actor_id=b.actor_id
group by a.first_name ||' '|| a.last_name
order by count desc
--Question 6
select b.address_id, a.customer_id
from public.address as b
join public.customer as a on a.address_id=b.address_id
where a.address_id is null
-- Question 7

