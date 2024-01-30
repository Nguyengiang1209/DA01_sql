--2)
ALTER TABLE sales_dataset_rfm_prj
ADD CONSTRAINT ORDERNUMBER CHECK(null),
ADD CONSTRAINT QUANTITYORDERED CHECK(null),
ADD CONSTRAINT PRICEEACH CHECK(null),
ADD CONSTRAINT ORDERLINENUMBER CHECK(null),
ADD CONSTRAINT SALES CHECK(null),
ADD CONSTRAINT ORDERDATE CHECK(null);
--3
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
--4
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
--5


