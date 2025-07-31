create database Student;

use Student;

create table Basic_Info(
student_id INT Primary key auto_increment,
f_name varchar(100) not null,
l_name varchar(100),
gender varchar(1),
dob date,
age int);


INSERT INTO Basic_Info (f_name, l_name, gender, dob, age) VALUES
('Rahul', 'Verma', 'M', '2002-05-14', 23),
('Priya', 'Nair', 'F', '2003-08-20', 22),
('Amit', 'Kumar', 'M', '2001-11-02', 24),
('Sneha', 'Patel', 'F', '2002-03-18', 23),
('Vikram', 'Singh', 'M', '2003-01-25', 22);

create table Contact_Info(
email varchar(100) unique,
p_number varchar(15),
address varchar(250)
);


INSERT INTO Contact_Info (email, p_number, address) VALUES
('rahul.verma@gmail.com', '9876543210', '123 MG Road, Bengaluru'),
('priya.nair@gmail.com', '9123456780', '45 Brigade Road, Kochi'),
('amit.kumar@gmail.com', '9988776655', '67 Nehru Street, Delhi'),
('sneha.patel@gmail.com', '9765432109', '89 Park Lane, Mumbai'),
('vikram.singh@gmail.com', '9001234567', '34 Lake View, Jaipur');

create table Department(
department_id int primary key auto_increment,
department_name varchar(100),
hod varchar(100)
);


INSERT INTO Department (department_name, hod) VALUES
('Computer Science', 'Dr. Anita Sharma'),
('Electronics & Communication', 'Dr. Rajesh Kumar'),
('Mechanical Engineering', 'Dr. Meena Gupta'),
('Civil Engineering', 'Dr. Ajay Verma');

create table Course(
course_id int primary key auto_increment,
course_name varchar(100),
credits int not null,
department_id int ,
Foreign key (department_id) references Department(department_id)
 );

INSERT INTO Course (course_name, credits, department_id) VALUES
('Database Management Systems', 4, 1),
('Data Structures', 3, 1),
('Digital Electronics', 4, 2),
('Thermodynamics', 3, 3),
('Structural Analysis', 3, 4);

create table Academic_Info(
e_number varchar(50) unique not null,
admission_date date,
course_id int,
foreign key (course_id) references Course(course_id)
);

INSERT INTO Academic_Info (e_number, admission_date, course_id) VALUES
('ENR2021001', '2021-09-15', 1),
('ENR2021002', '2021-09-16', 2),
('ENR2021003', '2021-09-17', 3),
('ENR2021004', '2021-09-18', 4),
('ENR2021005', '2021-09-19', 5);


show tables;
select * from academic_info;
select * from Basic_Info;
select * from Contact_Info;
select * from course;
select * from department;


ALTER TABLE Contact_Info ADD student_id INT, 
ADD FOREIGN KEY (student_id) REFERENCES Basic_Info(student_id);

ALTER TABLE Academic_Info ADD student_id INT,
ADD FOREIGN KEY (student_id) REFERENCES Basic_Info(student_id);


UPDATE Academic_Info SET student_id = 1 WHERE e_number = 'ENR2021001';
UPDATE Academic_Info SET student_id = 2 WHERE e_number = 'ENR2021002';
UPDATE Academic_Info SET student_id = 3 WHERE e_number = 'ENR2021003';
UPDATE Academic_Info SET student_id = 4 WHERE e_number = 'ENR2021004';
UPDATE Academic_Info SET student_id = 5 WHERE e_number = 'ENR2021005';

UPDATE Contact_Info SET student_id = 1 WHERE email = 'rahul.verma@gmail.com';
UPDATE Contact_Info SET student_id = 2 WHERE email = 'priya.nair@gmail.com';
UPDATE Contact_Info SET student_id = 3 WHERE email = 'amit.kumar@gmail.com';
UPDATE Contact_Info SET student_id = 4 WHERE email = 'sneha.patel@gmail.com';
UPDATE Contact_Info SET student_id = 5 WHERE email = 'vikram.singh@gmail.com';


--  Get student names with their course & department
SELECT b.f_name, b.l_name, c.course_name, d.department_name
FROM Basic_Info b
JOIN Academic_Info a ON b.student_id = a.student_id
JOIN Course c ON a.course_id = c.course_id
JOIN Department d ON c.department_id = d.department_id;


-- student with contact information
SELECT b.f_name, b.l_name, con.email, con.p_number
FROM Basic_Info b
JOIN Contact_Info con ON b.student_id = con.student_id;


-- count students per department
SELECT d.department_name, COUNT(b.student_id) AS total_students
FROM Basic_Info b
JOIN Academic_Info a ON b.student_id = a.student_id
JOIN Course c ON a.course_id = c.course_id
JOIN Department d ON c.department_id = d.department_id
GROUP BY d.department_name;



-- students plder than avg age
SELECT f_name, l_name, age
FROM Basic_Info
WHERE age > (SELECT AVG(age) FROM Basic_Info);


 -- Students who joined after the earliest admission date
SELECT f_name, l_name, admission_date
FROM Basic_Info b
JOIN Academic_Info a ON b.student_id = a.student_id
WHERE a.admission_date > (SELECT MIN(admission_date) FROM Academic_Info);