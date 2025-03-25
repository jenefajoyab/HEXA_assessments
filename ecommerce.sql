CREATE DATABASE ecommerce

CREATE TABLE customers
(
customer_id int primary key identity(1,1),
first_name varchar(50),
last_name varchar(50),
email varchar(max),
address text,
password varchar(50)
)

create table products
(
product_id int primary key identity(1,1),
name varchar(50),
description text,
price decimal(8,2),
stockQuantity int
)

create table cart
(
cart_id int primary key identity(1,1),
customer_id int,
product_id int,
quantity int,
constraint fk_cust foreign key (customer_id) references customers(customer_id),
constraint fk_prod foreign key (product_id) references products(product_id)
)

create table orders
(
order_id int primary key identity(1,1),
customer_id int,
order_date date,
total_price decimal(8,2),
shipping_address text,
constraint fk_order_cust foreign key (customer_id) references customers(customer_id)
)

create table order_items
(
order_item_id int primary key identity(1,1),
order_id int,
product_id int,
quantity int,
constraint fk_oid foreign key (order_id) references orders(order_id),
constraint fk_pid foreign key (product_id) references products(product_id)
)
alter table order_items
add itemAmount decimal(8,2)
insert into customers
values
('John', 'Doe', 'johndoe@example.com', '123 Main St, City', 'password123'),
('Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town', 'password456'),
('Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village', 'password789'),
('Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb', 'password234'),
('David', 'Lee', 'david@example.com', '234 Cedar St, District', 'password345'),
('Laura', 'Hall', 'laura@example.com', '567 Birch St, County', 'password567'),
('Michael', 'Davis', 'michael@example.com', '890 Maple St, State', 'password890'),
('Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country', 'password321'),
('William', 'Taylor', 'william@example.com', '432 Spruce St, Province', 'password678'),
('Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory', 'password765');


insert into products
values
('Laptop','High-performance laptop',800.00,10),
('Smartphone','Latest smartphone',600.00,15),
('Tablet','Portable Tablet',300.00,20),
('Headphones','Noise-cancelling',10.00,30),
('TV','4K Smart TV',900.00,5),
('Coffee Maker','Automatic coffee maker',50.00,25),
('Refrigerator', 'Energy-efficient', 700.00, 10), 
('Microwave Oven', 'Countertop microwave', 80.00 ,15), 
('Blender', 'High-speed blender', 70.00 ,20), 
('Vacuum Cleaner', 'Bagless vacuum cleaner' ,120.00 ,10) 

insert into orders
values
(1, '2023-01-05', 1200.00, '123 Main St, City'),
(2, '2023-02-10', 900.00, '456 Elm St, Town'),
(3, '2023-03-15', 300.00, '789 Oak St, Village'),
(4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
(5, '2023-05-25', 1800.00, '234 Cedar St, District'),
(6, '2023-06-30', 400.00, '567 Birch St, County'),
(7, '2023-07-05', 700.00, '890 Maple St, State'),
(8, '2023-08-10', 160.00, '321 Redwood St, Country'),
(9, '2023-09-15', 140.00, '432 Spruce St, Province'),
(10, '2023-10-20', 1400.00, '765 Fir St, Territory');

truncate table order_items
insert into order_items
values
(1,1,2,1600.00),
(1, 3, 1, 300.00),
( 2, 2, 3, 1800.00),
( 3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00);


insert into cart
values
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2);

--1
update products set price=800.00 where name='Refrigerator'
select * from products where  name='Refrigerator'
--2
delete from cart where customer_id=6
select * from cart

--3
select * from products where price<100.00

--4 
select * from products where stockQuantity>5

--5
select * from orders where total_price between 500 and 1000

--6
select * from products where name like 'r%'

--7
select * from cart where customer_id=5

--8
select c.first_name+' '+c.last_name as name,c.customer_id,o.order_id,order_date 
from customers c
join orders o on c.customer_id=o.customer_id
where year(order_date) = 2023

--9
SELECT name, MIN(stockQuantity) AS min_stock 
FROM products 
GROUP BY name;


--10
select c.first_name+' '+c.last_name as name,c.customer_id,sum(total_price) as totalSpent
from customers c
join orders o on c.customer_id=o.customer_id
group by first_name,last_name,c.customer_id

--11
select c.first_name+' '+c.last_name as name,c.customer_id,avg(total_price) as avgAmount
from customers c
join orders o on c.customer_id=o.customer_id
group by first_name,last_name,c.customer_id

--12
select c.first_name+' '+c.last_name as name,c.customer_id,count(o.order_id) as orderCount
from customers c
join orders o on c.customer_id=o.customer_id
group by first_name,last_name,c.customer_id

--13
select c.first_name+' '+c.last_name as name,c.customer_id,max(total_price) as maxAmount
from customers c
join orders o on c.customer_id=o.customer_id
group by first_name,last_name,c.customer_id

--14
select c.first_name+' '+c.last_name as name,c.customer_id,sum(total_price) as amtSpent
from customers c
join orders o on c.customer_id=o.customer_id
group by first_name,last_name,c.customer_id
having sum(total_price)>1000

--15
select * from products
where product_id not in (select product_id from cart)

--16
insert into customers values('Jenefa','Joy','jenefajoy@example.com','678 ABC st,Country','pass123')
select * from customers
where customer_id not in (select customer_id from orders)

--17
select name,(select sum(itemAmount*quantity))/(select sum(itemAmount*quantity) from order_items)*100 as revenue
from order_items ot
join products p on ot.product_id=p.product_id
group by name
--18
select * from products
where stockQuantity= (select min(stockQuantity) from products)

--19
select * from customers
where customer_id in (select customer_id from orders where total_price=
(select max(total_price) from orders))

