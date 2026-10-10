create database  Performance_Analysis;
use  Performance_Analysis;

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course VARCHAR(30),
    department VARCHAR(30)
);
INSERT INTO courses (course_id, course, department)VALUES
('C1', 'Excel', 'Business'),
('C2', 'PowerBI', 'Business'),
('C3', 'SQL', 'Technology'),
('C4', 'Python', 'Technology');


CREATE TABLE assessments (
assessment_id INT,
month VARCHAR(10),
course_id VARCHAR(10),
batch VARCHAR(20),
score INT,
attendance_pct INT,
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO assessments(assessment_id, month, course_id, batch, score, attendance_pct)VALUES
(1,  'Jan', 'C1', 'Morning', 72, 90),
(2,  'Jan', 'C2', 'Evening', 45, 70),
(3,  'Jan', 'C3', 'Morning', 65, 85),
(4,  'Jan', 'C4', 'Weekend', 38, 60),
(5,  'Feb', 'C1', 'Evening', 80, 95),
(6,  'Feb', 'C2', 'Weekend', 55, 80),
(7,  'Feb', 'C3', 'Morning', 48, 75),
(8,  'Feb', 'C4', 'Evening', 68, 88),
(9,  'Mar', 'C1', 'Weekend', 90, 98),
(10, 'Mar', 'C2', 'Morning', 60, 82),
(11, 'Mar', 'C3', 'Evening', 75, 92),
(12, 'Mar', 'C4', 'Weekend', 42, 65),
(12, 'Mar', 'C4', 'Weekend', 42, 65);

SELECT COUNT(*) AS total_courses FROM courses;
SELECT COUNT(*) AS total_assessments FROM assessments;

DELETE FROM assessments WHERE assessment_id = 12
AND month = 'Mar' AND course_id = 'C4' AND batch = 'Weekend'
AND score = 42 AND attendance_pct = 65
LIMIT 1;

select * from assessments;

######  S2 - Three Analytical Queries  ######

# S2a — Average score by department
select ass.assessment_id , co.course , co.department , avg(ass.score) as avg_score
from assessments ass
inner join courses co
on ass.course_id = co.course_id
group by ass.assessment_id , co.course , co.department
order by avg_score asc;

## S2b — Underperforming courses
SELECT c.course , AVG(a.score) AS avg_score
FROM assessments a
JOIN courses c
ON a.course_id = c.course_id
GROUP BY c.course_id, c.course
HAVING AVG(a.score) < 60;

### S3c  — Top two batches by average score
SELECT batch , AVG(score) AS avg_score
FROM assessments
GROUP BY batch
ORDER BY avg_score DESC, batch ASC
LIMIT 2;

######  S3 — Output Files & Data Integrity Check ######
SELECT
    c.course_id,
    c.course AS course_name,
    a.assessment_id
FROM courses c
LEFT JOIN assessments a
    ON c.course_id = a.course_id
WHERE a.course_id IS NULL;

SELECT
    a.assessment_id,
    a.course_id
FROM assessments a
LEFT JOIN courses c
    ON a.course_id = c.course_id
WHERE c.course_id IS NULL;