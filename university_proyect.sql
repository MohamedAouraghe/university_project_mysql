USE university_project;

INSERT INTO Students (student_id, student_name, student_major)
VALUES
  (1, 'Harry Potter', 'Gryffindor'),
  (2, 'Hermione Granger', 'Gryffindor'),
  (3, 'Ron Weasley', 'Gryffindor'),
  (4, 'Draco Malfoy', 'Slytherin'),
  (5, 'Luna Lovegood', 'Ravenclaw'),
  (6, 'Neville Longbottom', 'Gryffindor');

INSERT INTO Professors (professor_id, professor_name, professor_department)
VALUES
  (1, 'Severus Snape', 'Potions'),
  (2, 'Remus Lupin', 'Defense Against the Dark Arts'),
  (3, 'Minerva McGonagall', 'Transfiguration'),
  (4, 'Filius Flitwick', 'Charms'),
  (5, 'Sybill Trelawney', 'Divination');

INSERT INTO Courses (course_id, course_name, course_description, course_professor_id)
VALUES
  (1, 'Potions', 'Study of magical potions and their brewing', 1),
  (2, 'Defense Against the Dark Arts', 'Protection against dark magical creatures and spells', 2),
  (3, 'Transfiguration', 'Transformation of objects and creatures', 3),
  (4, 'Charms', 'Spells and enchantments', 4),
  (5, 'Divination', 'Foretelling the future through various methods', 5),
  (6, 'Herbology', 'Study of magical plants and their properties', 3);

INSERT INTO Grades (grade_id, grade_student_id, grade_course_id, grade_professor_id, grade)
VALUES
  -- Harry Potter's grades
  (1, 1, 1, 1, 85),
  (2, 1, 2, 2, 92),
  (3, 1, 3, 3, 78),
  (4, 1, 4, 4, 88),
  -- Hermione Granger's grades
  (5, 2, 1, 1, 95),
  (6, 2, 2, 2, 92),
  (7, 2, 3, 3, 88),
  (8, 2, 4, 4, 90),
  (9, 2, 5, 5, 85),
  (10, 2, 6, 3, 87),
  -- Ron Weasley's grades
  (11, 3, 1, 1, 76),
  (12, 3, 2, 2, 80),
  (13, 3, 3, 3, 92),
  (14, 3, 4, 4, 85),
  -- Draco Malfoy's grades
  (15, 4, 1, 1, 88),
  (16, 4, 2, 2, 90),
  (17, 4, 3, 3, 78),
  (18, 4, 4, 4, 92),
  -- Luna Lovegood's grades
  (19, 5, 2, 2, 85),
  (20, 5, 4, 4, 90),
  (21, 5, 5, 5, 78),
  (22, 5, 6, 3, 92),
  -- Neville Longbottom's grades
  (23, 6, 1, 1, 80),
  (24, 6, 3, 3, 75),
  (25, 6, 5, 5, 82);

-- The average grade that is given by each professor
SELECT p.professor_name, AVG(g.grade) AS 'Average grade'
FROM professors p 
JOIN courses c ON p.professor_id = c.course_professor_id
JOIN grades g ON c.course_id = g.grade_course_id
GROUP BY p.professor_name;


-- The top grades for each student
SELECT s.student_name, min(g.grade) AS 'Top grade'
FROM students s
JOIN grades g ON s.student_id = g.grade_student_id
GROUP BY s.student_name;

-- Sort students by the courses that they are enrolled in
SELECT s.student_name, count(c.course_name) AS 'Total courses'
FROM students s
JOIN grades g ON s.student_id = g.grade_student_id
JOIN courses c ON g.grade_course_id = c.course_id
GROUP BY s.student_name;

-- Create a summary report of courses and their average grades, 
-- sorted by the most challenging course (course with the lowest average grade) to the easiest course
SELECT c.course_name, AVG(g.grade) AS 'Average grade'
FROM courses c 
JOIN grades g ON c.course_id = g.grade_course_id
GROUP BY c.course_name
ORDER BY 'Average grade' ASC;

-- Finding which student and professor have the most courses in common
SELECT s.student_name, p.professor_name, COUNT(*) AS common_courses
FROM Students s
JOIN Grades g ON s.student_id = g.grade_student_id
JOIN Courses c ON g.grade_course_id = c.course_id
JOIN Professors p ON c.course_professor_id = p.professor_id
WHERE s.student_id = g.grade_student_id AND g.grade_professor_id = c.course_professor_id
GROUP BY s.student_name, p.professor_name
ORDER BY common_courses DESC
LIMIT 1;