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
WITH subquery1 as (
	select
	course.name AS "курс",
		CASE
		WHEN student_rating < 30 THEN 'неудовлетворительно'
		WHEN student_rating >= 30 AND student_rating < 60 THEN 'удовлетворительно'
		WHEN student_rating >= 60 AND student_rating < 85 THEN 'хорошо'
		ELSE 'отлично'
	END as "оценка",
	student_id
from student_on_course
join course ON student_on_course.course_id = course.id
order by course.name, "оценка"
)
select
	row_number() OVER(ORDER BY subquery1.курс, subquery1.оценка),
	row_number() OVER(PARTITION BY subquery1.курс),
	subquery1.курс,
	subquery1.оценка,
	count(subquery1."оценка") as "количество студентов по оценке"
from subquery1
group by subquery1.курс, subquery1.оценка

№2d !!!!!!!!!!!!!!!
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