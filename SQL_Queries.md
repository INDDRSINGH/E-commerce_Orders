# E-Commerce website Data Analysis


**Selecting Database**


````SQL
USE commerce;
````

**Altering Table ORDERS to select the correct and relevant DATA TYPE for each column.**

````SQL
ALTER TABLE `commerce`.`orders` 
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
````


**Checking Dataset**

````sql
SELECT * FROM orders;
````

**Result :**


| order_id | order_date          | ship_mode      | segment  | country       | city            | state      | postal_code | region | category        | sub_category | product_id      | quantity | discount | sales_price | profit              |
|----------|---------------------|----------------|----------|---------------|-----------------|------------|-------------|--------|-----------------|--------------|-----------------|----------|----------|-------------|---------------------|
|        1 | 2023-03-01 00:00:00 | Second Class   | Consumer | United States | Henderson       | Kentucky   |       42420 | South  | Furniture       | Bookcases    | FUR-BO-10001798 |        2 |      5.2 |       254.8 |  14.800000000000011 |
|        2 | 2023-08-15 00:00:00 | Second Class   | Consumer | United States | Henderson       | Kentucky   |       42420 | South  | Furniture       | Chairs       | FUR-CH-10000454 |        3 |     21.9 |       708.1 |  108.10000000000002 |
|        3 | 2023-01-10 00:00:00 | Second Class   | Consumer | United States | Los Angeles     | California |       90036 | West   | Office Supplies | Labels       | OFF-LA-10000240 |        2 |      0.5 |         9.5 |                -0.5 |
|        4 | 2022-06-18 00:00:00 | Standard Class | Consumer | United States | Fort Lauderdale | Florida    |       33311 | South  | Furniture       | Tables       | FUR-TA-10000577 |        5 |     19.2 |       940.8 |  160.79999999999995 |
|        5 | 2022-07-13 00:00:00 | Standard Class | Consumer | United States | Fort Lauderdale | Florida    |       33311 | South  | Office Supplies | Storage      | OFF-ST-10000760 |        2 |        1 |          19 |                  -1 |
|        6 | 2022-03-13 00:00:00 | Standard Class | Consumer | United States | Los Angeles     | California |       90032 | West   | Furniture       | Furnishings  | FUR-FU-10001487 |        7 |      1.5 |        48.5 |                -1.5 |
|        7 | 2022-12-28 00:00:00 | Standard Class | Consumer | United States | Los Angeles     | California |       90032 | West   | Office Supplies | Arts         | OFF-AR-10002833 |        4 |      0.3 |         9.7 | -0.3000000000000007 |
|        8 | 2022-01-25 00:00:00 | Standard Class | Consumer | United States | Los Angeles     | California |       90032 | West   | Technology      | Phones       | TEC-PH-10002275 |        6 |     45.5 |       864.5 |                 4.5 |
|        9 | 2023-03-23 00:00:00 | Standard Class | Consumer | United States | Los Angeles     | California |       90032 | West   | Office Supplies | Binders      | OFF-BI-10003910 |        3 |      0.4 |        19.6 | -0.3999999999999986 |
|       10 | 2023-05-16 00:00:00 | Standard Class | Consumer | United States | Los Angeles     | California |       90032 | West   | Office Supplies | Appliances   | OFF-AP-10002892 |        5 |      3.3 |       106.7 |  16.700000000000003 |






**Avg quantity, discount, sales_price and profit ship_mode wise.**


````SQL
select ship_mode, round(avg(quantity),2) as Avg_quantity,  round(avg(discount),2) as Avg_discount,  
round(avg(sales_price),2) as Avg_salePrice ,  round(avg(profit),2) as Avg_profit 
from orders 
group by ship_mode;
````

**Result :**

| ship_mode      | Avg_quantity | Avg_discount | Avg_salePrice | Avg_profit |
|----------------|--------------|--------------|---------------|------------|
| Second Class   |         3.82 |         8.27 |        227.75 |      21.28 |
| Standard Class |         3.82 |         7.98 |         219.5 |       20.5 |
| First Class    |         3.70 |         7.81 |        220.57 |       19.8 |
| Same Day       |         3.61 |          8.5 |         227.9 |      20.23 |



**Avg quantity, discount, sales_price and profit segment wise**

````SQL
select segment, round(avg(quantity),2) as Avg_quantity,  round(avg(discount),2) as Avg_discount ,  
round(avg(sales_price),2) as Avg_salePrice ,  round(avg(profit),2) as Avg_profit 
from orders 
group by segment;
````

**Result :**


| segment     | Avg_quantity | Avg_discount | Avg_salePrice | Avg_profit |
|-------------|--------------|--------------|---------------|------------|
| Consumer    |         3.76 |         7.89 |        215.66 |      19.57 |
| Home Office |         3.78 |         8.47 |        232.48 |      21.28 |
| Corporate   |         3.85 |         8.04 |        225.81 |      21.74 |


**Top 10 highest revenue generating products.**

````SQL
select product_id, sum(sales_price) as total_sales 
from orders 
group by product_id 
order by total_sales desc 
limit 10;
````

**Alternative approach**


````SQL
with cte as (select product_id, sum(sales_price) as total_sales 
from orders 
group by product_id 
order by total_sales desc), 
cte2 as (select *,row_number() over(order by total_sales desc) as rn 
from cte) 
select * from cte2 where rn <= 10;
````


**Result :**


| product_id      | total_sales        |
|-----------------|--------------------|
| TEC-CO-10004722 |              59514 |
| OFF-BI-10003527 | 26525.300000000003 |
| TEC-MA-10002412 |            21734.4 |
| FUR-CH-10002024 |            21096.2 |
| OFF-BI-10001359 |            19090.2 |
| OFF-BI-10000545 |              18249 |
| TEC-CO-10001449 |            18151.2 |
| TEC-MA-10001127 |            17906.4 |
| OFF-BI-10004995 |            17354.8 |
| OFF-SU-10000151 |            16325.8 |



**Find top 5 highest selling products in each region.**


````SQL
WITH cte1 as ( 
select region,product_id, sum(sales_price) as total_sales 
from orders 
group by region,product_id), 
cte2 as (select *, row_number() over(partition by region order by total_sales desc) as rn 
from cte1) 
select * from cte2 
where rn <6;
````


**Result :**


| region  | product_id      | total_sales       | rn |
|---------|-----------------|-------------------|----|
| Central | TEC-CO-10004722 |             16975 |  1 |
| Central | TEC-MA-10000822 |             13770 |  2 |
| Central | OFF-BI-10001120 |           11056.5 |  3 |
| Central | OFF-BI-10000545 |           10132.7 |  4 |
| Central | OFF-BI-10004995 |            8416.1 |  5 |
| East    | TEC-CO-10004722 |             29099 |  1 |
| East    | TEC-MA-10001047 |             13767 |  2 |
| East    | FUR-BO-10004834 |           11274.1 |  3 |
| East    | OFF-BI-10001359 | 8463.599999999999 |  4 |
| East    | TEC-CO-10001449 |              8316 |  5 |
| South   | TEC-MA-10002412 |           21734.4 |  1 |
| South   | TEC-MA-10001127 |           11116.4 |  2 |
| South   | OFF-BI-10001359 | 8053.200000000001 |  3 |
| South   | TEC-MA-10004125 |              7840 |  4 |
| South   | OFF-BI-10003527 |            7391.4 |  5 |
| West    | TEC-CO-10004722 |             13440 |  1 |
| West    | OFF-SU-10000151 |           12592.3 |  2 |
| West    | FUR-CH-10001215 |              9604 |  3 |
| West    | OFF-BI-10003527 | 7804.799999999999 |  4 |
| West    | TEC-AC-10003832 |            7722.7 |  5 |


**Comparison of sales of the year 2022 & 2023 month wise.**

````SQL
with cte as (select year(order_date) as years,month(order_date) as months, round(sum(sales_price),2) as Total_sales 
from orders 
group by years,months) 

select months, 
sum(case when years=2022 then total_sales else 0 end) as '2022', 
sum(case when years=2023 then total_sales else 0 end) as '2023' 
from cte 
group by months 
order by months;
````

**Result :**


| months | 2022     | 2023     |
|--------|----------|----------|
|      1 |  94712.5 |  88632.6 |
|      2 |    90091 | 128124.2 |
|      3 |    80106 |  82512.3 |
|      4 |  95451.6 | 111568.6 |
|      5 |  79448.3 |  86447.9 |
|      6 |  94170.5 |  68976.5 |
|      7 |  78652.2 |  90411.8 |
|      8 |   104808 |  87733.6 |
|      9 |  79142.2 |  76658.6 |
|     10 | 118912.7 | 121061.5 |
|     11 |  84225.3 |  75432.8 |
|     12 |  95869.9 | 102556.1 |


**For each category which month had highest sales**

````SQL
with cte as ( 
select date_format(order_date,"%Y-%m") as year_months,category, sum(sales_price) as sales  
from orders 
group by category,year_months) 

select * from  
(select *, row_number() over(partition by category order by sales desc) as rn 
from cte)a 
where rn = 1;
````


**Result :**


| year_months | category        | sales              | rn |
|-------------|-----------------|--------------------|----|
| 2022-10     | Furniture       |  42888.90000000001 |  1 |
| 2023-02     | Office Supplies | 44118.499999999985 |  1 |
| 2023-10     | Technology      |  53000.10000000002 |  1 |



**which top 3 sub-category has the higest growth by profit% in 2023 with comparison to 2022**

````SQL
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
````

**Result :**


| sub_category | year_2023 | year_2022 | profit_percent |
|--------------|-----------|-----------|----------------|
| Machines     |   10878.5 |    7243.2 |          50.19 |
| Supplies     |    1937.4 |    1500.7 |           29.1 |
| Binders      |   10511.1 |    8685.5 |          21.02 |














