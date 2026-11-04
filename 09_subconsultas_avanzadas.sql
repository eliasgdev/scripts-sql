-- 09. Subconsultas avanzadas, WITH y operadores de conjunto
-- Empleado mejor pagado de cada departamento
SELECT e.department_id, e.first_name, e.salary
FROM hr.employees e
WHERE e.salary = (SELECT MAX(salary) FROM hr.employees WHERE department_id = e.department_id);

-- Departamentos con promedio mayor al promedio general
SELECT department_id, ROUND(AVG(salary)) AS promedio
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM hr.employees);

-- Subconsulta en el FROM (tabla derivada)
SELECT d.department_name, t.promedio
FROM (SELECT department_id, ROUND(AVG(salary)) AS promedio
      FROM hr.employees GROUP BY department_id) t
JOIN hr.departments d ON t.department_id = d.department_id
WHERE t.promedio > 8000;

-- Subconsulta en el SELECT
SELECT d.department_name,
       (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) AS empleados
FROM hr.departments d;

-- ANY y ALL
SELECT first_name, salary FROM hr.employees
WHERE salary > ALL (SELECT salary FROM hr.employees WHERE department_id = 60);

SELECT first_name, salary FROM hr.employees
WHERE salary < ANY (SELECT salary FROM hr.employees WHERE job_id = 'SA_MAN');

-- WITH (CTE): departamentos y su nómina comparada con la media
WITH nomina AS (
  SELECT department_id, SUM(salary) AS total
  FROM hr.employees GROUP BY department_id
)
SELECT d.department_name, n.total
FROM nomina n
JOIN hr.departments d ON n.department_id = d.department_id
WHERE n.total > (SELECT AVG(total) FROM nomina)
ORDER BY n.total DESC;

-- Empleados que han cambiado de cargo (están en job_history)
SELECT employee_id, first_name, last_name FROM hr.employees
WHERE employee_id IN (SELECT employee_id FROM hr.job_history);

-- UNION: cargo actual e histórico de cada empleado
SELECT employee_id, job_id, 'Actual' AS tipo FROM hr.employees
UNION
SELECT employee_id, job_id, 'Historico' FROM hr.job_history
ORDER BY employee_id;

-- INTERSECT: empleados que hoy tienen un cargo que ya tuvieron antes
SELECT employee_id, job_id FROM hr.employees
INTERSECT
SELECT employee_id, job_id FROM hr.job_history;

-- MINUS: departamentos sin empleados
SELECT department_id FROM hr.departments
MINUS
SELECT department_id FROM hr.employees;
