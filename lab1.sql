-- 1 task
CREATE DATABASE lab1;

-- 2 task
CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);
-- 3 task
ALTER TABLE users
ADD COLUMN isadmin INTEGER
CHECK ( isadmin IN (1, 0) );

-- 4 task
ALTER TABLE users
DROP CONSTRAINT IF EXISTS users_isadmin_check;
ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN
USING isadmin::BOOLEAN;

-- 5 task
ALTER TABLE users
ALTER COLUMN isadmin SET  DEFAULT false;

-- 6 task
ALTER TABLE users
ADD CONSTRAINT add_primary PRIMARY KEY (id);

-- 7 task
CREATE TABLE tasks(
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);
-- 8 task
DROP TABLE tasks;

-- 9 task
DROP DATABASE lab1;