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
