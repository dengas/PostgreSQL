№2a
SELECT name,telegram_contact
FROM student
WHERE city IN ('Казань', 'Москва')
ORDER BY name DESC

№2b
SELECT CONCAT('университет: ',name, '; количество студентов: ', size) as "полная информация"
FROM college
ORDER BY "полная информация"

№2c
SELECT name, size
FROM college
WHERE id IN (10,30,50)
ORDER BY size, name

№2d
SELECT name, size, id
FROM college
WHERE id NOT IN (10,30,50)
ORDER BY size, name

№2e
SELECT name, amount_of_students
FROM course
WHERE amount_of_students > 27 AND amount_of_students < 300
ORDER BY name, amount_of_students DESC
