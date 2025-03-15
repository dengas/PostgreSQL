№2a
CREATE TABLE employees AS
SELECT
	ROW_NUMBER() OVER (ORDER BY student.name DESC) AS id,
	student.name,
	CASE
		WHEN student.name = 'Сергей Петров' THEN 'лидер проекта'
		WHEN student.name = 'Ильяс Мухаметшин' THEN 'тимлид команды разработчиков'
		WHEN student.name = 'Иван Иванов' THEN 'тимлид команды специалистов по тестированию'
		WHEN student.name = 'Екатерина Андреева' THEN 'backend разработчик'
		WHEN student.name = 'Анна Потапова' THEN 'frontend разработчик'
	END as "роль",
	CASE
		WHEN student.name = 'Сергей Петров' THEN 1
		WHEN student.name = 'Ильяс Мухаметшин' THEN 2
		WHEN student.name = 'Иван Иванов' THEN 3
		WHEN student.name = 'Екатерина Андреева' THEN 3
		WHEN student.name = 'Анна Потапова' THEN 2
	END as "уровень"
FROM student
ORDER BY уровень

№2b
WITH RECURSIVE temp1 AS (
SELECT e1.name, e1.роль, CAST (e1.name AS varchar(50)) as "путь от лидера"
FROM employees as e1 
WHERE e1.name = 'Сергей Петров'
UNION
SELECT e2.name, e2.роль, cast (temp1.path || '->'|| t2.name as varchar(50))
FROM employees as e2
JOIN temp1 ON temp1.уровень = e2.id
)
SELECT * 
FROM temp1



WITH RECURSIVE temp1 AS (
SELECT 
	e1.name,
	e1.роль,
	e1.уровень, 
	CAST (e1.name AS varchar(50)) as "путь от лидера"
FROM employees as e1 
WHERE e1.name = 'Сергей Петров'
UNION
SELECT 
	e2.name,
	e2.роль,
	e2.уровень,
	CAST (temp1."путь от лидера" || '->'|| e2.name as varchar(50))
FROM employees as e2
JOIN temp1 ON temp1.уровень + 1 = e2.уровень
)
SELECT *
FROM temp1

№2c

№2d
