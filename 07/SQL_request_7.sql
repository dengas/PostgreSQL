№2a
CREATE TABLE employees AS
SELECT
	CASE
		WHEN student.name = 'Сергей Петров' THEN 1
		WHEN student.name = 'Ильяс Мухаметшин' THEN 2
		WHEN student.name = 'Иван Иванов' THEN 5
		WHEN student.name = 'Екатерина Андреева' THEN 4
		WHEN student.name = 'Анна Потапова' THEN 3
	END as id
	student.name,
	CASE
		WHEN student.name = 'Сергей Петров' THEN 'лидер проекта'
		WHEN student.name = 'Ильяс Мухаметшин' THEN 'тимлид команды разработчиков' 
		WHEN student.name = 'Иван Иванов' THEN 'frontend разработчик'
		WHEN student.name = 'Екатерина Андреева' THEN 'backend разработчик'
		WHEN student.name = 'Анна Потапова' THEN 'тимлид команды специалистов по тестированию'
	END as "роль",
	CASE
		WHEN student.name = 'Сергей Петров' THEN 1
		WHEN student.name = 'Ильяс Мухаметшин' THEN 2
		WHEN student.name = 'Иван Иванов' THEN 3
		WHEN student.name = 'Екатерина Андреева' THEN 3
		WHEN student.name = 'Анна Потапова' THEN 2
	END as "уровень"
	CASE
		WHEN student.name = 'Сергей Петров' THEN [null]
		WHEN student.name = 'Ильяс Мухаметшин' THEN 1
		WHEN student.name = 'Иван Иванов' THEN 2
		WHEN student.name = 'Екатерина Андреева' THEN 2
		WHEN student.name = 'Анна Потапова' THEN 1
	END as parent_id
FROM student
ORDER BY уровень, роль

№2b,c Иерархический (рекурсивный) запрос
WITH RECURSIVE temp1 AS (
    SELECT 
        id,
        name AS "студент",
        роль,
        уровень,
        CAST(name AS TEXT) AS "путь от лидера"
    FROM employees 
    WHERE parent_id IS NULL  
    UNION ALL
    SELECT 
        e.id,
        e.name,
        e.роль,
        e.уровень,
        CAST(temp1."путь от лидера" || ' -> ' || e.name AS TEXT)
    FROM employees e
    JOIN temp1 ON e.parent_id = temp1.id
)
SELECT студент, роль, уровень, "путь от лидера" 
FROM temp1
ORDER BY уровень, id

№2d
