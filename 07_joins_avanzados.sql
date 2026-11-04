-- 07. JOINs avanzados: LEFT, RIGHT, FULL, CROSS y varias tablas
-- Departamentos con su cantidad de empleados (incluye los que no tienen ninguno)
SELECT d.department_name, COUNT(e.employee_id) AS empleados
FROM hr.departments d
LEFT JOIN hr.employees e ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY empleados DESC;

-- Empleados sin departamento asignado
SELECT e.first_name, e.last_name
FROM hr.employees e
LEFT JOIN hr.departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Departamentos sin empleados (RIGHT JOIN)
SELECT d.department_id, d.department_name
FROM hr.employees e
RIGHT JOIN hr.departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- FULL OUTER JOIN: todos los empleados y todos los departamentos
SELECT e.first_name, d.department_name
FROM hr.employees e
FULL OUTER JOIN hr.departments d ON e.department_id = d.department_id;

-- Empleado, cargo, departamento, ciudad y país en una sola consulta
SELECT e.first_name || ' ' || e.last_name AS empleado, j.job_title,
       d.department_name, l.city, c.country_name
FROM hr.employees e
JOIN hr.jobs j        ON e.job_id = j.job_id
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.locations l   ON d.location_id = l.location_id
JOIN hr.countries c   ON l.country_id = c.country_id
ORDER BY c.country_name, d.department_name;

-- Jefe de cada departamento
SELECT d.department_name, m.first_name || ' ' || m.last_name AS jefe
FROM hr.departments d
LEFT JOIN hr.employees m ON d.manager_id = m.employee_id;

-- Empleados que ganan más que su jefe
SELECT e.first_name AS empleado, e.salary, m.first_name AS jefe, m.salary AS salario_jefe
FROM hr.employees e
JOIN hr.employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- Salario fuera del rango del cargo
SELECT e.first_name, e.salary, j.job_title, j.min_salary, j.max_salary
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
WHERE e.salary NOT BETWEEN j.min_salary AND j.max_salary;

-- CROSS JOIN: combinaciones región x cargo (limitado)
SELECT r.region_name, j.job_title
FROM hr.regions r CROSS JOIN hr.jobs j
FETCH FIRST 20 ROWS ONLY;
