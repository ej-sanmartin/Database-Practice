/* Selects all columns in each table */
SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;
SELECT * FROM class;
SELECT * FROM grade;

/* See output of Views */
SELECT * FROM class_information;
SELECT * FROM student_date;

/* Get the entire school's average grade */
SELECT CAST(AVG(average_grade) AS DECIMAL(5, 2)) AS "School's Average"
FROM student;

/* Get the amount of students who have an above A- Average */
SELECT COUNT(id)
FROM student
WHERE average_grade >= 90.00;

/* Get the salutatorian */
SELECT CONCAT(first_name, ' ', last_name) AS "Salutatorian"
FROM student
ORDER BY average_grade DESC
LIMIT 1 OFFSET 1;

/* Get all teachers and order them from oldest to newly hired */
SELECT
  CONCAT(first_name, ' ', last_name) AS Teacher,
  start_date
FROM teacher
ORDER BY start_date;

/* Get all teachers who started working in the 2000s */
SELECT
  CONCAT(first_name, ' ', last_name) AS "Teacher",
  start_date
FROM teacher
WHERE start_date BETWEEN '2000-01-01' AND '2009-12-31';

/* Get all teachers with a yahoo email account */
SELECT CONCAT(first_name, ' ', last_name) AS "Teacher", email
FROM teacher
WHERE email LIKE '%yahoo.com';

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

/* Get the average grade in every course removing outliers, specifically the highest grade per course */
/* Challenge, do it on a per CLASS basis instead of whole course */
SELECT "Course Title", AVG("Student Grade")
FROM class_information c
INNER JOIN (SELECT "Course Title" AS course, MAX("Student Grade") AS max_grade
            FROM class_information
            GROUP BY "Course Title") o
ON o.max_grade != c."Student Grade" AND o.course = c."Course Title"
GROUP BY "Course Title"
ORDER BY "Course Title"
