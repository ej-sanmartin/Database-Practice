# School Database


![High School DB Schema](high_school_db_schema.png)


## Description

A database for keeping track of classes and which students are taking them, which teachers are teaching them, and what course is being taught.
Queries and table creation ran successfully in SQL Fiddle with PostgreSQL. Practicing my SQL skills.


## Tables

Note: Nearly all values are required and constraints are set to NOT NULL

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


## Improvements

* Slight optimization, make first_name and last_name columns not have Varchar set to 255, unlikely name would fill all of that space
* Add grade columns
* connect to a frontend and backend site
  * Backend handles communicating with database, frontend would be a dashboard to add and remove items from various tables


## Constributors

* Edgar Jr San Martin
