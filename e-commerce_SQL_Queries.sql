use com;

SELECT * FROM orders;

ALTER TABLE `com`.`orders` 
CHANGE COLUMN `order_id` `order_id` SMALLINT(5) NULL DEFAULT NULL ,
CHANGE COLUMN `ship_mode` `ship_mode` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `segment` `segment` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `country` `country` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `city` `city` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `state` `state` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `postal_code` `postal_code` INT(5) NULL DEFAULT NULL ,
CHANGE COLUMN `region` `region` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `category` `category` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `sub_category` `sub_category` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `product_id` `product_id` VARCHAR(20) NULL DEFAULT NULL ,
CHANGE COLUMN `quantity` `quantity` SMALLINT(3) NULL DEFAULT NULL ;

-- Avg quantity, discount, sales_price and profit ship_mode wise

select ship_mode, round(avg(quantity),2) as Avg_quantity,  round(avg(discount),2) as Avg_discount , 
round(avg(sales_price),2) as Avg_salePrice ,  round(avg(profit),2) as Avg_profit
from orders
group by ship_mode;

-- Avg quantity, discount, sales_price and profit segment wise

select segment, round(avg(quantity),2) as Avg_quantity,  round(avg(discount),2) as Avg_discount , 
round(avg(sales_price),2) as Avg_salePrice ,  round(avg(profit),2) as Avg_profit
from orders
group by segment;


-- Top 10 highest revenue generating products.

select product_id, sum(sales_price) as total_sales
from orders
group by product_id
order by total_sales desc
limit 10;

-- alternative

with cte as (select product_id, sum(sales_price) as total_sales
from orders
group by product_id
order by total_sales desc),
cte2 as (select *,row_number() over(order by total_sales desc) as rn
from cte)
select * from cte2 where rn <= 10;

## find top 5 highest selling products in each region;

WITH cte1 as (
select region,product_id, sum(sales_price) as total_sales
from orders
group by region,product_id),
cte2 as (select *, row_number() over(partition by region order by total_sales desc) as rn
from cte1)
select * from cte2
where rn <6;

-- comparison of sales of the year 2022 & 2023 month wise.

with cte as (select year(order_date) as years,month(order_date) as months, round(sum(sales_price),2) as Total_sales
from orders
group by years,months)

select months,
sum(case when years=2022 then total_sales else 0 end) as '2022',
sum(case when years=2023 then total_sales else 0 end) as '2023'
from cte
group by months
order by months;

-- for each category which month had highest sales

with cte as (
select date_format(order_date,"%Y-%m") as year_months,category, sum(sales_price) as sales 
from orders
group by category,year_months)

select * from 
(select *, row_number() over(partition by category order by sales desc) as rn
from cte)a
where rn = 1;

# which top 3 sub-category has the higest growth by profit% in 2023 with comparison to 2022

with cte as (select sub_category,year(order_date) as years,sum(profit) as profit
from orders
group by sub_category, years),

cte2 as (select sub_category, 
sum(case when years = 2022 then profit else 0 end) as 'year_2022',
sum(case when years = 2023 then profit else 0 end)as 'year_2023'
from cte
group by sub_category)

select sub_category, round(year_2023,2) as year_2023,
round(year_2022,2) as year_2022,
round(((year_2023-year_2022)*100/year_2022),2) as profit_percent  
from cte2
order by profit_percent desc
limit 3;



select date(order_date) , count(*)
from orders
where date(order_date) < '2022-01-03'
group by date(order_date)
;

select * from orders;





