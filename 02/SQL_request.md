№2a
SELECT name,telegram_contact
FROM student
WHERE city IN ('Казань', 'Москва')
ORDER BY name DESC

№2b
SELECT CONCAT('университет: ',name, '; количество студентов: ', size) as "полная информация"
FROM college
ORDER BY "полная информация"
