-- 05. JOINs entre tablas de HR
SELECT e.first_name, e.last_name, d.department_name
FROM hr.employees e JOIN hr.departments d ON e.department_id = d.department_id;

SELECT e.first_name, j.job_title
FROM hr.employees e JOIN hr.jobs j ON e.job_id = j.job_id;

SELECT d.department_name, l.city, c.country_name, r.region_name
FROM hr.departments d
JOIN hr.locations l ON d.location_id = l.location_id
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r   ON c.region_id = r.region_id;

SELECT e.first_name, d.department_name
FROM hr.employees e LEFT JOIN hr.departments d ON e.department_id = d.department_id;

SELECT d.department_name, e.first_name
FROM hr.employees e RIGHT JOIN hr.departments d ON e.department_id = d.department_id;

SELECT e.first_name AS empleado, m.first_name AS jefe
FROM hr.employees e LEFT JOIN hr.employees m ON e.manager_id = m.employee_id;

SELECT e.first_name, jh.start_date, jh.end_date, jh.job_id
FROM hr.job_history jh JOIN hr.employees e ON jh.employee_id = e.employee_id;
