# School Database


![High School DB Schema](high_school_db_schema.png)


## Description

A database for keeping track of classes and which students are taking them, which teachers are teaching them, and what course is being taught.
Also has data for students grades on a corresponding class. Queries and table creation ran successfully in SQL Fiddle with PostgreSQL.
Practicing my SQL skillz.


## Tables

Note: Nearly all values are required and constraints are set to NOT NULL

* Student
  * id SERIAL (PK)
  * first_name Varchar(255)
  * last_name Varchar(255)
  * school_year CHAR(1)
  * birth_date DATE
  * average_grade DECIMAL

* Teacher
  * id SERiAL (PK)
  * first_name Varchar(255)
  * last_name Varchar(255)
  * email Varchar(255)
  * start_date DATE

* Course
  * id SERIAL (PK)
  * title Varchar(255)
  * subject CHAR(1)

* Class
  * id SERIAL (PK)
  * student_id (FK)
  * teacher_id (FK)
  * course_id (FK)

* Grade
  * id SERIAL (PK)
  * student_id (FK)
  * course_id (FK)
  * grade DECIMAL


## Notes on Character Codes

* School Year Code
  * F - Freshman
  * L - Sophomore
  * J - Junior
  * S - Senior
 
* Subject Code
  * M - Math
  * H - History
  * E - English
  * S - Science
  * V - Visual Arts


## Improvements

* Slight optimization, make first_name and last_name columns not have Varchar set to 255, unlikely name would fill all of that space
* connect to a frontend and backend site
  * Backend handles communicating with database, frontend would be a dashboard to add and remove items from various tables


## Constributors

* Edgar Jr San Martin
