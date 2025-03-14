№2a
SELECT 
	student.name AS student_name,
	course.name AS course_name,
	college.name AS student_college,
	student_rating
FROM student_on_course AS soc
JOIN student ON student.id = soc.student_id
JOIN course ON course.id = soc.course_id
JOIN college ON college.id = student.college_id
WHERE student_rating > 50 AND college.size > 5000
ORDER BY student_name, course_name

№2b
SELECT 
	s2.name AS student_1,
	s1.name AS student_2,
	s1.city
FROM student AS s1
JOIN student AS s2 ON s1.city = s2.city
WHERE s1.name <> s2.name
ORDER BY s1.id

№2c
SELECT 
	student.name AS student_name,
	course.name AS course_date
FROM student
JOIN course ON student.college_id = course.college_id
ORDER BY student_name

№2d
SELECT 
	min(student_rating) AS min_student_rating,
	max(student_rating) AS max_student_rating,
	round(avg(student_rating), 2) AS avg_student_rating,
	sum(student_rating) AS sum_student_rating
FROM student_on_course

№2e
SELECT 
	city
FROM student
GROUP BY city
HAVING COUNT(city) = 2
ORDER BY city

№2f
SELECT 
	course.name AS course_name,
	student.name AS student_name
FROM student_on_course AS soc
JOIN course ON soc.course_id = course.id
JOIN student ON soc.student_id = student.id
UNION ALL
SELECT
	course.name AS course_name,
	'курс не зарегестрирован' AS student_name
FROM course
WHERE course.name = 'Machine Learning'
ORDER BY course_name, student_name