-- 10. Funciones analíticas y consultas jerárquicas
-- Ranking de salarios dentro de cada departamento
SELECT department_id, first_name, salary,
       RANK()       OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_rank,
       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS fila
FROM hr.employees;

-- Top 3 salarios por departamento
SELECT * FROM (
  SELECT d.department_name, e.first_name, e.salary,
         DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS pos
  FROM hr.employees e
  JOIN hr.departments d ON e.department_id = d.department_id
) WHERE pos <= 3;

-- Cada salario comparado con el promedio de su departamento
SELECT first_name, department_id, salary,
       ROUND(AVG(salary) OVER (PARTITION BY department_id)) AS promedio_depto,
       salary - ROUND(AVG(salary) OVER (PARTITION BY department_id)) AS diferencia
FROM hr.employees;

-- Acumulado de nómina por fecha de contratación
SELECT first_name, hire_date, salary,
       SUM(salary) OVER (ORDER BY hire_date) AS acumulado
FROM hr.employees;

-- Contratación anterior y siguiente (LAG y LEAD)
SELECT first_name, hire_date,
       LAG(hire_date)  OVER (ORDER BY hire_date) AS anterior,
       LEAD(hire_date) OVER (ORDER BY hire_date) AS siguiente
FROM hr.employees;

-- Porcentaje del salario sobre el total del departamento
SELECT first_name, department_id, salary,
       ROUND(RATIO_TO_REPORT(salary) OVER (PARTITION BY department_id) * 100, 2) AS porcentaje
FROM hr.employees;

-- Organigrama completo desde el presidente
SELECT LEVEL, LPAD(' ', (LEVEL - 1) * 2) || first_name || ' ' || last_name AS organigrama, job_id
FROM hr.employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;

-- Ruta jerárquica de cada empleado hasta el jefe máximo
SELECT first_name, SYS_CONNECT_BY_PATH(last_name, ' > ') AS ruta
FROM hr.employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;
