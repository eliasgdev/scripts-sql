-- 03. Funciones de fila
SELECT UPPER(first_name), LOWER(last_name), LENGTH(last_name) FROM hr.employees;
SELECT first_name || ' ' || last_name AS nombre_completo FROM hr.employees;
SELECT SUBSTR(first_name, 1, 3) FROM hr.employees;
SELECT ROUND(salary / 30, 2) AS salario_diario FROM hr.employees;
SELECT first_name, NVL(commission_pct, 0) AS comision FROM hr.employees;
SELECT first_name, TO_CHAR(hire_date, 'DD/MM/YYYY') AS fecha_ingreso FROM hr.employees;
SELECT first_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS anios FROM hr.employees;
SELECT first_name, salary,
       CASE WHEN salary >= 15000 THEN 'Alto'
            WHEN salary >= 8000  THEN 'Medio'
            ELSE 'Bajo' END AS nivel
FROM hr.employees;
