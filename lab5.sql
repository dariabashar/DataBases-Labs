create database lab5;

create table salesman (
    salesman_id int primary key,
    name varchar(100),
    city varchar(100),
    commission decimal(3,2)
);

insert into salesman (salesman_id, name, city, commission) VALUES
(5001,'James Hoog', 'New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5003,'Lauson Hen',null, 0.12),
(5007,'Paul Adam','Rome',0.13);

create table customers (
    customer_id int primary key,
    cust_name varchar(100),
    city varchar(100),
    grade int,
    salesman_id int,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

insert into customers(customer_id, cust_name, city, grade, salesman_id) VALUES
(3002,'Nick Rimando','New York',100,5001),
(3005,'Graham Zusi','California',200,5002),
(3001,'Brad Guzan','London',null,5005),
(3004,'Fabian Johns','Paris',300,5006),
(3007,'Brad Davis','New York',200,5001),
(3009,'Geoff  Camero','Berlin',100,5003),
(3008,'Julian Green','London',300,5002);

create table orders(
    ord_no int primary key,
    purch_amt decimal(10,2),
    ord_date date,
    customer_id int,
    salesman_id int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesman(salesman_id)
);

insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001);

select sum(orders.purch_amt) as total from orders;

select avg(orders.purch_amt) as average from orders;

select count(customers.cust_name) as count from customers where cust_name is not null;

select min(orders.purch_amt) as minimum from orders;

select * from customers where cust_name like '%b';

select * from orders where customer_id in (select customer_id from customers where city = 'New York');

select * from customers where customer_id in (select customer_id from orders where purch_amt>10);

select sum(customers.grade) as total from customers;

select * from customers where cust_name is not null;

select max(grade) as maxGrade from customers;