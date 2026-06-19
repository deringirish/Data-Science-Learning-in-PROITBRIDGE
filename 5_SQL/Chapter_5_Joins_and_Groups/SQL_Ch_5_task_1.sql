CREATE DATABASE university_management;

USE university_management;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    hod_name VARCHAR(100)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    department_id INT,
    mentor_id INT,
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

INSERT INTO
    departments
VALUES (
        101,
        'Computer Science',
        'Dr. Raman'
    ),
    (
        102,
        'Mechanical',
        'Dr. Suresh'
    ),
    (103, 'Civil', 'Dr. Kavitha'),
    (
        104,
        'Electrical',
        'Dr. Nirmala'
    ),
    (
        105,
        'Artificial Intelligence',
        'Dr. Meera'
    ),
    (
        106,
        'Data Science',
        'Dr. Arjun'
    );

INSERT INTO
    students
VALUES (
        1,
        'Arun',
        20,
        'Male',
        101,
        NULL
    ),
    (
        2,
        'Priya',
        21,
        'Female',
        101,
        1
    ),
    (
        3,
        'Rahul',
        20,
        'Male',
        102,
        2
    ),
    (
        4,
        'Sneha',
        22,
        'Female',
        103,
        2
    ),
    (
        5,
        'Karthik',
        21,
        'Male',
        104,
        3
    ),
    (
        6,
        'Ananya',
        20,
        'Female',
        105,
        4
    ),
    (
        7,
        'Rohit',
        22,
        'Male',
        101,
        1
    ),
    (
        8,
        'Divya',
        21,
        'Female',
        106,
        6
    ),
    (
        9,
        'Vignesh',
        20,
        'Male',
        102,
        3
    ),
    (
        10,
        'Keerthi',
        19,
        'Female',
        NULL,
        2
    ),
    (
        11,
        'Harish',
        23,
        'Male',
        105,
        6
    ),
    (
        12,
        'Nisha',
        20,
        'Female',
        NULL,
        NULL
    );

INSERT INTO
    courses
VALUES (
        201,
        'Database Systems',
        101,
        4
    ),
    (
        202,
        'Operating Systems',
        101,
        4
    ),
    (203, 'Machine Design', 102, 3),
    (
        204,
        'Structural Analysis',
        103,
        4
    ),
    (
        205,
        'Power Electronics',
        104,
        4
    ),
    (
        206,
        'Machine Learning',
        105,
        5
    ),
    (207, 'Deep Learning', 105, 5),
    (208, 'Big Data', 106, 4),
    (
        209,
        'Cloud Computing',
        106,
        4
    ),
    (
        210,
        'Computer Networks',
        101,
        3
    );

-- 1. Inner Join
-- Display the student name along with their department name. Show only students who belong to a department.
SELECT students.student_name, departments.department_name
FROM students
    INNER JOIN departments ON students.department_id = departments.department_id;

-- 2. LEFT JOIN
-- Display all students along with their department names, including students who have not been assigned to any department.
SELECT students.student_name, departments.department_name
FROM students
    LEFT JOIN departments ON students.department_id = departments.department_id;

-- 3. RIGHT JOIN
-- Display all departments along with the students enrolled in them, including departments that currently have no students.
SELECT students.student_name, departments.department_name
FROM students
    RIGHT JOIN departments ON students.department_id = departments.department_id;

-- 4. FULL JOIN
-- Display all students and all departments, including students without departments and departments without students.
SELECT students.student_name, departments.department_name
FROM students
    LEFT JOIN departments ON students.department_id = departments.department_id
UNION
SELECT students.student_name, departments.department_name
FROM students
    RIGHT JOIN departments ON students.department_id = departments.department_id;

-- 5. SELF JOIN
-- Display each student's name along with the name of their mentor.
SELECT s.student_name as Student, m.student_name as Mentor
FROM students s
    LEFT JOIN students m ON s.mentor_id = m.student_id

-- 6. CROSS JOIN
-- Display every possible combination of students and courses for planning elective enrollment.
SELECT students.student_name, courses.course_name
FROM students
    CROSS JOIN courses;