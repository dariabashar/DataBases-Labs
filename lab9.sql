--1
CREATE OR REPLACE FUNCTION increase_value(a integer)
RETURNS INTEGER AS $$
BEGIN
RETURN a+10;
END; $$
LANGUAGE plpgsql;

--2
CREATE OR REPLACE FUNCTION compare_numbers(a integer, b integer, OUT result text)
AS $$
    BEGIN
    IF a>b then
    result:= 'Greater';
    ELSIF a<b then
    result:= 'Lesser';
    ELSE
        result:='Equal';
    end if;
    END; $$
LANGUAGE plpgsql;

--3
CREATE OR REPLACE FUNCTION number_series(n integer)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--4
CREATE OR REPLACE FUNCTION find_employee(emp_name varchar)
    RETURNS TABLE(id integer, name varchar, salary numeric) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, salary FROM employees WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;

--5
CREATE OR REPLACE FUNCTION list_products(prod_category varchar)
    RETURNS TABLE(id integer, category varchar, name varchar, price numeric) AS $$
BEGIN
    RETURN QUERY
    SELECT id, category, name, price FROM products WHERE category=prod_category;
END;
$$ LANGUAGE plpgsql;

--6
CREATE OR REPLACE FUNCTION calculate_bonus(emp_id integer)
    RETURNS NUMERIC AS $$
DECLARE
    bonus_amount numeric;
BEGIN
    SELECT salary * 0.05 INTO bonus_amount FROM employees WHERE id = emp_id;
    RETURN bonus_amount;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id integer)
    RETURNS VOID AS $$
DECLARE
    bonus numeric;
BEGIN
    bonus := calculate_bonus(emp_id);
    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;

--7
CREATE OR REPLACE FUNCTION complex_calculation(num_param integer, str_param varchar)
    RETURNS TEXT AS $$
DECLARE
    numeric_result integer;
    string_result varchar;
BEGIN
    --Subblock1 - string manipulation
    string_result := str_param ||  '_completed_on_' || CURRENT_DATE;
    --Subblock2 - numeric computation
    numeric_result := num_param * num_param ;
    --Our results
    RETURN 'Number: ' || numeric_result || ', String: ' || string_result;
END;
$$ LANGUAGE plpgsql;