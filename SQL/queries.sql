  select * , datediff(actual_delivery,expected_delivery) as delay_days,
case when datediff(actual_delivery,expected_delivery)<= 2 then "on-time"
 when datediff(actual_delivery,expected_delivery) between 3 and 5 then "moderate-delay"
else "high delay" end as delay_segment,
  
case when stock_quantity <10 then "low stock"
when stock_quantity between 10 and 50 then "medium stock"
else "high stock" end as stock_segment,

case when stock_quantity <10 and datediff(actual_delivery,expected_delivery)>5 then "high risk"
when  datediff(actual_delivery,expected_delivery)>2 then "medium risk"
else"low risk" end as risk_segment 
from data_two;


select supplier_id, avg(datediff(actual_delivery,expected_delivery)) as avg_delay ,sum(order_quantity) as total_orders ,
   count(*)as total_rec,count(case when datediff(actual_delivery,expected_delivery)>2 then 1 end) as delayed_orders,
case when count(case when datediff(actual_delivery,expected_delivery)>5 then 1 end) >2 then "high risk suppliers"
when avg(datediff(actual_delivery,expected_delivery)) > 5 then "medium risk suppliers"
else "low risk suppliers" end as risk_segments
from data_two
group by supplier_id;