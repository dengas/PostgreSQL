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
GROUP BY оценка
ORDER BY оценка

№2b


№2c


№2d


№2e


