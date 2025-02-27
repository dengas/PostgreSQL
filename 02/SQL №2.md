№1
SELECT name,telegram_contact
FROM student
WHERE city IN ('Казань', 'Москва')
ORDER BY name DESC
