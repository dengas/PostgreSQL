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


№2d


№2e


№2f