-- This can be a query file to solve and better understand random problems.


-- Sum of off numbers: Given the triangle of consecutive odd numbers:
--      1
--   3     5
-- 7    9    11
-- Calculate the sum of the numbers in the nth row of this triangle
-- (starting at index 1)
-- Output of row 1 = 1; output of row 2 = 8

-- Create the table nums to use for testing
CREATE TABLE nums (
	n INT
);

-- Insert the testing data into nums to check my solutions
INSERT INTO nums (n) VALUES (1), (2), (13), (19), (41), (42), (74), (86), (93), (101);

SELECT * FROM nums;

-- Write the solution that solves the problem
SELECT POWER(n, 3)::int AS res from nums;

-- A practice problem for using WITH to create an auxillary statement for use in a larger query
-- This is sometimes a way to make subqueries more readable. The departments schema has just id
-- and name in it, where the sales schema has id, name, department_id (which is the foreign key
-- to departments), and price. So here we are trying to return all departments that have a sale
-- greater than 90.00.
WITH 
	special_sales AS (
		SELECT department_id FROM sales
		WHERE price > 90.00)
	SELECT id, name FROM departments
	WHERE id IN (
		SELECT department_id FROM special_sales);
-- another way we could have written this without using WITH is:
SELECT id, name FROM departments
WHERE id IN (
	SELECT department_id FROM sales
	WHERE price > 90.00); 


-- Return a table with one column, called Greeting, and the only row in the 
-- table is the string 'hello world'.
CREATE FUNCTION Greeting() RETURNS TEXT AS $$
	SELECT 'hello world' AS result;
$$ LANGUAGE SQL;

SELECT Greeting();


-- A practice problem for using TRUNC() function, which truncates a number to a specific
-- decimal point or to zero. Given a decimals table schema with columns id, number1, and number2, 
-- return a table with a single column 'towardzero' where the values are the result of number1 +
-- number2 truncated towards zero.
SELECT TRUNC(number1 + number2) AS towardzero FROM decimals;

-- A practice problem for using CASE or if/else statements. The task is to take table schema 
-- numbers, which has three columns: id, number1, and number2, and return a similar column with
-- columns number1 and number2 but use CASE to return the columns as: if the sum of the column is
-- an odd number, return the minimum number in that column. If the sum of the column is an even 
-- number, return the maximum number in that column.
SELECT
	CASE
		WHEN SUM(number1) % 2 = 0 THEN MAX(number1)
		ELSE MIN(number1)
		END AS number1
	CASE
		WHEN SUM(number2) % 2 = 0 THEN MAX(number2)
		ELSE MIN(number2)
		END AS number2
FROM numbers;


--
CREATE FUNCTION fibfunc(num INT) RETURNS TABLE (n INT, res INT) 
	AS $$ SELECT DISTINCT(n), SUM(n) AS res FROM evenfib 
	WHERE n < num
	GROUP BY n
	HAVING n % 2 == 0 
	ORDER BY n ASC $$
	LANGUAGE SQL;

SELECT * FROM fibfunc(33);







