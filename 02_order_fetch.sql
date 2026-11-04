-- 02. ORDER BY y FETCH
SELECT first_name, last_name, salary FROM hr.employees ORDER BY salary DESC;
SELECT first_name, last_name, hire_date FROM hr.employees ORDER BY hire_date;
SELECT department_id, last_name FROM hr.employees ORDER BY department_id, last_name;
SELECT first_name, salary FROM hr.employees ORDER BY salary DESC FETCH FIRST 5 ROWS ONLY;
SELECT first_name, salary FROM hr.employees ORDER BY salary DESC OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
SELECT first_name, salary * 12 AS salario_anual FROM hr.employees ORDER BY salario_anual DESC;
