use datas;
select * from data_info;
select sum(quantity) from data_info ;
select distinct order_number,timestampdiff(year,birthday,CURDATE()) as age,gender,quantity from data_info  where gender='male'or gender='female' ;
with ram as(select * from data_info),
manu as(select name,birthday,customerkey,order_number,sum(line_item)as  average_order,gender,brand,storekey,state_y,color,productkey,product_name,category from ram group by order_number,customerkey,name,gender,birthday,brand,storekey,state_y,color,productkey,product_name,category)
 select *,timestampdiff(year,birthday,CURDATE()) as age,gender from manu where gender='male'or gender='female';
 select  category,gender,timestampdiff(year,birthday,CURDATE()) as age from data_info;

with analy as (select * from data_info), 
analy_2 as (select  category,gender,birthday,brand from analy group by category,gender,birthday,brand)
select  *,timestampdiff(year,birthday,CURDATE()) as age from analy_2 where gender='male' and timestampdiff(year,birthday,CURDATE())<=30 or  gender='female' and timestampdiff(year,birthday,CURDATE())<=30;
with analy as (select * from data_info), 
analy_2 as (select  category,gender,birthday,brand from analy group by category,gender,birthday,brand)
select  *,timestampdiff(year,birthday,CURDATE()) as age from analy_2 where gender='male' and timestampdiff(year,birthday,CURDATE())>=31 or  gender='female' and timestampdiff(year,birthday,CURDATE())>=31;
 select  count(*)as highusers,brand,continent,gender from data_info group by brand,continent,gender ;
select rank() over( order by sum(quantity)  desc) as rank_top,sum(quantity) as average_order,product_name from data_info group by product_name limit 50 ;
select count(*) as users,storekey,country_y as country from data_info group by storekey,country_y order by storekey asc;
select count(*),color,brand,gender from data_info group by color,brand,gender order by count(*) desc;
select count(*) as everyday_orders, year(order_date)as year,sum(quantity) as orders from data_info group by order_date having year(order_date)="2020";
select name,gender,continent,rank() over(order by sum(quantity) desc) as high_purchased,sum(quantity)as purchasing,category,product_name from data_info group by name,product_name,gender,continent,category limit 50;
select product_name,unit_cost_usd,unit_price_usd,round(unit_price_usd-unit_cost_usd,2) as profit from data_info group by product_name,unit_cost_usd,unit_price_usd;
select subcategory,rank()over(order by sum(quantity) desc) as top_products,sum(quantity) as top_list from data_info group by subcategory;
select country_y,Year(open_date) as year_introduced,sum(quantity) as count,sum(round(unit_price_usd-unit_cost_usd,2)) as profit from data_info group by year(open_date),country_y,unit_cost_usd,unit_price_usd having country_y="online" order by year_introduced asc ;
select count(*) ,month(order_date) as month from data_info group by month(order_date) order by count(*) desc;