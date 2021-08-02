# School Database

## Description

A database for keeping track of classes and which students are taking them, which teachers are teaching them, and what course is being taught.
Queries and table creation ran successfully in SQL Fiddle with PostgreSQL. Practicing my SQL skills.


## Tables

* Student
  * id SERIAL (PK)
  * first_name Varchar(255)
  * last_name Varchar(255)
  * grade INT
  * birth_date DATE

* Teacher
  * id SERiAL (PK)
  * first_name Varchar(255)
  * last_name Varchar(255)
  * email Varchar(255)
  * start_date DATE

* Course
  * id SERIAL (PK)
  * title Varchar(255)
  * subject Varchar(255)

* Class
  * id SERIAL (PK)
  * student_id (FK)
  * teacher_id (FK)
  * course_id (FK)


## Constributors

* Edgar Jr San Martin
