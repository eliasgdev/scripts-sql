-- 06. Subconsultas
SELECT first_name, salary FROM hr.employees
WHERE salary > (SELECT AVG(salary) FROM hr.employees);

SELECT first_name, department_id FROM hr.employees
WHERE department_id IN (SELECT department_id FROM hr.departments WHERE location_id = 1700);

SELECT first_name, salary FROM hr.employees
WHERE salary = (SELECT MAX(salary) FROM hr.employees);

SELECT e.first_name, e.salary, e.department_id FROM hr.employees e
WHERE e.salary > (SELECT AVG(salary) FROM hr.employees WHERE department_id = e.department_id);

SELECT department_name FROM hr.departments d
WHERE EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id);

SELECT department_name FROM hr.departments d
WHERE NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id);
