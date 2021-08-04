/* Selects all columns in each table */
SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;
SELECT * FROM class;
SELECT * FROM grade;

/* See output of View */
SELECT * FROM student_class_information;

/* Get number of classes each teacher teaches */
SELECT DISTINCT
  CONCAT(t.first_name, ' ', t.last_name) AS "Teacher",
  COUNT(DISTINCT c.course_id) AS "Number of Classes"
FROM teacher t
INNER JOIN class c ON t.id = c.teacher_id
GROUP BY c.teacher_id, t.first_name, t.last_name
ORDER BY "Number of Classes" DESC;

/* Get course name with lowest average, possible hard course */
SELECT "Course Title"
FROM class_information
GROUP BY "Course Title"
ORDER BY AVG("Student Grade") LIMIT 1;
