№2a
SELECT name
FROM course
UNION
SELECT name
FROM student;

№2b
SELECT name, 'университет' AS type
FROM college
UNION
SELECT name, 'курс' AS type
FROM course
ORDER BY type DESC, name

№2c
SELECT name, amount_of_students
FROM course
ORDER BY
CASE
WHEN amount_of_students=300 THEN 0
ELSE amount_of_students
END
LIMIT 3

№2d
INSERT INTO course (id, name, is_online, amoubt_of_students, college_id)
VALUES (60, 'Machine Learning', false, 17, 20);

№2e
SELECT id
FROM course
WHERE id NOT IN (SELECT id FROM student_on_course)
UNION
SELECT id
FROM student_on_course
WHERE id NOT IN (SELECT id FROM course)
ORDER BY id;
