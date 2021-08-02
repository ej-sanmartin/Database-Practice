/* Database Schema for Simple School */
-- Clean up before table setup
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS class;

/* Creates Student, Teacher, Course, and Class Table */
CREATE TABLE student(
  id SERIAL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  grade INT CHECK(grade >= 9 AND grade <= 12) NOT NULL,
  birth_date DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE teacher(
  id SERIAL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE course(
  id SERIAL,
  title VARCHAR(255) NOT NULL UNIQUE,
  subject VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE class(
  id SERIAL,
  student_id SERIAL NOT NULL,
  teacher_id SERIAL NOT NULL,
  course_id SERIAL NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (teacher_id) REFERENCES teacher(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES course(id) ON UPDATE CASCADE ON DELETE CASCADE
  PRIMARY KEY(id)
);

/* Populates tables with data to test queries on */
INSERT INTO student (first_name, last_name, grade, birth_date)
VALUES ('Douglass', 'Walter', 10, '2005-07-24'),
       ('Jake', 'Stein', 9, '2007-11-18'),
       ('Shamus', 'Letty', 12, '2004-06-20'),
       ('Sarah', 'Miller', 9, '2007-12-12'),
       ('Michael', 'Hall', 10, '2006-03-19'),
       ('Tracy', 'Centerson', 12, '2004-09-15'),
       ('Jane', 'Foster', 11, '2006-05-02'),
       ('John', 'Dressler', 9, '2007-10-01'),
       ('Maple', 'Kingsley', 12, '2003-04-17'),
       ('Hunter', 'Lane', 12, '2004-06-28'),
       ('Vivi', 'Nguyen', 11, '2006-01-11'),
       ('Cindy', 'Turner', 9, '2007-10-24'),
       ('Zach', 'Zoo', 11, '2006-08-29'),
       ('Jackson', 'Baker', 9, '2004-02-05'),
       ('Penelope', 'Mye', 12, '2003-06-11'),
       ('Jared', 'Nixon', 10, '2006-07-05'),
       ('Nolan', 'Porter', 10, '2006-04-19'),
       ('Kasie', 'Renner', 9, '2007-12-01'),
       ('Mason', 'Gutierrez', 10, '2005-04-04'),
       ('Jorge', 'Rodriguez', 10, '2005-02-25'),
       ('Nina', 'Santos', 9, '2007-01-21'),
       ('Christopher', 'Weathermen', 10, '2005-10-15'),
       ('Ivan', 'Nolksy', 11, '2005-03-13'),
       ('Tanner', 'Warren', 9, '2007-05-06'),
       ('Clementine', 'Avery', 12, '2004-11-29');

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
VALUES ('Algebra I', 'Math'),
       ('Geometry', 'Math'),
       ('Calculus', 'Math'),
       ('American History', 'History'),
       ('World History', 'History'),
       ('European History', 'History'),
       ('English I', 'English'),
       ('English II', 'English'),
       ('Classic Literature', 'English'),
       ('Computer Science', 'Science'),
       ('Biology', 'Science'),
       ('Physics', 'Science'),
       ('Chemistry', 'Science'),
       ('Spanish', 'Language'),
       ('French', 'Language'),
       ('Korean', 'Language'),
       ('Intro To Art', 'Visual Arts'),
       ('Drawing I', 'Visual Arts'),
       ('Photography', 'Visual Arts'),
       ('Digital Art', 'Visual Arts');
       
INSERT INTO class (student_id, teacher_id, course_id)
VALUES (1, 1, 4), (1, 2, 2), (1, 5, 7), (1, 7, 10) (1, 6, 14), (1, 9, 17),
       (2, 2, 2), (2, 3, 5), (2, 4, 11), (2, 6, 14), (2, 9, 17),
       (3, 10, 3), (3, 3, 6), (3, 6, 9), (3, 11, 12), (3, 12, 14), (3, 9, 19),
       (4, 1, 4), (4, 2, 1), (4, 5, 7), (4, 4, 11), (4, 13, 15), (4, 9, 18),
       (5, 1, 4), (5, 4, 11), (5, 5, 8), (5, 10, 3), (5, 13, 15), (5, 9, 18),
       (6, 10, 3), (6, 3, 6), (6, 6, 9), (6, 7, 10), (6, 10, 16), (6, 13, 20),
       (7, 10, 2), (7, 3, 6), (7, 5, 8), (7, 11, 12), (7, 10, 16), (7, 9, 18),
       (8, 2, 1), (8, 5, 7), (8, 7, 10), (8, 6, 14), (8, 9, 17),
       (9, 10, 3), (9, 8, 5), (9, 6, 9), (9, 13, 13), (9, 10, 16), (9, 13, 20),
       (10, 10, 3), (10, 8, 5), (10, 6, 9), (10, 13, 13), (10, 10, 16), (10, 13, 20),
       (11),
       (12),
       (13),
       (14),
       (15),
       (16),
       (17),
       (18),
       (19),
       (20),
       (21),
       (22),
       (23),
       (24),
       (25),
       
