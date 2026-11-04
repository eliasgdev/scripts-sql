-- 04. Funciones de grupo, GROUP BY y HAVING
SELECT COUNT(*), SUM(salary), AVG(salary), MIN(salary), MAX(salary) FROM hr.employees;
SELECT department_id, COUNT(*) AS empleados FROM hr.employees GROUP BY department_id;
SELECT department_id, ROUND(AVG(salary), 2) AS promedio FROM hr.employees GROUP BY department_id ORDER BY promedio DESC;
SELECT job_id, MAX(salary) FROM hr.employees GROUP BY job_id;
SELECT department_id, COUNT(*) FROM hr.employees GROUP BY department_id HAVING COUNT(*) > 5;
SELECT department_id, AVG(salary) FROM hr.employees GROUP BY department_id HAVING AVG(salary) > 8000;
