-- 01. SELECT y WHERE sobre el esquema HR (Oracle)
SELECT * FROM hr.employees;
SELECT employee_id, first_name, last_name, salary FROM hr.employees;
SELECT * FROM hr.employees WHERE department_id = 90;
SELECT * FROM hr.employees WHERE salary > 10000;
SELECT * FROM hr.employees WHERE salary BETWEEN 5000 AND 8000;
SELECT * FROM hr.employees WHERE department_id IN (10, 20, 30);
SELECT * FROM hr.employees WHERE first_name LIKE 'S%';
SELECT * FROM hr.employees WHERE commission_pct IS NULL;
SELECT * FROM hr.employees WHERE job_id = 'IT_PROG' AND salary > 5000;
SELECT DISTINCT job_id FROM hr.employees;
