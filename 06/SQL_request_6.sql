№2a
SELECT
	CASE
		WHEN student_rating < 30 THEN 'неудовлетворительно'
		WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
		WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
		ELSE 'отлично'
	END as "оценка",
	COUNT(student_id) as "количество студентов"
FROM student_on_course AS soc
GROUP BY "оценка"
ORDER BY "оценка"

№2b
SELECT
	course.name AS "курс",
	CASE
		WHEN student_rating < 30 THEN 'неудовлетворительно'
		WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
		WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
		ELSE 'отлично'
	END as "оценка",
	COUNT(student_id) as "количество студентов"
FROM student_on_course AS soc
JOIN course ON soc.course_id = course.id
GROUP BY "оценка", course.name
ORDER BY "курс", "оценка"

№2c ?????????????????????????????????
SELECT
	ROW_NUMBER() OVER () AS "строки",
	ROW_NUMBER() OVER (PARTITION BY course.name ORDER BY soc.course_id) AS "строки в группе",
	course.name AS "курс",
	CASE
		WHEN student_rating < 30 THEN 'неудовлетворительно'
		WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
		WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
		ELSE 'отлично'
	END as "оценка",
	COUNT(student_id) as "количество студентов"
FROM student_on_course AS soc
JOIN course ON soc.course_id = course.id
GROUP BY "оценка", course.name, soc.course_id
ORDER BY "курс", "оценка"

№2d
SELECT
    DENSE_RANK() OVER (ORDER BY 
        CASE
            WHEN student_rating < 30 THEN 'неудовлетворительно'
            WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
            WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
            ELSE 'отлично'
        END
    ) AS "ранг курса и оценки", 
    course.name AS "курс",
    CASE
        WHEN student_rating < 30 THEN 'неудовлетворительно'
        WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
        WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
        ELSE 'отлично'
    END as "оценка"
FROM student_on_course AS soc
JOIN course ON soc.course_id = course.id
ORDER BY "ранг курса и оценки"