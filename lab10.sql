CREATE DATABASE OnlineBookstore;

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INTEGER
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    book_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    FOREIGN KEY (book_id) REFERENCES Books (book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
);

INSERT INTO Books (book_id, title, author, price, quantity) VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (customer_id, name, email) VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

--task1
BEGIN;
INSERT INTO Orders (book_id, customer_id, order_date, quantity)
VALUES (1, 101, CURRENT_DATE, 2);
UPDATE Books
SET quantity = quantity-2
WHERE book_id = 1;

COMMIT;

--task2
BEGIN;
DO $$
DECLARE
    available_quantity INTEGER;
BEGIN
    SELECT quantity INTO available_quantity FROM Books WHERE book_id = 3;
    IF available_quantity < 10 THEN
        RAISE NOTICE 'Not enough books';
        ROLLBACK;
    ELSE
        INSERT INTO Orders (book_id, customer_id, order_date, quantity)
        VALUES (3, 102, CURRENT_DATE, 10);
        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
        COMMIT;
    END IF;
END $$;

--task3

--session1
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books
SET price = 580803085.34
WHERE book_id = 3;

--session2
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price FROM Books WHERE book_id = 3;
COMMIT;
SELECT price FROM Books WHERE book_id = 3;

--task4
BEGIN;
UPDATE Customers
SET email = 'newemail@adress.com'
WHERE customer_id = 101;
COMMIT;
SELECT customer_id, email FROM Customers WHERE customer_id = 101;

drop database OnlineBookstore;
drop table orders cascade;
drop table customers cascade;
drop table books;
