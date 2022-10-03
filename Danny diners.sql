-- Creating a Database for Dannys dinner
 
 CREATE DATABASE Dannys_dinner;
 -- The use function is to call out the database or schema to be used
 
 use Dannys_dinner;
 --------------------------------------------------------------------
 -- Creating Danny_dinner sales table
 CREATE table sales
 ( 
 customer_id VARCHAR(1),
 order_date date,
 product_id int

 );
---------------------------------------------------------------------
-- Creating Danny_dinner menu table

CREATE TABLE menu
(
product_id int,
product_name VARCHAR(5),
price INT,
PRIMARY KEY (product_id)
);
-----------------------------------------------------------------------
-- Creating Danny_dinner members table

CREATE TABLE members
( 
customer_id VARCHAR(1),
join_date TIMESTAMP,
PRIMARY KEY (join_date)
);
----------------------------------------------------------------------
-- To DESCRIBE the tables

DESCRIBE sales;
DESCRIBE menu;
DESCRIBE members;
----------------------------------------------------------------------
-- To insert into the tables 

EXPLAIN ANALYZE

INSERT INTO sales
(customer_id,order_date,product_id)
VALUES
("A","2021-01-01",1),
("A","2021-01-01",2),
("A","2021-01-07",2),
("A","2021-01-10",3),
("A","2021-01-11",3),
("A","2021-01-11",3),
("B","2021-01-01",2),
("B","2021-01-02",2),
("B","2021-01-04",1),
("B","2021-01-11",1),
("B","2021-01-16",3),
("B","2021-02-01",3),
("C","2021-01-01",3),
("C","2021-01-01",3),
("C","2021-01-07",3);
--------------------------------------------------------------------------------

EXPLAIN ANALYZE

INSERT INTO members
(customer_id,join_date)
VALUES
("A","2021-01-07"),
("B","2021-01-09");
--------------------------------------------------------------------------------

EXPLAIN ANALYZE

INSERT INTO menu
(product_id,product_name,price)
VALUES
(1,"sushi",10),
(2,"curry",15),
(3,"ramen",12);
--------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE  SELECTING_SALE_TABLE ()

BEGIN

SELECT * FROM SALES;

END //

DELIMITER ;

CALL SELECTING_SALE_TABLE ();
-----------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE  SELECTING_MENU_TABLE ()

BEGIN

SELECT * FROM MENU;

END //

DELIMITER ;

CALL SELECTING_MENU_TABLE ();
-----------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE  SELECTING_MEMBERS_TABLE ()

BEGIN 

SELECT * FROM MEMBERS;

END //

DELIMITER ;

CALL SELECTING_MEMBERS_TABLE ();
------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE SELECTING_SALES_WITH_PRICE_TABLE()

BEGIN

SELECT * FROM dannys_dinner.`sales including the price`;

END //

DELIMITER ;

CALL SELECTING_SALES_WITH_PRICE_TABLE();

------------------------------------------------------------------------------------
use dannys_dinner;

SELECT *from members;
select *from menu;
SELECT *from sales;

------------------------------------------------------------------------------------
-- What is the most purchased item on the menu and how times was it purchased by all customer


SELECT m.product_name,count(s.product_id) as "most_purchased"
FROM sales as s
JOIN menu as m
on s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased DESC;

------------------------------------------------------------------------------------
-- Which item was the most popular for each customer
with most_popular_cte as (
SELECT s.customer_id, m.product_name,count( s.product_id) as "most_popular",
DENSE_RANK () over (PARTITION BY s.customer_id
ORDER BY count( s.customer_id)) as ranks
FROM sales as s
join menu as m
on s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
)
SELECT customer_id,product_name,most_popular
FROM most_popular_cte
where ranks = 1;

-------------------------------------------------------------------------------------
-- What is the total amount each customer spent at the resturant?

with total_amount as (

SELECT s.customer_id, m.product_name,sum( m.price) as total_sales,
dense_rank() over (partition by s.customer_id 
order by m.price) as ranks
from sales as s
join menu as m
on s.product_id = m.product_id
GROUP BY s.customer_id
)
SELECT customer_id, product_name ,total_sales
from total_amount
where ranks = 1;




------------------------------------------------------------------------------------
-- How many days has each customer visited  the resturant?

select customer_id, count(distinct order_date) as visited
from sales
GROUP BY customer_id;


------------------------------------------------------------------------------------
-- Which item was purchased first by the customer after they became a member
with item_purchase_before as (
SELECT m.customer_id,s.order_date,m.join_date,s.product_id,
DENSE_RANK() over ( PARTITION BY m.customer_id
ORDER BY m.customer_id) as ranks
from members as m
join sales as s
on m.customer_id = s.customer_id
where s.order_date >= m.join_date
GROUP BY m.customer_id
)
SELECT i.customer_id,i.order_date,mm.product_name
from item_purchase_before as i
join menu as mm
on  i.product_id = mm.product_id
GROUP BY i.customer_id;




-------------------------------------------------------------------------------------
-- which item was purchase just before the customer become a member

with item_purchase_before as (
SELECT m.customer_id,s.order_date,m.join_date,s.product_id,
DENSE_RANK() over ( PARTITION BY m.customer_id
ORDER BY m.customer_id) as ranks
from members as m
join sales as s
on m.customer_id = s.customer_id
where s.order_date < m.join_date
GROUP BY m.customer_id
)
SELECT i.customer_id,i.order_date,mm.product_name
from item_purchase_before as i
join menu as mm
on  i.product_id = mm.product_id
GROUP BY i.customer_id;


 ------------------------------------------------------------------------------------
 -- what is the total item and amount spent for each member before they became a member
 
 with totalitem_amoumtspent as (
 SELECT s.customer_id, count(DISTINCT (s.product_id)) as "total_item",
 sum(m.price) as "amount_spent",
 DENSE_RANK() over (PARTITION BY s.customer_id
 ORDER BY s.customer_id) as ranks
 FROM sales as s
 join members as mm
 on s.customer_id = mm.customer_id
 join menu as m
 on s.product_id = m.product_id
where s.order_date < mm.join_date
GROUP BY s.customer_id
)
SELECT customer_id, total_item,amount_spent
from totalitem_amoumtspent
where ranks = 1;
 
---------------------------------------------------------------------------------------
 -- what was the first item from the menu purchased by each customer?
 with first_item as (
 SELECT s.customer_id, m.product_name, s.product_id,s.order_date,
 DENSE_RANK() over (PARTITION BY s.customer_id
 ORDER BY s.order_date) as ranks
 from sales as s
 join menu as m
 on s.product_id = m.product_id
 
 )
 SELECT customer_id,product_name,product_id
 from first_item
 where ranks = 1
 group by customer_id,product_name;
 -----------------------------------------------------------------------------------------
 -- if each $1 spent equates to 10 points and sushi has a 2X points multiplier
 -- How many points would each customer have?
 
 with point_prices as (
 SELECT m.product_id, m.product_name, m.price,
   case 
     when m.product_id = 1 then m.price * 20
     else price * 10
     end as points
     from menu as m
     )
 SELECT s.customer_id, sum(p.points) as "total_point"
 from  point_prices as p
 join sales as s
 on s.product_id = p.product_id
 GROUP BY s.customer_id;