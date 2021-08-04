/* Database Schema for Simple School */
-- Clean up before table setup
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS grade;

/* Sequences for auto incrementing IDs */
CREATE SEQUENCE student_table_id;
CREATE SEQUENCE course_table_id;
CREATE SEQUENCE teacher_table_id;
CREATE SEQUENCE class_table_id;
CREATE SEQUENCE grade_table_id;

/* Creates Student, Teacher, Course, and Class Table */
/*
  School Year Code
  ----------------
  F - Freshman
  L - Sophomore
  J - Junior
  S - Senior
*/
CREATE TABLE student(
  id INTEGER DEFAULT NEXTVAL('student_table_id'),
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  school_year CHARACTER NOT NULL,
  birth_date DATE NOT NULL,
  average_grade DECIMAL (5, 2) DEFAULT 0.00,
  PRIMARY KEY(id)
);

CREATE TABLE teacher(
  id INTEGER DEFAULT NEXTVAL('teacher_table_id'),
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  PRIMARY KEY(id)
);

/*
  Subject Codes
  --------------
  M - Math
  H - History
  E - English
  S - Science
  L - Language
  V - Visual Arts
*/
CREATE TABLE course(
  id INTEGER DEFAULT NEXTVAL('course_table_id'),
  title VARCHAR(255) NOT NULL UNIQUE,
  subject CHARACTER NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE class(
  id INTEGER DEFAULT NEXTVAL('class_table_id'),
  student_id INTEGER NOT NULL,
  teacher_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (teacher_id) REFERENCES teacher(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE TABLE grade(
  id INTEGER DEFAULT NEXTVAL('grade_table_id'),
  student_id INTEGER NOT NULL,
  class_id INTEGER NOT NULL,
  grade DECIMAL (5, 2) DEFAULT 0.00,
  FOREIGN KEY (student_id) REFERENCES student(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (class_id) REFERENCES class(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(id)
);

/* Connects sequences for auto incrementing with corresponding table IDs */
ALTER SEQUENCE student_table_id OWNED BY student.id;
ALTER SEQUENCE teacher_table_id OWNED BY teacher.id;
ALTER SEQUENCE course_table_id OWNED BY course.id;
ALTER SEQUENCE class_table_id OWNED BY class.id;
ALTER SEQUENCE grade_table_id OWNED BY grade.id;

/* Convenience View that joins Student, Class, and Grade Tables */
CREATE VIEW student_class_information AS
  SELECT
    s.id AS student_id,
    g.id AS grade_id,
    c.id AS class_id,
    g.grade AS student_grade,
    o.title AS student_course_name
  FROM student s
  INNER JOIN grade g ON s.id = g.student_id
  INNER JOIN class c ON s.id = c.student_id
  INNER JOIN course o ON o.id = c.course_id;


/* Populates tables with mock data to test queries on */
INSERT INTO student (first_name, last_name, school_year, birth_date)
VALUES ('Douglass', 'Walter', 'L', '2005-07-24'),
       ('Jake', 'Stein', 'F', '2007-11-18'),
       ('Shamus', 'Letty', 'S', '2004-06-20'),
       ('Sarah', 'Miller', 'F', '2007-12-12'),
       ('Michael', 'Hall', 'L', '2006-03-19'),
       ('Tracy', 'Centerson', 'S', '2004-09-15'),
       ('Jane', 'Foster', 'J', '2006-05-02'),
       ('John', 'Dressler', 'F', '2007-10-01'),
       ('Maple', 'Kingsley', 'S', '2003-04-17'),
       ('Hunter', 'Lane', 'S', '2004-06-28'),
       ('Vivi', 'Nguyen', 'J', '2006-01-11'),
       ('Cindy', 'Turner', 'F', '2007-10-24'),
       ('Zach', 'Zoo', 'J', '2006-08-29'),
       ('Jackson', 'Baker', 'F', '2004-02-05'),
       ('Penelope', 'Mye', 'S', '2003-06-11'),
       ('Jared', 'Nixon', 'L', '2006-07-05'),
       ('Nolan', 'Porter', 'L', '2006-04-19'),
       ('Kasie', 'Renner', 'F', '2007-12-01'),
       ('Mason', 'Gutierrez', 'L', '2005-04-04'),
       ('Jorge', 'Rodriguez', 'L', '2005-02-25'),
       ('Nina', 'Santos', 'F', '2007-01-21'),
       ('Christopher', 'Weathermen', 'L', '2005-10-15'),
       ('Ivan', 'Nolksy', 'J', '2005-03-13'),
       ('Tanner', 'Warren', 'F', '2007-05-06'),
       ('Clementine', 'Avery', 'S', '2004-11-29');

INSERT INTO teacher (first_name, last_name, email, start_date)
VALUES ('Dean', 'Laymen', 'dlaymen@hotmail.com', '2000-09-01'),
       ('Lily', 'Ola', 'lily_ola_20@yahoo.com', '2018-08-28'),
       ('Raymond', 'Hammer', 'ray.hammer@yahoo.com', '2014-08-26'),
       ('Obediah', 'Broder', 'broder1970@yahoo.com', '1996-09-01'),
       ('Shiela', 'Gallant', 'shiela.gallant24@yahoo.com', '2008-09-01'),
       ('Daniella', 'Amos', 'd_amos@brown.edu', '2020-08-28'),
       ('Logan', 'Ferguson', 'ferguson.logan@gmail.com', '2012-09-01'),
       ('Hank', 'Hardy', 'hank.j.hardy@gmail.com', '2011-09-01'),
       ('Taylor', 'Abott', 'taylorSanders100@hotmail.com', '2002-08-24'),
       ('Julia', 'Sing', 'julia_sing12@gmail.com', '2015-09-01'),
       ('Max', 'Tradermen', 'mtradermen@hotmail.com', '1999-08-29'),
       ('Vincent', 'Hernandez', 'vincent.hernandez24@yahoo.com', '2008-09-01'),
       ('Alexi', 'Yahontov', 'alexi_yahontov@gmail.com', '2017-09-01');

INSERT INTO course (title, subject)
VALUES ('Algebra I', 'M'),
       ('Geometry', 'M'),
       ('Calculus', 'M'),
       ('American History', 'H'),
       ('World History', 'H'),
       ('European History', 'H'),
       ('English I', 'E'),
       ('English II', 'E'),
       ('Classic Literature', 'E'),
       ('Computer Science', 'S'),
       ('Biology', 'S'),
       ('Physics', 'S'),
       ('Chemistry', 'S'),
       ('Spanish', 'L'),
       ('French', 'L'),
       ('Korean', 'L'),
       ('Intro To Art', 'V'),
       ('Drawing I', 'V'),
       ('Photography', 'V'),
       ('Digital Art', 'V');
       
INSERT INTO class (student_id, teacher_id, course_id)
VALUES (1, 1, 4), (1, 2, 2), (1, 5, 7), (1, 7, 10), (1, 6, 14), (1, 9, 17),
       (2, 2, 2), (2, 3, 5), (2, 4, 11), (2, 6, 14), (2, 9, 17),
       (3, 10, 3), (3, 3, 6), (3, 6, 9), (3, 11, 12), (3, 12, 14), (3, 9, 19),
       (4, 1, 4), (4, 2, 1), (4, 5, 7), (4, 4, 11), (4, 13, 15), (4, 9, 18),
       (5, 1, 4), (5, 4, 11), (5, 5, 8), (5, 10, 3), (5, 13, 15), (5, 9, 18),
       (6, 10, 3), (6, 3, 6), (6, 6, 9), (6, 7, 10), (6, 10, 16), (6, 13, 20),
       (7, 10, 2), (7, 3, 6), (7, 5, 8), (7, 11, 12), (7, 10, 16), (7, 9, 18),
       (8, 2, 1), (8, 5, 7), (8, 7, 10), (8, 6, 14), (8, 9, 17),
       (9, 10, 3), (9, 8, 5), (9, 6, 9), (9, 13, 13), (9, 10, 16), (9, 13, 20),
       (10, 10, 3), (10, 8, 5), (10, 6, 9), (10, 13, 13), (10, 10, 16), (10, 13, 20),
       (11, 10, 2), (11, 3, 6), (11, 5, 8), (11, 11, 12), (11, 10, 16), (11, 9, 18),
       (12, 2, 2), (12, 1, 4), (12, 5, 7), (12, 7, 10), (12, 6, 14), (12, 9, 17),
       (13, 10, 2), (13, 3, 6), (13, 5, 8), (13, 7, 10), (13, 10, 16), (13, 13, 20),
       (14, 2, 2), (14, 3, 6), (14, 5, 8), (14, 8, 10), (14, 13, 15), (14, 9, 17),
       (15, 10, 3), (15, 3, 6), (15, 6, 9), (15, 7, 10), (15, 10, 16), (15, 13, 20),
       (16, 1, 4), (16, 2, 2), (16, 5, 7), (16, 7, 10), (16, 6, 14), (16, 9, 17),
       (17, 1, 4), (17, 2, 2), (17, 5, 7), (17, 8, 10), (17, 6, 14), (17, 9, 18),
       (18, 2, 1), (18, 1, 4), (18, 5, 7), (18, 4, 11), (18, 6, 14), (18, 9, 17),
       (19, 2, 2), (19, 8, 5), (19, 5, 8), (19, 4, 11), (19, 13, 15), (19, 9, 18),
       (20, 2, 2), (20, 8, 5), (20, 5, 8), (20, 4, 11), (20, 13, 15), (20, 9, 18),
       (21, 2, 1), (21, 1, 4), (21, 5, 7), (21, 4, 11), (21, 6, 14), (21, 9, 17),
       (22, 10, 3), (22, 1, 4), (22, 5, 8), (22, 8, 10), (22, 10, 16), (22, 13, 20),
       (23, 10, 3), (23, 8, 5), (23, 5, 8), (23, 11, 12), (23, 10, 16), (23, 13, 20),
       (24, 2, 1), (24, 3, 6), (24, 5, 7), (24, 8, 10), (24, 10, 16), (24, 9, 17),
       (25, 10, 3), (25, 3, 6), (25, 6, 9), (25, 13, 13), (25, 10, 16), (25, 13, 20);

INSERT INTO grade (student_id, class_id, grade)
VALUES (1, 1, 87.00), (1, 2, 78.00), (1, 3, 92.00), (1, 4, 75.00), (1, 5, 82.00), (1, 6, 91.00),
       (2, 7, 93.00), (2, 8, 90.00), (2, 9, 70.00), (2, 10, 86.00), (2, 11, 99.00),
       (3, 12, 86.00), (3, 13, 95.00), (3, 14, 91.00), (3, 15, 88.00), (3, 16, 94.00), (3, 17, 100.00),
       (4, 18, 90.00), (4, 19, 99.00), (4, 20, 96.00), (4, 21, 91.00), (4, 22, 100.00), (4, 23, 100.00),
       (5, 24, 82.00), (5, 25, 79.00), (5, 26, 75.00), (5, 27, 87.00), (5, 28, 80.00), (5, 29, 90.00),
       (6, 30, 95.00), (6, 31, 92.00), (6, 32, 98.00), (6, 33, 100.00), (6, 34, 90.00), (6, 35, 100.00),
       (7, 36, 90.00), (7, 37, 92.00), (7, 38, 81.00), (7, 39, 71.00), (7, 40, 88.00), (7, 41, 94.00),
       (8, 42, 65.00), (8, 43, 81.00), (8, 44, 73.00), (8, 45, 84.00), (8, 46, 100.00),
       (9, 47, 80.00), (9, 48, 77.00), (9, 49, 91.00), (9, 50, 63.00), (9, 51, 92.00), (9, 52, 97.00),
       (10, 53, 87.00), (10, 54, 92.00), (10, 55, 77.00), (10, 56, 75.00), (10, 57, 83.00), (10, 58, 98.00),
       (11, 59, 93.00), (11, 60, 97.00), (11, 61, 95.00), (11, 62, 98.00), (11, 63, 96.00), (11, 64, 100.00),
       (12, 65, 77.00), (12, 66, 87.00), (12, 67, 83.00), (12, 68, 90.00), (12, 69, 92.00), (12, 70, 95.00),
       (13, 71, 88.00), (13, 72, 91.00), (13, 73, 94.00), (13, 74, 81.00), (13, 75, 71.00), (13, 76, 89.00),
       (14, 77, 97.00), (14, 78, 94.00), (14, 79, 96.00), (14, 80, 98.00), (14, 81, 92.00), (14, 82, 100.00),
       (15, 83, 86.00), (15, 84, 93.00), (15, 85, 97.00), (15, 86, 77.00), (15, 87, 82.00), (15, 88, 97.00),
       (16, 89, 74.00), (16, 90, 81.00), (16, 91, 83.00), (16, 92, 85.00), (16, 93, 80.00), (16, 94, 86.00),
       (17, 95, 91.00), (17, 96, 87.00), (17, 97, 92.00), (17, 98, 95.00), (17, 99, 81.00), (17, 100, 100.00),
       (18, 101, 92.00), (18, 102, 93.00), (18, 103, 94.00), (18, 104, 78.00), (18, 105, 87.00), (18, 106, 92.00),
       (19, 107, 83.00), (19, 108, 91.00), (19, 109, 95.00), (19, 110, 72.00), (19, 111, 85.00), (19, 112, 80.00),
       (20, 113, 81.00), (20, 114, 85.00), (20, 115, 91.00), (20, 116, 80.00), (20, 117, 81.00), (20, 118, 100.00),
       (21, 119, 69.00), (21, 120, 75.00), (21, 121, 85.00), (21, 122, 65.00), (21, 123, 87.00), (21, 124, 75.00),
       (22, 125, 97.00), (22, 126, 95.00), (22, 127, 93.00), (22, 128, 100.00), (22, 129, 91.00), (22, 130, 100.00),
       (23, 131, 100.00), (23, 132, 91.00), (23, 133, 87.00), (23, 134, 97.00), (23, 135, 95.00), (23, 136, 91.00),
       (24, 137, 71.00), (24, 138, 85.00), (24, 139, 80.00), (24, 140, 75.00), (24, 141, 74.00), (24, 142, 93.00),
       (25, 143, 91.00), (25, 144, 90.00), (25, 145, 100.00), (25, 146, 87.00), (25, 147, 92.00), (25, 148, 97.00);
