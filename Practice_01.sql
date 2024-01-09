---Bai 1
Select Name from CITY
Where population >120000
and CountryCode = 'USA'
--Bai 2
Select * from CITY
Where COUNTRYCODE ='JPN'
--Bai 3
Select CITY, STATE from STATION
--Bai 4
Select distinct CITY from STATION 
where left(city,1) in ('a', 'e', 'i', 'o', 'u')
--Bai 5
Select distinct CITY from STATION 
Where right(city,1) in ('a', 'e', 'i', 'o', 'u')
--Bai 6
Select distinct CITY from STATION 
Where left(city,1) not in ('a', 'e', 'i', 'o', 'u')
--Bai 7
Select name from Employee
Order by Name ASC
--Bai 8
Select Name from Employee
Where salary > 2000
and months < 10
--Bai 9
Select product_id from Products
Where low_fats ='y'
and recyclable = 'y'
--Bai 10
Select name from Customer
Where not referee_id = 2 
or referee_id is Null
--Bai 11
Select name, population, area from World
Where area >= 3000000
or population >= 25000000
--Bai 12
Select distinct author_id as id from Views
Where author_id = viewer_id
order by author_id
--Bai 13
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;
--Bai 14
SELECT * FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000
--Bai 15
Select * from uber_advertising
WHERE money_spent >= 1000000
AND year =2019
