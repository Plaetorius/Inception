Test if DB is persistent:
-> Log in with a user account: 
docker exec -it [container_id] mysql -u[MYSQL_USER] -p[MYSQL_PASSWORD]

-> Use the DB:
USE [MYSQL_DATABASE]

-> Create a new table for example (if not done yet)
CREATE TABLE example_table (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT
);

-> Insert data in the DB:
INSERT INTO example_table (name, age) VALUES ('Alice', 30), ('Bob', 25);

-> Show the DB
SELECT * FROM example_table;
