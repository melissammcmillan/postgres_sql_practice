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





