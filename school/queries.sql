/* Selects all columns in each table */
SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;
SELECT * FROM class;
SELECT * FROM grade;

/* See output of Views */
SELECT * FROM class_information;
SELECT * FROM student_date;

/* Get all teachers and order them from oldest to newly hired */
SELECT
  CONCAT(first_name, ' ', last_name) AS Teacher,
  start_date
FROM teacher
ORDER BY start_date;

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

/* Get all teachers for Tracy Centerson */
SELECT teacher
FROM class_information
WHERE student_id = (SELECT id FROM student
                    WHERE first_name = 'Tracy' AND last_name = 'Centerson');
                    
/* Get all of the students Daniella Amos teaches */
SELECT student
FROM class_information
WHERE teacher_id = (SELECT id FROM teacher
                    WHERE first_name = 'Daniella' AND last_name = 'Amos');
                    
/* Get the averages of each subject and translate subject codes */
SELECT
  "Course Subject" AS "Subject Code",
  CASE
    WHEN "Course Subject" = 'V' THEN 'Visual Arts'
    WHEN "Course Subject" = 'H' THEN 'History'
    WHEN "Course Subject" = 'L' THEN 'Languages'
    WHEN "Course Subject" = 'E' THEN 'English'
    WHEN "Course Subject" = 'M' THEN 'Maths'
    WHEN "Course Subject" = 'S' THEN 'Sciences'
  END AS "Subject",
  CAST(AVG("Student Grade") AS DECIMAL(5, 2)) AS "Subject Average"
FROM class_information
GROUP BY "Course Subject"
ORDER BY (AVG("Student Grade")) DESC;

/* Select bottom 5 teachers who's students had the lowest average scores */
SELECT
  teacher AS "Teacher",
  CAST(AVG("Student Grade") AS DECIMAL(5, 2)) AS "Average Student Grades"
FROM class_information
GROUP BY teacher_id, teacher
ORDER BY AVG("Student Grade") LIMIT 5;
