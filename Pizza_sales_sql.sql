show databases;
use pizza_sale;

CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100),
    order_month VARCHAR(20),
    order_day VARCHAR(20)
);

describe pizza_sales;
select * from pizza_sales;
select count(*) from pizza_sales;
ALTER TABLE pizza_sales
ADD PRIMARY KEY (pizza_id);

-- KPIS
-- 1. Total Revenue:  
SELECT SUM(total_price) as Total_Revenue 
FROM pizza_sales;

-- 2. Average Order Value  
SELECT SUM(total_price) / COUNT(distinct order_id)  as Avg_order_value
FROM pizza_sales;

-- 3. Total Pizzas Sold  
SELECT SUM(quantity) as Total_pizza_sold
FROM pizza_sales;

-- 4. Total Orders  
SELECT COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order  
SELECT ROUND( SUM(quantity) / COUNT(DISTINCT order_id),2)
As Avg_pizza_per_order
FROM pizza_sales;

-- Q) Daily Trend for total orders:
SELECT order_day, COUNT(DISTINCT order_id) as Total_order
from pizza_sales
group by order_day
order by Total_order desc;


-- Q) Monthly trends for total orders:
SELECT order_month, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
group by order_month
order by Total_orders DESC;


-- Q) % of Sales by Pizza Category  
SELECT DISTINCT pizza_category ,
SUM(total_price) as Total_revenue,
concat(                            -- use to add string("%") 
round(                             -- round decimal in 2
(SUM(total_price) * 100) / (SELECT sum(total_price) FROM pizza_sales),2),"%") as Per
FROM pizza_sales
group by pizza_category
order by Total_revenue DESC;


-- Q) % of Sales by Pizza Size
SELECT pizza_size,
sum(total_price) as Total_revenue,
concat(
round(
(sum(total_price) * 100 ) / (select sum(total_price) from pizza_sales),2),"%") as per
from pizza_sales
group by pizza_size
order by Total_revenue DESC;


-- Q)Total Pizzas Sold by Pizza Category in month of february
select pizza_category, 
sum(quantity) as pizza_sold
from pizza_sales
WHERE order_month = "February"
group by pizza_category
order by pizza_sold DESC;


-- Q) Top 5 Pizzas by Revenue 
SELECT pizza_name,
ROUND(sum(total_price),0) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue DESC
LIMIT 5;

-- Q)Bottom 5 Pizzas by Revenue  
SELECT pizza_name,
ROUND(sum(total_price),0) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue ASC
LIMIT 5;


-- Q) Top 5 pizza by quantity
SELECT pizza_name,
SUM(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by Total_pizza_sold DESC
LIMIT 5;


-- Q) Bottom 5 pizza by quantity
SELECT pizza_name,
SUM(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by Total_pizza_sold ASC
LIMIT 5;


-- Q)  Top 5 Pizzas by Total Orders  
SELECT pizza_name,
COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
group by pizza_name
order by Total_orders DESC
LIMIT 5;

-- Q) Bottom 5 Pizzas by Total Orders  
SELECT pizza_name,
COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
group by pizza_name
order by Total_orders ASC
LIMIT 5;


-- Top 5 pizza_name sold by Classic category
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders  
FROM pizza_sales  
WHERE pizza_category = 'Classic'  
GROUP BY pizza_name  
ORDER BY Total_Orders DESC
LIMIT 5;



