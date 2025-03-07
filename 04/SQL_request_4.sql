№2a
CREATE TABLE student_on_course_kn AS
SELECT *
FROM student_on_course
WHERE student_id IN (10,30,40)

№2b
UPDATE student_on_course_kn
SET student_rating = CASE
    WHEN student_rating BETWEEN 0 AND 60 THEN student_rating - 5
    WHEN student_rating BETWEEN 61 AND 80 THEN student_rating - 10
    WHEN student_rating BETWEEN 81 AND 90 THEN student_rating - 15
    ELSE student_rating - 20
END

№2c
DELETE FROM student_on_course_kn
WHERE id = 60

№2d
INSERT INTO student_on_course_kn (id, student_id, course_id, student_rating, finished_date)
SELECT id, student_id, course_id,
    CASE
        WHEN student_rating BETWEEN 0 AND 60 THEN student_rating - 5
        WHEN student_rating BETWEEN 61 AND 80 THEN student_rating - 10
        WHEN student_rating BETWEEN 81 AND 90 THEN student_rating - 15
        ELSE student_rating - 20
    END AS student_rating,
    finished_date
FROM student_on_course
WHERE student_id IN (20,50)

№2e
