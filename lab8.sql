--1
CREATE DATABASE lab8;
--2
CREATE TABLE salesman(
    salesman_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(3, 2)
);

INSERT INTO salesman
VALUES (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5003, 'Lauson Hen', NULL, 0.12),
       (5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customers
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3001, 'Brad Guzan', 'London', NULL, 5005),
       (3004, 'Fabian Johns', 'Paris', 300, 5006),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3009, 'Geoff Camero', 'Berlin', 100, 5003),
       (3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders(
    ord_no INTEGER PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);


INSERT INTO orders
VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001);

--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE VIEW salesman_view AS
    SELECT * FROM salesman
    WHERE city = 'New York';
SELECT * FROM salesman_view;

--5
CREATE VIEW salcusname_view AS
    SELECT orders.ord_no, orders.purch_amt, orders.ord_date, customers.cust_name, salesman.name
    FROM orders
    JOIN salesman ON orders.salesman_id=salesman.salesman_id
    JOIN customers ON orders.customer_id = customers.customer_id;
SELECT * FROM salcusname_view;

GRANT ALL PRIVILEGES ON salcusname_view TO junior_dev;

--6
CREATE VIEW higcus_view AS
    SELECT * FROM customers
    WHERE customers.grade = (SELECT MAX(grade) FROM customers);
SELECT * FROM higcus_view;

GRANT SELECT ON higcus_view TO junior_dev;

--7
CREATE VIEW countsale_view AS
    SELECT city, COUNT(*) FROM salesman GROUP BY city;
SELECT * FROM countsale_view;

--8
CREATE VIEW salesman_with AS
SELECT salesman.salesman_id, salesman.name, COUNT(customers.customer_id) AS num_customers
FROM salesman
JOIN customers ON salesman.salesman_id = customers.customer_id
GROUP BY salesman.salesman_id, salesman.name
HAVING COUNT(customers.customer_id) > 1;

--9
CREATE ROLE intern;
GRANT junior_dev TO intern;

drop table customers cascade;
drop table salesman cascade;
drop table orders;