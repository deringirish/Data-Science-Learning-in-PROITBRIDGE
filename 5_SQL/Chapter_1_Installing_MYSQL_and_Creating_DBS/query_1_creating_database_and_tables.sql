create database studentsdb;

use studentsdb;

create table students(
	studentid int auto_increment primary key, 
    firstname varchar(50),
    lastname varchar(50),
    birthdate date,
    gender varchar(10)
);

create table courses(
	courseid int auto_increment primary key,
    coursename varchar(50),
    credits int
);


create table enrollment(
	enrollmentid int auto_increment primary key,
    studentid int,
    courseid int,
    entrollmentdate date,
    foreign key(studentid) references students(studentid),
    foreign key(courseid) references courses(courseid)
);