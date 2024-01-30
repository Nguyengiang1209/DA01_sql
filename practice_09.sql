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
