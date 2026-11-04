-- 08. JOINs combinados con GROUP BY y HAVING
-- Salario promedio, mínimo y máximo por departamento
SELECT d.department_name, COUNT(*) AS empleados,
       ROUND(AVG(e.salary), 2) AS promedio, MIN(e.salary) AS minimo, MAX(e.salary) AS maximo
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY promedio DESC;

-- Empleados por país
SELECT c.country_name, COUNT(e.employee_id) AS empleados
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.locations l   ON d.location_id = l.location_id
JOIN hr.countries c   ON l.country_id = c.country_id
GROUP BY c.country_name
ORDER BY empleados DESC;

-- Nómina total por región
SELECT r.region_name, SUM(e.salary) AS nomina_total
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.locations l   ON d.location_id = l.location_id
JOIN hr.countries c   ON l.country_id = c.country_id
JOIN hr.regions r     ON c.region_id = r.region_id
GROUP BY r.region_name;

-- Cargos con más de 3 empleados y promedio mayor a 5000
SELECT j.job_title, COUNT(*) AS empleados, ROUND(AVG(e.salary)) AS promedio
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
GROUP BY j.job_title
HAVING COUNT(*) > 3 AND AVG(e.salary) > 5000;

-- Jefes con la cantidad de personas a cargo
SELECT m.first_name || ' ' || m.last_name AS jefe, COUNT(e.employee_id) AS a_cargo
FROM hr.employees e
JOIN hr.employees m ON e.manager_id = m.employee_id
GROUP BY m.first_name, m.last_name
HAVING COUNT(e.employee_id) >= 5
ORDER BY a_cargo DESC;

-- Contrataciones por año y departamento
SELECT d.department_name, EXTRACT(YEAR FROM e.hire_date) AS anio, COUNT(*) AS contratados
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY d.department_name, EXTRACT(YEAR FROM e.hire_date)
ORDER BY anio, d.department_name;

-- Ciudades con departamentos y cuántos empleados tienen
SELECT l.city, COUNT(DISTINCT d.department_id) AS departamentos, COUNT(e.employee_id) AS empleados
FROM hr.locations l
LEFT JOIN hr.departments d ON d.location_id = l.location_id
LEFT JOIN hr.employees e   ON e.department_id = d.department_id
GROUP BY l.city
ORDER BY empleados DESC;

-- Subtotales por región y país con ROLLUP
SELECT r.region_name, c.country_name, COUNT(e.employee_id) AS empleados
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.locations l   ON d.location_id = l.location_id
JOIN hr.countries c   ON l.country_id = c.country_id
JOIN hr.regions r     ON c.region_id = r.region_id
GROUP BY ROLLUP (r.region_name, c.country_name);
