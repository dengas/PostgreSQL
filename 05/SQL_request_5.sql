№2a
SELECT 
	student.name as student_name,
	course.name as course_name,
	college.name as student_college,
	student_rating
FROM student_on_course as soc
JOIN student ON student.id = soc.student_id
JOIN course ON course.id = soc.course_id
JOIN college ON college.id = student.college_id
WHERE student_rating > 50 AND college.size > 5000
ORDER BY student_name, course_name

№2b
SELECT 
	s2.name as student_1,
	s1.name as student_2,
	s1.city
FROM student as s1
JOIN student as s2 ON s1.city = s2.city
WHERE s1.name <> s2.name
ORDER BY s1.id

№2c
SELECT 
	student.name as student_name,
	course.name as course_date
FROM student
JOIN course ON student.college_id = course.college_id
ORDER BY student_name

№2d
SELECT 
	min(student_rating) as min_student_rating,
	max(student_rating) as max_student_rating,
	round(avg(student_rating), 2) as avg_student_rating,
	sum(student_rating) as sum_student_rating
FROM student_on_course

№2e
SELECT 
	city
FROM student
GROUP BY city
HAVING COUNT(city) = 2
ORDER BY city

№2f