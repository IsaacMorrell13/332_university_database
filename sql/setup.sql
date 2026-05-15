USE cs332b21;

-- Clean existing data on startup --

DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Student_Minors;
DROP TABLE IF EXISTS Sections;
DROP TABLE IF EXISTS Prerequisites;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Professors;

-- Professors --

CREATE TABLE Professors (
    ssn VARCHAR(11) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(20),
    zip_code VARCHAR(10),
    area_code VARCHAR(3),
    phone_number VARCHAR(7),
    sex CHAR(1),
    title VARCHAR(50),
    salary DECIMAL(10, 2),
    college_degrees VARCHAR(255)
);

INSERT INTO Professors VALUES
('111-11-1111','John','Smith','1 Main St','LA','CA','90001','213','5551234','M','Professor',90000,'PhD CPSC'),
('222-22-2222','Alice','Brown','2 Oak St','LA','CA','90002','213','5552345','F','Associate Professor',85000,'PhD Math'),
('333-33-3333','David','Lee','3 Pine St','LA','CA','90003','213','5553456','M','Assistant Professor',80000,'PhD EE');

-- Departments --

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE,
    telephone VARCHAR(15),
    office_location VARCHAR(100),
    chairperson_ssn VARCHAR(11),

    FOREIGN KEY (chairperson_ssn)
        REFERENCES Professors(ssn)
);

INSERT INTO Departments VALUES
(1,'Computer Science','123-1111','CPSC Bldg','111-11-1111'),
(2,'Mathematics','123-2222','Math Bldg','222-22-2222');

-- Courses -- 

CREATE TABLE Courses (
    course_no VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    textbook VARCHAR(100),
    units INT,
    dept_id INT,

    FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id)
);

INSERT INTO Courses VALUES
('CPSC101','Intro to CS','Book A',3,1),
('CPSC201','Data Structures','Book B',3,1),
('MATH101','Calculus I','Book C',4,2),
('MATH201','Calculus II','Book D',4,2);

-- Prereqs --

CREATE TABLE Prerequisites (
    course_no VARCHAR(10),
    prereq_course_no VARCHAR(10),

    PRIMARY KEY(course_no, prereq_course_no),

    FOREIGN KEY(course_no)
        REFERENCES Courses(course_no),

    FOREIGN KEY(prereq_course_no)
        REFERENCES Courses(course_no)
);

INSERT INTO Prerequisites VALUES
('CPSC201','CPSC101'),
('MATH201','MATH101');

-- Sections --

CREATE TABLE Sections (
    course_no VARCHAR(10),
    section_no INT,
    classroom VARCHAR(50),
    seats INT,
    meeting_days VARCHAR(20),
    begin_time TIME,
    end_time TIME,
    professor_ssn VARCHAR(11),

    PRIMARY KEY(course_no, section_no),

    FOREIGN KEY(course_no)
        REFERENCES Courses(course_no),

    FOREIGN KEY(professor_ssn)
        REFERENCES Professors(ssn)
);

INSERT INTO Sections VALUES
('CPSC101',1,'R1',30,'M-W','09:00','10:15','111-11-1111'),
('CPSC101',2,'R2',30,'T-Th','10:30','11:45','111-11-1111'),
('CPSC201',1,'R3',25,'M-W','12:00','13:15','333-33-3333'),
('MATH101',1,'M1',40,'M-W','08:00','09:15','222-22-2222'),
('MATH201',1,'M2',40,'T-Th','09:30','10:45','222-22-2222'),
('MATH201',2,'M3',40,'M-W','14:00','15:15','222-22-2222');

-- Students --

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(20),
    zip_code VARCHAR(10),
    area_code VARCHAR(3),
    phone_number VARCHAR(7),
    major_dept_id INT,

    FOREIGN KEY (major_dept_id)
        REFERENCES Departments(dept_id)
);

INSERT INTO Students VALUES
(1,'Tom','A','Street 1','LA','CA','90001','213','1111111',1),
(2,'Sara','B','Street 2','LA','CA','90002','213','2222222',1),
(3,'Mike','C','Street 3','LA','CA','90003','213','3333333',2),
(4,'Anna','D','Street 4','LA','CA','90004','213','4444444',2),
(5,'James','E','Street 5','LA','CA','90005','213','5555555',1),
(6,'Linda','F','Street 6','LA','CA','90006','213','6666666',2),
(7,'Robert','G','Street 7','LA','CA','90007','213','7777777',1),
(8,'Emily','H','Street 8','LA','CA','90008','213','8888888',2);

-- Minors --

CREATE TABLE Student_Minors (
    student_id INT,
    dept_id INT,

    PRIMARY KEY(student_id, dept_id),

    FOREIGN KEY(student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY(dept_id)
        References Departments(dept_id)
);

INSERT INTO Student_Minors VALUES
(1,2),
(2,2),
(3,1);

-- Enrollments --

CREATE TABLE Enrollments (
        enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
        student_id INT,
        course_no VARCHAR(10),
        section_no INT,
        grade VARCHAR(2),

        FOREIGN KEY(student_id)
            REFERENCES Students(student_id),

        FOREIGN KEY(course_no, section_no)
            REFERENCES Sections(course_no, section_no)
);

INSERT INTO Enrollments (student_id, course_no, section_no, grade) VALUES
(1,'CPSC101',1,'A'),
(1,'MATH101',1,'B+'),
(1,'CPSC201',1,'B'),
(2,'CPSC101',1,'F'),
(2,'MATH101',1,'B'),
(2,'CPSC201',1,'A'),
(3,'CPSC201',1,'A'),
(3,'CPSC101',2,'B+'),
(3,'MATH101',1,'B+'),
(4,'MATH201',1,'A'),
(4,'MATH101',1,'B'),
(4,'CPSC101',2,'A-'),
(5,'CPSC101',2,'C'),
(5,'CPSC201',1,'B+'),
(6,'MATH201',2,'A-'),
(6,'MATH101',1,'B+'),
(7,'CPSC101',1,'D'),
(7,'CPSC201',1,'A-'),
(8,'MATH201',1,'B+'),
(8,'MATH201',2,'A');