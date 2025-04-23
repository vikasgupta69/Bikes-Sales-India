# Project In Bike_sales_Indina

create database bikes_sales;
use bikes_sales;

select * from bike_sales_india;



# Category = State, Brand, Model, Fuel type, Owner Type, Insurance Status, Seller Type, City Tier


# Containing = Avg Daily Distance (Km) , Price (INR) , Year of Manufacture,
#              Engine Capacity (cc) , Mileage (km/l), Registration Year, Resale Price (INR)


# Change the columns Name 

create or replace view bike_sales as
(select State, `Avg Daily Distance (km)` as Avg_D_Dist, Brand, Model, `Price (INR)` as Price ,
 `Year of Manufacture` as Year_of_Manufacture, 
`Engine Capacity (cc)` as Engine_Capacity, `Fuel Type` as  Fuel_Type,
 `Mileage (km/l)` as Mileage, `Owner Type` as Owner_Type , `Registration Year` as Registration_Year,
`Insurance Status` as Insurance_Status , `Seller Type` as Seller_Type,
 `Resale Price (INR)` as Resale_Price, `City Tier` as City_Tier from bike_sales_india);



# KPIs

select * from bike_sales;

select avg(price) as Avg_Price, sum(price) as Sum_Price, avg(engine_capacity) as AVG_Engine_Capacity,
 sum(resale_price) as Sum_Resale_Price, avg(resale_price) as Avg_Resale_Price, count(brand) as Count_Bikes
 from bike_sales;


#  Basic (1-10)
-- Q1) Retrieve all columns from the dataset.
select * from bike_sales;



-- Q2) Select distinct bike brands from the dataset.
select distinct brand from bike_sales;


-- Q3) Count the number of bikes available in the dataset.

select count(brand) as Bikes_Available from bike_sales;

-- Q4) Find the number of bikes available per fuel type.
select * from bike_sales;
select * from bike_sales where `fuel_type` = 'petrol';


-- Q5) Get the maximum and minimum resale price of bikes.
select * from bike_sales;
select max(resale_price) as Max_Pice, min(resale_price) as Min_Pice from bike_sales;

-- Q6) Find the average mileage of bikes.
select * from bike_sales;
select Brand, avg(mileage) as Avg_Mileage from bike_sales 
group by Brand;


-- Q7) Retrieve all bikes manufactured in 2020.
select * from bike_sales where Year_of_Manufacture = '2020';

-- Q8) Count the number of bikes owned by individuals versus dealers.

select * from bike_sales;
select Brand ,Seller_Type, count(brand) as Count_Brand from bike_sales
group by Brand ,Seller_Type
order by Seller_Type;

select Brand ,owner_type, count(brand) as Count_Brand from bike_sales
group by Brand ,owner_type
order by Brand;




-- Q9) List the top 5 most expensive bikes.

select * from bike_sales 
order by price desc 
limit 5;


-- Q10) Find all bikes with an engine capacity greater than 500cc.
select * from bike_sales where engine_capacity >500;





# Intermediate (11-30)
-- Q1) Find the average price of bikes by brand.
select * from bike_sales;
select brand , avg(price) Avg_Price from bike_sales
group by brand;

-- Q2) Retrieve the number of bikes sold in each state.
select * from bike_sales;


select state, count(brand) as Number_of_Bikes from bike_sales
group by state
order by Number_of_Bikes desc;

select *, round((Number_of_Bikes/Total),2)*100 as `Per%_Values` from
(select *, sum(Number_of_Bikes) over() as Total from
(select state, count(brand) as Number_of_Bikes from bike_sales
group by state
order by Number_of_Bikes desc)dt)dt2;


-- Q3) Get the number of bikes in each city tier.

select * from bike_sales;
select city_tier, count(brand) as Numer_of_Bikes from bike_sales
group by city_tier;

-- Q4) Find the most common owner type.

select * from bike_sales;
select owner_type, count(*) as Count from bike_sales
group by owner_type
order by Count desc;

-- Q5) List the top 3 fuel types based on their average mileage.
select * from bike_sales;
select fuel_Type , round(avg(mileage),2) as Avg_Mileage from bike_sales
group by fuel_Type 
order by Avg_Mileage desc 
limit 3;


-- Q6) Find the most common insurance status of bikes.

select * from bike_sales;
select insurance_status , count(*) as Count from bike_sales
group by insurance_status
order by Count desc;

-- Q7) Get all bikes with an active insurance status.
select * from bike_sales;
select  brand , insurance_status , count(insurance_status) as Count_active
from bike_sales
where insurance_status = 'active'
 group by brand , insurance_status 
 order by Count_active desc;


-- Q8) Find the most popular brand based on the number of bikes available.
select * from bike_sales;
select brand , count(brand) as Most_popular from bike_sales
group by  brand 
order by Most_popular desc;

-- Q9) Retrieve the total number of bikes registered in 2023.
select * from bike_sales;

select *, round((Total_number_bikes/ total)*100,2) as `per%` from
(select *,sum(Total_number_bikes) over()  as Total   from
(select brand , registration_year , count(registration_year) as Total_number_bikes
from bike_sales
where registration_year =  '2023'
group by brand , registration_year)dt) dt2;




select brand , registration_year , count(registration_year) as Total_number_bikes
from bike_sales
where registration_year =  '2023'
group by brand , registration_year ;


-- Q10) Find the highest-priced bike in each city tier.
select * from bike_sales;

with highest as (
select brand , city_tier, price, 
row_number() over(partition by city_tier order by price desc) as Rank_Num 
from bike_sales
)
select brand , city_tier, price from highest 
where Rank_Num =1;


-- Q11) Count the number of electric bikes in the dataset.

select  fuel_type , count(*) as Electric_Bikes from bike_sales
where fuel_type = 'electric'
group by fuel_type;

select brand, fuel_type , count(*) as Electric_Bikes from bike_sales
where fuel_type = 'electric'
group by brand ,fuel_type;

-- Q12) Retrieve all bikes with a mileage of more than 70 km/l.
select * from bike_sales;

select * from bike_sales 
where mileage > 70;

-- Q13) Find all bikes with a resale price above 80% of their original price.
select * from bike_sales;

select * from bike_sales
where "Resale_price" > 0.8 * 'price'; 




-- Q14) Get the average resale price of bikes by seller type
select  brand, seller_type , round(avg(resale_price),2) as Avg_Resal_Price from 
bike_sales 
group by brand, seller_type 
order by brand;

-- Q15) Find the difference in price between petrol and electric bikes.
select * from bike_sales;

select brand , fuel_type , price from bike_sales 
where fuel_type in  ('petrol','electric');



-- Q16) Count the number of bikes that have had at least two owners.
select * from bike_sales;
select brand ,owner_type, count(*) as Number_Bikes from bike_sales 
where owner_type = 'Second'
group by brand, owner_type
order by Number_Bikes desc;

-- Q17) List all bikes sorted by price in descending order.
select * from bike_sales
order by price desc;


-- Q18) Retrieve bikes that have been resold for more than 60% of their original price.

select * from bike_sales;

-- Q19) Find the state with the highest number of bike sales.

select * from bike_sales;
select state , count(brand) as Highest_Number from bike_sales 
group by state 
order by Highest_Number desc;


select state , count(*) as Highest_Number from bike_sales 
group by state 
order by Highest_Number desc;


-- Q20) Get the percentage of bikes in each city tier.

select * from bike_sales;

select  City_tier, round((city_count/Total_Count*100),2) as per from 
(select *, sum(city_count) over () as Total_Count from
(select city_tier , count(*) as city_count
from bike_sales
group by city_tier)dt) dt2 ;


select city_tier , round(count(*) * 100 / (select count(*) from bike_sales),2) as `per%` from bike_sales 
group by city_tier;


# Advanced (31-50)
-- Q1) Retrieve the top 5 states with the highest resale values.
select * from bike_sales;

select state , round(sum(resale_price),2) as Highest_resale from bike_sales 
group by state 
order by Highest_resale desc
limit 5;

-- Q2) Find the correlation between engine capacity and mileage.
select * from bike_sales;


select (avg(xy) - avg(x) * avg(y) /
stddev_pop(x) * stddev_pop(y)) as Correlation from 
(select 
Engine_Capacity as x,
Mileage as y,
Engine_Capacity * Mileage  as xy
from bike_sales) dt;


-- Q3) Get the average mileage for each engine capacity range (e.g., 100-200cc, 200-300cc).

select * from bike_sales;

select  
case 
when engine_capacity>=100 and engine_capacity< 200 then '100-200CC'
when engine_capacity>=200 and engine_capacity<300 then '200-300CC'
when engine_capacity>=300 and engine_capacity <400 then '300-400CC'
when engine_capacity >= 400 and engine_capacity < 500 then '500-600CC'
when engine_capacity >= 500 and engine_capacity < 600  then '600-700CC'
when engine_capacity >= 600 and engine_capacity < 700  then '700-800CC'
when engine_capacity >= 700 and engine_capacity < 800  then '800-900CC'
when engine_capacity >= 800 and engine_capacity < 900  then '900-1000CC'
when engine_capacity >= 900 and engine_capacity < 1000  then '1000-1100CC'
else "1200CC"
end as Engine_capacity_range ,
round(avg(mileage),2) as Avg_Mileage from bike_sales 
where engine_capacity >= 100
group by 
case 
when engine_capacity>=100 and engine_capacity< 200 then '100-200CC'
when engine_capacity>=200 and engine_capacity<300 then '200-300CC'
when engine_capacity>=300 and engine_capacity <400 then '300-400CC'
when engine_capacity >= 400 and engine_capacity < 500 then '500-600CC'
when engine_capacity >= 500 and engine_capacity < 600  then '600-700CC'
when engine_capacity >= 600 and engine_capacity < 700  then '700-800CC'
when engine_capacity >= 700 and engine_capacity < 800  then '800-900CC'
when engine_capacity >= 800 and engine_capacity < 900  then '900-1000CC'
when engine_capacity >= 900 and engine_capacity < 1000  then '1000-1100CC'
else "1200CC"
end 
order by Avg_Mileage desc;


-- Q4) Calculate the percentage depreciation of each bike from its original price.  (IM)
select * from bike_sales;

select brand , price , resale_price ,
round(((price-resale_price) / price *100),2) as `pre%`
from bike_sales;


-- Q5) Find the most common registration year.

select * from bike_sales;
select registration_year , count(*) as Common_Year
from bike_sales
group by registration_year
order by Common_Year desc;


-- Q6) Identify which brands have the lowest resale value.

select * from bike_sales;

select brand, round(avg(resale_price),2) as Avg_Sales  from bike_sales
group by  brand
order by Avg_Sales asc; 


-- Q7) Rank the top 10 bikes based on their depreciation rate.
select * from bike_sales;

select brand , price, resale_price ,
round(((price-resale_price) / price *100),2) as depreciation
from bike_sales
where price >0
limit 10;



-- Q8) Find bikes whose resale price is higher than the average resale price.
select * from bike_sales;

select avg(resale_price) from bike_sales;  # 133828.9739980006

select * from bike_sales 
where resale_price > (select avg(resale_price) from bike_sales);


-- Q9) Get the total number of bikes by year of manufacture.
select * from bike_sales;

select year_of_manufacture , count(*) as Manufacture
from bike_sales 
group by year_of_manufacture
order by Manufacture desc;

-- select year_of_manufacture, brand, count(brand) as Total_Number_Bikes 
-- from bike_sales
-- group by year_of_manufacture, brand
-- order by brand;


-- Q10) Calculate the percentage of bikes that have active insurance.
select * from bike_sales;

select brand,insurance_status,Active_Insurance,
 round((Active_Insurance/ Total) *100,2) `Percentage%` from 
(select *, sum(Active_Insurance) over() as Total from
(select brand, insurance_status,  count(*) as Active_Insurance
 from bike_sales
where insurance_status = 'active'
group by  brand, insurance_status) dt) dt2;

-- Q11) Identify the top 5 brands with the best mileage-to-price ratio.

select * from  bike_sales;


select * from
(select Brand , price, mileage , row_number() over(order by mileage desc ) as Top_5
from bike_sales)dt
where Top_5 <=5;


-- Q12) Get the city with the highest average bike price.

select * from bike_sales;

select city_Tier, round(avg(price),2) as Highest_Avg 
from bike_sales
group by city_Tier
order by Highest_Avg desc
limit 1;

-- Q13) Find bikes that have lost more than 50% of their value.
select * from bike_sales
where  resale_price < price   *0.5;


-- Q14) Retrieve the latest model year bikes and their details.

select *  from bike_sales
where  year_of_manufacture = (select max(year_of_manufacture) from bike_sales) ;

-- Q16) Identify bikes with the best resale price based on depreciation.
select *  from bike_sales;

select * , (price / resale_price) as depreciation
from bike_sales
where  price >0
order by depreciation desc;



-- Q17) Find the top 3 bike models with the lowest mileage.

select * from bike_sales;

select * from 
(select brand, model, mileage as Lowest_mileage,
 row_number() over(order by mileage ) as Rank_Top_3
from bike_sales)dt
where Rank_Top_3 <=3;

-- Q18) Calculate the average resale price per registration year.
select * from bike_sales;

select registration_year, round(avg(resale_price),2) as Avg_Price 
from bike_sales
group by registration_year;


-- Q19) Find the state with the highest number of high-engine capacity bikes.
select * from bike_sales;

select state , count(*) as high_engine_capacity
from bike_sales
where Engine_capacity > 500
group by state
order by high_engine_capacity desc;

-- Q20) Identify if electric bikes have higher resale values than petrol bikes.
select * from bike_sales;

select fuel_Type,
round(avg(Resale_price),2) as avg_sales
from bike_sales
where fuel_Type in ('electric','petrol')
group by fuel_Type
order by avg_sales desc
limit 1;


-- Q21) Rank all bikes based on their mileage and resale price.

select * from bike_sales;

select brand ,mileage, resale_price ,
rank() over(order by mileage, resale_price desc) as Ranks
from bike_sales;








# Here are 20 SQL questions specifically focusing on window functions, ranging from basic to advanced:

# Basic (1-5)
-- Rank all bikes by their price in descending order.
select * from bike_sales;

select brand, price, rank() over(order by price desc) as Ranks
from bike_sales;

-- Assign a dense rank to bikes based on their resale price.
select * from bike_sales; 
select brand, resale_price, dense_rank() over(partition by resale_price) as Dense_Ranks
from bike_sales;

-- Compute the running total of resale prices ordered by registration year.
select * from bike_sales;


select brand, model, registration_year, resale_price,
sum(resale_price) over(order by registration_year) as Running_sales
from bike_sales;

-- Find the moving average of mileage for each brand over the years.
select * from bike_sales;

select brand, mileage, year_of_manufacture,
round(avg(mileage) over(partition by brand order by year_of_manufacture),2) as Moving_Avg
from bike_sales;

-- Display each bike's price along with the average price of all bikes.

select * from bike_sales;

select brand, price, round(avg(price) over(),2) as Avg_price from bike_sales;

# Intermediate (6-15)
-- Compute the difference between a bike’s price and the average price of bikes in the same brand.
select * from bike_sales;

select * from 
(select brand, model, price, 
avg(price) over(partition by brand ) as Avg_price_brand,
price - avg(price) over() as Difference_Price
from bike_sales ) dt
where price > Avg_price_brand;

# Loss Values
select * from 
(select brand, model, price, 
avg(price) over(partition by brand ) as Avg_price_brand,
price - avg(price) over() as Difference_Price
from bike_sales ) dt
where price < Avg_price_brand;


-- Show each bike’s resale price along with the highest resale price in its city tier.

select * from bike_sales;

select brand, resale_price, city_tier,
max( resale_price) over(partition by city_tier) as Highest_sales 
from bike_sales;

-- Calculate the cumulative sum of the resale price partitioned by state.
select * from bike_sales;

select state , resale_price ,
sum(resale_price) over(partition by state order by resale_price) as Cumulative_sum
from bike_sales;

-- Find the lead and lag values of a bike’s resale price within each brand.
select * from bike_sales;

select brand,  model , resale_price,
lag(resale_price,1,0) over(partition by brand order by resale_price) as Perve_sales,
lead(resale_price) over(partition by brand order by resale_price ) as Next_vales
from bike_sales;

-- Rank bikes within each fuel type based on engine capacity.
select * from bike_sales;

select brand, model, fuel_Type, engine_capacity ,
rank () over(partition by fuel_Type order by engine_capacity desc) as Ranks
from bike_sales;

-- Calculate the percentage of each bike’s price relative to the highest-priced bike in its brand.
select * from bike_sales;

select brand, price, model, Resale_price, 
max(price) over(partition by brand) Max_valus,
round((price * 100.0) / max(price) over(partition by brand),2) as per
from bike_sales;

-- Show the previous and next bike’s mileage for each bike in the dataset.
select * from bike_sales;

select brand, model, price, mileage,
lag(mileage) over(order by brand) as Previous_Values,
lead(mileage) over(order by brand) as Next_Values
from bike_sales;



-- Find the bike with the lowest depreciation rate within each state.
select * from bike_sales;

select state, brand, 
round((Resale_price - price) * 1.0 / Resale_price,2)  as Depreciation from bike_sales;


-- Compute the difference in price between each bike and the one before it (sorted by price).
select * from bike_sales;

select state, brand, model, price, 
lag(price,1,0) over (order by price) as Peve_values,
price - lag(price,1,0) over(order by price) as difference_price
from bike_sales;

-- Display the highest mileage bike per fuel type along with its difference from the average mileage.
select * from bike_sales;
 
 with Ful_tipy as (
 select fuel_type,
 avg(mileage) as Avg_Mileage
 from bike_sales
 group by fuel_type
 ),
 RankBrand as (
 select b.brand, b.model, b.price, b.fuel_type, f.Avg_Mileage, b.mileage - f.Avg_Mileage as Mileage_Diff,
 row_number() over(partition by b.fuel_type order by f.Avg_Mileage desc) as Rnk
 from bike_sales b 
 join Ful_tipy f on f.fuel_type = b.fuel_type)
 select * from RankBrand
 where Rnk <=3;
 
 
# Advanced (16-20)
-- Find the top 3 most expensive bikes in each city tier.
select * from bike_sales;

select * from 
(select brand, model, price, city_tier,
row_number() over(partition by city_tier order by price desc) as Rn
from bike_sales)dt
where Rn <=3;

-- Compute the moving average of resale prices for bikes in each year of manufacture.
select * from bike_sales;

select brand, model, price,
round(avg(resale_price) over(partition by year_of_Manufacture order by resale_price
rows between 1 preceding and 1 following),2) rn
from bike_sales;


-- Calculate the rank of each bike’s depreciation rate within its brand.
select * from bike_sales;

select * from 
(select brand, model, price, mileage, resale_price,
round((resale_price - price) * 1.0 /  resale_price,2) as Depereciation,
row_number() over(partition by brand
 order by (resale_price - price) * 1.0 /  resale_price desc) as Depereciation_RN
from bike_sales) dt
where Depereciation < 0;


-- Identify the bikes that have a higher resale price than the previous year’s average resale price.

select * from bike_sales;

with year_sales as (
select year_of_Manufacture,
round(avg(resale_price),2) as Avg_sales
from bike_sales
group by year_of_Manufacture
)
select b.brand, b.model, b.resale_price, b.year_of_Manufacture,f.Avg_sales as Perve_year_sales
from bike_sales b join year_sales f on b.year_of_Manufacture = f.year_of_Manufacture 
where b.resale_price > f.Avg_sales;


-- Compare the price of each bike with the bike registered just before it in the same city.

select * from bike_sales;

 select brand, model, price, mileage, resale_price,
 lag(price) over(partition by state order by Registration_year) as Perve_Sales,
 price -  lag(price) over(partition by state order by Registration_year) as Next_sales
 from bike_sales;









