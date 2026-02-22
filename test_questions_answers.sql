USE SQL_Interview_Prac;

-- 1. Find all employees who were hired after January 1st, 2022.

SELECT 
	emp_id,
	CONCAT(first_name, ' ', last_name) AS employees,
	hire_date
FROM
	employees
WHERE
	hire_date > '2022-01-01';

-- 2. Find all employees with the last name 'Sharma' and order them by salary in descending order.

SELECT 
	emp_id,
	first_name,
	last_name,
	salary
FROM
	employees
WHERE
	last_name = 'Sharma'
ORDER BY
	salary DESC;

-- 3. How many employees are in the Analytics department?

SELECT 
	COUNT(e.emp_id) AS number_of_emp,
	d.dept_name AS departments
FROM 
	employees AS e
INNER JOIN 
	departments AS d
ON 
	e.dept_id = d.dept_id
WHERE
	d.dept_name = 'Analytics'
GROUP BY
	d.dept_name;

-- 4. Find the average salary for each department.

SELECT 
	d.dept_name AS department,
	AVG(e.salary) AS avarage_salary
FROM 
	employees AS e
INNER JOIN 
	departments AS d
ON 
	e.dept_id = d.dept_id
GROUP BY
	d.dept_name
ORDER BY 
	AVG(salary) DESC;

-- 5. Find all departments that have more than 5 employees.

SELECT
	COUNT(e.emp_id) AS number_of_emp,
	d.dept_name AS departments
FROM 
	employees AS e
INNER JOIN 
	departments AS d
ON 
	e.dept_id = d.dept_id
GROUP BY
	d.dept_name
HAVING 
	COUNT(e.emp_id) > 5;

-- 6. Find the names of all employees who are working on Project ID 501.

SELECT 
	e.emp_id,
	e.first_name,
	e.last_name,
	p.project_id
FROM
	employees AS e
INNER JOIN
	employee_projects AS p
ON
	e.emp_id = p.emp_id
WHERE
	p.project_id = 501;

-- 7. Find the names of all employees and the number of projects they are assigned to.

SELECT 
	e.emp_id,
	CONCAT(first_name, ' ', last_name) AS employee_name,
	COUNT(p.project_id) as present_projects
FROM
	employees AS e
INNER JOIN
	employee_projects AS p
ON
	e.emp_id = p.emp_id
GROUP BY
	e.emp_id,
	CONCAT(first_name, ' ', last_name)
ORDER BY
	e.emp_id ASC;

-- 8. Find all employees who are not assigned to any projects.

SELECT 
	e.emp_id,
	CONCAT(first_name, ' ', last_name) AS employee_name,
	COUNT(p.project_id) as present_projects
FROM
	employees AS e
LEFT JOIN
	employee_projects AS p
ON
	e.emp_id = p.emp_id
WHERE
	p.project_id IS NULL
GROUP BY
	e.emp_id,
	CONCAT(first_name, ' ', last_name)
ORDER BY
	e.emp_id ASC;

-- 9. Find the employee with the highest salary.

SELECT TOP 1
	emp_id,
	first_name,
	last_name,
	MAX(salary) AS highest_salary
FROM 
	employees
GROUP BY
	emp_id,
	first_name,
	last_name
ORDER BY 
	MAX(salary) DESC;

-- 10. Find the second highest salary in the company.

SELECT
    ranked.emp_id,
    ranked.first_name,
    ranked.last_name,
    ranked.salary
FROM (
    SELECT
        emp_id,
        first_name,
        last_name,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM employees
) AS ranked
WHERE ranked.salary_rank = 1;

-- 11. Find the names of employees who earn more than the average salary of their department.

WITH dept_avg AS (
	
	SELECT 
		dept_id,
		AVG(salary) AS dept_avarage_salary
	FROM 
		employees
	GROUP BY dept_id
)

SELECT 
	*
FROM 
	employees AS e
JOIN 
	dept_avg AS da
ON 
	e.dept_id = da.dept_id

WHERE 
	e.salary > da.dept_avarage_salary;

-- 12. Find the top 3 highest-paid employees in each department.

WITH emp_ranked AS (
    SELECT
        e.emp_id,
        e.first_name,
        e.last_name,
        e.salary,
        d.dept_name,
        DENSE_RANK() OVER (
            PARTITION BY e.dept_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employees e
    JOIN departments d
        ON e.dept_id = d.dept_id
)

SELECT
    emp_id,
    first_name,
    last_name,
    salary,
    dept_name
FROM emp_ranked
WHERE salary_rank <= 3
ORDER BY dept_name, salary DESC, last_name, first_name;

-- 13. Rewrite the previous query using a Common Table Expression (CTE).
-- 14. Find the hire date of an employee and the hire date of the next employee hired in the same department.
-- 15. Find the most \"loyal\" employees in the company.