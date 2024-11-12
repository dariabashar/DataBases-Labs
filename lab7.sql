create database lab7;

create table countries(
    country_id serial primary key,
    name varchar(50)
);

insert into countries(name) values
    ('Kazakhstan'),
    ('USA'),
    ('Russia'),
    ('Switzerland');

create table departments(
    department_id serial primary key,
    department_name varchar(50),
    budget int
);

insert into departments(department_name, budget) values
    ('HR', 100000),
    ('IT', 200000),
    ('Finance', 150000),
    ('Marketing', 80000),
    ('Sales', 120000);

create table employees(
    employee_id serial primary key,
    name varchar(50),
    surname varchar(100),
    salary int,
    department_id int references departments
);

insert into employees(name, surname, salary, department_id) values
    ('Nick','Rimando', 150000, 1),
    ('Graham','Zusi',50000, 5),
    ('Brad','Guzan',500, 3),
    ('Fabian','Johns',505, 4),
    ('Brad','Davis',67000, 2);

-- task 1
create index idx_countries_name on countries(name);

-- task 2
create index idx_employees_namesurname on employees(name, surname);

-- task 3
create unique index idx_salary on employees(salary);

--task 4
create index idx_empl_name on employees((substring(name from 1 for 4)));

--task5
create index idx_empl_depsal on employees(department_id, salary);
create index idx_dep_budget on departments(budget);
