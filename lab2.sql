CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name TEXT,
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Kazakhstan', 2, 19620000);

INSERT INTO countries (country_name)
VALUES ('Uzbekistan');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Unknown Country', NULL, 500000);

INSERT INTO countries (country_name, region_id, population)
VALUES
('Kyrgyzstan', 5, 331000000),
('China', 7, 38000000),
('Russia', 9, 128000000);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (3, 18000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries);

INSERT INTO countries_new (SELECT * FROM countries);

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

UPDATE countries
SET population = population * 1.1
RETURNING country_name, population AS "New Population";

DELETE FROM countries WHERE population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

DELETE FROM countries
RETURNING *;