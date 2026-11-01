-- One-file ClassVoice setup: schema + named fictional demo accounts.
-- Safe to rerun; old accounts and feedback are preserved.

-- ClassVoice schema for MySQL 8 and TiDB Cloud Starter (MySQL compatible).
-- Rerunnable, non-destructive schema setup.
-- No CREATE USER / GRANT statements (managed cloud user from TiDB Connect page).
CREATE DATABASE IF NOT EXISTS classvoice_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE classvoice_db;

CREATE TABLE IF NOT EXISTS users (
  user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password VARCHAR(500) NOT NULL,
  role ENUM('teacher','student') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS lectures (
  lecture_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  teacher_id BIGINT NOT NULL,
  title VARCHAR(180) NOT NULL,
  description VARCHAR(500),
  lecture_date DATE NOT NULL,
  status ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_lecture_teacher FOREIGN KEY (teacher_id) REFERENCES users(user_id) ON DELETE CASCADE,
  INDEX idx_lecture_teacher (teacher_id), INDEX idx_lecture_status (status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS topics (
  topic_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  lecture_id BIGINT NOT NULL,
  topic_name VARCHAR(150) NOT NULL,
  description VARCHAR(300),
  CONSTRAINT fk_topic_lecture FOREIGN KEY (lecture_id) REFERENCES lectures(lecture_id) ON DELETE CASCADE,
  CONSTRAINT uq_topic_name UNIQUE (lecture_id, topic_name),
  INDEX idx_topic_lecture (lecture_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS topic_keywords (
  keyword_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  topic_id BIGINT NOT NULL,
  keyword VARCHAR(100) NOT NULL,
  CONSTRAINT fk_keyword_topic FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE CASCADE,
  CONSTRAINT uq_topic_keyword UNIQUE (topic_id, keyword),
  INDEX idx_keyword_topic (topic_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS feedback (
  feedback_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  lecture_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  topic_id BIGINT NULL,
  feedback_text VARCHAR(1000) NOT NULL,
  submitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_feedback_lecture FOREIGN KEY (lecture_id) REFERENCES lectures(lecture_id) ON DELETE CASCADE,
  CONSTRAINT fk_feedback_student FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_feedback_topic FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE SET NULL,
  INDEX idx_feedback_lecture (lecture_id), INDEX idx_feedback_topic (topic_id), INDEX idx_feedback_student (student_id)
) ENGINE=InnoDB;

-- ClassVoice realistic, fictional demo profiles (reserved .example email domain).
-- The passwords appear only in docs/DEMO_ACCOUNTS.md; the DB stores salted hashes.
-- Safe to rerun: INSERT IGNORE keeps existing user passwords and IDs unchanged.
-- Import AFTER 01_schema.sql; never run a DROP TABLE to install demo data.
USE classvoice_db;

INSERT IGNORE INTO users(name,email,password,role) VALUES
('Dr. Ananya Sharma','ananya.sharma@classvoice.example','pbkdf2_sha256$210000$pQGF31B8imSei1t0iElDxg==$d4VP62IUaKDnKS0UxLwsRpo8kOjhmYtIeROwWWfCmjs=','teacher'),
('Prof. Rahul Verma','rahul.verma@classvoice.example','pbkdf2_sha256$210000$U258Cz5PB9ESx0jsUbC0tw==$0CfDcL+4rZQUyHAvQFelPPX2C+7m36XQCiQwz5hCZLM=','teacher'),
('Aditi Gupta','aditi.gupta@classvoice.example','pbkdf2_sha256$210000$wUm1aPAzJ04fg3ldF1jJ7w==$rcwdVOkcZ7NzUUcza/KD4vzY9gVaPf8UzORQqfhm5vg=','student'),
('Aarav Mehta','aarav.mehta@classvoice.example','pbkdf2_sha256$210000$y1FbZdnPdPIZAkGo+J65kQ==$fXMoO9ljfF0fwOhtJpou8j7uWA7PBfcJEkdJn43v8bA=','student'),
('Kavya Singh','kavya.singh@classvoice.example','pbkdf2_sha256$210000$DknlU30qW/8bTjXFYmCO/w==$yPJWK9WTobOq6o5rLclnxw7Go+hShKf61fL3aVnH4Y8=','student'),
('Rohan Patel','rohan.patel@classvoice.example','pbkdf2_sha256$210000$RH+gof1FmuFfE5wPs/dM2A==$7Toq9ppCOx+4qyQ5CTolZfngMGFikyapX8lKHpHCFWk=','student'),
('Neha Kapoor','neha.kapoor@classvoice.example','pbkdf2_sha256$210000$frRZaxyCmiIWKn/oZ7eZ3g==$Ib+KgNuq1HM/RKoMvDTrIX3aDnGbmwujNeXu7vpz/qE=','student');

-- Insert a lecture only once per demo teacher/title.
INSERT INTO lectures(teacher_id,title,description,lecture_date,status)
SELECT u.user_id,'Database Management System','Demo lecture: relational data, normalization, SQL and transactions.',CURRENT_DATE(),'active'
FROM users u WHERE u.email='ananya.sharma@classvoice.example'
  AND NOT EXISTS (SELECT 1 FROM lectures l WHERE l.teacher_id=u.user_id AND l.title='Database Management System');

-- Insert a lecture only once per demo teacher/title.
INSERT INTO lectures(teacher_id,title,description,lecture_date,status)
SELECT u.user_id,'Core Java Programming','Demo lecture: OOP, exceptions, collections and threads.',CURRENT_DATE(),'active'
FROM users u WHERE u.email='rahul.verma@classvoice.example'
  AND NOT EXISTS (SELECT 1 FROM lectures l WHERE l.teacher_id=u.user_id AND l.title='Core Java Programming');

INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Normalization','Understanding 1NF, 2NF and 3NF.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Normalization');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'SQL Joins','Combining related tables using joins.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='SQL Joins');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Transactions','ACID, COMMIT and ROLLBACK.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Transactions');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Keys and Constraints','Primary, foreign and candidate keys.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Keys and Constraints');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'OOP Concepts','Encapsulation, inheritance and polymorphism.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='OOP Concepts');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Exception Handling','Try/catch, throws and checked exceptions.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Exception Handling');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Collections','ArrayList, HashMap and collections.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Collections');
INSERT INTO topics(lecture_id,topic_name,description)
SELECT l.lecture_id,'Multithreading','Thread lifecycle and synchronization.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Multithreading');

-- Topic keywords; unique constraint ensures rerunning does not duplicate rows.
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'normalization' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Normalization';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'1nf' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Normalization';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'2nf' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Normalization';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'3nf' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Normalization';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'normal form' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Normalization';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'join' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='SQL Joins';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'joins' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='SQL Joins';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'inner join' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='SQL Joins';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'left join' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='SQL Joins';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'right join' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='SQL Joins';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'transaction' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Transactions';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'acid' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Transactions';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'commit' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Transactions';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'rollback' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Transactions';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'atomicity' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Transactions';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'primary key' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Keys and Constraints';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'foreign key' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Keys and Constraints';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'candidate key' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Keys and Constraints';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'constraints' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Keys and Constraints';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'unique key' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System' AND t.topic_name='Keys and Constraints';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'inheritance' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='OOP Concepts';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'polymorphism' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='OOP Concepts';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'encapsulation' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='OOP Concepts';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'oop' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='OOP Concepts';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'abstraction' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='OOP Concepts';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'exception' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Exception Handling';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'try' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Exception Handling';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'catch' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Exception Handling';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'throws' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Exception Handling';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'finally' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Exception Handling';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'arraylist' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Collections';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'hashmap' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Collections';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'collections' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Collections';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'list' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Collections';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'map' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Collections';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'thread' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Multithreading';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'multithreading' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Multithreading';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'synchronization' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Multithreading';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'concurrency' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Multithreading';
INSERT IGNORE INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,'runnable' FROM topics t
JOIN lectures l ON l.lecture_id=t.lecture_id JOIN users u ON u.user_id=l.teacher_id
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming' AND t.topic_name='Multithreading';

-- Anonymous teacher-facing results; underlying student IDs remain protected.
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Normalization' LIMIT 1),'I did not understand why 2NF and 3NF are different.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='aditi.gupta@classvoice.example'
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='I did not understand why 2NF and 3NF are different.');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='SQL Joins' LIMIT 1),'Can you explain left join and inner join again?'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='aarav.mehta@classvoice.example'
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='Can you explain left join and inner join again?');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Transactions' LIMIT 1),'I am confused by rollback and commit in a transaction.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='kavya.singh@classvoice.example'
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='I am confused by rollback and commit in a transaction.');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Keys and Constraints' LIMIT 1),'How does a foreign key differ from a primary key?'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='rohan.patel@classvoice.example'
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='How does a foreign key differ from a primary key?');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,NULL,'Please repeat the final database example slowly.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='neha.kapoor@classvoice.example'
WHERE u.email='ananya.sharma@classvoice.example' AND l.title='Database Management System'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='Please repeat the final database example slowly.');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='OOP Concepts' LIMIT 1),'I need another example of inheritance and polymorphism.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='aditi.gupta@classvoice.example'
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='I need another example of inheritance and polymorphism.');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Exception Handling' LIMIT 1),'What is the difference between throw and throws in an exception?'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='aarav.mehta@classvoice.example'
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='What is the difference between throw and throws in an exception?');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Collections' LIMIT 1),'When should I use ArrayList instead of HashMap?'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='kavya.singh@classvoice.example'
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='When should I use ArrayList instead of HashMap?');
INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,(SELECT t.topic_id FROM topics t WHERE t.lecture_id=l.lecture_id AND t.topic_name='Multithreading' LIMIT 1),'Thread synchronization was difficult to understand.'
FROM lectures l JOIN users u ON u.user_id=l.teacher_id JOIN users s ON s.email='rohan.patel@classvoice.example'
WHERE u.email='rahul.verma@classvoice.example' AND l.title='Core Java Programming'
  AND NOT EXISTS (SELECT 1 FROM feedback f WHERE f.lecture_id=l.lecture_id AND f.student_id=s.user_id AND f.feedback_text='Thread synchronization was difficult to understand.');
