-- Using Data which is created in Chapter 5 - Task

USE university_management;

CREATE TABLE student_marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    semester INT,
    subject_name VARCHAR(100),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students (student_id)
);

INSERT INTO
    student_marks
VALUES (1, 1, 1, 'DBMS', 92),
    (
        2,
        1,
        1,
        'Operating Systems',
        88
    ),
    (
        3,
        1,
        1,
        'Python Programming',
        95
    ),
    (4, 2, 1, 'DBMS', 96),
    (
        5,
        2,
        1,
        'Operating Systems',
        91
    ),
    (
        6,
        2,
        1,
        'Python Programming',
        94
    ),
    (7, 3, 1, 'DBMS', 75),
    (
        8,
        3,
        1,
        'Operating Systems',
        82
    ),
    (
        9,
        3,
        1,
        'Python Programming',
        78
    ),
    (10, 4, 1, 'DBMS', 89),
    (
        11,
        4,
        1,
        'Operating Systems',
        86
    ),
    (
        12,
        4,
        1,
        'Python Programming',
        91
    ),
    (13, 5, 1, 'DBMS', 68),
    (
        14,
        5,
        1,
        'Operating Systems',
        72
    ),
    (
        15,
        5,
        1,
        'Python Programming',
        70
    ),
    (16, 6, 1, 'DBMS', 98),
    (
        17,
        6,
        1,
        'Operating Systems',
        95
    ),
    (
        18,
        6,
        1,
        'Python Programming',
        99
    ),
    (19, 7, 1, 'DBMS', 84),
    (
        20,
        7,
        1,
        'Operating Systems',
        80
    ),
    (
        21,
        7,
        1,
        'Python Programming',
        85
    ),
    (22, 8, 1, 'DBMS', 90),
    (
        23,
        8,
        1,
        'Operating Systems',
        93
    ),
    (
        24,
        8,
        1,
        'Python Programming',
        89
    ),
    (25, 9, 1, 'DBMS', 76),
    (
        26,
        9,
        1,
        'Operating Systems',
        79
    ),
    (
        27,
        9,
        1,
        'Python Programming',
        81
    ),
    (28, 10, 1, 'DBMS', 87),
    (
        29,
        10,
        1,
        'Operating Systems',
        84
    ),
    (
        30,
        10,
        1,
        'Python Programming',
        90
    ),
    (31, 11, 1, 'DBMS', 94),
    (
        32,
        11,
        1,
        'Operating Systems',
        92
    ),
    (
        33,
        11,
        1,
        'Python Programming',
        97
    ),
    (34, 12, 1, 'DBMS', 81),
    (
        35,
        12,
        1,
        'Operating Systems',
        77
    ),
    (
        36,
        12,
        1,
        'Python Programming',
        83
    );

-- Task 1 – Window Functions
-- 1. RANK()
-- Rank students based on their marks in each subject.
SELECT *, RANK() OVER (
        PARTITION BY
            subject_name
        ORDER BY marks DESC
    ) as Rank_Based_on_Mark
FROM student_marks;

-- 2. DENSE_RANK()
-- Assign dense ranks to students based on their marks in each subject.
SELECT *, DENSE_RANK() OVER (
        PARTITION BY
            subject_name
        ORDER BY marks DESC
    ) Rank_Based_on_Mark
FROM student_marks;

-- 3. SUM() OVER()
-- Display the running total of marks scored by each student across all subjects.
SELECT *, SUM(marks) OVER (
        PARTITION BY
            student_id
        ORDER BY subject_name
    )
FROM student_marks;

-- 4. AVG() OVER()
-- Display each student's marks along with the average marks of the subject.
SELECT *, AVG(marks) OVER (
        PARTITION BY
            subject_name
    )
from student_marks;

-- 5. COUNT() OVER()
-- Display the total number of students who appeared for each subject.
SELECT DISTINCT
    subject_name,
    COUNT(*) OVER (
        PARTITION BY
            subject_name
    ) AS Total_Students
FROM student_marks;

-- 6. LAG()
-- Display each student's marks along with the previous student's marks in the same subject.
SELECT *, LAG(marks) OVER (
        PARTITION BY
            subject_name
        ORDER BY student_id
    ) as Previous_Student_Mark
FROM student_marks;

-- 7. LEAD()
-- Display each student's marks along with the next student's marks in the same subject.
SELECT *, LEAD(marks) OVER (
        PARTITION BY
            subject_name
        ORDER BY student_id
    ) as Next_Student_Mark
from student_marks;

-- Task 2 – Stored Procedures
-- Procedure 1 (Without Parameters)
-- Display all students with their department and marks.
DELIMITER $$

CREATE PROCEDURE Get_Student_Details()
BEGIN
    SELECT students.student_name, departments.department_name, student_marks.subject_name, student_marks.marks
    from
        students
        JOIN departments on students.department_id = departments.department_id
        JOIN student_marks on students.student_id = student_marks.student_id;
END $$

DELIMITER;

CALL Get_Student_Details ()
-- DROP PROCEDURE IF EXISTS Get_Student_Details;

-- Procedure 2 (With Input Parameter)
-- Display the marks of a student using the student ID.
DELIMITER $$

CREATE PROCEDURE Get_Student_Mark_By_ID(IN stud_id INT)
BEGIN
    SELECT students.student_name, student_marks.subject_name, student_marks.marks
    FROM students
        JOIN student_marks ON students.student_id = student_marks.student_id
    WHERE
        students.student_id = stud_id;
END $$

DELIMITER;

CALL Get_Student_Mark_By_ID (9)

-- Procedure 3 (With Input Parameter)
-- Display students who scored more than the given marks.

DELIMITER $$

CREATE PROCEDURE Get_Student_Details_By_Mark_Filter(IN filter_mark int)
BEGIN
    SELECT students.student_name, student_marks.subject_name, student_marks.marks
    FROM students
    JOIN student_marks on students.student_id = student_marks.student_id
    WHERE student_marks.marks >= filter_mark;
END $$

DELIMITER;

CALL Get_Student_Details_By_Mark_Filter (90);

-- DROP Procedure if EXISTS Get_Student_Details_By_Mark_Filter