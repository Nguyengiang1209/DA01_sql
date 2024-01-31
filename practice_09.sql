--Cau hoi 1
ALTER TABLE public.sales_dataset_rfm_prj
alter column ordernumber type numeric
--(Tương tự với các cột còn lại)
ALTER TABLE public.sales_dataset_rfm_prj
alter column quantityordered type int
alter column priceeach type float
alter column orderlinenumber type numeric
alter column sales type float
alter column msrp type int
alter column customername type text
alter column phone type numeric
alter column postalcode type character
alter column customername type text
--cau hoi 2
ALTER TABLE sales_dataset_rfm_prj
ADD CONSTRAINT ORDERNUMBER CHECK(null),
ADD CONSTRAINT QUANTITYORDERED CHECK(null),
ADD CONSTRAINT PRICEEACH CHECK(null),
ADD CONSTRAINT ORDERLINENUMBER CHECK(null),
ADD CONSTRAINT SALES CHECK(null),
ADD CONSTRAINT ORDERDATE CHECK(null);
--cau hoi 3
alter table public.sales_dataset_rfm_prj
add column CONTACTFIRSTNAME Varchar(20),
add column CONTACTLASTNAME Varchar(20)

update public.sales_dataset_rfm_prj
set contactfirstname = (Left(contactfullname,position('-' in contactfullname) - 1))
where contactfirstname is Null;
UPDATE public.sales_dataset_rfm_prj
SET contactfirstname= CONCAT(UPPER(LEFT(contactfirstname,1)),LOWER(RIGHT(contactfirstname,LENGTH(contactfirstname)-1)))
  
update public.sales_dataset_rfm_prj
set contactlastname = (Right(contactfullname, length(contactfullname)-position('-' in contactfullname)))
where contactlastname is Null;
UPDATE public.sales_dataset_rfm_prj
SET contactlastname= CONCAT(UPPER(LEFT(contactlastname,1)),LOWER(RIGHT(contactlastname,LENGTH(contactlastname)-1)))
--cau hoi 4
alter table public.sales_dataset_rfm_prj
add column QTR_ID numeric,
add column MONTH_ID numeric,
add column YEAR_ID numeric;

update public.sales_dataset_rfm_prj
set month_id = EXTRACT(MONTH FROM orderdate) 
where month_id is null

update public.sales_dataset_rfm_prj
set year_id = EXTRACT(year FROM orderdate) 
where year_id is null

update public.sales_dataset_rfm_prj
set QTR_ID =(case
when month_id between 1 and 3 then 1
when month_id between 4 and 6 then 2
when month_id between 7 and 9 then 3
else '4'
end)
where QTR_ID is null
--cau hoi 5
--Cach z_score
with cte as
(
select ordernumber,quantityordered,
	(select avg(quantityordered) from sales_dataset_rfm_prj) as avg,
	(select stddev(quantityordered) from sales_dataset_rfm_prj) as stddev
from sales_dataset_rfm_prj)
,twt_outlier as (
select ordernumber, quantityordered, (quantityordered-avg)/stddev as z_score
from cte
where abs((quantityordered-avg)/stddev)>3)
--cach IQR/BOXPLOT

with twt_min_max_value as(
select Q1 -1.5*IQR AS MIN_VALUE,
Q3+1.5*IQR AS MAX_VALUE
FROM (
SELECT
percentile_cont(0.25) within group (order by quantityordered) as Q1,
percentile_cont(0.75) within group (order by quantityordered) as Q3,
percentile_cont(0.75) within group (order by quantityordered) - percentile_cont(0.25) within group (order by quantityordered) as IQR
from public.sales_dataset_rfm_prj) as a)
, twt_outlier as (
	select quantityordered from sales_dataset_rfm_prj
	Where quantityordered < (select MIN_VALUE from twt_min_max_value)
    or quantityordered> (select MAX_VALUE from twt_min_max_value))
-- Xu ly outlier
delete from sales_dataset_rfm_prj
where quantityordered in (select quantityordered from twt_outlier);
--cau hoi 6
SELECT * INTO sales_dataset_rfm_prj_clean
FROM sales_dataset_rfm_prj;

with cte as
(
select quantityordered,
	(select avg(quantityordered) from sales_dataset_rfm_prj_clean) as avg,
	(select stddev(quantityordered) from sales_dataset_rfm_prj_clean) as stddev
from sales_dataset_rfm_prj_clean)
,twt_outlier as (
select quantityordered, (quantityordered-avg)/stddev as z_score
from cte
where abs((quantityordered-avg)/stddev)>3)
delete from sales_dataset_rfm_prj_clean
where quantityordered in (select quantityordered from twt_outlier)
